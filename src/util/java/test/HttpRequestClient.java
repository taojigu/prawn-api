package test;

import ltd.newbee.mall.util.Result;
import org.springframework.core.ParameterizedTypeReference;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.lang.Nullable;
import org.springframework.web.client.RestTemplate;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.Serializable;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.Collections;
import java.util.List;
import java.util.Map;
import java.util.Objects;
import java.util.function.Supplier;

public class HttpRequestClient implements Serializable {

    private static final long serialVersionUID = 1L;
    private final String host;
    private final int port;
    private RestTemplate restTemplate = new RestTemplate();

    public HttpRequestClient(String host, int port) {
        this.host = host;
        this.port = port;
    }


    private <T> ResponseEntity<Result<T>> sendRequest(String path, String method, String body) {
        return null;
    }

    public <T> ResponseEntity<Result<List<T>>> get(String path, @Nullable Map<String,?> queryParam) {
        String url = fullURL(path);
        Map<String, ?> map = queryParam != null ? queryParam : Collections.emptyMap();
        return this.restTemplate.exchange(url,
                HttpMethod.GET,
                null,
                new ParameterizedTypeReference<Result<List<T>>>() {},
                map
                );
    }

    private String fullURL(String path) {
        String url = String.format("http://%s:%d%s", host, port, path);
        return url;
    }

    public <T> ResponseEntity<Result<T>> post(String path, String body) {
        return sendRequest(path, "POST", body);
    }

    public <T> ResponseEntity<Result<T>> put(String path, String body) {
        return sendRequest(path, "PUT", body);
    }

    public <T> ResponseEntity<Result<T>> delete(String path) {
        return sendRequest(path, "DELETE", null);
    }
}
