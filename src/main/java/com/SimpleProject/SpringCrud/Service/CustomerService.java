package com.SimpleProject.SpringCrud.Service;

import com.SimpleProject.SpringCrud.Model.CustomerModel;
import com.SimpleProject.SpringCrud.Repository.CustomerRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class CustomerService {

    @Autowired

    private CustomerRepository customerRepository;

    public void addCustomer(CustomerModel customerModel) {
        customerRepository.save(customerModel);

    }

    public List<CustomerModel> readAllCustomer() {

        return customerRepository.findAll();
    }

    public CustomerModel updateCutomer(Long id, CustomerModel customerEntity) {

        CustomerModel customer = customerRepository.findById(id).orElse(null);
        if (customer != null) {
            customer.setName(customerEntity.getName());
            customer.setEmail(customerEntity.getEmail());
            customer.setAddress(customerEntity.getAddress());
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
}
