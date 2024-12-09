package ltd.prawn.dao;

import ltd.prawn.entity.PrawnPublishOrderEntity;

/**
 * 发布产品订单Mapper
 * */
public interface PrawnPublishProductOrderMapper {

    //新增发布产品订单
    int insertOrder(PrawnPublishOrderEntity orderEntity);
    // 根据产品Id获取订单记录
    PrawnPublishOrderEntity selectByProductId(Long productId);
}
