package com.yang.daijia.rules.service;

import com.yang.daijia.model.form.rules.FeeRuleRequestForm;
import com.yang.daijia.model.vo.rules.FeeRuleResponseVo;

public interface FeeRuleService {

    //计算订单费用
    FeeRuleResponseVo calculateOrderFee(FeeRuleRequestForm calculateOrderFeeForm);
}
