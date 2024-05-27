package com.example.demo.service;

import com.example.demo.constant.Constants;
import com.example.demo.constant.FileHelper;
import com.example.demo.dao.ProductDAO;
import com.example.demo.entity.ProductEntity;
import com.example.demo.model.PagerModel;
import com.example.demo.model.ResponseDataModel;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
@Transactional
public class ProductServiceImpl implements IProductService{

    private String productImageFolderPath;
    @Autowired
    private ProductDAO productDao;

    @Override
    public List<ProductEntity> getAll() {
        return productDao.findAll();
    }

    @Override
    public ProductEntity findByProductName(String productName) {
        return productDao.findByProductName(productName);
    }

    @Override
    public ResponseDataModel addProduct(ProductEntity productEntity) {
        int responseCode = Constants.RESULT_CD_FAIL;
        String responseMsg = StringUtils.EMPTY;
        try {
            if(findByProductName(productEntity.getProductName()) != null) {
                responseCode = Constants.RESULT_CD_DUPL;
                responseMsg = "Product Name is duplicated";
            }else {
                MultipartFile[] imageFiles = productEntity.getImageFiles();
                if(imageFiles != null && imageFiles[0].getSize() > 0) {
                    String imagePath = FileHelper.addNewFile(productImageFolderPath, imageFiles);
                    productEntity.setImage(imagePath);
                }
                productDao.saveAndFlush(productEntity);
                responseCode = Constants.RESULT_CD_SUCCESS;
                responseMsg = "Product is added successfully";

            }
        } catch (Exception e) {
            responseMsg = "Error when adding brand";

        }
        return new ResponseDataModel(responseCode, responseMsg);
    }

    @Override
    public ResponseDataModel findAllWithPaper(int pageNumber) {
        int responseCode = Constants.RESULT_CD_FAIL;
        String responseMsg = StringUtils.EMPTY;
        Map<String, Object> rpMap = new HashMap<>();
        try {
            Sort sort = Sort.by(Sort.Direction.ASC, "productName");
            Pageable pageable = PageRequest.of(pageNumber - 1, Constants.PAGE_SIZE,sort);
            Page<ProductEntity> pages = productDao.findAll(pageable);
            rpMap.put("productList", pages.getContent());
            rpMap.put("paginationInfo", new PagerModel(pageNumber, pages.getTotalPages()));
            rpMap.put("totalItem", pages.getTotalElements());
            responseCode = Constants.RESULT_CD_SUCCESS;
        } catch (Exception e) {
            responseMsg = e.getMessage();

        }
        return new ResponseDataModel(responseCode, responseMsg,rpMap);
    }

    @Override
    public ResponseDataModel findByProductId(Long productId) {
        int responseCode = Constants.RESULT_CD_FAIL;
        String responseMsg = StringUtils.EMPTY;
        ProductEntity productEntity = null;
        try {
            productEntity = productDao.findByProductId(productId);
            if (productEntity != null) {
                responseCode = Constants.RESULT_CD_SUCCESS;
            }
        } catch (Exception e) {
            responseMsg = ("error");

        }

        return new ResponseDataModel(responseCode, responseMsg, productEntity);
    }

    @Override
    public ResponseDataModel updateProduct(ProductEntity productEntity) {
        int responseCode = Constants.RESULT_CD_FAIL;
        String responseMsg = StringUtils.EMPTY;
        try {
            ProductEntity productEntityUpdated = productDao.findByProductNameAndProductIdNot(productEntity.getProductName(),
                    productEntity.getProductId());
            if(productEntityUpdated != null) {
                responseMsg = "Product Name is duplicated";
                responseCode = Constants.RESULT_CD_DUPL;
            }else {
                MultipartFile[] imageFiles = productEntity.getImageFiles();
                if(imageFiles != null && imageFiles[0].getSize() > 0) {
                    String imagePath = FileHelper.editFile(productImageFolderPath, imageFiles, productEntity.getImage());
                    productEntity.setImage(imagePath);
                }
                productDao.saveAndFlush(productEntity);
                responseCode = Constants.RESULT_CD_SUCCESS;
                responseMsg = "Product is updated successfully";
            }
        } catch (Exception e) {
            responseMsg = "Error when updating product";

        }
        return new ResponseDataModel(responseCode, responseMsg);
    }

    @Override
    public ResponseDataModel deleteProduct(Long productId) {
        int responseCode = Constants.RESULT_CD_FAIL;
        String responseMsg = StringUtils.EMPTY;
        ProductEntity productEntity = productDao.findByProductId(productId);
        try {
            if(productEntity != null) {
                productDao.deleteById(productId);
                productDao.flush();
                FileHelper.deleteFile(productEntity.getImage());
                responseCode = Constants.RESULT_CD_SUCCESS;
                responseMsg = "Product is deleted successfully";
            }

        } catch (Exception e) {
            responseMsg = "Error when delete product";

        }
        return new ResponseDataModel(responseCode, responseMsg);
    }


    @Override
    public ResponseDataModel searchByNameAndPrice(Map<String, Object> search, int pageNumber) {
       return null;

    }




}
