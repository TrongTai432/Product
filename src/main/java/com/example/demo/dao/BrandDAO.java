package com.example.demo.dao;

import com.example.demo.entity.BrandEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface BrandDAO extends JpaRepository<BrandEntity, Long> {
}
