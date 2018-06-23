/*
 * Copyright (c) 2018. Hunan Hisun Union Information Technology Co, Ltd. All rights reserved.
 * http://www.hn-hisun.com
 * 注意:本内容知识产权属于湖南海数互联信息技术有限公司所有,除非取得商业授权,否则不得用于商业目的.
 */

package com.hisun.saas.xx.app.console.gbmc.service;

import com.hisun.base.service.BaseService;
import com.hisun.saas.xx.app.console.gbmc.entity.GbMcA01;
import com.hisun.saas.xx.app.console.gbmc.entity.GbMcA01gzjl;

import java.util.Map;

/**
 * Created by zhouying on 2017/9/15.
 */
public interface GbMcA01gzjlService extends BaseService<GbMcA01gzjl,String> {


    public void saveFromWord(GbMcA01 gbMcA01, Map<String, String> dataMap);
    String toSqliteInsertSql(GbMcA01gzjl entity);

}
