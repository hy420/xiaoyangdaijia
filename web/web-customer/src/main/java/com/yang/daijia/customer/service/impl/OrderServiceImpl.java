package com.yang.daijia.customer.service.impl;

import com.yang.daijia.common.execption.GuiguException;
import com.yang.daijia.common.result.Result;
import com.yang.daijia.common.result.ResultCodeEnum;
import com.yang.daijia.coupon.client.CouponFeignClient;
import com.yang.daijia.customer.client.CustomerInfoFeignClient;
import com.yang.daijia.customer.service.OrderService;
import com.yang.daijia.dispatch.client.NewOrderFeignClient;
import com.yang.daijia.driver.client.DriverInfoFeignClient;
import com.yang.daijia.map.client.LocationFeignClient;
import com.yang.daijia.map.client.MapFeignClient;
import com.yang.daijia.map.client.WxPayFeignClient;
import com.yang.daijia.model.entity.order.OrderInfo;
import com.yang.daijia.model.enums.OrderStatus;
import com.yang.daijia.model.form.coupon.UseCouponForm;
import com.yang.daijia.model.form.customer.ExpectOrderForm;
import com.yang.daijia.model.form.customer.SubmitOrderForm;
import com.yang.daijia.model.form.map.CalculateDrivingLineForm;
import com.yang.daijia.model.form.order.OrderInfoForm;
import com.yang.daijia.model.form.payment.CreateWxPaymentForm;
import com.yang.daijia.model.form.payment.PaymentInfoForm;
import com.yang.daijia.model.form.rules.FeeRuleRequestForm;
import com.yang.daijia.model.vo.base.PageVo;
import com.yang.daijia.model.vo.customer.ExpectOrderVo;
import com.yang.daijia.model.vo.dispatch.NewOrderTaskVo;
import com.yang.daijia.model.vo.driver.DriverInfoVo;
import com.yang.daijia.model.vo.map.DrivingLineVo;
import com.yang.daijia.model.vo.map.OrderLocationVo;
import com.yang.daijia.model.vo.map.OrderServiceLastLocationVo;
import com.yang.daijia.model.vo.order.CurrentOrderInfoVo;
import com.yang.daijia.model.vo.order.OrderBillVo;
import com.yang.daijia.model.vo.order.OrderInfoVo;
import com.yang.daijia.model.vo.order.OrderPayVo;
import com.yang.daijia.model.vo.payment.WxPrepayVo;
import com.yang.daijia.model.vo.rules.FeeRuleResponseVo;
import com.yang.daijia.order.client.OrderInfoFeignClient;
import com.yang.daijia.rules.client.FeeRuleFeignClient;
import jakarta.annotation.Resource;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.BeanUtils;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.util.Date;

@Slf4j
@Service
@SuppressWarnings({"unchecked", "rawtypes"})
public class OrderServiceImpl implements OrderService {
    @Resource
    private FeeRuleFeignClient feeRuleFeignClient;

    @Resource
    private MapFeignClient mapFeignClient;

    @Resource
    private OrderInfoFeignClient orderInfoFeignClient;

    @Resource
    private NewOrderFeignClient newOrderFeignClient;

    @Resource
    private DriverInfoFeignClient driverInfoFeignClient;

    @Resource
    private LocationFeignClient locationFeignClient;

    @Resource
    private CustomerInfoFeignClient customerInfoFeignClient;

    @Resource
    private WxPayFeignClient wxPayFeignClient;

    @Resource
    private CouponFeignClient couponFeignClient;

    @Override
    public ExpectOrderVo expectOrder(ExpectOrderForm expectOrderForm) {
        //获取驾驶线路
        CalculateDrivingLineForm calculateDrivingLineForm = new CalculateDrivingLineForm();
        BeanUtils.copyProperties(expectOrderForm,calculateDrivingLineForm);
        Result<DrivingLineVo> drivingLineVoResult = mapFeignClient.calculateDrivingLine(calculateDrivingLineForm);
        DrivingLineVo drivingLineVo = drivingLineVoResult.getData();

        //获取订单费用
        FeeRuleRequestForm calculateOrderFeeForm = new FeeRuleRequestForm();
        calculateOrderFeeForm.setDistance(drivingLineVo.getDistance());
        calculateOrderFeeForm.setStartTime(new Date());
        calculateOrderFeeForm.setWaitMinute(0);
        Result<FeeRuleResponseVo> feeRuleResponseVoResult = feeRuleFeignClient.calculateOrderFee(calculateOrderFeeForm);
        FeeRuleResponseVo feeRuleResponseVo = feeRuleResponseVoResult.getData();

        //封装ExpectOrderVo
        ExpectOrderVo expectOrderVo = new ExpectOrderVo();
        expectOrderVo.setDrivingLineVo(drivingLineVo);
        expectOrderVo.setFeeRuleResponseVo(feeRuleResponseVo);
        return expectOrderVo;
    }

