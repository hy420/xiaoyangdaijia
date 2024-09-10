package com.yang.daijia.order.mapper;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.yang.daijia.model.entity.order.OrderInfo;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.yang.daijia.model.vo.order.OrderListVo;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface OrderInfoMapper extends BaseMapper<OrderInfo> {

    //获取乘客订单分页列表
    IPage<OrderListVo> selectCustomerOrderPage(Page<OrderInfo> pageParam, Long customerId);

    // 获取司机订单分页列表
    IPage<OrderListVo> selectDriverOrderPage(Page<OrderInfo> pageParam, Long driverId);
}
