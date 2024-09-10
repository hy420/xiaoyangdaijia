package com.yang.daijia.driver.service.impl;

import com.yang.daijia.common.execption.GuiguException;
import com.yang.daijia.common.result.Result;
import com.yang.daijia.common.result.ResultCodeEnum;
import com.yang.daijia.driver.client.DriverInfoFeignClient;
import com.yang.daijia.driver.service.LocationService;
import com.yang.daijia.map.client.LocationFeignClient;
import com.yang.daijia.model.entity.driver.DriverSet;
import com.yang.daijia.model.form.map.OrderServiceLocationForm;
import com.yang.daijia.model.form.map.UpdateDriverLocationForm;
import com.yang.daijia.model.form.map.UpdateOrderLocationForm;
import jakarta.annotation.Resource;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.util.List;

@Slf4j
@Service
@SuppressWarnings({"unchecked", "rawtypes"})
public class LocationServiceImpl implements LocationService {

    @Resource
    private LocationFeignClient locationFeignClient;

    @Resource
    private DriverInfoFeignClient driverInfoFeignClient;

    //更新司机位置
    @Override
    public Boolean updateDriverLocation(UpdateDriverLocationForm updateDriverLocationForm) {
        //根据司机id获取司机个性化设置信息
        Long driverId = updateDriverLocationForm.getDriverId();
        Result<DriverSet> driverSetResult = driverInfoFeignClient.getDriverSet(driverId);
        DriverSet driverSet = driverSetResult.getData();

        //判断：如果司机开始接单，更新位置信息
        if(driverSet.getServiceStatus() == 1) {
            Result<Boolean> booleanResult = locationFeignClient.updateDriverLocation(updateDriverLocationForm);
            return booleanResult.getData();
        } else {
            //没有接单
            throw new GuiguException(ResultCodeEnum.NO_START_SERVICE);
        }
    }

    // 司机赶往代驾起始点：更新订单位置到Redis缓存
    @Override
    public Boolean updateOrderLocationToCache(UpdateOrderLocationForm updateOrderLocationForm) {
        return locationFeignClient.updateOrderLocationToCache(updateOrderLocationForm).getData();
    }

    //开始代驾服务：保存代驾服务订单位置
    @Override
    public Boolean saveOrderServiceLocation(List<OrderServiceLocationForm> orderLocationServiceFormList) {
        return locationFeignClient.saveOrderServiceLocation(orderLocationServiceFormList).getData();
    }
}
