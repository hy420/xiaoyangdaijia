package com.yang.daijia.order.handler;

import com.alibaba.nacos.common.utils.StringUtils;
import com.yang.daijia.order.service.OrderInfoService;
import jakarta.annotation.PostConstruct;
import jakarta.annotation.Resource;
import org.redisson.api.RBlockingQueue;
import org.redisson.api.RedissonClient;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

//监听延迟队列
@Component
public class RedisDelayHandle {

    @Resource
    private RedissonClient redissonClient;

    @Resource
    private OrderInfoService orderInfoService;

    @PostConstruct
    public void listener() {
        new Thread(()->{
            while(true) {
                //获取延迟队列里面阻塞队列
                RBlockingQueue<String> blockingQueue = redissonClient.getBlockingQueue("queue_cancel");

                //从队列获取消息
                try {
                    String orderId = blockingQueue.take();

                    //取消订单
                    if(StringUtils.hasText(orderId)) {
                        //调用方法取消订单
                        orderInfoService.orderCancel(Long.parseLong(orderId));
                    }

                } catch (InterruptedException e) {
                    throw new RuntimeException(e);
                }

            }
        }).start();
    }
}