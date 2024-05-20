package com.example.demo.dao;

import com.example.demo.entity.BrandEntity;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface BrandDAO extends JpaRepository<BrandEntity, Long> {

    BrandEntity findByBrandId(Long brandId);

    BrandEntity findByBrandName(String brandName);

    BrandEntity findByBrandNameAndBrandIdNot(String brandName, Long brandId);

    Page<BrandEntity> findByBrandNameLike(String brandName, Pageable pageable);

}
