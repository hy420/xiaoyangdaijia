package com.yang.daijia.mgr.service;

import com.yang.daijia.model.entity.system.SysLoginLog;
import com.yang.daijia.model.query.system.SysLoginLogQuery;
import com.yang.daijia.model.vo.base.PageVo;

public interface SysLoginLogService {

    PageVo<SysLoginLog> findPage(Long page, Long limit, SysLoginLogQuery sysLoginLogQuery);

    /**
     * 记录登录信息
     *
     * @param sysLoginLog
     * @return
     */
    void recordLoginLog(SysLoginLog sysLoginLog);

    SysLoginLog getById(Long id);
}
