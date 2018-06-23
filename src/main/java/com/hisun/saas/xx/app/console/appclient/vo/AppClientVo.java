/*
 * Copyright (c) 2018. Hunan Hisun Union Information Technology Co, Ltd. All rights reserved.
 * http://www.hn-hisun.com
 * 注意:本内容知识产权属于湖南海数互联信息技术有限公司所有,除非取得商业授权,否则不得用于商业目的.
 */

package com.hisun.saas.xx.app.console.appclient.vo;

import com.hisun.saas.xx.app.console.appclient.entity.AppClient;

/**
 * Created by zhouying on 2017/9/23.
 */
public class AppClientVo {


    private String id;
    private String identification;//终端标识
    private int status;//1-正常,2-停用
    private String statusValue;
    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getIdentification() {
        return identification;
    }

    public void setIdentification(String identification) {
        this.identification = identification;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public String getStatusValue() {
        if(this.status == AppClient.ON){
            return "正常";
        }else if(this.status == AppClient.OFF)
        {
            return "停用";
        }
        return "";
    }

    public void setStatusValue(String statusValue) {
        this.statusValue = statusValue;
    }
}
