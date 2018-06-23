/*
 * Copyright (c) 2018. Hunan Hisun Union Information Technology Co, Ltd. All rights reserved.
 * http://www.hn-hisun.com
 * 注意:本内容知识产权属于湖南海数互联信息技术有限公司所有,除非取得商业授权,否则不得用于商业目的.
 */

package com.hisun.saas.xx.app.console.shpc.service.impl;

import com.hisun.base.dao.BaseDao;
import com.hisun.base.service.impl.BaseServiceImpl;
import com.hisun.saas.xx.app.console.shpc.dao.Sha01jcDao;
import com.hisun.saas.xx.app.console.shpc.entity.Sha01jc;
import com.hisun.saas.xx.app.console.shpc.service.Sha01jcService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * Created by zhouying on 2017/9/15.
 */
@Service
public class Sha01jcServiceImpl extends BaseServiceImpl<Sha01jc,String> implements Sha01jcService {

    private Sha01jcDao sha01jcDao;

    @Autowired
    public void setBaseDao(BaseDao<Sha01jc, String> sha01jcDao) {
        this.baseDao = sha01jcDao;
        this.sha01jcDao = (Sha01jcDao) sha01jcDao;
    }

}