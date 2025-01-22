package ltd.prawn.service;

import com.github.javafaker.Faker;
import ltd.NewBeeMallAPIApplication;
import ltd.prawn.common.PrawnPlatformEnum;
import ltd.prawn.entity.PrawnUserEntity;
import ltd.prawn.service.implement.PrawnUserServiceImp;
import net.minidev.json.writer.FakeMapper;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

@SpringBootTest(classes = NewBeeMallAPIApplication.class)
public class PrawnUserServiceTest {
    @Autowired
    private PrawnUserServiceImp prawnUserService;

    @Test
    public void testGetUserInfoByID(){
        PrawnUserEntity entity = prawnUserService.getUserInfoById(1L);
        assert entity.getUserId() > 0;
    }
    @Test void testInsertUser() {

        PrawnUserEntity pe = PrawnUserEntity.fakeEntity();
        int result = prawnUserService.insertUser(pe);
        assert result == 1;
    }
}
