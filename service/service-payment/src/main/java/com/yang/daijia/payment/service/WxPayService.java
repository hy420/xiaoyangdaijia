package com.yang.daijia.payment.service;

import com.yang.daijia.model.form.payment.PaymentInfoForm;
import com.yang.daijia.model.vo.payment.WxPrepayVo;
import jakarta.servlet.http.HttpServletRequest;

public interface WxPayService {


    //创建微信支付
    WxPrepayVo createWxPayment(PaymentInfoForm paymentInfoForm);

    //查询支付状态
    Boolean queryPayStatus(String orderNo);

    //微信支付成功后，进行的回调
    void wxnotify(HttpServletRequest request);

    //支付成功后续处理
    void handleOrder(String orderNo);
}
