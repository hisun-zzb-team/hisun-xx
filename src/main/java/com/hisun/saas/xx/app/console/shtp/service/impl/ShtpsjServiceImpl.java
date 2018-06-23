/*
 * Copyright (c) 2018. Hunan Hisun Union Information Technology Co, Ltd. All rights reserved.
 * http://www.hn-hisun.com
 * 注意:本内容知识产权属于湖南海数互联信息技术有限公司所有,除非取得商业授权,否则不得用于商业目的.
 */

package com.hisun.saas.xx.app.console.shtp.service.impl;

import com.hisun.base.dao.BaseDao;
import com.hisun.base.service.impl.BaseServiceImpl;
import com.hisun.saas.xx.app.console.shtp.dao.ShtpsjDao;
import com.hisun.saas.xx.app.console.shtp.entity.Shtpsj;
import com.hisun.saas.xx.app.console.shtp.service.ShtpsjService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * Created by zhouying on 2017/9/15.
 */
@Service
public class ShtpsjServiceImpl extends BaseServiceImpl<Shtpsj,String> implements ShtpsjService {

    private ShtpsjDao shtpsjDao;

    @Autowired
    public void setBaseDao(BaseDao<Shtpsj, String> shtpsjDao) {
        this.baseDao = shtpsjDao;
        this.shtpsjDao = (ShtpsjDao) shtpsjDao;
    }

}