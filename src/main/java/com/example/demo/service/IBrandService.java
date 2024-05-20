package com.example.demo.service;

import com.example.demo.entity.BrandEntity;
import com.example.demo.model.ResponseDataModel;
import java.util.List;
import java.util.Map;

public interface IBrandService {

    BrandEntity add(BrandEntity brandEntity);

    BrandEntity update(BrandEntity brandEntity);

    ResponseDataModel delete(Long brandId);

    List<BrandEntity> getAll();

    BrandEntity findByBrandId(Long brandId);

    BrandEntity findByBrandName(String brandName);

    Map<String, Object> findAllWithPager(int pageNumber);

    ResponseDataModel findAllWithPagerApi(int pageNumber);

    ResponseDataModel findBrandByIdApi(Long brandId);

    ResponseDataModel addApi(BrandEntity brandEntity);

    ResponseDataModel updateApi(BrandEntity brandEntity);

    ResponseDataModel deleteApi(Long brandId);

    ResponseDataModel search(int pageNumber , String keyword);


}
