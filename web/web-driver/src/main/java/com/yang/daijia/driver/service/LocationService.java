package com.yang.daijia.driver.service;

import com.yang.daijia.model.form.map.OrderServiceLocationForm;
import com.yang.daijia.model.form.map.UpdateDriverLocationForm;
import com.yang.daijia.model.form.map.UpdateOrderLocationForm;

import java.util.List;

public interface LocationService {


    //更新司机位置
    Boolean updateDriverLocation(UpdateDriverLocationForm updateDriverLocationForm);

    // 司机赶往代驾起始点：更新订单位置到Redis缓存
    Boolean updateOrderLocationToCache(UpdateOrderLocationForm updateOrderLocationForm);

    //开始代驾服务：保存代驾服务订单位置
    Boolean saveOrderServiceLocation(List<OrderServiceLocationForm> orderLocationServiceFormList);
}
