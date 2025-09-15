package com.SimpleProject.SpringCrud.Repository;

import com.SimpleProject.SpringCrud.DTO.ProductDropdownDTO;
import com.SimpleProject.SpringCrud.Model.CustomerModel;
import com.SimpleProject.SpringCrud.Model.ProductModel;
import org.springframework.data.domain.Sort;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface ProductRepository extends JpaRepository<ProductModel, Long> {

    @Query("SELECT new com.SimpleProject.SpringCrud.DTO.ProductDropdownDTO(p.productId, p.name) " +
            "FROM ProductModel p " +
            "WHERE LOWER(p.name) LIKE LOWER(CONCAT('%', :keyword, '%'))")
    List<ProductDropdownDTO> searchProducts(@Param("keyword") String keyword);

    List<ProductModel> findByArchivedFalse(Sort sort);

    @Query("SELECT p FROM ProductModel p " +
            "WHERE LOWER(p.name) LIKE LOWER(CONCAT('%', :keyword, '%')) " +
            "OR LOWER(p.description) LIKE LOWER(CONCAT('%', :keyword, '%')) " +
            "OR str(p.price) LIKE CONCAT('%', :keyword, '%') " +
            "OR str(p.stockQuantity) LIKE CONCAT('%', :keyword, '%')")
    List<ProductModel> searchProduct(@Param("keyword") String keyword);
}
