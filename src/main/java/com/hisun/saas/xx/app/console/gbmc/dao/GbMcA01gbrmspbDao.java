/*
 * Copyright (c) 2018. Hunan Hisun Union Information Technology Co, Ltd. All rights reserved.
 * http://www.hn-hisun.com
 * 注意:本内容知识产权属于湖南海数互联信息技术有限公司所有,除非取得商业授权,否则不得用于商业目的.
 */

package com.hisun.saas.xx.app.console.gbmc.dao;

import com.hisun.base.dao.BaseDao;
import com.hisun.saas.xx.app.console.gbmc.entity.GbMcA01gbrmspb;

import java.util.Map;

/**
 * Created by zhouying on 2017/9/12.
 */
public interface GbMcA01gbrmspbDao extends BaseDao<GbMcA01gbrmspb,String> {

    public String saveFromWord(GbMcA01gbrmspb gbrmspb, Map<String, String> wordDataMap) throws Exception;

}
