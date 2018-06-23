/*
 * Copyright (c) 2018. Hunan Hisun Union Information Technology Co, Ltd. All rights reserved.
 * http://www.hn-hisun.com
 * 注意:本内容知识产权属于湖南海数互联信息技术有限公司所有,除非取得商业授权,否则不得用于商业目的.
 */

package com.hisun.saas.xx.app.console.appclient.service.impl;

import com.hisun.base.dao.BaseDao;
import com.hisun.base.service.impl.BaseServiceImpl;
import com.hisun.saas.xx.app.console.appclient.dao.AppClientDao;
import com.hisun.saas.xx.app.console.appclient.entity.AppClient;
import com.hisun.saas.xx.app.console.appclient.service.AppClientService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * Created by zhouying on 2017/9/16.
 */
@Service
public class AppClientServiceImpl extends BaseServiceImpl<AppClient,String> implements AppClientService {

    private AppClientDao appClientDao;

    @Autowired
    public void setBaseDao(BaseDao<AppClient, String> appClientDao) {
        this.baseDao = appClientDao;
        this.appClientDao = (AppClientDao) appClientDao;
    }}
