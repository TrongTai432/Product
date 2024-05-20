package com.example.demo.controller;

import com.example.demo.entity.BrandEntity;
import com.example.demo.model.ResponseDataModel;
import com.example.demo.service.IBrandService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
@RequestMapping(value = { "/brand" })
public class BrandController {
    @Autowired
    IBrandService brandService;

    @GetMapping
    public String getAllBrands(Model model){
        List<BrandEntity> brands = brandService.getAll();
        model.addAttribute("brands", brands);
        return "brand";
 }

    @GetMapping("/{id}")
    public ResponseEntity<ResponseDataModel> getBrandById(@PathVariable Long id) {
        ResponseDataModel response = brandService.findBrandByIdApi(id);
        return new ResponseEntity<>(response, response.getStatus());
    }

    @PostMapping
    public ResponseEntity<ResponseDataModel> createBrand(@RequestBody BrandEntity brandEntity) {
        ResponseDataModel response = brandService.addApi(brandEntity);
        return new ResponseEntity<>(response, response.getStatus());
    }

    @PutMapping("/{id}")
    public ResponseEntity<ResponseDataModel> updateBrand(@PathVariable Long id, @RequestBody BrandEntity brandEntity) {
        if (brandService.findByBrandId(id) == null) {
            return new ResponseEntity<>(new ResponseDataModel(HttpStatus.NOT_FOUND, "Brand not found."), HttpStatus.NOT_FOUND);
        }
        brandEntity.setBrandId(id);
        ResponseDataModel response = brandService.updateApi(brandEntity);
        return new ResponseEntity<>(response, response.getStatus());
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<ResponseDataModel> deleteBrand(@PathVariable Long id) {
        ResponseDataModel response = brandService.deleteApi(id);
        return new ResponseEntity<>(response, response.getStatus());
    }

    @GetMapping("/search")
    public ResponseEntity<ResponseDataModel> searchBrandsByName(@RequestParam String name, @RequestParam int page) {
        ResponseDataModel response = brandService.search(page, name);
        return new ResponseEntity<>(response, response.getStatus());
    }

    @GetMapping("/paged")
    public ResponseEntity<ResponseDataModel> getAllBrandsPaged(@RequestParam int page) {
        ResponseDataModel response = brandService.findAllWithPagerApi(page);
        return new ResponseEntity<>(response, response.getStatus());
    }
}
