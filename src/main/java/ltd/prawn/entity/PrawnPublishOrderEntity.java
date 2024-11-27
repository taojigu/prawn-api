package ltd.prawn.entity;

import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Data;

import java.util.Date;

/**
 * 发布产品的订单Entity
 * */



@Data
public class PrawnPublishOrderEntity {
    private Long orderId;
    private String orderNo;
    private Long sellerId;
    private Long productId;
    private Double cost;
    private int payStatus;
    private int payType;
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
    private Date payTime;
    private String extraInfo;
    private Byte isDeleted;
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
    private Date createTime;
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
    private Date updateTime;
}
