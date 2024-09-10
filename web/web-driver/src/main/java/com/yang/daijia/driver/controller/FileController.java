package com.yang.daijia.driver.controller;

import com.yang.daijia.common.result.Result;
import com.yang.daijia.driver.service.CosService;
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
    private CosService cosService;

    //文件上传接口
    @Operation(summary = "上传")
    //@YangLogin
    @PostMapping("/upload")
    public Result<String> upload(@RequestPart("file") MultipartFile file,
                                      @RequestParam(name = "path",defaultValue = "auth") String path) {
        CosUploadVo cosUploadVo = cosService.uploadFile(file,path);
        return Result.ok(cosUploadVo.getShowUrl());
    }
}
