package ltd.prawn.api.vo;

import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

@Data
public class PrawnUserVO {
    @ApiModelProperty("用户名字")
    private String userName;
    @ApiModelProperty("当前组织名字")
    private String orgName;
}
