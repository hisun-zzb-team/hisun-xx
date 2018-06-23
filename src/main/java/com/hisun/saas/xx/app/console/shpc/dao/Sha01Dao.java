/*
 * Copyright (c) 2018. Hunan Hisun Union Information Technology Co, Ltd. All rights reserved.
 * http://www.hn-hisun.com
 * 注意:本内容知识产权属于湖南海数互联信息技术有限公司所有,除非取得商业授权,否则不得用于商业目的.
 */

package com.hisun.saas.xx.app.console.shpc.dao;

import com.hisun.base.dao.BaseDao;
import com.hisun.saas.sys.tenant.tenant.entity.Tenant;
import com.hisun.saas.xx.app.console.shpc.entity.Sha01;

import java.util.Map;

/**
 * Created by zhouying on 2017/9/13.
 */
public interface Sha01Dao extends BaseDao<Sha01,String> {

    public void saveFromWordDataMap(Tenant tenant, Map<String, String> dataMap, String pcId);

}
