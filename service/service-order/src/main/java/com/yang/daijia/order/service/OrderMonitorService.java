package com.yang.daijia.order.service;

import com.yang.daijia.model.entity.order.OrderMonitor;
import com.baomidou.mybatisplus.extension.service.IService;
import com.yang.daijia.model.entity.order.OrderMonitorRecord;

public interface OrderMonitorService extends IService<OrderMonitor> {

    // 保存订单监控记录数据
    Boolean saveOrderMonitorRecord(OrderMonitorRecord orderMonitorRecord);
}
