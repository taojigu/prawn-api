package ltd.newbee.mall;

import ltd.newbee.mall.api.mall.NewBeeMallGoodsCategoryAPI;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import static org.assertj.core.api.Assertions.assertThat;
@SpringBootTest
public class MallAPIApplicationTest {

    @Autowired
    private NewBeeMallGoodsCategoryAPI mallCategoryApi;

    @Test
    void contextLoads() {
        assertThat(mallCategoryApi).isNotNull();
    }
}
