package com.SimpleProject.SpringCrud.Controller;

import com.SimpleProject.SpringCrud.Model.CustomerModel;
import com.SimpleProject.SpringCrud.Model.ProductModel;
import com.SimpleProject.SpringCrud.Service.CustomerService;
import com.SimpleProject.SpringCrud.Service.ProductService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
@RequestMapping("/api")

public class ProductController {

    @Autowired
    private ProductService productService;

    @PostMapping("/createP")
    @ResponseBody
    public String createProduct(@RequestParam("name") String name,
                              @RequestParam("description") String description,
                              @RequestParam("price") double price,
                              @RequestParam("stock_quantity") int stock_quantity) {
        ProductModel product = new ProductModel();
        product.setName(name);
        product.setDescription(description);
        product.setPrice(price);
        product.setStockQuantity(stock_quantity);

        productService.addProduct(product);

        return "Product created";

    }

    @GetMapping("readP")
    public String readProduct(Model model) {
        List<ProductModel> products = productService.readAllProduct();
        model.addAttribute("products", products);
        return "allProducts";
    }


    @PostMapping("/updateP")
    @ResponseBody
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

        return "updated successfully";
    }

    @PostMapping("/deleteP/{id}")
    @ResponseBody
    public String deleteProduct(@PathVariable long id) {
        productService.deleteProduct(id);
        return "Product with id  "+id +"  Deleted";
    }
}
