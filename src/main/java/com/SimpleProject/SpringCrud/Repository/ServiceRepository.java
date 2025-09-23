package com.SimpleProject.SpringCrud.Repository;

import com.SimpleProject.SpringCrud.Model.ProductModel;
import com.SimpleProject.SpringCrud.Model.ServiceModel;
import org.springframework.data.domain.Sort;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface ServiceRepository extends JpaRepository<ServiceModel, Long> {
    Optional<ServiceModel> findByServiceName(String serviceName);
    Optional<ServiceModel> findByServiceId(Long id);

    List<ServiceModel> findByArchivedFalse(Sort sort);

    @Query("SELECT s FROM ServiceModel s " +
            "WHERE LOWER(s.serviceName) LIKE LOWER(CONCAT('%', :keyword, '%')) " +
            "OR str(s.amount) LIKE CONCAT('%', :keyword, '%') " )
    List<ServiceModel> searchService(@Param("keyword") String keyword);
}
