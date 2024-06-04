package com.example.demo.dao;

import com.example.demo.entity.ProductEntity;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

@Repository
public interface ProductDAO extends JpaRepository<ProductEntity, Long>, JpaSpecificationExecutor<ProductEntity> {
    ProductEntity findByProductName(String productName);

    ProductEntity findByProductId(Long productId);

    ProductEntity findByProductNameAndProductIdNot(String productName, Long Id);

    @Query(value = "SELECT p FROM ProductEntity p JOIN BrandEntity b ON p.brandEntity.brandId = b.brandId "
            + " WHERE (p.productName LIKE %:keyword% OR b.brandName LIKE %:keyword%)"
            + " AND (p.price BETWEEN :priceFrom AND :priceTo)")
    Page<ProductEntity> searchProductByNameAndPrice(@Param("keyword") String keyword, @Param("priceFrom") double priceFrom,
                                                    @Param("priceTo") double priceTo, Pageable pageable);

    Page<ProductEntity> findAll(Specification<ProductEntity> searchProductBySpec, Pageable pageable);
}
