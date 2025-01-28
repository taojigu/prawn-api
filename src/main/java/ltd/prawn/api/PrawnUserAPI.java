package ltd.prawn.api;

import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import ltd.newbee.mall.util.BeanUtil;
import ltd.newbee.mall.util.Result;
import ltd.newbee.mall.util.ResultGenerator;
import ltd.prawn.api.vo.PrawnUserVO;
import ltd.prawn.config.annotation.TokenToPrawnUser;
import ltd.prawn.entity.PrawnUserEntity;
import ltd.prawn.service.PrawnUserService;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.annotation.Resource;

@RestController
@Api(value = "prawn", tags = "用户界面相关接口")
@RequestMapping("/api/v1/prawn")
public class PrawnUserAPI {

    @Resource
    private PrawnUserService prawnUserService;

    @GetMapping("/user")
    @ApiOperation(value = "获取用户界面显示数据")
    Result<PrawnUserVO> getUserInfo(@TokenToPrawnUser PrawnUserEntity loginPrawnUser) {
        PrawnUserEntity entity = prawnUserService.getUserInfoById(loginPrawnUser.getUserId());
        if (null ==entity) {
            return ResultGenerator.genFailResult("No User Info");
        }
        PrawnUserVO vo = new PrawnUserVO();
        BeanUtil.copyProperties(entity,vo);
        return ResultGenerator.genSuccessResult(vo);
    }

}
