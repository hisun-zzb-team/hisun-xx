/*
 * Copyright (c) 2018. Hunan Hisun Union Information Technology Co, Ltd. All rights reserved.
 * http://www.hn-hisun.com
 * 注意:本内容知识产权属于湖南海数互联信息技术有限公司所有,除非取得商业授权,否则不得用于商业目的.
 */

package com.hisun.saas.xx.app.console.gendata.vo;

import com.aspose.slides.Collections.Generic.List;
import com.hisun.saas.xx.app.console.gbtj.vo.GbtjVo;
import com.hisun.saas.xx.app.console.shpc.vo.ShpcVo;

import javax.persistence.Column;
import javax.persistence.FetchType;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;

/**
 * Created by zhouying on 2017/9/16.
 */
public class DataPacketContentVo {

    private String id;

    private String name;

    private String dataId;


    private int dataType;

    private int sort;

    private String parent_id;

    private GendataVo gendataVo;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDataId() {
        return dataId;
    }

    public void setDataId(String dataId) {
        this.dataId = dataId;
    }

    public int getDataType() {
        return dataType;
    }

    public void setDataType(int dataType) {
        this.dataType = dataType;
    }

    public int getSort() {
        return sort;
    }

    public void setSort(int sort) {
        this.sort = sort;
    }

    public String getParent_id() {
        return parent_id;
    }

    public void setParent_id(String parent_id) {
        this.parent_id = parent_id;
    }

    public GendataVo getGendataVo() {
        return gendataVo;
    }

    public void setGendataVo(GendataVo gendataVo) {
        this.gendataVo = gendataVo;
    }
}
