package com.SimpleProject.SpringCrud.Controller;

import com.SimpleProject.SpringCrud.Model.CustomerModel;
import com.SimpleProject.SpringCrud.Model.ProductModel;
import com.SimpleProject.SpringCrud.Service.CustomerService;
import com.SimpleProject.SpringCrud.Service.ProductService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/api")

public class ProductController {

    @Autowired
    private ProductService productService;

    @PostMapping("/createP")
    public String createProduct(@RequestParam("name") String name,
                                @RequestParam("description") String description,
                                @RequestParam("price") double price,
                                @RequestParam("stockQuantity") int stock_quantity,
                                RedirectAttributes redirectAttributes,
                                Model model) {
        try {
            ProductModel product = new ProductModel();
            product.setName(name);
            product.setDescription(description);
            product.setPrice(price);
            product.setStockQuantity(stock_quantity);

            productService.addProduct(product);

            redirectAttributes.addFlashAttribute("toastMessage", "Product created successfully!");
            redirectAttributes.addFlashAttribute("toastType", "success");

            return "redirect:/api/readP";
        }
        catch (org.springframework.dao.DataIntegrityViolationException ex) {
            // This catches database-level unique constraint violations
            model.addAttribute("toastMessage", "ID or unique field already exists in the database!");
            model.addAttribute("toastType", "danger");

            // Repopulate entered values
            model.addAttribute("name", name);
            model.addAttribute("description", description);
            model.addAttribute("price", price);
            model.addAttribute("stockQuantity", stock_quantity);

            return "allProducts"; // stay on same page with toast
        }
    }

    @GetMapping("/readP")
    public String readProduct(
            @RequestParam(value = "showArchived", required = false) Boolean showArchived,
            @RequestParam(value = "sortField", required = false, defaultValue = "name") String sortField,
            @RequestParam(value = "sortDir", required = false, defaultValue = "asc") String sortDir,
            Model model) {

        List<ProductModel> products;

        //for archived as well as for sorting
        if (Boolean.TRUE.equals(showArchived)) {
            products = productService.readAllProduct(sortField, sortDir);
        } else {
            products = productService.readActiveProducts(sortField, sortDir);
        }

        model.addAttribute("products", products);
        model.addAttribute("sortField", sortField);
        model.addAttribute("sortDir", sortDir);

        return "allProducts";
    }


    @PostMapping("/updateP")
    public String updateProductFromForm(
            @RequestParam("id") Long id,
            @RequestParam("name") String name,
            @RequestParam("description") String description,
            @RequestParam("price") double price,
            @RequestParam("stockQuantity") int stockQuantity) {

        ProductModel product = new ProductModel();
        product.setName(name);
        product.setDescription(description);
        product.setPrice(price);
        product.setStockQuantity(stockQuantity);

        productService.updateProduct(id, product);

        return "redirect:/api/readP";
    }

    @PostMapping("/deleteP/{id}")
    public String deleteProduct(@PathVariable long id) {
        productService.deleteProduct(id);
        return "redirect:/api/readP";
    }

    @PostMapping("/product/archive")
    @ResponseBody
    public ResponseEntity<String> archiveProducts(@RequestBody List<Long> productId) {
        try {
            for(Long id : productId) {
                ProductModel product = productService.getProductById(id);
                if(product != null) {
                    product.setArchived(true);
                    productService.saveProduct(product); // or update
                }
            }
            return ResponseEntity.ok("Products archived successfully");
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body("Error archiving products");
        }
    }

    @PostMapping("/product/unarchive")
    @ResponseBody
    public ResponseEntity<String> unarchiveProducts(@RequestBody List<Long> productId) {
        productService.unarchiveProducts(productId);
        return ResponseEntity.ok("Restored Successfully!");
    }

    @GetMapping("/product/search")
    public String searchProducts(@RequestParam("keyword") String keyword, Model model) {
        List<ProductModel> products = productService.searchProducts(keyword);

        model.addAttribute("products", products);
        model.addAttribute("keyword", keyword);

        model.addAttribute("sortField", "name");
        model.addAttribute("sortDir", "asc");

        return "allProducts";
    }

    //getting product for update
    @GetMapping("/product/{id}")
    @ResponseBody
    public ResponseEntity<?> getProduct(@PathVariable Long id) {
        ProductModel product = productService.getProductById(id);
        if (product != null) {
            ProductModel dto = new ProductModel();
            dto.setName(product.getName());
            dto.setDescription(product.getDescription());
            dto.setPrice(product.getPrice());
            dto.setStockQuantity(product.getStockQuantity());
            return ResponseEntity.ok(dto);
        } else {
            Map<String, String> error = new HashMap<>();
            error.put("message", "Product not found");
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body(error);
        }
    }
}
