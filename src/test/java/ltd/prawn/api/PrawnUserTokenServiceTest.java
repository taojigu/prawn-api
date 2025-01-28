package ltd.prawn.api;

import com.fasterxml.jackson.databind.ObjectMapper;
import ltd.newbee.mall.common.Constants;
import ltd.newbee.mall.util.Result;
import org.junit.jupiter.api.Disabled;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.http.MediaType;
import org.springframework.test.web.client.match.MockRestRequestMatchers;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.MvcResult;
import org.springframework.test.web.servlet.RequestBuilder;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.result.MockMvcResultMatchers;
@SpringBootTest
@AutoConfigureMockMvc
public class PrawnUserTokenServiceTest {
    @Autowired
    private MockMvc mockMvc;

    @Test
    @Disabled("Skipping getDingTokenAndUserInfo")
    public void getDingTokenAndUserInfo() throws  Exception{
        //dingding auth code from:https://open-dev.dingtalk.com/apiExplorer?spm=ding_open_doc.document.0.0.673539b7a86KKk#/jsapi?api=runtime.permission.requestAuthCode
        String code = "edc79b0d39023bcbaa0112db5285d34a";
        MvcResult result = mockMvc.perform(MockMvcRequestBuilders.get("/api/v1/prawn/ding/token")
                .contentType(MediaType.APPLICATION_JSON)
                .param("code",code))
                .andExpect(MockMvcResultMatchers.status().isOk())
                .andExpect(MockMvcResultMatchers.jsonPath("$.data").isNotEmpty())
                .andReturn();
        String responseContent = result.getResponse().getContentAsString();
        ObjectMapper objectMapper = new ObjectMapper();
        Result responseDto = objectMapper.readValue(responseContent, Result.class);
        String token = responseDto.getData().toString();
        mockMvc.perform(MockMvcRequestBuilders.get("/ltd/api/v1/prawn/user")
                        .contentType(MediaType.APPLICATION_JSON)
                        .header("token", token))
                .andExpect(MockMvcResultMatchers.status().isOk())
                .andExpect(MockMvcResultMatchers.jsonPath("$.data.avatar").isNotEmpty())
                .andExpect(MockMvcResultMatchers.jsonPath("$.data.name").isNotEmpty());




    }
}
