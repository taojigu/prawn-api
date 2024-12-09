package ltd.prawn.dao;

import ltd.newbee.mall.util.PageQueryUtil;
import ltd.prawn.entity.PrawnFavoriteEntity;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * 收藏相关Mapper
 * */
public interface PrawnFavoriteMapper {
    //获取某个用户的收藏个数
    public int getTotalFavoriteCountByUserId(Long userId);
    // 查询用户收藏记录的分页数据
    public List<PrawnFavoriteEntity> selectFavoritePage(PageQueryUtil pageQueryUtil);
    // 更新收藏数据
    public int updateFavorite(PrawnFavoriteEntity entity);
    // 插入收藏数据
    public int insert(PrawnFavoriteEntity entity);
    // 获取用户的某个产品的收藏信息
    PrawnFavoriteEntity selectByProductIdAndUserId(@Param("productId") Long productId, @Param("userId")Long userId);

}
