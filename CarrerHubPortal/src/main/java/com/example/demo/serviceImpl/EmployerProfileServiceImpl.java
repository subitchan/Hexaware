package com.example.demo.serviceImpl;

import com.example.demo.model.EmployerProfile;
import com.example.demo.repository.EmployerProfileRepository;
import com.example.demo.service.EmployerProfileService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class EmployerProfileServiceImpl implements EmployerProfileService {

    @Autowired
    private EmployerProfileRepository employerRepo;

    @Override
    public EmployerProfile addEmployer(EmployerProfile employer) {
        return employerRepo.save(employer);
    }

    @Override
    public EmployerProfile getEmployerById(Integer employerId) {
        return employerRepo.findById(employerId).orElse(null);
    }

    @Override
    public List<EmployerProfile> getAllEmployers() {
        return employerRepo.findAll();
    }
}
