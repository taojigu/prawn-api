package ltd.prawn.dao;

import ltd.prawn.entity.PrawnUserEntity;

/**
 * 用户相关Mapper
 * */
public interface PrawnUserMapper {

    PrawnUserEntity selectByOpenId(String openId);

    int insert(PrawnUserEntity userEntity);

    PrawnUserEntity selectByPrimaryKey(Long userId);
}
