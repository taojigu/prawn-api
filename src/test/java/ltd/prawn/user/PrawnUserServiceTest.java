package ltd.prawn.user;

import ltd.NewBeeMallAPIApplication;
import ltd.prawn.entity.PrawnUserEntity;
import ltd.prawn.service.implement.PrawnUserServiceImp;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

@SpringBootTest(classes = NewBeeMallAPIApplication.class)
public class PrawnUserServiceTest {
    @Autowired
    private PrawnUserServiceImp prawnUserService;

    @Test
    public void testGetUserInfoByID(){
        PrawnUserEntity entity = prawnUserService.getUserInfoById(0L);
        assert entity.getUserId() > 0;
    }
}
