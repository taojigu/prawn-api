package ltd.prawn.entity;


import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Data;
import ltd.prawn.common.PrawnPlatformEnum;

import java.util.Date;
import java.util.Map;

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
    // 电子邮件
    private String email;
    //头像图片
    private String avatar;

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

    public PrawnUserEntity() {
        this.isDeleted = 0;
        this.lockedFlag = 0;
        this.createTime = new Date();
    }

    static public PrawnUserEntity fromDingDingUser(Map<String,Object> dingUserMap){
        PrawnUserEntity entity = new PrawnUserEntity();
        entity.setName(dingUserMap.get("name").toString());
        entity.setAvatar(dingUserMap.get("avatar").toString());
        if(dingUserMap.containsKey("email")){
            entity.setEmail(dingUserMap.get("email").toString());
        } else{
            entity.setEmail("");
        }

        entity.setOpenId(dingUserMap.get("unionid").toString());
        entity.setMobile(dingUserMap.get("mobile").toString());
        entity.setPlatform(PrawnPlatformEnum.DingDingEnterprise.getPlatformType());
        entity.setOrgName("且徐行北京科技有限公司");
        entity.setOrgId(9900001);

        entity.setEmployeeNo(dingUserMap.get("userid").toString());
        return entity;
    }

}
