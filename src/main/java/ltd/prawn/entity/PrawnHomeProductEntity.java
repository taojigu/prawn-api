package ltd.prawn.entity;

import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Data;

import java.util.Date;

/*
和数据库交互的首页产品Entity
* */

@Data
public class PrawnHomeProductEntity {
    private Long productId;
    private String title;
    private String description;
    private double price;
    private String productImage;
    //单品状态： 编辑中/已发布/已撤销/已卖出
    private int productStatus;
    private Byte isDeleted;
    private Byte lockedFlag;
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
    private Date createTime;
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
    private Date updateTime;
    private String keyWords;
    private Long categoryId;
    private Long sellerId;
    private String sellerName;
    private Long orgId;
    private String orgName;
    private String sellerEmployeeNo;

    public PrawnHomeProductEntity() {
        this.isDeleted = 0;
        this.lockedFlag = 0;
    }
}
