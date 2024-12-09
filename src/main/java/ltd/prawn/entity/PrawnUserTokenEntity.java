package ltd.prawn.entity;

import lombok.Data;

import java.util.Date;

@Data
public class PrawnUserTokenEntity {

    private Long userId;

    private String token;

    private Date updateTime;

    private Date expireTime;
}
