package com.yang.daijia.customer.service;

import com.yang.daijia.model.vo.base.PageVo;
import com.yang.daijia.model.vo.coupon.AvailableCouponVo;
import com.yang.daijia.model.vo.coupon.NoReceiveCouponVo;
import com.yang.daijia.model.vo.coupon.NoUseCouponVo;
import com.yang.daijia.model.vo.coupon.UsedCouponVo;

import java.util.List;

public interface CouponService  {


    // 查询未领取优惠券分页列表
    PageVo<NoReceiveCouponVo> findNoReceivePage(Long customerId, Long page, Long limit);

    //查询未使用优惠券分页列表
    PageVo<NoUseCouponVo> findNoUsePage(Long customerId, Long page, Long limit);

    //查询已使用优惠券分页列表
    PageVo<UsedCouponVo> findUsedPage(Long customerId, Long page, Long limit);

    // 领取优惠券
    Boolean receive(Long customerId, Long couponId);

    // 获取未使用的最佳优惠券信息
    List<AvailableCouponVo> findAvailableCoupon(Long customerId, Long orderId);
}
