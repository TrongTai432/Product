package com.example.demo.service;

import com.example.demo.constant.Constants;
import com.example.demo.constant.FileHelper;
import com.example.demo.dao.BrandDAO;
import com.example.demo.entity.BrandEntity;
import com.example.demo.model.PagerModel;
import com.example.demo.model.ResponseDataModel;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
@Transactional
public class BrandServiceImpl implements IBrandService {
    @Value("static/images/")
    private String brandLogoFolderPath;

    @Autowired
    BrandDAO brandDAO;

    @Override
    public BrandEntity add(BrandEntity brandEntity) {
        try {
            String imagePath = FileHelper.addNewFile(brandLogoFolderPath, brandEntity.getLogoFiles());
            brandEntity.setLogo(imagePath);
        } catch (IOException e) {
            e.printStackTrace();
        }
        return brandDAO.saveAndFlush(brandEntity);
    }

    @Override
    public BrandEntity update(BrandEntity brandEntity) {
        return brandDAO.save(brandEntity);
    }

    @Override
    public ResponseDataModel delete(Long brandId) {
        BrandEntity brandEntity = brandDAO.findByBrandId(brandId);
        if (brandEntity != null) {
            brandDAO.deleteById(brandId);
            brandDAO.flush();
            try {
                // Remove logo of brand from store folder
                FileHelper.deleteFile(brandEntity.getLogo());
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
        return null;
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
    public Map<String, Object> findAllWithPager(int pageNumber) {
        Map<String, Object> responseMap = new HashMap<>();
        Sort sortInfo = Sort.by(Sort.Direction.DESC, "brandId");
        Pageable pageable = PageRequest.of(pageNumber - 1, Constants.PAGE_SIZE, sortInfo);
        Page<BrandEntity> brandEntitiesPage = brandDAO
                .findAll(pageable);
        responseMap.put("brandsList", brandEntitiesPage.getContent());
        responseMap.put("paginationInfo", new PagerModel(pageNumber, brandEntitiesPage.getTotalPages()));
        return responseMap;
    }

    @Override
    public ResponseDataModel addApi(BrandEntity brandEntity) {
        int responseCode = Constants.RESULT_CD_FAIL;
        String responseMsg = StringUtils.EMPTY;
        try {
            if (findByBrandName(brandEntity.getBrandName()) != null) {
                responseMsg = "Brand Name is duplicated";
                responseCode = Constants.RESULT_CD_DUPL;
            } else {
                MultipartFile[] logoFiles = brandEntity.getLogoFiles();
                if (logoFiles != null && logoFiles[0].getSize() > 0) {

                    String imagePath = FileHelper.addNewFile(brandLogoFolderPath, logoFiles);
                    brandEntity.setLogo(imagePath);
                }
                brandDAO.saveAndFlush(brandEntity);
                responseMsg = "Brand is added successfully";
                responseCode = Constants.RESULT_CD_SUCCESS;
            }
        } catch (IOException e) {
            responseMsg = "Error when adding brand";

        }
        return new ResponseDataModel(responseCode, responseMsg);
    }

    @Override
    public ResponseDataModel findAllWithPagerApi(int pageNumber) {
        int responseCode = Constants.RESULT_CD_FAIL;
        String responseMsg = StringUtils.EMPTY;
        Map<String, Object> responseMap = new HashMap<>();
        try {
            Sort sortInfo = Sort.by(Sort.Direction.ASC, "brandName");
            Pageable pageable = PageRequest.of(pageNumber - 1, Constants.PAGE_SIZE, sortInfo);
            Page<BrandEntity> brandEntitiesPage = brandDAO.findAll(pageable);
            responseMap.put("brandsList", brandEntitiesPage.getContent());
            responseMap.put("paginationInfo", new PagerModel(pageNumber, brandEntitiesPage.getTotalPages()));
            responseMap.put("totalItem", brandEntitiesPage.getTotalElements());
            responseCode = Constants.RESULT_CD_SUCCESS;
        } catch (Exception e) {
            responseMsg = e.getMessage();

        }
        return new ResponseDataModel(responseCode, responseMsg, responseMap);
    }

    @Override
    public ResponseDataModel findBrandByIdApi(Long brandId) {
        int responseCode = Constants.RESULT_CD_FAIL;
        String responseMsg = StringUtils.EMPTY;
        BrandEntity brandEntity = null;
        try {
            brandEntity = brandDAO.findByBrandId(brandId);
            if (brandEntity != null) {
                responseCode = Constants.RESULT_CD_SUCCESS;
            }
        } catch (Exception e) {
            responseMsg = "Error when finding brand by ID";
        }
        return new ResponseDataModel(responseCode, responseMsg, brandEntity);
    }
    public int getTotalPageCount(int pageSize) {
        long recordCount = brandDAO.count(); // Giả sử phương thức count() trả về tổng số bản ghi
        return (int) Math.ceil((double) recordCount / pageSize);
    }
    @Override
    public ResponseDataModel updateApi(BrandEntity brandEntity) {
        int responseCode = Constants.RESULT_CD_FAIL;
        String responseMsg = StringUtils.EMPTY;
        try {
            BrandEntity duplicatedBrand = brandDAO.findByBrandNameAndBrandIdNot(brandEntity.getBrandName(),
                    brandEntity.getBrandId());
            if (duplicatedBrand != null) {
                responseMsg = "Brand Name is duplicated";
                responseCode = Constants.RESULT_CD_DUPL;
            } else {
                MultipartFile[] logoFiles = brandEntity.getLogoFiles();
                if (logoFiles != null && logoFiles[0].getSize() > 0) {
                    String imagePath = FileHelper.editFile(brandLogoFolderPath, logoFiles, brandEntity.getLogo());
                    brandEntity.setLogo(imagePath);
                }
                brandDAO.saveAndFlush(brandEntity);
                responseMsg = "Brand is updated successfully";
                responseCode = Constants.RESULT_CD_SUCCESS;
            }
        } catch (Exception e) {
            responseMsg = "Error when updating brand";
        }
        return new ResponseDataModel(responseCode, responseMsg);
    }

    @Override
    public ResponseDataModel deleteApi(Long brandId) {
        int responseCode = Constants.RESULT_CD_FAIL;
        String responseMsg = StringUtils.EMPTY;
        BrandEntity brandEntity = brandDAO.findByBrandId(brandId);
        try {
            if (brandEntity != null) {
                brandDAO.deleteById(brandId);
                brandDAO.flush();
                FileHelper.deleteFile(brandEntity.getLogo());
                responseMsg = "Brand is deleted successfully";
                responseCode = Constants.RESULT_CD_SUCCESS;
            }
        } catch (Exception e) {
            responseMsg = "Error when deleting brand";
        }
        return new ResponseDataModel(responseCode, responseMsg);

    }

    @Override
    public BrandEntity findByBrandName(String brandName) {
        // TODO Auto-generated method stub
        return brandDAO.findByBrandName(brandName);
    }

    @Override
    public ResponseDataModel search(int pageNumber, String keyword) {
        int responseCode = Constants.RESULT_CD_FAIL;
        String responseMsg = StringUtils.EMPTY;

        //List<BrandEntity> listBrand = brandDao.findByBrandNameLike("%" + keyword + "%" );
        Map<String, Object> rpMap = new HashMap<>();
        try {
            Sort sort = Sort.by(Sort.Direction.ASC, "brandName");
            Pageable pageable = PageRequest.of(pageNumber -1, Constants.PAGE_SIZE,sort);
            Page<BrandEntity> brandEntitiesPage = brandDAO.findByBrandNameLike("%" + keyword + "%",pageable);
            rpMap.put("brandsList", brandEntitiesPage.getContent());
            rpMap.put("paginationInfo", new PagerModel(pageNumber, brandEntitiesPage.getTotalPages()));
            rpMap.put("totalItem", brandEntitiesPage.getTotalElements());
            responseCode = Constants.RESULT_CD_SUCCESS;
            responseMsg = "ResultSet has " + brandEntitiesPage.getTotalElements() + " products";
        } catch (Exception e) {
            responseMsg = e.getMessage();
        }
        return new ResponseDataModel(responseCode, responseMsg, rpMap);
    }

}
