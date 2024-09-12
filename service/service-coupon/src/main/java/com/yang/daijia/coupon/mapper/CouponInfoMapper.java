package com.yang.daijia.coupon.mapper;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.yang.daijia.model.entity.coupon.CouponInfo;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.yang.daijia.model.vo.coupon.NoReceiveCouponVo;
import com.yang.daijia.model.vo.coupon.NoUseCouponVo;
import com.yang.daijia.model.vo.coupon.UsedCouponVo;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface CouponInfoMapper extends BaseMapper<CouponInfo> {

    // 查询未领取优惠券分页列表
    IPage<NoReceiveCouponVo> findNoReceivePage(Page<CouponInfo> pageParam, @Param("customerId") Long customerId);

    // 查询未使用优惠券分页列表
    IPage<NoUseCouponVo> findNoUsePage(Page<CouponInfo> pageParam, @Param("customerId") Long customerId);

    // 查询已使用优惠券分页列表
    IPage<UsedCouponVo> findUsedPage(Page<CouponInfo> pageParam, @Param("customerId") Long customerId);

    // 更新领取数量
    int updateReceiveCount(@Param("id") Long id);

    int updateReceiveCountByLimit(@Param("id") Long id);

    // 获取未使用的优惠券列表
    List<NoUseCouponVo> findNoUseList(Long customerId);

    int updateUseCount(@Param("id") Long id);
}
