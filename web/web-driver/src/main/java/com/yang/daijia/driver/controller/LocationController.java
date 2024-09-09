package com.yang.daijia.driver.controller;

import com.yang.daijia.common.login.YangLogin;
import com.yang.daijia.common.result.Result;
import com.yang.daijia.common.util.AuthContextHolder;
import com.yang.daijia.driver.service.LocationService;
import com.yang.daijia.model.form.map.UpdateDriverLocationForm;
import com.yang.daijia.model.form.map.UpdateOrderLocationForm;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.annotation.Resource;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@Slf4j
@Tag(name = "位置API接口管理")
@RestController
@RequestMapping(value="/location")
@SuppressWarnings({"unchecked", "rawtypes"})
public class LocationController {

    @Resource
    private LocationService locationService;

    @Operation(summary = "开启接单服务：更新司机经纬度位置")
    @YangLogin
    @PostMapping("/updateDriverLocation")
    public Result<Boolean> updateDriverLocation(@RequestBody UpdateDriverLocationForm updateDriverLocationForm) {
        Long driverId = AuthContextHolder.getUserId();//司机id
        updateDriverLocationForm.setDriverId(driverId);
        return Result.ok(locationService.updateDriverLocation(updateDriverLocationForm));
    }

    @Operation(summary = "司机赶往代驾起始点：更新订单位置到Redis缓存")
    @YangLogin
    @PostMapping("/updateOrderLocationToCache")
    public Result updateOrderLocationToCache(@RequestBody UpdateOrderLocationForm updateOrderLocationForm) {
        return Result.ok(locationService.updateOrderLocationToCache(updateOrderLocationForm));
    }
}

