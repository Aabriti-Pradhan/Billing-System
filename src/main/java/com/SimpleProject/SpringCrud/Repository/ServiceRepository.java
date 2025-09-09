package com.SimpleProject.SpringCrud.Repository;

import com.SimpleProject.SpringCrud.Model.ServiceModel;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface ServiceRepository extends JpaRepository<ServiceModel, Long> {
    Optional<ServiceModel> findByServiceName(String serviceName);
    Optional<ServiceModel> findByServiceId(Long id);
}
