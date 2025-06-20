package com.example.demo.serviceImpl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.demo.exception.ResourceNotFoundException;
import com.example.demo.model.JobSeekerProfile;
import com.example.demo.repository.JobSeekerProfileRepository;
import com.example.demo.service.JobSeekerProfileService;

@Service
public class JobSeekerProfileServiceImpl implements JobSeekerProfileService {

    @Autowired
    private JobSeekerProfileRepository jobSeekerRepo;

    @Override
    public JobSeekerProfile addJobSeeker(JobSeekerProfile jobSeeker) {
        return jobSeekerRepo.save(jobSeeker);
    }

    @Override
    public List<JobSeekerProfile> searchByJobSeekerName(String name) {
        return jobSeekerRepo.findByFullNameContainingIgnoreCase(name);
    }

    @Override
    public List<JobSeekerProfile> showAllJobSeekers() {
        return jobSeekerRepo.findAll();
    }

    // 🔍 NEW: Get by ID with exception
    @Override
    public JobSeekerProfile getJobSeekerById(Integer id) {
        return jobSeekerRepo.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("Job Seeker not found with ID: " + id));
    }

    // ✏️ NEW: Update job seeker
    @Override
    public JobSeekerProfile updateJobSeeker(Integer id, JobSeekerProfile updatedProfile) {
        JobSeekerProfile existing = jobSeekerRepo.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("Cannot update. Job Seeker not found with ID: " + id));

        existing.setSkills(updatedProfile.getSkills());
        existing.setEducation(updatedProfile.getEducation());
        existing.setPhone(updatedProfile.getPhone());
        existing.setEmail(updatedProfile.getEmail());

        return jobSeekerRepo.save(existing);
    }

    // 🗑️ NEW: Delete job seeker
    @Override
    public void deleteJobSeeker(Integer id) {
        JobSeekerProfile existing = jobSeekerRepo.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("Cannot delete. Job Seeker not found with ID: " + id));

        jobSeekerRepo.delete(existing);
    }
}
