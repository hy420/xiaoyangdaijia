package com.yang.daijia.driver.service.impl;

import com.baomidou.mybatisplus.core.assist.ISqlRunner;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.yang.daijia.driver.mapper.DriverAccountDetailMapper;
import com.yang.daijia.driver.mapper.DriverAccountMapper;
import com.yang.daijia.driver.service.DriverAccountService;
import com.yang.daijia.model.entity.driver.DriverAccount;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.yang.daijia.model.entity.driver.DriverAccountDetail;
import com.yang.daijia.model.form.driver.TransferForm;
import jakarta.annotation.Resource;

import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.BeanUtils;
import org.springframework.stereotype.Service;

@Slf4j
@Service
@SuppressWarnings({"unchecked", "rawtypes"})
public class DriverAccountServiceImpl extends ServiceImpl<DriverAccountMapper, DriverAccount> implements DriverAccountService {

    @Resource
    private DriverAccountDetailMapper driverAccountDetailMapper;

    @Resource
    private DriverAccountMapper driverAccountMapper;

    //转账
    @Override
    public Boolean transfer(TransferForm transferForm) {
        //1 去重
        LambdaQueryWrapper<DriverAccountDetail> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(DriverAccountDetail::getTradeNo,transferForm.getTradeNo());
        Long count = driverAccountDetailMapper.selectCount(wrapper);
        if(count > 0) {
            return true;
        }

        //2 添加奖励到司机账户表
        driverAccountMapper.add(transferForm.getDriverId(),transferForm.getAmount());

        //3 添加交易记录
        DriverAccountDetail driverAccountDetail = new DriverAccountDetail();
        BeanUtils.copyProperties(transferForm,driverAccountDetail);
        driverAccountDetailMapper.insert(driverAccountDetail);

        return true;
    }
}
