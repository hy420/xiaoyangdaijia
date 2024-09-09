package com.yang.daijia.customer.controller;

import com.yang.daijia.common.login.YangLogin;
import com.yang.daijia.common.result.Result;
import com.yang.daijia.common.util.AuthContextHolder;
import com.yang.daijia.customer.service.CustomerService;
import com.yang.daijia.model.form.customer.UpdateWxPhoneForm;
import com.yang.daijia.model.vo.customer.CustomerLoginVo;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.annotation.Resource;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

@Slf4j
@Tag(name = "客户API接口管理")
@RestController
@RequestMapping("/customer")
@SuppressWarnings({"unchecked", "rawtypes"})
public class CustomerController {
    @Resource
    private CustomerService customerInfoService;

    @Operation(summary = "小程序授权登录")
    @GetMapping("/login/{code}")
    public Result<String> wxLogin(@PathVariable String code) {
        return Result.ok(customerInfoService.login(code));
    }

    @Operation(summary = "获取客户登录信息")
    @YangLogin
    @GetMapping("/getCustomerLoginInfo")
    public Result<CustomerLoginVo>
    getCustomerLoginInfo() {
        //1 从请求头获取token字符串
//        HttpServletRequest request
//        String token = request.getHeader("token");
        // 1. 从ThreadLocal 中获取用户id
        Long customerId = AuthContextHolder.getUserId();
        //调用service
        CustomerLoginVo customerLoginVo = customerInfoService.getCustomerInfo(customerId);

        return Result.ok(customerLoginVo);
    }

//    @Operation(summary = "获取客户登录信息")
//    @YangLogin
//    @GetMapping("/getCustomerLoginInfo")
//    public Result<CustomerLoginVo>
//    getCustomerLoginInfo(@RequestHeader(value = "token") String token) {
//        //1 从请求头获取token字符串
////        HttpServletRequest request
////        String token = request.getHeader("token");
//
//        //调用service
//        CustomerLoginVo customerLoginVo = customerInfoService.getCustomerLoginInfo(token);
//
//        return Result.ok(customerLoginVo);
//    }

    @Operation(summary = "更新用户微信手机号")
    @YangLogin
    @PostMapping("/updateWxPhone")
    public Result updateWxPhone(@RequestBody UpdateWxPhoneForm updateWxPhoneForm) {
        updateWxPhoneForm.setCustomerId(AuthContextHolder.getUserId());
        return Result.ok(customerInfoService.updateWxPhoneNumber(updateWxPhoneForm));
    }
}