    //乘客下单
    @Override
    public Long submitOrder(SubmitOrderForm submitOrderForm) {
        //1 重新计算驾驶线路
        CalculateDrivingLineForm calculateDrivingLineForm = new CalculateDrivingLineForm();
        BeanUtils.copyProperties(submitOrderForm,calculateDrivingLineForm);
        Result<DrivingLineVo> drivingLineVoResult = mapFeignClient.calculateDrivingLine(calculateDrivingLineForm);
        DrivingLineVo drivingLineVo = drivingLineVoResult.getData();

        //2 重新订单费用
        FeeRuleRequestForm calculateOrderFeeForm = new FeeRuleRequestForm();
        calculateOrderFeeForm.setDistance(drivingLineVo.getDistance());
        calculateOrderFeeForm.setStartTime(new Date());
        calculateOrderFeeForm.setWaitMinute(0);
        Result<FeeRuleResponseVo> feeRuleResponseVoResult = feeRuleFeignClient.calculateOrderFee(calculateOrderFeeForm);
        FeeRuleResponseVo feeRuleResponseVo = feeRuleResponseVoResult.getData();

        //封装数据
        OrderInfoForm orderInfoForm = new OrderInfoForm();
        BeanUtils.copyProperties(submitOrderForm,orderInfoForm);
        orderInfoForm.setExpectDistance(drivingLineVo.getDistance());
        orderInfoForm.setExpectAmount(feeRuleResponseVo.getTotalAmount());
        Result<Long> orderInfoResult = orderInfoFeignClient.saveOrderInfo(orderInfoForm);
        Long orderId = orderInfoResult.getData();

        //任务调度：查询附近可以接单司机
        NewOrderTaskVo newOrderDispatchVo = new NewOrderTaskVo();
        newOrderDispatchVo.setOrderId(orderId);
        newOrderDispatchVo.setStartLocation(orderInfoForm.getStartLocation());
        newOrderDispatchVo.setStartPointLongitude(orderInfoForm.getStartPointLongitude());
        newOrderDispatchVo.setStartPointLatitude(orderInfoForm.getStartPointLatitude());
        newOrderDispatchVo.setEndLocation(orderInfoForm.getEndLocation());
        newOrderDispatchVo.setEndPointLongitude(orderInfoForm.getEndPointLongitude());
        newOrderDispatchVo.setEndPointLatitude(orderInfoForm.getEndPointLatitude());
        newOrderDispatchVo.setExpectAmount(orderInfoForm.getExpectAmount());
        newOrderDispatchVo.setExpectDistance(orderInfoForm.getExpectDistance());
        newOrderDispatchVo.setExpectTime(drivingLineVo.getDuration());
        newOrderDispatchVo.setFavourFee(orderInfoForm.getFavourFee());
        newOrderDispatchVo.setCreateTime(new Date());
        //远程调用
        Long jobId = newOrderFeignClient.addAndStartTask(newOrderDispatchVo).getData();
        //返回订单id
        return orderId;
    }

    //查询订单状态
    @Override
    public Integer getOrderStatus(Long orderId) {
        Result<Integer> integerResult = orderInfoFeignClient.getOrderStatus(orderId);
        return integerResult.getData();
    }

    //乘客查找当前订单
    @Override
    public CurrentOrderInfoVo searchCustomerCurrentOrder(Long customerId) {
        return orderInfoFeignClient.searchCustomerCurrentOrder(customerId).getData();
    }

    // 获取订单信息
    @Override
    public OrderInfoVo getOrderInfo(Long orderId, Long customerId) {
        OrderInfo orderInfo = orderInfoFeignClient.getOrderInfo(orderId).getData();
        //判断
        if(orderInfo.getCustomerId() != customerId) {
            throw new GuiguException(ResultCodeEnum.ILLEGAL_REQUEST);
        }

        //获取司机信息
        DriverInfoVo driverInfoVo = null;
        Long driverId = orderInfo.getDriverId();
        if(driverId != null) {
            driverInfoVo = driverInfoFeignClient.getDriverInfoOrder(driverId).getData();
        }

        //获取账单信息
        OrderBillVo orderBillVo = null;
        if(orderInfo.getStatus() >= OrderStatus.UNPAID.getStatus()) {
            orderBillVo = orderInfoFeignClient.getOrderBillInfo(orderId).getData();
        }

        OrderInfoVo orderInfoVo = new OrderInfoVo();
        orderInfoVo.setOrderId(orderId);
        BeanUtils.copyProperties(orderInfo,orderInfoVo);
        orderInfoVo.setOrderBillVo(orderBillVo);
        orderInfoVo.setDriverInfoVo(driverInfoVo);
        return orderInfoVo;
    }

