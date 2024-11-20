package ltd.prawn.dao;

import ltd.newbee.mall.util.PageQueryUtil;
import ltd.prawn.entity.PrawnHomeProductEntity;

import java.util.List;

/**
 * 首页相关数据Mapper
 * */
public interface PrawnHomeMapper {
    /**
     * 获取首页数据List，支持分页参数
     * */
    public List<PrawnHomeProductEntity> getHomeProductList(PageQueryUtil queryUtil);
    /**
     * 获取首页产品数量的总数
     * */
    public int getTotalHomeProductCount(PageQueryUtil queryUtil);
}
