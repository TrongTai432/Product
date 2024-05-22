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

    @GetMapping("/api/findAll/{pageNumber}")
    @ResponseBody
    public ResponseDataModel findAllWithPagerApi(@PathVariable("pageNumber") int pageNumber) {
        return brandService.findAllWithPagerApi(pageNumber);
    }
    @GetMapping("/api/findAll")
    @ResponseBody
    public ResponseDataModel findBrandByIdApi(@RequestParam("id") Long brandId) {
        return brandService.findBrandByIdApi(brandId);
    }

    @PostMapping(value="/api/add")
    @ResponseBody
    public ResponseDataModel addApi(@ModelAttribute BrandEntity brandEntity) {
        return brandService.addApi(brandEntity);
    }

    @GetMapping("/api/getBrand")
    public ResponseEntity<BrandEntity> getBrandById(@RequestParam Long id) {
        BrandEntity brand = brandService.findByBrandId(id);
        if (brand != null) {
            return ResponseEntity.ok(brand);
        } else {
            return ResponseEntity.notFound().build();
        }
    }
    @PostMapping(value ="/api/update")
    @ResponseBody
    public ResponseDataModel updateApi(@ModelAttribute BrandEntity brandEntity) {
        return brandService.updateApi(brandEntity);
    }

    @DeleteMapping(value ="/api/delete/{brandId}")
    @ResponseBody
    public ResponseDataModel deleteApi(@PathVariable("brandId") Long brandId) {
        return brandService.deleteApi(brandId);
    }

    @GetMapping(value = { "/api/search/{keyword}/{pageNumber}" })
    @ResponseBody
    public ResponseDataModel searchApi(@PathVariable("keyword") String keyword,
                                       @PathVariable("pageNumber") int pageNumber) {
        return brandService.search(pageNumber, keyword);
    }
}
