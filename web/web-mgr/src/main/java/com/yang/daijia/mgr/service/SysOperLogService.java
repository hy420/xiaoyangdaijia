package com.yang.daijia.mgr.service;

import com.yang.daijia.model.entity.system.SysOperLog;
import com.yang.daijia.model.query.system.SysOperLogQuery;
import com.yang.daijia.model.vo.base.PageVo;

public interface SysOperLogService {

    PageVo<SysOperLog> findPage(Long page, Long limit, SysOperLogQuery sysOperLogQuery);

    /**
     * 保存系统日志记录
     */
    void saveSysLog(SysOperLog sysOperLog);

    SysOperLog getById(Long id);
}
