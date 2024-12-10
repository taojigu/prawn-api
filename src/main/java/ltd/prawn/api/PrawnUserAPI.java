package ltd.prawn.api;

import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import ltd.newbee.mall.util.Result;
import ltd.newbee.mall.util.ResultGenerator;
import ltd.prawn.api.vo.PrawnUserVO;
import ltd.prawn.config.annotation.TokenToPrawnUser;
import ltd.prawn.entity.PrawnUserEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@Api(value = "prawn", tags = "用户界面相关接口")
@RequestMapping("/ltd/api/v1/prawn")
public class PrawnUserAPI {



    @GetMapping("/user")
    @ApiOperation(value = "获取用户界面显示数据")
    Result<PrawnUserVO> getUserInfo(@TokenToPrawnUser PrawnUserEntity loginPrawnUser) {
        PrawnUserVO vo = new PrawnUserVO();
        vo.setUserName(loginPrawnUser.getOrgName());
        vo.setOrgName(loginPrawnUser.getOrgName());
        return ResultGenerator.genSuccessResult(vo);
    }

}
