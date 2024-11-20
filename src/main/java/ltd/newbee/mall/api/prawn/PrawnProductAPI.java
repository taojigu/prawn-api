package ltd.newbee.mall.api.prawn;

import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import io.swagger.annotations.ApiParam;
import ltd.newbee.mall.common.Constants;
import ltd.newbee.mall.util.*;
import ltd.prawn.api.param.PrawnUpdateProductParam;
import ltd.prawn.api.vo.PrawnMyProductVO;
import ltd.prawn.api.vo.PrawnProductDetailVO;
import ltd.prawn.common.bizCode.PrawnProductResultCode;
import ltd.prawn.config.annotation.TokenToPrawnUser;
import ltd.prawn.dao.PrawnProductMapper;
import ltd.prawn.entity.PrawnProductEntity;
import ltd.prawn.entity.PrawnUserEntity;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.*;

@RestController
@Api(value = "prawn", tags = "产品相关api")
@RequestMapping("/api/v1")
public class PrawnProductAPI {

    @Autowired
    PrawnProductMapper productMapper;

    @GetMapping("/prawn/product/detail")
    public Result<PrawnProductDetailVO> getProductDetail(@ApiParam(value="产品id") @RequestParam("productId") Long productId,@TokenToPrawnUser
            PrawnUserEntity prawnUserEntity) {
        List<Long> prdList = new ArrayList<Long>();
        prdList.add(productId);
        List<PrawnProductEntity> entityList = this.productMapper.selectByPrimaryKeys(prdList);
        if (null == entityList || entityList.size() == 0){
            return ResultGenerator.genFailResult("该商品不存在");
        }
        PrawnProductDetailVO vo = new PrawnProductDetailVO();
        BeanUtil.copyProperties(entityList.get(0),vo);
        return ResultGenerator.genSuccessResult(vo);
    }

    @PostMapping(value = {"/prawn/save-product","/prawn/product/save"})
    @ApiOperation(value = "Prawn产品保存", notes = "保存产品信息")
    public Result<PrawnProductEntity> saveProduct(@ApiParam(value = "订单参数") @RequestBody
                                          PrawnUpdateProductParam saveProductParam, @TokenToPrawnUser
            PrawnUserEntity prawnUserEntity){
        PrawnProductEntity entity = prawnEntityFrom(saveProductParam,prawnUserEntity);
        if (saveProductParam.getProductId() == null) {
            int result =productMapper. insertProduct(entity);
            if (0 == result) {
                return ResultGenerator.genErrorResult(PrawnProductResultCode.ProductDuplicated,"插入产品失败");
            } else{
                // 获取最新的userId的entity
                return ResultGenerator.genSuccessResultData(entity);
            }
        } else {
            int updateResult = this.productMapper.updateProduct(entity);
            if ( 0== updateResult){
                return ResultGenerator.genFailResult("更新产品失败");
            }
            return ResultGenerator.genSuccessResultData(entity);
        }
    }

    @PostMapping("/prawn/product/change-status")
    @ApiOperation(value = "修改产品状态", notes = "产品")
    public Result<String> changeProductStatus(@ApiParam(value = "修改状态的产品参数") @RequestBody
                                                      PrawnUpdateProductParam productParam, @TokenToPrawnUser
                                                      PrawnUserEntity prawnUserEntity){
        PrawnProductEntity paramEntity = this.productMapper.selectByProductId(productParam.getProductId());
        if (null == paramEntity && null != paramEntity.getProductId()) {
            return ResultGenerator.genFailResult("不存在对应产品");
        }
        paramEntity.setProductStatus(productParam.getProductStatus());
        int result = this.productMapper.updateProduct(paramEntity);
        if ( 0 == result) {
            return ResultGenerator.genFailResult("更新失败");
        }
        return ResultGenerator.genSuccessResult();
    }


    @GetMapping("/prawn/product/my")
    @ApiOperation(value = "获取我发布的产品列表，支持分页", notes = "产品")
    public Result<PageResult<List<PrawnMyProductVO>>> getMyProductPage(@ApiParam(value = "页码") @RequestParam(required = false,value = "page") Integer pageNumber,
                                                         @ApiParam(value = "页面大小") @RequestParam(required = false) Integer pageSize,
                                                         @ApiParam("商品状态") @RequestParam(value = "status",required = false) Integer status,
                                                         @TokenToPrawnUser PrawnUserEntity prawnUserEntity) {
        Map params = new HashMap(8);
        if (pageNumber == null || pageNumber < 1) {
            pageNumber = 1;
        }
        if (pageSize == null) {
            pageSize = Constants.ORDER_SEARCH_PAGE_LIMIT;
        }
        if (null != status) {
            params.put("productStatus",status);
        }
        params.put("userId", prawnUserEntity.getUserId());
        params.put("page", pageNumber);
        params.put("limit", pageSize);

        PageQueryUtil pageUtil = new PageQueryUtil(params);

        PageResult result = this.fetchMyProductPage(pageUtil);
        return ResultGenerator.genSuccessResult(result);
    }

    private PageResult<List<PrawnMyProductVO>> fetchMyProductPage(PageQueryUtil queryUtil) {
        Long userId = (Long) queryUtil.get("userId");
        Integer productStatus = (Integer) queryUtil.get("productStatus");
        int count = this.productMapper.getUserProductTotalCount(userId,productStatus);
        List<PrawnProductEntity> entityList = this.productMapper.getUserProductPage(queryUtil);
        List<PrawnMyProductVO> voList = new ArrayList<PrawnMyProductVO>();
        Integer pageSize = (Integer) queryUtil.get("limit");
        Integer pageIndex = (Integer)queryUtil.get("page");
        voList = BeanUtil.copyList(entityList,PrawnMyProductVO.class);
        return new PageResult(voList,count,pageSize,pageIndex);
    }



    private PrawnProductEntity prawnEntityFrom(PrawnUpdateProductParam productParam,PrawnUserEntity userEntity) {
        PrawnProductEntity entity = new PrawnProductEntity();
        entity.setProductId(productParam.getProductId());
        entity.setTitle(productParam.getTitle());
        entity.setDescription(productParam.getDescription());
        entity.setPrice(productParam.getPrice());
        entity.setProductImage(productParam.getProductImage());
        entity.setKeyWords(productParam.getKeyWord());
        if (productParam.getCategoryId() == null) {
            entity.setCategoryId(0L);
        } else {
            entity.setCategoryId(productParam.getCategoryId());
        }
        Date dt = new Date();
        entity.setCreateTime(dt);
        entity.setUpdateTime(dt);

        entity.setSellerId(userEntity.getUserId());
        entity.setSellerName(userEntity.getName());
        entity.setOrgId(userEntity.getOrgId());
        entity.setOrgName(userEntity.getOrgName());
        entity.setSellerEmployeeNo(userEntity.getEmployeeNo());
        return entity;
    }
}
