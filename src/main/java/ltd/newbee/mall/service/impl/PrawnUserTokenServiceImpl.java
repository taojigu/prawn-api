package ltd.newbee.mall.service.impl;

import ltd.newbee.mall.common.Constants;
import ltd.newbee.mall.common.ServiceResultEnum;
import ltd.newbee.mall.service.PrawnUserTokenService;
import ltd.newbee.mall.util.NumberUtil;
import ltd.newbee.mall.util.SystemUtil;
import ltd.prawn.common.PrawnMallException;
import ltd.prawn.dao.PrawnUserMapper;
import ltd.prawn.dao.PrawnUserTokenMapper;
import ltd.prawn.entity.PrawnUserEntity;
import ltd.prawn.entity.PrawnUserTokenEntity;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;

/**
 *
 * */

@Service
public class PrawnUserTokenServiceImpl implements PrawnUserTokenService {
    @Autowired
    PrawnUserTokenMapper userTokenMapper;
    @Autowired
    PrawnUserMapper userMapper;

    /**
     * 根据UserId 获取新的Token
     */
    public String generateNewTokenByUserId(Long userId){
        String timeStr = System.currentTimeMillis() + "";
        String src = timeStr + userId + NumberUtil.genRandomNum(4);
        return SystemUtil.genToken(src);
    }
    /**
     * 根据openId或者unionId 生成对应的token，在登录时候使用
     * */
    public String generateNewToken(String openId){
        PrawnUserEntity userEntity = this.userMapper.selectByOpenId(openId);
        assert userEntity!= null :" unionId 没有找到对应的用户";
        //登录后即执行修改token的操作
        String token = this.generateNewTokenByUserId(userEntity.getUserId());
        PrawnUserTokenEntity userTokenEntity = this.userTokenMapper.selectByPrimaryKey(userEntity.getUserId());
        //当前时间
        Date now = new Date();
        //过期时间
        Date expireTime = new Date(now.getTime() + 2 * 24 * 3600 * 1000);//过期时间 48 小时
        if (userTokenEntity == null) {
            userTokenEntity = new PrawnUserTokenEntity();
            userTokenEntity.setUserId(userEntity.getUserId());
            userTokenEntity.setToken(token);
            userTokenEntity.setUpdateTime(now);
            userTokenEntity.setExpireTime(expireTime);
            //新增一条token数据
            if (this.userTokenMapper.insertSelective(userTokenEntity) > 0) {
                //新增成功后返回
                return token;
            }
            return null;
        } else {
            userTokenEntity.setToken(token);
            userTokenEntity.setUpdateTime(now);
            userTokenEntity.setExpireTime(expireTime);
            //更新
            if (this.userTokenMapper.updateByPrimaryKeySelective(userTokenEntity) > 0) {
                //修改成功后返回
                return token;
            }
            return null;
        }
    }

    /**
     * 根据token获取用户信息
     * */
    public PrawnUserEntity selectUserByToken(String token) {
        if (null != token && !"".equals(token) && token.length() == Constants.TOKEN_LENGTH) {
            PrawnUserTokenEntity tokenEntity = this.userTokenMapper.selectByToken(token);
            if (tokenEntity == null || tokenEntity.getExpireTime().getTime() <= System.currentTimeMillis()) {
                PrawnMallException.fail(ServiceResultEnum.TOKEN_EXPIRE_ERROR.getResult());
            }
            PrawnUserEntity userEntity = this.userMapper.selectByPrimaryKey(tokenEntity.getUserId());
            if (userEntity == null) {
                PrawnMallException.fail(ServiceResultEnum.USER_NULL_ERROR.getResult());
            }
            if (userEntity.getLockedFlag().intValue() == 1) {
                PrawnMallException.fail(ServiceResultEnum.LOGIN_USER_LOCKED_ERROR.getResult());
            }
            return userEntity;
        } else {
            PrawnMallException.fail(ServiceResultEnum.NOT_LOGIN_ERROR.getResult());
        }

        return null;
    }

}
