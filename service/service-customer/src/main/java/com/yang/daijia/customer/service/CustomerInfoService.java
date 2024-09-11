package com.yang.daijia.customer.service;

import com.yang.daijia.model.entity.customer.CustomerInfo;
import com.baomidou.mybatisplus.extension.service.IService;
import com.yang.daijia.model.form.customer.UpdateWxPhoneForm;
import com.yang.daijia.model.vo.customer.CustomerLoginVo;

public interface CustomerInfoService extends IService<CustomerInfo> {

    //微信小程序登录接口
    Long login(String code);

    //获取客户登录信息
    CustomerLoginVo getCustomerInfo(Long customerId);

    // 更新客户微信手机号码
    Boolean updateWxPhoneNumber(UpdateWxPhoneForm updateWxPhoneForm);

    // 获取客户OpenId
    String getCustomerOpenId(Long customerId);
}
