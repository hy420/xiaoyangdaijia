package com.yang.daijia.order.service.impl;

import com.yang.daijia.model.entity.order.OrderMonitor;
import com.yang.daijia.model.entity.order.OrderMonitorRecord;
import com.yang.daijia.order.mapper.OrderMonitorMapper;
import com.yang.daijia.order.repository.OrderMonitorRecordRepository;
import com.yang.daijia.order.service.OrderMonitorService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;

import jakarta.annotation.Resource;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
@SuppressWarnings({"unchecked", "rawtypes"})
public class OrderMonitorServiceImpl extends ServiceImpl<OrderMonitorMapper, OrderMonitor> implements OrderMonitorService {


    @Resource
    private OrderMonitorRecordRepository orderMonitorRecordRepository;

    // 保存订单监控记录数据
    @Override
    public Boolean saveOrderMonitorRecord(OrderMonitorRecord orderMonitorRecord) {
        orderMonitorRecordRepository.save(orderMonitorRecord);
        return true;
    }
}
