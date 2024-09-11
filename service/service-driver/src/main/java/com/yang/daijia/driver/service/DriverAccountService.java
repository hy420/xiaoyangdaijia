package com.yang.daijia.driver.service;

import com.yang.daijia.model.entity.driver.DriverAccount;
import com.baomidou.mybatisplus.extension.service.IService;
import com.yang.daijia.model.form.driver.TransferForm;

public interface DriverAccountService extends IService<DriverAccount> {


    //转账
    Boolean transfer(TransferForm transferForm);
}
