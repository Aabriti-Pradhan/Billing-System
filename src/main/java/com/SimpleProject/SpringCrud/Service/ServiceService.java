package com.SimpleProject.SpringCrud.Service;

import com.SimpleProject.SpringCrud.Model.ServiceModel;
import com.SimpleProject.SpringCrud.Repository.ServiceRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service

public class ServiceService {

    @Autowired

    private ServiceRepository serviceRepository;

    public void addService(ServiceModel serviceModel) {
        serviceRepository.save(serviceModel);

    }

    public List<ServiceModel> readAllService() {

        return serviceRepository.findAll();
    }

    public List<ServiceModel> readAllService(String sortField, String sortDir) {
        Sort sort = sortDir.equalsIgnoreCase("asc") ?
                Sort.by(sortField).ascending() :
                Sort.by(sortField).descending();

        return serviceRepository.findAll(sort);
    }

    public List<ServiceModel> readActiveServices(String sortField, String sortDir) {
        Sort sort = sortDir.equalsIgnoreCase("asc") ?
                Sort.by(sortField).ascending() :
                Sort.by(sortField).descending();

        return serviceRepository.findByArchivedFalse(sort);
    }

    public ServiceModel getServiceById(Long serviceId) {
        Optional<ServiceModel> service = serviceRepository.findById(serviceId);
        return service.orElseThrow(() -> new RuntimeException("Service not found"));
    }

    public ServiceModel updateService(Long id, ServiceModel customerEntity) {

        ServiceModel service = serviceRepository.findById(id).orElse(null);
        if (service != null) {
            service.setServiceName(customerEntity.getServiceName());
            service.setAmount(customerEntity.getAmount());
            return serviceRepository.save(service);
        }
        return null;
    }

    public void deleteService(Long id) {

        serviceRepository.deleteById(id);

    }

    public ServiceModel readServiceById(Long id) {
        return serviceRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Service not found with id: " + id));
    }

    public List<ServiceModel> getAllServices() {
        return serviceRepository.findAll();
    }

    public ServiceModel saveService(ServiceModel serviceModel) {
        return serviceRepository.save(serviceModel);
    }

    public void unarchiveServices(List<Long> serviceId) {
        List<ServiceModel> service = serviceRepository.findAllById(serviceId);
        service.forEach(prod -> prod.setArchived(false));
        serviceRepository.saveAll(service);
    }

    public List<ServiceModel> searchServices(String keyword) {
        return serviceRepository.searchService(keyword);
    }
}
