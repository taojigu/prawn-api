package ltd.prawn.dao;

import ltd.prawn.entity.PrawnUserTokenEntity;

public interface PrawnUserTokenMapper {

    int deleteByPrimaryKey(Long userId);

    int insert(PrawnUserTokenEntity record);

    int insertSelective(PrawnUserTokenEntity record);

    PrawnUserTokenEntity selectByPrimaryKey(Long userId);

    PrawnUserTokenEntity selectByToken(String token);

    int updateByPrimaryKeySelective(PrawnUserTokenEntity record);

    int updateByPrimaryKey(PrawnUserTokenEntity record);
}
