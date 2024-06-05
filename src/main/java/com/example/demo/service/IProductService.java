package com.example.demo.service;

import com.example.demo.entity.ProductEntity;
import com.example.demo.model.ResponseDataModel;
import java.util.List;
import java.util.Map;

public interface IProductService {
    List<ProductEntity> getAll();

    ResponseDataModel addProduct(ProductEntity productEntity);

    ProductEntity findByProductName(String productName);

    ResponseDataModel findAllWithPaper(int papeNumber);

    ResponseDataModel findByProductId(Long productId);

    ResponseDataModel updateProduct(ProductEntity productEntity);

    ResponseDataModel deleteProduct(Long productId);

    ResponseDataModel searchByNameAndPrice(Map<String, Object> search, int pageNumber);
}
