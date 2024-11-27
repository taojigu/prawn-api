package ltd.newbee.mall.api.prawn;

import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import io.swagger.annotations.ApiParam;
import ltd.newbee.mall.common.Constants;
import ltd.newbee.mall.util.*;
import ltd.prawn.api.param.PrawnFavoriteParam;
import ltd.prawn.api.vo.PrawnFavoriteVO;
import ltd.prawn.api.vo.PrawnHomeProductVO;
import ltd.prawn.config.annotation.TokenToPrawnUser;
import ltd.prawn.dao.PrawnFavoriteMapper;
import ltd.prawn.dao.PrawnProductMapper;
import ltd.prawn.entity.PrawnFavoriteEntity;
import ltd.prawn.entity.PrawnProductEntity;
import ltd.prawn.entity.PrawnUserEntity;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.util.CollectionUtils;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.function.Function;
import java.util.stream.Collectors;

/**
 * 收藏相关接口
 * */
@RestController
@Api(value = "prawn", tags = "收藏相关")
@RequestMapping("/api/v1")
public class PrawnFavoriteAPI {
    @Autowired
    private PrawnFavoriteMapper favoriteMapper;

    @Autowired
    private PrawnProductMapper prawnProductMapper;

    @GetMapping("/prawn/favorite/list")
    @ApiOperation(value = "获取用户的产品收藏列表", notes = "获取用户的产品收藏列表")
    public Result<PageResult<List<PrawnHomeProductVO>>> homeNew(@ApiParam(value = "页码") @RequestParam(required = false) Integer pageNumber,
                                                                @ApiParam(value = "页面大小") @RequestParam(required = false) Integer pageSize,
                                                                @TokenToPrawnUser PrawnUserEntity loginMallUser) {
        Map params = new HashMap(8);
        if (pageNumber == null || pageNumber < 1) {
            pageNumber = 1;
        }
        if (pageSize == null) {
            pageSize = Constants.ORDER_SEARCH_PAGE_LIMIT;
        }
        params.put("userId", loginMallUser.getUserId());
        params.put("page", pageNumber);
        params.put("limit", pageSize);

        PageQueryUtil pageUtil = new PageQueryUtil(params);
        PageResult result = this.fetchFavoriteListResult(pageUtil);
        return ResultGenerator.genSuccessResult(result);
    }

    @PostMapping("/prawn/favorite/add")
    @ApiOperation(value = "获取用户的产品收藏", notes = "添加收藏")
    public Result<String> addFavorite(@ApiParam(value = "收藏参数") @RequestBody PrawnFavoriteParam param, @TokenToPrawnUser
                                      PrawnUserEntity prawnUserEntity){
        Long productId = param.getProductId();
        PrawnFavoriteEntity entity = this.favoriteMapper.selectByProductIdAndUserId(productId,prawnUserEntity.getUserId());
        if (null != entity) {
            return ResultGenerator.genFailResult("您已经收藏该商品");
        }
        entity = new PrawnFavoriteEntity();
        entity.setUserId(prawnUserEntity.getUserId());
        entity.setProductId(productId);
        int result = this.favoriteMapper.insert(entity);
        if (0 < result) {
            return ResultGenerator.genSuccessResult();
        }
        return ResultGenerator.genFailResult("收藏失败");
    }

    @GetMapping("/prawn/favorite/is-favorite")
    @ApiOperation(value = "判断当前产品是否被用户收藏", notes = "判断收藏")
    public Result<Boolean> isFavorite(@ApiParam(value = "收藏相关参数") @RequestParam("productId") Long productId, @TokenToPrawnUser
            PrawnUserEntity prawnUserEntity){
        //Long productId = param.getProductId();
        PrawnFavoriteEntity entity = this.favoriteMapper.selectByProductIdAndUserId(productId,prawnUserEntity.getUserId());
        if (null == entity) {
            return ResultGenerator.genSuccessResult(Boolean.valueOf(false));
        }
        return ResultGenerator.genSuccessResult(entity.getIsDeleted() == 0);
    }

    @PostMapping("/prawn/favorite/cancel")
    @ApiOperation(value = "产品收藏", notes = "取消收藏")
    public Result<String> cancel(@ApiParam(value = "收藏相关参数") @RequestBody PrawnFavoriteParam param, @TokenToPrawnUser
            PrawnUserEntity prawnUserEntity){

        Long productId = param.getProductId();
        PrawnFavoriteEntity entity = this.favoriteMapper.selectByProductIdAndUserId(productId,prawnUserEntity.getUserId());
        if (null == entity) {
            return ResultGenerator.genFailResult("并不存在对应收藏");
        }
        entity.setIsDeleted((byte)1);
        int result = this.favoriteMapper.updateFavorite(entity);
        if (0 < result) {
            return ResultGenerator.genSuccessResult();
        }
        return ResultGenerator.genFailResult("取消失败");
    }


    private PageResult<List<PrawnFavoriteVO>> fetchFavoriteListResult(PageQueryUtil queryUtil) {
        Long userId = (Long) queryUtil.get("userId");
        int total = this.favoriteMapper.getTotalFavoriteCountByUserId(userId);
        List<PrawnFavoriteVO> voList = new ArrayList<PrawnFavoriteVO>();
        List<PrawnFavoriteEntity> favoriteEntityList = this.favoriteMapper.selectFavoritePage(queryUtil);
        List<Long> productIDList = favoriteEntityList.stream().map(PrawnFavoriteEntity::getProductId).collect(Collectors.toList());
        List<PrawnProductEntity> entityList = this.prawnProductMapper.selectByPrimaryKeys(productIDList);
        Map<Long,PrawnProductEntity> productMap = new HashMap<>();
        if (!CollectionUtils.isEmpty(entityList)){
            productMap =  entityList.stream().collect(Collectors.toMap(PrawnProductEntity::getProductId,Function.identity(),(entity1,entity2)->entity1));
        }
        if (!CollectionUtils.isEmpty(favoriteEntityList)){
            voList = BeanUtil.copyList(favoriteEntityList,PrawnFavoriteVO.class);
        }
        for (PrawnFavoriteVO vo:voList) {
            PrawnProductEntity ppe = productMap.get(vo.getProductId());
            BeanUtil.copyProperties(ppe,vo);
        }
        return new PageResult(voList,total,queryUtil.getLimit(),queryUtil.getPage());

    }

}
