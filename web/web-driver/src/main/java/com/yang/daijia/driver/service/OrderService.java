package com.yang.daijia.driver.service;

import com.yang.daijia.model.form.map.CalculateDrivingLineForm;
import com.yang.daijia.model.form.order.OrderFeeForm;
import com.yang.daijia.model.form.order.StartDriveForm;
import com.yang.daijia.model.form.order.UpdateOrderCartForm;
import com.yang.daijia.model.vo.base.PageVo;
import com.yang.daijia.model.vo.map.DrivingLineVo;
import com.yang.daijia.model.vo.order.CurrentOrderInfoVo;
import com.yang.daijia.model.vo.order.NewOrderDataVo;
import com.yang.daijia.model.vo.order.OrderInfoVo;

import java.util.List;

public interface OrderService {


    // 查询订单状态
    Integer getOrderStatus(Long orderId);

    // 查询司机新订单数据
    List<NewOrderDataVo> findNewOrderQueueData(Long driverId);

    // 司机抢单
    Boolean robNewOrder(Long driverId, Long orderId);


    // 司机端查找当前订单
    CurrentOrderInfoVo searchDriverCurrentOrder(Long driverId);

    // 获取订单账单详细信息
    OrderInfoVo getOrderInfo(Long orderId, Long driverId);

    //计算最佳驾驶线路
    DrivingLineVo calculateDrivingLine(CalculateDrivingLineForm calculateDrivingLineForm);

    // 司机到达代驾起始地点
    Boolean driverArriveStartLocation(Long orderId, Long driverId);

    // 更新代驾车辆信息
    Boolean updateOrderCart(UpdateOrderCartForm updateOrderCartForm);

    // 开始代驾服务
    Boolean startDrive(StartDriveForm startDriveForm);

    // 结束代驾服务更新订单账单
    Boolean endDrive(OrderFeeForm orderFeeForm);

    // 获取司机订单分页列表
    PageVo findDriverOrderPage(Long driverId, Long page, Long limit);

    //使用多线程CompletableFuture实现
    // 结束代驾服务更新订单账单
    Boolean endDriveThread(OrderFeeForm orderFeeForm);

    // 司机发送账单信息
    Boolean sendOrderBillInfo(Long orderId, Long driverId);
}
