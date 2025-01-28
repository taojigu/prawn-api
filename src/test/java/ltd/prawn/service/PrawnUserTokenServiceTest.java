package ltd.prawn.service;


import ltd.NewBeeMallAPIApplication;
import ltd.newbee.mall.service.impl.PrawnUserTokenServiceImpl;
import ltd.prawn.entity.PrawnUserEntity;
import ltd.prawn.service.implement.PrawnUserServiceImp;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

@SpringBootTest(classes = NewBeeMallAPIApplication.class)
public class PrawnUserTokenServiceTest {
    @Autowired
    private PrawnUserTokenServiceImpl userTokenService;
    @Autowired
    private PrawnUserServiceImp userService;

    @Test
    public void testGenerateToken(){
        PrawnUserEntity userEntity= userService.getUserInfoById(2L);
        String token = userTokenService.generateNewToken(userEntity.getOpenId());
        PrawnUserEntity userEntity1 = userTokenService.selectUserByToken(token);
        assert userEntity.getUserId() == userEntity1.getUserId();

    }
}
