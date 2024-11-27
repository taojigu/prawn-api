package ltd.prawn.api.vo;

import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Data;

import java.io.Serializable;
import java.util.Date;

/**
 * 用户本人的发布/保存的商品页面对应数据结构
 * */
@Data
public class PrawnMyProductVO implements Serializable {

    private Long productId;
    private String title;
    private String description;
    private double price;
    private String productImage;
    //单品状态： 编辑中/已发布/已撤销/已卖出
    private int productStatus;
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
    private Date createTime;
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
    private Date updateTime;
    private String keyWords;
    private Long categoryId;
}
