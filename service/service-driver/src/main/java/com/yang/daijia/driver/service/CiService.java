package com.yang.daijia.driver.service;

import com.yang.daijia.model.vo.order.TextAuditingVo;

public interface CiService {

    //图片审核
    Boolean imageAuditing(String path);

    //文本审核
    TextAuditingVo textAuditing(String content);
}
