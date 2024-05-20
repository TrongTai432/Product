package com.example.demo.dao;

import com.example.demo.entity.BrandEntity;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface BrandDAO extends JpaRepository<BrandEntity, Long> {
    @Query("SELECT b FROM BrandEntity b ORDER BY b.brandId DESC")
    List<BrandEntity> findAllOrderByBrandIdDesc();

    List<BrandEntity> findAll();

    BrandEntity findByBrandId(Long brandId);

    BrandEntity findByBrandName(String brandName);

    BrandEntity findByBrandNameAndBrandIdNot(String brandName, Long brandId);

    Page<BrandEntity> findByBrandNameLike(String brandName, Pageable pageable);

}
