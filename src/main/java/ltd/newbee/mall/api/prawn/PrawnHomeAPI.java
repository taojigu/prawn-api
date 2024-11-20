package ltd.newbee.mall.api.prawn;

import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import io.swagger.annotations.ApiParam;
import ltd.newbee.mall.common.Constants;
import ltd.newbee.mall.util.*;
import ltd.prawn.api.vo.PrawnHomeProductVO;
import ltd.prawn.config.annotation.TokenToPrawnUser;
import ltd.prawn.dao.PrawnHomeMapper;
import ltd.prawn.entity.PrawnHomeProductEntity;
import ltd.prawn.entity.PrawnUserEntity;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.util.CollectionUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RestController
@Api(value = "prawn", tags = "获取首页数据")
@RequestMapping("/api/v1")
public class PrawnHomeAPI {
    @Autowired
    PrawnHomeMapper homeMapper;

    @GetMapping("/prawn/home-new")
    @ApiOperation(value = "Prawn获取首页数据", notes = "同一组织中的人，新上的数据")
    public Result<PageResult<List<PrawnHomeProductVO>>> homeNew(@ApiParam(value = "页码") @RequestParam(required = false) Integer pageNumber,
                                                                @TokenToPrawnUser PrawnUserEntity loginMallUser) {
        Map params = new HashMap(8);
        if (pageNumber == null || pageNumber < 1) {
            pageNumber = 1;
        }
        params.put("userId", loginMallUser.getUserId());
        params.put("page", pageNumber);
        params.put("limit", Constants.ORDER_SEARCH_PAGE_LIMIT);

        PageQueryUtil pageUtil = new PageQueryUtil(params);
        PageResult result = this.fetchNearbyGoodsPage(pageUtil);
        return ResultGenerator.genSuccessResult(result);
    }

    private PageResult fetchNearbyGoodsPage(PageQueryUtil queryUtil) {
        List<PrawnHomeProductVO> homeProductVOList = new ArrayList<PrawnHomeProductVO>();
        int total = this.homeMapper.getTotalHomeProductCount(queryUtil);
        List<PrawnHomeProductEntity> productList = this.homeMapper.getHomeProductList(queryUtil);
        if (!CollectionUtils.isEmpty(productList)){
            homeProductVOList = BeanUtil.copyList(productList,PrawnHomeProductVO.class);
        }
        PageResult pageResult = new PageResult(homeProductVOList, total, queryUtil.getLimit(), queryUtil.getPage());
        return pageResult;

    }

}
