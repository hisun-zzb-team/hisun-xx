/*
 * Copyright (c) 2018. Hunan Hisun Union Information Technology Co, Ltd. All rights reserved.
 * http://www.hn-hisun.com
 * 注意:本内容知识产权属于湖南海数互联信息技术有限公司所有,除非取得商业授权,否则不得用于商业目的.
 */

package com.hisun.saas.xx.app.console.shtp.vo;

import com.hisun.saas.sys.tenant.tenant.vo.TenantEntityVo;
import com.hisun.saas.xx.app.console.shpc.vo.Sha01Vo;

/**
 * Created by zhouying on 2017/9/15.
 */
public class ShtpsjVo extends TenantEntityVo{

    private String id;
    private Sha01Vo sha01Vo;
    private String sha01Id;
    private ShtpVo shtpVo;
    private String shtpId;
    private int tp;


    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public Sha01Vo getSha01Vo() {
        return sha01Vo;
    }

    public void setSha01Vo(Sha01Vo sha01Vo) {
        this.sha01Vo = sha01Vo;
    }

    public ShtpVo getShtpVo() {
        return shtpVo;
    }

    public void setShtpVo(ShtpVo shtpVo) {
        this.shtpVo = shtpVo;
    }

    public int getTp() {
        return tp;
    }

    public void setTp(int tp) {
        this.tp = tp;
    }

    public String getSha01Id() {
        return sha01Id;
    }

    public void setSha01Id(String sha01Id) {
        this.sha01Id = sha01Id;
    }

    public String getShtpId() {
        return shtpId;
    }

    public void setShtpId(String shtpId) {
        this.shtpId = shtpId;
    }
}
