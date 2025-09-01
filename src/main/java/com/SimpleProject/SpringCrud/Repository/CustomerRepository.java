package com.SimpleProject.SpringCrud.Repository;

import com.SimpleProject.SpringCrud.Model.CustomerModel;
import org.springframework.data.jpa.repository.JpaRepository;

public interface CustomerRepository extends JpaRepository<CustomerModel, Long> {
}
