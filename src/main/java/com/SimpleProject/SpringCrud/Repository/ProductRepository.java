package com.SimpleProject.SpringCrud.Repository;

import com.SimpleProject.SpringCrud.Model.ProductModel;
import org.springframework.data.jpa.repository.JpaRepository;

public interface ProductRepository extends JpaRepository<ProductModel, Long> {
}
