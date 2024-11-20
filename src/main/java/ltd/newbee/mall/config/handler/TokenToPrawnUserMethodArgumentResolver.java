/**
 * 严肃声明：
 * 开源版本请务必保留此注释头信息，若删除我方将保留所有法律责任追究！
 * 本软件已申请软件著作权，受国家版权局知识产权以及国家计算机软件著作权保护！
 * 可正常分享和学习源码，不得用于违法犯罪活动，违者必究！
 * Copyright (c) 2019-2021 十三 all rights reserved.
 * 版权所有，侵权必究！
 */
package ltd.newbee.mall.config.handler;
import ltd.lib.DebugConfig;

import ltd.prawn.dao.PrawnUserMapper;
import ltd.prawn.entity.PrawnUserEntity;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.MethodParameter;
import org.springframework.stereotype.Component;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.support.WebDataBinderFactory;
import org.springframework.web.context.request.NativeWebRequest;
import org.springframework.web.method.support.HandlerMethodArgumentResolver;
import org.springframework.web.method.support.ModelAndViewContainer;

import javax.servlet.http.HttpServletRequest;
import java.io.IOException;

@Component
public class TokenToPrawnUserMethodArgumentResolver implements HandlerMethodArgumentResolver {

    @Autowired
    private PrawnUserTokenService userTokenService;

    @Autowired
    private PrawnUserMapper userMapper;

    public TokenToPrawnUserMethodArgumentResolver() {
    }

    public boolean supportsParameter(MethodParameter parameter) {
        if (parameter.hasParameterAnnotation(TokenToPrawnUser.class)) {
            return true;
        }
        return false;
    }

    public Object resolveArgument(MethodParameter parameter, ModelAndViewContainer mavContainer, NativeWebRequest webRequest, WebDataBinderFactory binderFactory){

        if (parameter.getParameterAnnotation(TokenToPrawnUser.class) instanceof TokenToPrawnUser) {
            String token = webRequest.getHeader("token");
            if (true == DebugConfig.TOKEN_DEBUG &&
                    (this.isFakeToken(token) ||this.isUndefinedToken(token))){
                Long userId = this.fakeUserIdFromInvalidateToken(token);
                return this.userMapper.selectByPrimaryKey(userId);
            }

            PrawnUserEntity userEntity = this.userTokenService.selectUserByToken(token);
            return userEntity;
        }
        return null;
    }

    public static byte[] getRequestPostBytes(HttpServletRequest request)
            throws IOException {
        int contentLength = request.getContentLength();
        if (contentLength < 0) {
            return null;
        }
        byte buffer[] = new byte[contentLength];
        for (int i = 0; i < contentLength; ) {
            int readlen = request.getInputStream().read(buffer, i,
                    contentLength - i);
            if (readlen == -1) {
                break;
            }
            i += readlen;
        }
        return buffer;
    }
    private boolean isUndefinedToken(String token){
        return StringUtils.isEmpty(token) || token.equalsIgnoreCase("18310067970")
                || token.equalsIgnoreCase("null") ;
    }
    private boolean isFakeToken(String token) {
        return token.equalsIgnoreCase("123456") ;
    }
    private Long fakeUserIdFromInvalidateToken(String token) {
        if(this.isFakeToken(token)){
            return Long.valueOf(3);
        }
        if (this.isUndefinedToken(token)){
            return Long.valueOf(2);
        }
        return null;
    }

}
