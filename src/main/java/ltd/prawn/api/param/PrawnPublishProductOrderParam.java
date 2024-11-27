package ltd.prawn.api.param;

import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.io.Serializable;

/**
 * 发布产品订单输入参数
 * */

@Data
public class PrawnPublishProductOrderParam implements Serializable {
    @ApiModelProperty("商品id")
    private long productId;

    @ApiModelProperty("支付方式")
    private int payType;
}
