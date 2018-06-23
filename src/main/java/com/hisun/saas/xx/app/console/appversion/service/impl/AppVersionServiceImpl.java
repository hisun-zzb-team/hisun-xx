/*
 * Copyright (c) 2018. Hunan Hisun Union Information Technology Co, Ltd. All rights reserved.
 * http://www.hn-hisun.com
 * 注意:本内容知识产权属于湖南海数互联信息技术有限公司所有,除非取得商业授权,否则不得用于商业目的.
 */

package com.hisun.saas.xx.app.console.appversion.service.impl;

import com.hisun.base.dao.BaseDao;
import com.hisun.base.service.impl.BaseServiceImpl;
import com.hisun.saas.xx.app.console.appversion.dao.AppVersionDao;
import com.hisun.saas.xx.app.console.appversion.entity.AppVersion;
import com.hisun.saas.xx.app.console.appversion.service.AppVersionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.io.File;

/**
 * Created by zhouying on 2017/9/16.
 */
@Service
public class AppVersionServiceImpl extends BaseServiceImpl<AppVersion,String> implements AppVersionService {

    private AppVersionDao appVersionDao;

    @Autowired
    public void setBaseDao(BaseDao<AppVersion, String> appVersionDao) {
        this.baseDao = appVersionDao;
        this.appVersionDao = (AppVersionDao) appVersionDao;
    }}
