package com.SimpleProject.SpringCrud.DTO;


public class ProductDropdownDTO {
    private Long productId;
    private String name;

    public ProductDropdownDTO(Long productId, String name) {
        this.productId = productId;
        this.name = name;
    }

    // getters
    public Long getProductId() { return productId; }
    public String getName() { return name; }
}
