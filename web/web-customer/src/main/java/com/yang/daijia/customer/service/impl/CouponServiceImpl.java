package com.yang.daijia.customer.service.impl;

import com.yang.daijia.coupon.client.CouponFeignClient;
import com.yang.daijia.customer.service.CouponService;
import com.yang.daijia.model.vo.base.PageVo;
import com.yang.daijia.model.vo.coupon.AvailableCouponVo;
import com.yang.daijia.model.vo.coupon.NoReceiveCouponVo;
import com.yang.daijia.model.vo.coupon.NoUseCouponVo;
import com.yang.daijia.model.vo.coupon.UsedCouponVo;
import com.yang.daijia.model.vo.order.OrderBillVo;
import com.yang.daijia.order.client.OrderInfoFeignClient;
import jakarta.annotation.Resource;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.util.List;

@Slf4j
@Service
@SuppressWarnings({"unchecked", "rawtypes"})
public class CouponServiceImpl implements CouponService {


    @Resource
    private CouponFeignClient couponFeignClient;

    @Resource
    private OrderInfoFeignClient orderInfoFeignClient;

    // 查询未领取优惠券分页列表
    @Override
    public PageVo<NoReceiveCouponVo> findNoReceivePage(Long customerId, Long page, Long limit) {
        return couponFeignClient.findNoReceivePage(customerId, page, limit).getData();
    }

    //查询未使用优惠券分页列表
    @Override
    public PageVo<NoUseCouponVo> findNoUsePage(Long customerId, Long page, Long limit) {
        return couponFeignClient.findNoUsePage(customerId, page, limit).getData();
    }

    //查询已使用优惠券分页列表
    @Override
    public PageVo<UsedCouponVo> findUsedPage(Long customerId, Long page, Long limit) {
        return couponFeignClient.findUsedPage(customerId, page, limit).getData();
    }

    // 领取优惠券
    @Override
    public Boolean receive(Long customerId, Long couponId) {
        return couponFeignClient.receive(customerId, couponId).getData();
    }

    // 获取未使用的最佳优惠券信息
    @Override
    public List<AvailableCouponVo> findAvailableCoupon(Long customerId, Long orderId) {
        OrderBillVo orderBillVo = orderInfoFeignClient.getOrderBillInfo(orderId).getData();
        return couponFeignClient.findAvailableCoupon(customerId, orderBillVo.getPayAmount()).getData();
    }
}
