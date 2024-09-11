package com.yang.daijia.customer.service;

import com.yang.daijia.model.form.customer.ExpectOrderForm;
import com.yang.daijia.model.form.customer.SubmitOrderForm;
import com.yang.daijia.model.form.map.CalculateDrivingLineForm;
import com.yang.daijia.model.form.payment.CreateWxPaymentForm;
import com.yang.daijia.model.vo.base.PageVo;
import com.yang.daijia.model.vo.customer.ExpectOrderVo;
import com.yang.daijia.model.vo.driver.DriverInfoVo;
import com.yang.daijia.model.vo.map.DrivingLineVo;
import com.yang.daijia.model.vo.map.OrderLocationVo;
import com.yang.daijia.model.vo.map.OrderServiceLastLocationVo;
import com.yang.daijia.model.vo.order.CurrentOrderInfoVo;
import com.yang.daijia.model.vo.order.OrderInfoVo;
import com.yang.daijia.model.vo.payment.WxPrepayVo;

public interface OrderService {

    //预估订单数据
    ExpectOrderVo expectOrder(ExpectOrderForm expectOrderForm);

    //乘客下单
    Long submitOrder(SubmitOrderForm submitOrderForm);

    //查询订单状态
    Integer getOrderStatus(Long orderId);

    //乘客查找当前订单
    CurrentOrderInfoVo searchCustomerCurrentOrder(Long customerId);

    // 获取订单信息
    OrderInfoVo getOrderInfo(Long orderId, Long customerId);

    // 根据订单id获取司机基本信息
    DriverInfoVo getDriverInfo(Long orderId, Long customerId);

    // 司机赶往代驾起始点：获取订单经纬度位置
    OrderLocationVo getCacheOrderLocation(Long orderId);

    //计算最佳驾驶线路
    DrivingLineVo calculateDrivingLine(CalculateDrivingLineForm calculateDrivingLineForm);

    // 代驾服务：获取订单服务最后一个位置信息
    OrderServiceLastLocationVo getOrderServiceLastLocation(Long orderId);

    // 获取乘客订单分页列表
    PageVo findCustomerOrderPage(Long customerId, Long page, Long limit);

    //创建微信支付
    WxPrepayVo createWxPayment(CreateWxPaymentForm createWxPaymentForm);

    // 支付状态查询
    Boolean queryPayStatus(String orderNo);
}
