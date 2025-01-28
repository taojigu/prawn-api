package ltd.prawn.api;

import ltd.newbee.mall.common.Constants;
import ltd.newbee.mall.service.impl.PrawnUserTokenServiceImpl;
import ltd.prawn.entity.PrawnUserTokenEntity;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.http.MediaType;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.result.MockMvcResultMatchers;


@SpringBootTest
@AutoConfigureMockMvc
public class PrawnUserControllerTest {
    @Autowired
    private MockMvc mockMvc;

    @Autowired
    private PrawnUserTokenServiceImpl userTokenService;

    @Test
    public void testGetUser() throws  Exception {
        mockMvc.perform(MockMvcRequestBuilders.get("/ltd/api/v1/prawn/user")
                .contentType(MediaType.APPLICATION_JSON)
                .header("token", Constants.FAKE_USER_TOKEN))
                .andExpect(MockMvcResultMatchers.status().isOk())
                .andExpect(MockMvcResultMatchers.jsonPath("$.data.avatar").isNotEmpty())
                .andExpect(MockMvcResultMatchers.jsonPath("$.data.name").isNotEmpty());
    }


}
