package ltd.prawn.dao;

import ltd.newbee.mall.util.PageQueryUtil;
import ltd.prawn.entity.PrawnProductEntity;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * 产品相关的DB Mapper
 * */
public interface PrawnProductMapper {
    /**
     * 新增产品
     * @param entity 产品数据
     * @return : insert result
     * */
    int insertProduct(PrawnProductEntity entity);

    /**
     * 更新产品
     * @param entity 产品数据
     * @return 更新结果
     * */
    int updateProduct(PrawnProductEntity entity);

    //根据多个ProductID获取对应的产品信息
    public List<PrawnProductEntity> selectByPrimaryKeys(List<Long>productIds);
    // 根据productId 来获取产品信息
    public PrawnProductEntity selectByProductId(Long productId);

    /**
     * 获取某个用户发布/保存的产品总数
     * @param userId  用户id
     * @param productStatus 产品状态
     * */
    public int  getUserProductTotalCount(@Param("userId")Long userId,@Param("productStatus") Integer productStatus);

    /**
     * 获取某个用户发布/保存的产品的分页列表数据
     * @param queryUtil： 包括分页相关，productStatus,userId
     * */
    List<PrawnProductEntity> getUserProductPage(PageQueryUtil queryUtil);
}
