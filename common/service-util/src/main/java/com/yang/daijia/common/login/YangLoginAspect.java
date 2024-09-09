package com.yang.daijia.common.login;

import com.yang.daijia.common.constant.RedisConstant;
import com.yang.daijia.common.execption.GuiguException;
import com.yang.daijia.common.result.ResultCodeEnum;
import com.yang.daijia.common.util.AuthContextHolder;
import jakarta.annotation.Resource;
import jakarta.servlet.http.HttpServletRequest;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.stereotype.Component;
import org.springframework.util.StringUtils;
import org.springframework.web.context.request.RequestAttributes;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

@Component
@Aspect  //切面类
public class YangLoginAspect {

    @Resource
    private RedisTemplate redisTemplate;

    //环绕通知，登录判断
    //切入点表达式：指定对哪些规则的方法进行增强
    @Around("execution(* com.yang.daijia.*.controller.*.*(..)) && @annotation(yangLogin)")
    public Object login(ProceedingJoinPoint proceedingJoinPoint, YangLogin yangLogin)  throws Throwable {

        //1 获取request对象
        RequestAttributes attributes = RequestContextHolder.getRequestAttributes();
        ServletRequestAttributes sra = (ServletRequestAttributes)attributes;
        HttpServletRequest request = sra.getRequest();

        //2 从请求头获取token
        String token = request.getHeader("token");

        //3 判断token是否为空，如果为空，返回登录提示
        if(!StringUtils.hasText(token)) {
            throw new GuiguException(ResultCodeEnum.LOGIN_AUTH);
        }

        //4 token不为空，查询redis
        String customerId = (String)redisTemplate.opsForValue()
                           .get(RedisConstant.USER_LOGIN_KEY_PREFIX+token);

        //5 查询redis对应用户id，把用户id放到ThreadLocal里面
        if(StringUtils.hasText(customerId)) {
            AuthContextHolder.setUserId(Long.parseLong(customerId));
        }

        //6 执行业务方法
        return proceedingJoinPoint.proceed();
    }

}