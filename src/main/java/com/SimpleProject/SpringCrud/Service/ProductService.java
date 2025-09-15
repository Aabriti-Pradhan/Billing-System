package com.SimpleProject.SpringCrud.Service;

import com.SimpleProject.SpringCrud.Model.CustomerModel;
import com.SimpleProject.SpringCrud.Model.ProductModel;
import com.SimpleProject.SpringCrud.Repository.CustomerRepository;
import com.SimpleProject.SpringCrud.Repository.ProductRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

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

    public List<ProductModel> readAllProduct(String sortField, String sortDir) {
        Sort sort = sortDir.equalsIgnoreCase("asc") ?
                Sort.by(sortField).ascending() :
                Sort.by(sortField).descending();

        return productRepository.findAll(sort);
    }

    public List<ProductModel> readActiveProducts(String sortField, String sortDir) {
        Sort sort = sortDir.equalsIgnoreCase("asc") ?
                Sort.by(sortField).ascending() :
                Sort.by(sortField).descending();

        return productRepository.findByArchivedFalse(sort);
    }

    public ProductModel getProductById(Long productId) {
        Optional<ProductModel> product = productRepository.findById(productId);
        return product.orElseThrow(() -> new RuntimeException("Product not found"));
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

    public ProductModel saveProduct(ProductModel productModel) {
        return productRepository.save(productModel);
    }

    public void unarchiveProducts(List<Long> productId) {
        List<ProductModel> product = productRepository.findAllById(productId);
        product.forEach(prod -> prod.setArchived(false));
        productRepository.saveAll(product);
    }

    public List<ProductModel> searchProducts(String keyword) {
        return productRepository.searchProduct(keyword);
    }
}
