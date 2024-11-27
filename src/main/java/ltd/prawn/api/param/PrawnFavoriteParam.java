package ltd.prawn.api.param;

import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.io.Serializable;

/**
 * 收藏请求相关参数
 * */
@Data
public class PrawnFavoriteParam implements Serializable {
    @ApiModelProperty("商品id")
    private Long productId;
}
