/*
 * Copyright (c) 2018. Hunan Hisun Union Information Technology Co, Ltd. All rights reserved.
 * http://www.hn-hisun.com
 * 注意:本内容知识产权属于湖南海数互联信息技术有限公司所有,除非取得商业授权,否则不得用于商业目的.
 */

package com.hisun.saas.xx.app.console.shpc.service.impl;

import com.hisun.base.dao.BaseDao;
import com.hisun.base.service.impl.BaseServiceImpl;
import com.hisun.saas.xx.app.console.shpc.dao.Sha01shgxDao;
import com.hisun.saas.xx.app.console.shpc.entity.Sha01shgx;
import com.hisun.saas.xx.app.console.shpc.service.Sha01shgxService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * Created by zhouying on 2017/9/15.
 */
@Service
public class Sha01shgxServiceImpl extends BaseServiceImpl<Sha01shgx,String> implements Sha01shgxService {

    private Sha01shgxDao sha01shgxDao;

    @Autowired
    public void setBaseDao(BaseDao<Sha01shgx, String> sha01shgxDao) {
        this.baseDao = sha01shgxDao;
        this.sha01shgxDao = (Sha01shgxDao) sha01shgxDao;
    }

}