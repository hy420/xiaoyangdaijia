package com.yang.daijia.customer.service;

import com.yang.daijia.model.form.customer.UpdateWxPhoneForm;
import com.yang.daijia.model.vo.customer.CustomerLoginVo;

public interface CustomerService {


    String login(String code);

    CustomerLoginVo getCustomerLoginInfo(String token);

    CustomerLoginVo getCustomerInfo(Long customerId);

    //更新用户微信手机号
    Boolean updateWxPhoneNumber(UpdateWxPhoneForm updateWxPhoneForm);
}
