/*
 * Copyright (c) 2018. Hunan Hisun Union Information Technology Co, Ltd. All rights reserved.
 * http://www.hn-hisun.com
 * 注意:本内容知识产权属于湖南海数互联信息技术有限公司所有,除非取得商业授权,否则不得用于商业目的.
 */

package com.hisun.saas.xx.app.console.gbmc.service;

import com.hisun.base.service.BaseService;
import com.hisun.saas.xx.app.console.gbmc.entity.GbMc;
import com.hisun.saas.xx.app.console.gbmc.entity.GbMcB01;

import java.io.File;

/**
 * Created by zhouying on 2017/9/16.
 */
public interface GbMcB01Service extends BaseService<GbMcB01,String> {

    String ATTS_PATH =GbMcService.ATTS_PATH+"mcb01"+ File.separator;
    String APP_ATTS_PATH =GbMcService.APP_ATTS_PATH+"mcb01/";
    String toSqliteInsertSql(GbMcB01 entity);
}
