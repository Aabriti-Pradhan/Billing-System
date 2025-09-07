package com.SimpleProject.SpringCrud.Repository;

import com.SimpleProject.SpringCrud.DTO.ProductDropdownDTO;
import com.SimpleProject.SpringCrud.Model.ProductModel;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface ProductRepository extends JpaRepository<ProductModel, Long> {

    @Query("SELECT new com.SimpleProject.SpringCrud.DTO.ProductDropdownDTO(p.productId, p.name) " +
            "FROM ProductModel p " +
            "WHERE LOWER(p.name) LIKE LOWER(CONCAT('%', :keyword, '%'))")
    List<ProductDropdownDTO> searchProducts(@Param("keyword") String keyword);
}
