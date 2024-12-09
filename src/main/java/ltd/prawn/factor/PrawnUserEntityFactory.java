package ltd.prawn.factor;

import ltd.prawn.common.PrawnPlatformEnum;
import ltd.prawn.entity.PrawnUserEntity;

public class PrawnUserEntityFactory {
    static public PrawnUserEntity fakeUser1 (String openId) {
        PrawnUserEntity userEntity = new PrawnUserEntity();
        Long userId = PrawnFactoryUtil.getPositiveLong(10000)+10086;
        userEntity.setOpenId(openId);
        userEntity.setUserId(userId);
        userEntity.setName("name");
        userEntity.setMobile("13812341234");
        userEntity.setEmployeeNo("Employee007");
        userEntity.setPlatform(PrawnPlatformEnum.DingDingEnterprise.getPlatformType());
        userEntity.setOrgId(1);
        userEntity.setOrgName("贝壳找房（北京）科技有限公司");
        return userEntity;
    }

}
