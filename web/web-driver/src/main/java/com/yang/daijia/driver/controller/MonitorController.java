package com.yang.daijia.driver.controller;

import com.yang.daijia.common.result.Result;
import com.yang.daijia.driver.service.MonitorService;
import com.yang.daijia.model.form.order.OrderMonitorForm;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.annotation.Resource;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

@Slf4j
@Tag(name = "监控接口管理")
@RestController
@RequestMapping(value="/monitor")
@SuppressWarnings({"unchecked", "rawtypes"})
public class MonitorController {

    @Resource
    private MonitorService monitorService;

    @Operation(summary = "上传录音")
    @PostMapping("/upload")
    public Result<Boolean> upload(@RequestParam("file") MultipartFile file,
                                  OrderMonitorForm orderMonitorForm) {

        return Result.ok(monitorService.upload(file, orderMonitorForm));
    }

}

