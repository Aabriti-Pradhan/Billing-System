package com.SimpleProject.SpringCrud.DTO;

public class CustomerDropdownDTO {
    private Long customerId;
    private String name;

    public CustomerDropdownDTO(Long customerId, String name) {
        this.customerId = customerId;
        this.name = name;
    }

    // getters
    public Long getCustomerId() { return customerId; }
    public String getName() { return name; }
}
