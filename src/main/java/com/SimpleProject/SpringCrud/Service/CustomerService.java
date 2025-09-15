package com.SimpleProject.SpringCrud.Service;

import com.SimpleProject.SpringCrud.Model.CustomerModel;
import com.SimpleProject.SpringCrud.Model.MainInvoiceModel;
import com.SimpleProject.SpringCrud.Repository.CustomerRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class CustomerService {

    @Autowired

    private CustomerRepository customerRepository;

    public void addCustomer(CustomerModel customerModel) {
        customerRepository.save(customerModel);

    }

    //for service
    public List<CustomerModel> readAllCustomer() {

        return customerRepository.findAll();
    }

    //for sorting
    public List<CustomerModel> readAllCustomer(String sortField, String sortDir) {
        Sort sort = sortDir.equalsIgnoreCase("asc") ?
                Sort.by(sortField).ascending() :
                Sort.by(sortField).descending();

        return customerRepository.findAll(sort);
    }

    public CustomerModel updateCutomer(Long id, CustomerModel customerEntity) {

        CustomerModel customer = customerRepository.findById(id).orElse(null);
        if (customer != null) {
            customer.setName(customerEntity.getName());
            customer.setEmail(customerEntity.getEmail());
            customer.setAddress(customerEntity.getAddress());
            customer.setPhone(customerEntity.getPhone());
            return customerRepository.save(customer);
        }
        return null;
    }

    public void deleteCustomer(Long id) {

        customerRepository.deleteById(id);

    }

    public CustomerModel readCustomerById(Long id) {
        return customerRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Customer not found with id: " + id));
    }

    public List<CustomerModel> getAllCustomers() {
        return customerRepository.findAll();
    }

    public boolean existsByPhone(String phone) {
        return customerRepository.existsByPhone(phone);
    }

    public boolean existsByEmail(String email) {
        return customerRepository.existsByEmail(email);
    }

    public CustomerModel saveCustomer(CustomerModel customerModel) {
        return customerRepository.save(customerModel);
    }

    public CustomerModel getCustomerById(Long customerId) {
        Optional<CustomerModel> customer = customerRepository.findById(customerId);
        return customer.orElseThrow(() -> new RuntimeException("Customer not found"));
    }

    public void unarchiveCustomers(List<Long> customerId) {
        List<CustomerModel> customer = customerRepository.findAllById(customerId);
        customer.forEach(cust -> cust.setArchived(false));
        customerRepository.saveAll(customer);
    }

    public List<CustomerModel> readActiveCustomers(String sortField, String sortDir) {
        Sort sort = sortDir.equalsIgnoreCase("asc") ?
                Sort.by(sortField).ascending() :
                Sort.by(sortField).descending();

        return customerRepository.findByArchivedFalse(sort);
    }

    public List<CustomerModel> searchCustomers(String keyword) {
        return customerRepository.searchCustomer(keyword);
    }

}
