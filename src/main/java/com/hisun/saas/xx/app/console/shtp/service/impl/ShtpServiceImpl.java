/*
 * Copyright (c) 2018. Hunan Hisun Union Information Technology Co, Ltd. All rights reserved.
 * http://www.hn-hisun.com
 * 注意:本内容知识产权属于湖南海数互联信息技术有限公司所有,除非取得商业授权,否则不得用于商业目的.
 */

package com.hisun.saas.xx.app.console.shtp.service.impl;

import com.hisun.base.dao.BaseDao;
import com.hisun.base.dao.util.CommonConditionQuery;
import com.hisun.base.dao.util.CommonOrder;
import com.hisun.base.dao.util.CommonOrderBy;
import com.hisun.base.dao.util.CommonRestrictions;
import com.hisun.base.service.impl.BaseServiceImpl;
import com.hisun.saas.xx.app.console.shpc.entity.Shpc;
import com.hisun.saas.xx.app.console.shtp.dao.ShtpDao;
import com.hisun.saas.xx.app.console.shtp.entity.Shtp;
import com.hisun.saas.xx.app.console.shtp.service.ShtpService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * Created by zhouying on 2017/9/15.
 */
@Service
public class ShtpServiceImpl extends BaseServiceImpl<Shtp,String> implements ShtpService {

    private ShtpDao shtpDao;

    @Autowired
    public void setBaseDao(BaseDao<Shtp, String> shtpDao) {
        this.baseDao = shtpDao;
        this.shtpDao = (ShtpDao) shtpDao;
    }

    public String saveByRestApi(Shtp shtp){
        String tpq_bh = shtp.getTpq_bh();
        Shpc shpc = shtp.getShpc();
        CommonConditionQuery query = new CommonConditionQuery();
        query.add(CommonRestrictions.and(" shpc.id = :shpcId", "shpcId",shpc.getId()));
        query.add(CommonRestrictions.and(" tombstone = :tombstone", "tombstone", 0));
        query.add(CommonRestrictions.and(" tpq_bh = :tpq_bh", "tpq_bh", tpq_bh));
//        CommonOrderBy orderBy = new CommonOrderBy();
//        orderBy.add(CommonOrder.desc("tp_sj"));
        List<Shtp> shtpList = this.shtpDao.list(query,null);
        if(shtpList!=null && shtpList.size()>0){
            for(Shtp tp : shtpList){
                this.shtpDao.delete(tp);
            }
        }
        return this.shtpDao.save(shtp);
    }

}