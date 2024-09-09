package com.yang.daijia.driver.service;

import com.yang.daijia.model.vo.driver.CosUploadVo;
import org.springframework.web.multipart.MultipartFile;

public interface CosService {

    // 文件上传
    CosUploadVo upload(MultipartFile file, String path);

    //获取临时签名URL
    String getImageUrl(String path);
}
