package ltd.prawn.entity;


import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Data;

import java.util.Date;

@Data
public class PrawnUserEntity {
    // Prawn 平台生成的userID
    private Long userId;
    //各个平台赋予用户的UserID；
    private String openId;
    //登录名称
    private String name;
    // 员工编号
    private String employeeNo;
    // 手机号
    private String mobile;

    private Byte isDeleted;

    private Byte lockedFlag;

    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
    private Date createTime;

    // 用户所在平台：钉钉/企业微信
    private int platform;

    // 用户所在组织的ID，例如公司
    private long orgId;

    //组织名称
    private String orgName;
}
