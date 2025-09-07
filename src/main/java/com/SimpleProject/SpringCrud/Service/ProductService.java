package com.SimpleProject.SpringCrud.Service;

import com.SimpleProject.SpringCrud.Model.CustomerModel;
import com.SimpleProject.SpringCrud.Model.ProductModel;
import com.SimpleProject.SpringCrud.Repository.CustomerRepository;
import com.SimpleProject.SpringCrud.Repository.ProductRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service

public class ProductService {

    @Autowired

    private ProductRepository productRepository;

    public void addProduct(ProductModel productModel) {
        productRepository.save(productModel);

    }

    public List<ProductModel> readAllProduct() {

        return productRepository.findAll();
    }

    public ProductModel updateProduct(Long id, ProductModel customerEntity) {

        ProductModel product = productRepository.findById(id).orElse(null);
        if (product != null) {
            product.setName(customerEntity.getName());
            product.setDescription(customerEntity.getDescription());
            product.setPrice(customerEntity.getPrice());
            product.setStockQuantity(customerEntity.getStockQuantity());
            return productRepository.save(product);
        }
        return null;
    }

    public void deleteProduct(Long id) {

        productRepository.deleteById(id);

    }

    public ProductModel readProductById(Long id) {
        return productRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Product not found with id: " + id));
    }

    public List<ProductModel> getAllProducts() {
        return productRepository.findAll();
    }
}
