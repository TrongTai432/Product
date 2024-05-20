package com.example.demo.service;

import com.example.demo.dao.BrandDAO;
import com.example.demo.entity.BrandEntity;
import com.example.demo.model.ResponseDataModel;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class BrandServiceImpl implements IBrandService {

    BrandDAO brandDAO;

    @Override
    public BrandEntity add(BrandEntity brandEntity) {
        return brandDAO.save(brandEntity);
    }

    @Override
    public BrandEntity update(BrandEntity brandEntity) {
        return brandDAO.save(brandEntity);
    }

    @Override
    public ResponseDataModel delete(Long brandId) {
        if (brandDAO.existsById(brandId)) {
            brandDAO.deleteById(brandId);
            return new ResponseDataModel(HttpStatus.OK, "Brand deleted successfully.");
        }
        return new ResponseDataModel(HttpStatus.NOT_FOUND, "Brand not found.");
    }

    @Override
    public List<BrandEntity> getAll() {
        return brandDAO.findAll();
    }


    @Override
    public BrandEntity findByBrandId(Long brandId) {
        return brandDAO.findById(brandId).orElse(null);
    }

    @Override
    public BrandEntity findByBrandName(String brandName) {
        return brandDAO.findByBrandName(brandName);
    }

    @Override
    public Map<String, Object> findAllWithPager(int pageNumber) {
        int pageSize = 10;
        Pageable pageable = PageRequest.of(pageNumber, pageSize);
        Page<BrandEntity> brandPage = brandDAO.findAll(pageable);

        Map<String, Object> response = new HashMap<>();
        response.put("brands", brandPage.getContent());
        response.put("currentPage", brandPage.getNumber());
        response.put("totalItems", brandPage.getTotalElements());
        response.put("totalPages", brandPage.getTotalPages());

        return response;
    }

    @Override
    public ResponseDataModel findAllWithPagerApi(int pageNumber) {
        try {
            Map<String, Object> data = findAllWithPager(pageNumber);
            return new ResponseDataModel(HttpStatus.OK, "Data retrieved successfully.", data);
        } catch (Exception e) {
            return new ResponseDataModel(HttpStatus.INTERNAL_SERVER_ERROR, "Error retrieving data.");
        }
    }

    @Override
    public ResponseDataModel findBrandByIdApi(Long brandId) {
        BrandEntity brand = findByBrandId(brandId);
        if (brand != null) {
            return new ResponseDataModel(HttpStatus.OK, "Brand retrieved successfully.", brand);
        }
        return new ResponseDataModel(HttpStatus.NOT_FOUND, "Brand not found.");
    }

    @Override
    public ResponseDataModel addApi(BrandEntity brandEntity) {
        try {
            BrandEntity savedBrand = add(brandEntity);
            return new ResponseDataModel(HttpStatus.CREATED, "Brand created successfully.", savedBrand);
        } catch (Exception e) {
            return new ResponseDataModel(HttpStatus.INTERNAL_SERVER_ERROR, "Error creating brand.");
        }
    }

    @Override
    public ResponseDataModel updateApi(BrandEntity brandEntity) {
        try {
            BrandEntity updatedBrand = update(brandEntity);
            return new ResponseDataModel(HttpStatus.OK, "Brand updated successfully.", updatedBrand);
        } catch (Exception e) {
            return new ResponseDataModel(HttpStatus.INTERNAL_SERVER_ERROR, "Error updating brand.");
        }
    }

    @Override
    public ResponseDataModel deleteApi(Long brandId) {
        return delete(brandId);
    }

    @Override
    public ResponseDataModel search(int pageNumber, String keyword) {
        try {
            int pageSize = 5; // Set your desired page size
            Pageable pageable = PageRequest.of(pageNumber, pageSize);
            Page<BrandEntity> page = brandDAO.findByBrandNameLike("%" + keyword + "%", pageable);

            Map<String, Object> response = new HashMap<>();
            response.put("brands", page.getContent());
            response.put("currentPage", page.getNumber());
            response.put("totalItems", page.getTotalElements());
            response.put("totalPages", page.getTotalPages());

            return new ResponseDataModel(HttpStatus.OK, "Data retrieved successfully.", response);
        } catch (Exception e) {
            return new ResponseDataModel(HttpStatus.INTERNAL_SERVER_ERROR, "Error retrieving data.");
        }
    }

}
