package ltd.newbee.mall.api.mall;

import com.fasterxml.jackson.databind.ObjectMapper;
import ltd.newbee.mall.api.mall.vo.NewBeeMallIndexCategoryVO;
import ltd.newbee.mall.util.Result;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.boot.test.web.server.LocalServerPort;
import org.springframework.core.ParameterizedTypeReference;
import org.springframework.http.HttpMethod;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.client.RestTemplate;
import com.fasterxml.jackson.core.type.TypeReference;
import java.util.List;

import static org.junit.jupiter.api.Assertions.*;
@SpringBootTest(webEnvironment = SpringBootTest.WebEnvironment.RANDOM_PORT)
//@SpringBootTest
class NewBeeMallGoodsCategoryURLApiTest {
    @LocalServerPort
    int port;
    RestTemplate restTemplate = new RestTemplate();
    private final ObjectMapper objectMapper = new ObjectMapper();

    @Test
    public void testGetCategoryIndex() {
        String url = "http://localhost:"+port+"/ltd/newbee/mall/api/v1/categories";
        ResponseEntity<Result<List<NewBeeMallIndexCategoryVO>>> response = restTemplate.exchange(
                url,
                HttpMethod.GET,
                null,
                new ParameterizedTypeReference<Result<List<NewBeeMallIndexCategoryVO>>>() {}
        );
        assertEquals(HttpStatus.OK,response.getStatusCode());
        assertTrue(response.getBody().getData().size() >= 0);
    }

}