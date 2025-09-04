package com.SimpleProject.SpringCrud.Repository;

import com.SimpleProject.SpringCrud.Model.ServiceModel;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ServiceRepository extends JpaRepository<ServiceModel, Long> {

    List<ServiceModel> findByCustomerCustomerId(Long customerId);
}
