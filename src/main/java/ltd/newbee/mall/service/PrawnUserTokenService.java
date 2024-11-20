package ltd.newbee.mall.service;

import ltd.prawn.entity.PrawnUserEntity;

/**
 * Prawn 用户的 Token相关操作
 * */

public interface PrawnUserTokenService {

    /**
     * 根据UserId 获取新的Token
     */
    public String generateNewTokenByUserId(Long userId);

    /**
     * 根据openId或者unionId 生成对应的token，在登录时候使用
     * */
    public String generateNewToken(String openId);

    /**
     * 根据token获取用户信息
     * */
    public PrawnUserEntity selectUserByToken(String token);

}
