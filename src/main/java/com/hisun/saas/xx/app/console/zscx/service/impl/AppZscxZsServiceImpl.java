/*
 * Copyright (c) 2018. Hunan Hisun Union Information Technology Co, Ltd. All rights reserved.
 * http://www.hn-hisun.com
 * 注意:本内容知识产权属于湖南海数互联信息技术有限公司所有,除非取得商业授权,否则不得用于商业目的.
 */

package com.hisun.saas.xx.app.console.zscx.service.impl;

import com.hisun.base.dao.BaseDao;
import com.hisun.base.service.impl.BaseServiceImpl;
import com.hisun.saas.xx.app.console.zscx.dao.AppZscxZsDao;
import com.hisun.saas.xx.app.console.zscx.entity.AppZscxZs;
import com.hisun.saas.xx.app.console.zscx.service.AppZscxZsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * Created by zhouying on 2017/9/16.
 */
@Service
public class AppZscxZsServiceImpl extends BaseServiceImpl<AppZscxZs,String> implements AppZscxZsService {

    private AppZscxZsDao appZscxZsDao;

    @Autowired
    public void setBaseDao(BaseDao<AppZscxZs, String> appZscxZsDao) {
        this.baseDao = appZscxZsDao;
        this.appZscxZsDao = (AppZscxZsDao) appZscxZsDao;
    }}
