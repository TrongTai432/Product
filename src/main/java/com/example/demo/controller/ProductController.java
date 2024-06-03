package com.example.demo.controller;

import com.example.demo.entity.BrandEntity;
import com.example.demo.entity.ProductEntity;
import com.example.demo.model.PagerModel;
import com.example.demo.model.ResponseDataModel;
import com.example.demo.service.IBrandService;
import com.example.demo.service.IProductService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

@Controller
@RequestMapping(value = "/product")
public class ProductController {
    @Autowired
    private IProductService productService;
    @Autowired
    IBrandService brandService;

    @GetMapping
    public String initPage(Model model) {
        model.addAttribute("brandList", brandService.getAll());
        return "product";
    }

    @PostMapping(value = "/api/add")
    @ResponseBody
    public ResponseDataModel addProduct(@ModelAttribute ProductEntity productEntity) {
        return productService.addProduct(productEntity);
    }


    @GetMapping(value = "/api/findAll/{pageNumber}")
    @ResponseBody
    public ResponseDataModel findAllWithPaper(@PathVariable("pageNumber") int pageNumber) {
        return productService.findAllWithPaper(pageNumber);
    }

    @GetMapping(value = "/api/findAll")
    @ResponseBody
    public ResponseDataModel findByProductId(@RequestParam("id") Long productId) {
        return productService.findByProductId(productId);
    }

    @PostMapping(value = "/api/update")
    @ResponseBody
    public ResponseDataModel updateProduct(@ModelAttribute ProductEntity productEntity) {

        return productService.updateProduct(productEntity);
    }

    @DeleteMapping(value = "/api/delete/{productId}")
    @ResponseBody
    public ResponseDataModel deleteProduct(@PathVariable("productId") Long productId) {
        return productService.deleteProduct(productId);
    }


    @PostMapping(value = {"/api/searchProduct/{pageNumber}"})
    @ResponseBody
    public ResponseDataModel searchProduct(@RequestBody Map<String, Object> search,
                                           @PathVariable("pageNumber") int pageNumber) {
        return productService.searchByNameAndPrice(search, pageNumber);
    }

}
