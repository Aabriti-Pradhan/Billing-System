package com.SimpleProject.SpringCrud.Repository;

import com.SimpleProject.SpringCrud.DTO.CustomerDropdownDTO;
import com.SimpleProject.SpringCrud.Model.CustomerModel;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface CustomerRepository extends JpaRepository<CustomerModel, Long> {

    @Query("SELECT new com.SimpleProject.SpringCrud.DTO.CustomerDropdownDTO(c.customerId, c.name) " +
            "FROM CustomerModel c " +
            "WHERE LOWER(c.name) LIKE LOWER(CONCAT('%', :keyword, '%'))")
    List<CustomerDropdownDTO> searchCustomers(@Param("keyword") String keyword);
    boolean existsByPhone(String phone);
    boolean existsByEmail(String email);
}
