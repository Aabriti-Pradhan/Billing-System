package com.SimpleProject.SpringCrud.Controller;

import com.SimpleProject.SpringCrud.Model.CustomerModel;
import com.SimpleProject.SpringCrud.Model.ProductModel;
import com.SimpleProject.SpringCrud.Service.CustomerService;
import com.SimpleProject.SpringCrud.Service.ProductService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api")

public class ProductController {

    @Autowired
    private ProductService productService;

    @PostMapping("/createP")
    public void createProduct(@RequestBody ProductModel productEntity) {
        productService.addProduct(productEntity);
    }

    @GetMapping("readP")
    public List<ProductModel> readProduct() {
        return productService.readAllProduct();
    }


    @PutMapping("/updateP/{id}")
    public ProductModel updateProduct(@PathVariable Long id, @RequestBody ProductModel productEntity) {
        return productService.updateProduct(id,productEntity);
    }

    @DeleteMapping("/deleteP/{id}")
    public String deleteProduct(@PathVariable long id) {
        productService.deleteProduct(id);
        return "Product with id  "+id +"  Deleted";
    }
}
