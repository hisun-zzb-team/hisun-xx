/*
 * Copyright (c) 2018. Hunan Hisun Union Information Technology Co, Ltd. All rights reserved.
 * http://www.hn-hisun.com
 * 注意:本内容知识产权属于湖南海数互联信息技术有限公司所有,除非取得商业授权,否则不得用于商业目的.
 */

package com.hisun.saas.xx.app.console.bset.service;

import com.hisun.base.service.BaseService;
import com.hisun.saas.xx.app.console.bset.entity.AppBsetFl2B01;

import javax.sql.DataSource;

/**
 * Created by zhouying on 2017/9/16.
 */
public interface AppBsetFl2B01Service extends BaseService<AppBsetFl2B01,String> {

     int saveFromYw(DataSource dataSource)throws Exception;
     int saveFromZdwx(DataSource dataSource)throws Exception;
     String toSqliteInsertSql(AppBsetFl2B01 entity);
}
