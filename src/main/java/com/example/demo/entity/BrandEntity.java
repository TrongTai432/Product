package com.example.demo.entity;

import com.fasterxml.jackson.annotation.JsonIgnore;
import org.springframework.web.multipart.MultipartFile;
import javax.persistence.Id;
import javax.persistence.*;
import java.util.Set;

@Entity
@Table(name = "brand")
public class BrandEntity {
    @Id
    @Column(name = "brand_id", nullable = false)
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Long brandId;

    @Column(name = "brand_name", length = 100, nullable = true)
    private String brandName;

    @Column(name = "logo", nullable = true)
    private String logo;

    @Column(name = "description", nullable = true)
    private String description;

    @JsonIgnore
    @OneToMany(mappedBy = "brandEntity", fetch = FetchType.LAZY)
    private Set<ProductEntity> productSet;

    public Set<ProductEntity> getProductSet() {
        return productSet;
    }

    public void setProductSet(Set<ProductEntity> productSet) {
        this.productSet = productSet;
    }

    @Transient
    private MultipartFile[] logoFiles;

    public BrandEntity() {
    }

    public Long getBrandId() {
        return brandId;
    }

    public void setBrandId(Long brandId) {
        this.brandId = brandId;
    }

    public String getBrandName() {
        return brandName;
    }

    public void setBrandName(String brandName) {
        this.brandName = brandName;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getLogo() {
        return logo;
    }

    public void setLogo(String logo) {
        this.logo = logo;
    }

    public MultipartFile[] getLogoFiles() {
        return logoFiles;
    }

    public void setLogoFiles(MultipartFile[] logoFiles) {
        this.logoFiles = logoFiles;
    }
}
