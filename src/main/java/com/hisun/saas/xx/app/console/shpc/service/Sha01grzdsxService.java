/*
 * Copyright (c) 2018. Hunan Hisun Union Information Technology Co, Ltd. All rights reserved.
 * http://www.hn-hisun.com
 * 注意:本内容知识产权属于湖南海数互联信息技术有限公司所有,除非取得商业授权,否则不得用于商业目的.
 */

package com.hisun.saas.xx.app.console.shpc.service;

import com.hisun.base.service.BaseService;
import com.hisun.saas.xx.app.console.shpc.entity.Sha01grzdsx;

import java.io.File;

/**
 * Created by zhouying on 2017/9/15.
 */
public interface Sha01grzdsxService extends BaseService<Sha01grzdsx,String> {

    String ATTS_PATH = Sha01Service.ATTS_PATH+"grzdsx"+ File.separator;
    String APP_ATTS_PATH = Sha01Service.APP_ATTS_PATH + "grzdsx/";

    String toSqliteInsertSql(Sha01grzdsx entity);
}
