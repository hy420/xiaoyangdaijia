package com.yang.daijia.rules.service;

import com.yang.daijia.model.form.rules.RewardRuleRequestForm;
import com.yang.daijia.model.vo.rules.RewardRuleResponseVo;

public interface RewardRuleService {

    // 计算订单奖励费用
    RewardRuleResponseVo calculateOrderRewardFee(RewardRuleRequestForm rewardRuleRequestForm);
}
