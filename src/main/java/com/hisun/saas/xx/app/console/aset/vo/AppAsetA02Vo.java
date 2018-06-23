/*
 * Copyright (c) 2018. Hunan Hisun Union Information Technology Co, Ltd. All rights reserved.
 * http://www.hn-hisun.com
 * 注意:本内容知识产权属于湖南海数互联信息技术有限公司所有,除非取得商业授权,否则不得用于商业目的.
 */

package com.hisun.saas.xx.app.console.aset.vo;

import javax.persistence.Column;

/**
 * Created by zhouying on 2017/9/23.
 */
public class AppAsetA02Vo {
    private String id;
    private String b0101;
    private String zwmc;
    private String rzsj;//任职时间
    private int jtlPx;//集体类排列顺序
    private int px;//个人职务排序

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getB0101() {
        return b0101;
    }

    public void setB0101(String b0101) {
        this.b0101 = b0101;
    }

    public String getZwmc() {
        return zwmc;
    }

    public void setZwmc(String zwmc) {
        this.zwmc = zwmc;
    }

    public String getRzsj() {
        return rzsj;
    }

    public void setRzsj(String rzsj) {
        this.rzsj = rzsj;
    }

    public int getJtlPx() {
        return jtlPx;
    }

    public void setJtlPx(int jtlPx) {
        this.jtlPx = jtlPx;
    }

    public int getPx() {
        return px;
    }

    public void setPx(int px) {
        this.px = px;
    }
}
