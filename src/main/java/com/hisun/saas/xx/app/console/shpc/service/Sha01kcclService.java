/*
 * Copyright (c) 2018. Hunan Hisun Union Information Technology Co, Ltd. All rights reserved.
 * http://www.hn-hisun.com
 * 注意:本内容知识产权属于湖南海数互联信息技术有限公司所有,除非取得商业授权,否则不得用于商业目的.
 */

package com.hisun.saas.xx.app.console.shpc.service;

import com.hisun.base.service.BaseService;
import com.hisun.saas.xx.app.console.shpc.entity.Sha01kccl;

import java.io.File;

/**
 * Created by zhouying on 2017/9/15.
 */
public interface Sha01kcclService extends BaseService<Sha01kccl,String> {

    String ATTS_PATH = Sha01Service.ATTS_PATH+"kccl"+ File.separator;
    String APP_ATTS_PATH = Sha01Service.APP_ATTS_PATH+"kccl/";
    String toSqliteInsertSql(Sha01kccl kccl);
}
