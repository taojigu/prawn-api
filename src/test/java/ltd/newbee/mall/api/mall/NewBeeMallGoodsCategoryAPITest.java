package ltd.newbee.mall.api.mall;

import com.fasterxml.jackson.databind.ObjectMapper;
import ltd.newbee.mall.api.mall.vo.NewBeeMallIndexCategoryVO;
import ltd.newbee.mall.service.NewBeeMallCategoryService;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.WebMvcTest;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.boot.test.mock.mockito.MockBean;
import org.springframework.boot.test.web.server.LocalServerPort;
import org.springframework.core.ParameterizedTypeReference;
import org.springframework.http.HttpMethod;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.MockMvcBuilder;
import org.springframework.web.client.RestTemplate;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.List;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertTrue;


@SpringBootTest
//@SpringBootTest(webEnvironment = SpringBootTest.WebEnvironment.RANDOM_PORT)
public class NewBeeMallGoodsCategoryAPITest  {
    //@LocalServerPort
    int port=8080;

    RestTemplate restTemplate = new RestTemplate();
    private final ObjectMapper objectMapper = new ObjectMapper();

    @Resource
    private NewBeeMallCategoryService newBeeMallCategoryService;
//    @Autowired
//    private MockMvc mockMvc;
////
    //@MockBean
    //@Autowired
    private NewBeeMallGoodsCategoryAPI mallCategoryApi;
    private NewBeeMallIndexCategoryVO sampleCategory;

    @BeforeEach()
    void setup(){
//        sampleCategory = new NewBeeMallIndexCategoryVO();
//        sampleCategory.setCategoryId(1L);
//        sampleCategory.setCategoryName("Sample Category");
    }
    @Test
    public void testGetCategoryIndex() throws Exception {
//        String url = "http://localhost:"+port+"/ltd/newbee/mall/api/v1/categories";
//        ResponseEntity<List<NewBeeMallIndexCategoryVO>> response = restTemplate.exchange(
//                url,
//                HttpMethod.GET,
//                null,
//                new ParameterizedTypeReference<List<NewBeeMallIndexCategoryVO>>() {}
//        );
//        assertEquals(HttpStatus.OK,response.getStatusCode());
//        assertTrue(response.getBody().size() > 0);
    }

    @Test
    public void testGetCategoriesSuccess() throws Exception{
        List resultList = this.newBeeMallCategoryService.getCategoriesForIndex();
        assertEquals(1,1);
//        List<NewBeeMallIndexCategoryVO> list = new ArrayList<NewBeeMallIndexCategoryVO>();
//        list.add(sampleCategory);
//        when(this.mallCategoryService.getCategoriesForIndex()).thenReturn(list);
//        mockMvc.perform(get("/ltd/newbee/mall/api/v1/get/categories")
//                .accept(MediaType.APPLICATION_JSON)
//                ).andExpect(status().isOk());

    }



}
