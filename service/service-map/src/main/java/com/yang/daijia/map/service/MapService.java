package com.yang.daijia.map.service;

import com.yang.daijia.model.form.map.CalculateDrivingLineForm;
import com.yang.daijia.model.vo.map.DrivingLineVo;

public interface MapService {

    //计算驾驶线路
    DrivingLineVo calculateDrivingLine(CalculateDrivingLineForm calculateDrivingLineForm);
}
