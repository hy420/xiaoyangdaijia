package com.yang.daijia.mgr.service;


import com.yang.daijia.model.entity.system.SysUser;
import com.yang.daijia.model.query.system.SysUserQuery;
import com.yang.daijia.model.vo.base.PageVo;

public interface SysUserService {

    SysUser getById(Long id);

    void save(SysUser sysUser);

    void update(SysUser sysUser);

    void remove(Long id);

    PageVo<SysUser> findPage(Long page, Long limit, SysUserQuery sysUserQuery);

    void updateStatus(Long id, Integer status);


}
