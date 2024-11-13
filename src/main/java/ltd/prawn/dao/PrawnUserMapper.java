package ltd.prawn.dao;

import ltd.prawn.entity.PrawnUserEntity;

public interface PrawnUserMapper {
    PrawnUserEntity selectByOpenId(String openId);

    int insert(PrawnUserEntity userEntity);
}