    // 根据订单id获取司机基本信息
    @Override
    public DriverInfoVo getDriverInfo(Long orderId, Long customerId) {
        //根据订单id获取订单信息
        OrderInfo orderInfo = orderInfoFeignClient.getOrderInfo(orderId).getData();
        if(orderInfo.getCustomerId() != customerId) {
            throw new GuiguException(ResultCodeEnum.DATA_ERROR);
        }
        return driverInfoFeignClient.getDriverInfoOrder(orderInfo.getDriverId()).getData();
    }

    // 司机赶往代驾起始点：获取订单经纬度位置
    @Override
    public OrderLocationVo getCacheOrderLocation(Long orderId) {
        return locationFeignClient.getCacheOrderLocation(orderId).getData();
    }

    //计算最佳驾驶线路
    @Override
    public DrivingLineVo calculateDrivingLine(CalculateDrivingLineForm calculateDrivingLineForm) {
        return mapFeignClient.calculateDrivingLine(calculateDrivingLineForm).getData();
    }

    // 代驾服务：获取订单服务最后一个位置信息
    @Override
    public OrderServiceLastLocationVo getOrderServiceLastLocation(Long orderId) {
        return locationFeignClient.getOrderServiceLastLocation(orderId).getData();
    }

    // 获取乘客订单分页列表
    @Override
    public PageVo findCustomerOrderPage(Long customerId, Long page, Long limit) {
        return orderInfoFeignClient.findCustomerOrderPage(customerId,page,limit).getData();
    }

    //创建微信支付
    @Override
    public WxPrepayVo createWxPayment(CreateWxPaymentForm createWxPaymentForm) {
        //获取订单支付信息
        OrderPayVo orderPayVo = orderInfoFeignClient.getOrderPayVo(createWxPaymentForm.getOrderNo(),
                createWxPaymentForm.getCustomerId()).getData();
        //判断
        if(orderPayVo.getStatus() != OrderStatus.UNPAID.getStatus()) {
            throw new GuiguException(ResultCodeEnum.ILLEGAL_REQUEST);
        }

        //获取乘客和司机openid
        String customerOpenId = customerInfoFeignClient.getCustomerOpenId(orderPayVo.getCustomerId()).getData();

        String driverOpenId = driverInfoFeignClient.getDriverOpenId(orderPayVo.getDriverId()).getData();

        //4.处理优惠券
        BigDecimal couponAmount = null;
        //支付时选择过一次优惠券，如果支付失败或未支付，下次支付时不能再次选择，只能使用第一次选中的优惠券（前端已控制，后端再次校验）
        if (null == orderPayVo.getCouponAmount() && null != createWxPaymentForm.getCustomerCouponId() && createWxPaymentForm.getCustomerCouponId() != 0) {
            UseCouponForm useCouponForm = new UseCouponForm();
            useCouponForm.setOrderId(orderPayVo.getOrderId());
            useCouponForm.setCustomerCouponId(createWxPaymentForm.getCustomerCouponId());
            useCouponForm.setOrderAmount(orderPayVo.getPayAmount());
            useCouponForm.setCustomerId(createWxPaymentForm.getCustomerId());
            couponAmount = couponFeignClient.useCoupon(useCouponForm).getData();
        }

        //5.更新账单优惠券金额
        //支付金额
        BigDecimal payAmount = orderPayVo.getPayAmount();
        if (null != couponAmount) {
            Boolean isUpdate = orderInfoFeignClient.updateCouponAmount(orderPayVo.getOrderId(), couponAmount).getData();
            if (!isUpdate) {
                throw new GuiguException(ResultCodeEnum.DATA_ERROR);
            }
            //当前支付金额 = 支付金额 - 优惠券金额
            payAmount = payAmount.subtract(couponAmount);
        }

        //6.封装微信下单对象，微信支付只关注以下订单属性
        PaymentInfoForm paymentInfoForm = new PaymentInfoForm();
        paymentInfoForm.setCustomerOpenId(customerOpenId);
        paymentInfoForm.setDriverOpenId(driverOpenId);
        paymentInfoForm.setOrderNo(orderPayVo.getOrderNo());
        paymentInfoForm.setAmount(payAmount);
        paymentInfoForm.setContent(orderPayVo.getContent());
        paymentInfoForm.setPayWay(1);

        WxPrepayVo wxPrepayVo = wxPayFeignClient.createWxPayment(paymentInfoForm).getData();
        return wxPrepayVo;
    }

    // 支付状态查询
    @Override
    public Boolean queryPayStatus(String orderNo) {
        return wxPayFeignClient.queryPayStatus(orderNo).getData();
    }
}
