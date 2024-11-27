package ltd.prawn.api.param;


import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.io.Serializable;
//
//@Data
//public class SaveCartItemParam implements Serializable {
//
//    @ApiModelProperty("商品数量")
//    private Integer goodsCount;
//
//    @ApiModelProperty("商品id")
//    private Long goodsId;
//}

/*
更新产品数据的的参数
* */

@Data
public class PrawnUpdateProductParam implements  Serializable{
    @ApiModelProperty("商品id")
    private Long productId;
    @ApiModelProperty("商品标题")
    private String title;
    @ApiModelProperty("商品介绍")
    private String description;
    @ApiModelProperty("商品价格")
    private double price;
    @ApiModelProperty("商品状态")
    private Integer productStatus;
    @ApiModelProperty("图片url")
    private String productImage;
    @ApiModelProperty("商品关键字集合")
    private String keyWord;
    @ApiModelProperty("商品分类ID")
    private Long categoryId;

}
