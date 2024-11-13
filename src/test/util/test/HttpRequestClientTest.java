package test;

import ltd.newbee.mall.NewBeeMallAPIApplication;
import ltd.newbee.mall.api.mall.vo.NewBeeMallIndexCategoryVO;
import ltd.newbee.mall.util.Result;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.boot.test.web.server.LocalServerPort;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;

import java.util.List;

import static org.junit.jupiter.api.Assertions.*;
@SpringBootTest(classes = NewBeeMallAPIApplication.class,webEnvironment = SpringBootTest.WebEnvironment.RANDOM_PORT)
class HttpRequestClientTest {
    @LocalServerPort
    int port;
    final String host = "localhost";
    HttpRequestClient client;
    @BeforeEach
    public void eachSetup() {
        if (null == client) {
            client = new HttpRequestClient(host, port);
        }
    }
    @Test
    public void testGetMethod() {
        String path = "/ltd/newbee/mall/api/v1/categories";
        ResponseEntity<Result<List<NewBeeMallIndexCategoryVO>>> response =
                client.get(path,null);
        assertEquals(response.getStatusCode(), HttpStatus.OK);
    }
}