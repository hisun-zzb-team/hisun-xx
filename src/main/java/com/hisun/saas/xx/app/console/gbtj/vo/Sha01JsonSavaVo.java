/*
 * Copyright (c) 2018. Hunan Hisun Union Information Technology Co, Ltd. All rights reserved.
 * http://www.hn-hisun.com
 * 注意:本内容知识产权属于湖南海数互联信息技术有限公司所有,除非取得商业授权,否则不得用于商业目的.
 */

package com.hisun.saas.xx.app.console.gbtj.vo;

import java.util.List;

/**
 * Created by zhouying on 2017/9/8.
 */
public class Sha01JsonSavaVo {

    private String title;
    private List<Sha01JsonDataVo> jsonDataVos;
    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public List<Sha01JsonDataVo> getJsonDataVos() {
        return jsonDataVos;
    }

    public void setJsonDataVos(List<Sha01JsonDataVo> jsonDataVos) {
        this.jsonDataVos = jsonDataVos;
    }
}
