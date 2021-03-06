/*
 * Copyright (c) 2018. Hunan Hisun Union Information Technology Co, Ltd. All rights reserved.
 * http://www.hn-hisun.com
 * 注意:本内容知识产权属于湖南海数互联信息技术有限公司所有,除非取得商业授权,否则不得用于商业目的.
 */

package com.hisun.saas.xx.app.console.shpc.dao.impl;

import com.hisun.saas.sys.tenant.base.dao.imp.TenantBaseDaoImpl;
import com.hisun.saas.sys.tenant.base.entity.TenantEntity;
import com.hisun.saas.xx.app.console.shpc.dao.ShpcAttsDao;
import com.hisun.saas.xx.app.console.shpc.entity.ShpcAtts;
import org.springframework.stereotype.Repository;

/**
 * Created by zhouying on 2017/11/15.
 */
@Repository
public class ShpcAttsDaoImpl extends TenantBaseDaoImpl<ShpcAtts,String> implements ShpcAttsDao {

}
