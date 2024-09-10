package com.yang.daijia.driver.controller;

import com.yang.daijia.common.result.Result;
import com.yang.daijia.driver.service.CosService;
import com.yang.daijia.driver.service.FileService;
import com.yang.daijia.model.vo.driver.CosUploadVo;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.annotation.Resource;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

@Tag(name = "上传管理接口")
@RestController
@RequestMapping("file")
public class FileController {

    @Resource
    private FileService fileService;

    @Operation(summary = "文件上传")
    @PostMapping("/upload")
    public Result<String> upload(@RequestPart("file") MultipartFile file) {
        String url = fileService.upload(file);
        return Result.ok(url);
    }
}
