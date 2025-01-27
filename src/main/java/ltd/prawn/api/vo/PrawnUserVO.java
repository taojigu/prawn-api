package ltd.prawn.api.vo;

import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.io.Serializable;

@Data
public class PrawnUserVO implements Serializable {
    @ApiModelProperty("用户名字")
    private String name;
    @ApiModelProperty("当前组织名字")
    private String orgName;
    @ApiModelProperty("头像url")
    private String avatar;
}
