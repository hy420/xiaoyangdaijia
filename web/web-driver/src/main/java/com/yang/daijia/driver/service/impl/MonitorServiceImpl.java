package com.yang.daijia.driver.service.impl;

import com.yang.daijia.driver.client.CiFeignClient;
import com.yang.daijia.driver.service.FileService;
import com.yang.daijia.driver.service.MonitorService;
import com.yang.daijia.model.entity.order.OrderMonitorRecord;
import com.yang.daijia.model.form.order.OrderMonitorForm;
import com.yang.daijia.model.vo.order.TextAuditingVo;
import com.yang.daijia.order.client.OrderMonitorFeignClient;
import jakarta.annotation.Resource;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

@Slf4j
@Service
@SuppressWarnings({"unchecked", "rawtypes"})
public class MonitorServiceImpl implements MonitorService {

    @Resource
    private FileService fileService;

    @Resource
    private OrderMonitorFeignClient orderMonitorFeignClient;

    @Resource
    private CiFeignClient ciFeignClient;

    // 上传录音
    @Override
    public Boolean upload(MultipartFile file, OrderMonitorForm orderMonitorForm) {
        //上传文件
        String url = fileService.upload(file);

        OrderMonitorRecord orderMonitorRecord = new OrderMonitorRecord();
        orderMonitorRecord.setOrderId(orderMonitorForm.getOrderId());
        orderMonitorRecord.setFileUrl(url);
        orderMonitorRecord.setContent(orderMonitorForm.getContent());

        //增加文本审核
        TextAuditingVo textAuditingVo =
                ciFeignClient.textAuditing(orderMonitorForm.getContent()).getData();
        orderMonitorRecord.setResult(textAuditingVo.getResult());
        orderMonitorRecord.setKeywords(textAuditingVo.getKeywords());

        orderMonitorFeignClient.saveMonitorRecord(orderMonitorRecord);

        return true;
    }
}
