package com.yang.daijia.driver.service;

import org.springframework.web.multipart.MultipartFile;

public interface FileService {

    // 文件上传
    String upload(MultipartFile file);
}
