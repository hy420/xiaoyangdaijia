package com.yang.daijia.order.mapper;

import com.yang.daijia.model.entity.order.OrderBill;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.math.BigDecimal;

@Mapper
public interface OrderBillMapper extends BaseMapper<OrderBill> {

    int updateCouponAmount(@Param("orderId") Long orderId, @Param("couponAmount") BigDecimal couponAmount);
}
