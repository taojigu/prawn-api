package ltd.prawn.entity;

import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Data;

import java.util.Date;

@Data
public class PrawnFavoriteEntity {
    private Long favoriteId;
    private Long userId;
    private Long productId;
    private Byte isDeleted;
    private Byte lockedFlag;
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
    private Date createTime;
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
    private Date updateTime;

    public PrawnFavoriteEntity() {
        this.isDeleted = 0;
        this.lockedFlag = 0;
    }

}
