package com.yang.daijia.driver.mapper;

import com.yang.daijia.model.entity.driver.DriverAccount;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Mapper;

import java.math.BigDecimal;

@Mapper
public interface DriverAccountMapper extends BaseMapper<DriverAccount> {


    // 添加奖励到司机账户表
    void add(Long driverId, BigDecimal amount);
}
