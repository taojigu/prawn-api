package ltd.prawn.api.vo;

import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Data;

import java.io.Serializable;
import java.util.Date;


/**
 * 显示收藏相关的数据Model
 * */
@Data
public class PrawnFavoriteVO implements Serializable {
    private Long favoriteId;
    private Long productId;
    private Byte isDeleted;
    private Byte lockedFlag;
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
    private Date createTime;
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
    private Date updateTime;

    private String title;
    private String productImage;
    private String sellerName;
    private String sellerEmployeeNo;
    private double price;
    private String description;

    public PrawnFavoriteVO() {
        this.isDeleted = 0;
        this.lockedFlag = 0;
    }

}
