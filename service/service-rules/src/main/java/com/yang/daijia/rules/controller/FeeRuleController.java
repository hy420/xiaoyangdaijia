package com.yang.daijia.rules.controller;

import com.yang.daijia.common.result.Result;
import com.yang.daijia.model.form.rules.FeeRuleRequestForm;
import com.yang.daijia.model.vo.rules.FeeRuleResponseVo;
import com.yang.daijia.rules.service.FeeRuleService;
import io.swagger.v3.oas.annotations.Operation;
import jakarta.annotation.Resource;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@Slf4j
@RestController
@RequestMapping("/rules/fee")
@SuppressWarnings({"unchecked", "rawtypes"})
public class FeeRuleController {

    @Resource
    private FeeRuleService feeRuleService;

    @Operation(summary = "计算订单费用")
    @PostMapping("/calculateOrderFee")
    public Result<FeeRuleResponseVo> calculateOrderFee(@RequestBody FeeRuleRequestForm calculateOrderFeeForm) {
        FeeRuleResponseVo feeRuleResponseVo = feeRuleService.calculateOrderFee(calculateOrderFeeForm);
        return Result.ok(feeRuleResponseVo);
    }


}

