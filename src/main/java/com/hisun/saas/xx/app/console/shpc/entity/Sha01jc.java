/*
 * Copyright (c) 2018. Hunan Hisun Union Information Technology Co, Ltd. All rights reserved.
 * http://www.hn-hisun.com
 * 注意:本内容知识产权属于湖南海数互联信息技术有限公司所有,除非取得商业授权,否则不得用于商业目的.
 */

package com.hisun.saas.xx.app.console.shpc.entity;

import com.hisun.saas.sys.tenant.base.entity.TenantEntity;
import org.hibernate.annotations.GenericGenerator;

import javax.persistence.*;
import java.io.Serializable;

/**
 * Created by zhouying on 2017/9/8.
 */

@Entity
@Table(name = "APP_SH_A01_JC")
public class Sha01jc extends TenantEntity implements Serializable{


    private String id;

    private Sha01 sha01;


    private String nd;

    private String JCSM;

    private int px;

    @Id
    @GenericGenerator(name="generator",strategy="uuid.hex")
    @GeneratedValue(generator="generator")
    @Column(name="ID",nullable=false,unique=true,length=32)
    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }
    @ManyToOne(optional=true,fetch = FetchType.LAZY)
    @JoinColumn(name="APP_SH_A01_ID")
    public Sha01 getSha01() {
        return sha01;
    }

    public void setSha01(Sha01 sha01) {
        this.sha01 = sha01;
    }
    @Column(name = "ND",length = 24)
    public String getNd() {
        return nd;
    }

    public void setNd(String nd) {
        this.nd = nd;
    }
    @Column(name = "JCSM",length = 255)
    public String getJCSM() {
        return JCSM;
    }

    public void setJCSM(String JCSM) {
        this.JCSM = JCSM;
    }
    @Column(name = "JC_PX")
    public int getPx() {
        return px;
    }

    public void setPx(int px) {
        this.px = px;
    }
}
