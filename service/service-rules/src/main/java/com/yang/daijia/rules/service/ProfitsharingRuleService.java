package com.yang.daijia.rules.service;

import com.yang.daijia.model.form.rules.ProfitsharingRuleRequestForm;
import com.yang.daijia.model.vo.rules.ProfitsharingRuleResponseVo;

public interface ProfitsharingRuleService {

    // 计算系统分账费用
    ProfitsharingRuleResponseVo calculateOrderProfitsharingFee(ProfitsharingRuleRequestForm profitsharingRuleRequestForm);
}
