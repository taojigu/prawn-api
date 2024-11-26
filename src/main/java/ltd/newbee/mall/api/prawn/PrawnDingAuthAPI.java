package ltd.newbee.mall.api.prawn;

import com.alibaba.fastjson.JSON;
import io.swagger.annotations.Api;
import ltd.lib.HttpClientUtil;
import ltd.newbee.mall.common.Constants;
import ltd.newbee.mall.service.PrawnUserTokenService;
import ltd.newbee.mall.util.DdConfigSign;
import ltd.newbee.mall.util.Result;
import ltd.newbee.mall.util.ResultGenerator;
import ltd.newbee.mall.util.StringUtil;
import ltd.prawn.common.PrawnMallException;
import ltd.prawn.config.annotation.TokenToPrawnUser;
import ltd.prawn.dao.PrawnUserMapper;
import ltd.prawn.entity.PrawnUserEntity;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RestController
@Api(value = "prawn", tags = "钉钉用户认证相关")
@RequestMapping("/api/v1")
public class PrawnDingAuthAPI {
    @Autowired
    private PrawnUserMapper userMapper;
    @Autowired
    private PrawnUserTokenService userTokenService;
    private String corpId = "dingdfd635d844dc249df5bf40eda33b7ba0";
    private String agentId = "1347471188";

    @GetMapping("prawn/ding/auth/signature")
    public Result getDingAuthSignature(@TokenToPrawnUser PrawnUserEntity loginMallUser) throws Exception {
        String token = this.requestDingToken();
        String noncestr= StringUtil.getRandomString(8);
        String ticket= this.requestDingTicket(token);
        if (null == ticket) {
            return ResultGenerator.genFailResult("TicketFailed");
        }
        long  timestamp=  System.currentTimeMillis()/1000;//1414588745;
        String url = "http://"+ Constants.serviceDomain +":9002";
        String signature = DdConfigSign.sign(ticket,noncestr,timestamp,url);
        HashMap<String,Object> result = new HashMap<String,Object>();
        result.put("url",url);
        result.put("agentId",this.agentId);
        result.put("nonceStr",noncestr);
        result.put("timeStamp",Long.valueOf(timestamp).toString());
        result.put("signature",signature);
        List<String> apiList = dingApiList();
        result.put("jsApiList",apiList);
        result.put("corpId",this.corpId);
        return ResultGenerator.genSuccessResult(result);
    }

    @GetMapping("prawn/ding/token")
    //dingding auth code from:https://open-dev.dingtalk.com/apiExplorer?spm=ding_open_doc.document.0.0.673539b7a86KKk#/jsapi?api=runtime.permission.requestAuthCode
    public Result<String> getTokenFromDing(@RequestParam("code") String code) throws Exception {
        // 请求DingToken
        String dingToken = requestDingToken();
        if (StringUtils.isEmpty(dingToken)){
            return ResultGenerator.genFailResult("请求钉钉 Token 失败");
        }
        // 请求UserId
        Map<String,Object> userInfo = requestDingUserInfo(dingToken,code);
        String unionId = userInfo.get("unionid").toString();
        String dingUserId = userInfo.get("userid").toString();
        PrawnUserEntity userEntity = this.userMapper.selectByOpenId(unionId);
        if ( null == userEntity){
            Map<String,Object> dingUserMap = requestDingUserDetail(dingToken,dingUserId);
            if (null == dingUserMap){
                return ResultGenerator.genFailResult("请求钉钉用户详情失败");
            }
            insertUserInfoPrawn(dingUserMap);
        } 
        String prawnToken = this.userTokenService.generateNewToken(unionId);
        if (StringUtils.isEmpty(prawnToken)){
            return ResultGenerator.genFailResult("登录钉钉失败");
        }
        return ResultGenerator.genSuccessResult(prawnToken);
    }


    private Map<String,Object>requestDingUserDetail(String dingToken,String userId){
        String url = String.format("https://oapi.dingtalk.com/topapi/v2/user/get?access_token=%s",dingToken);
        Map<String,String> body= new HashMap<String, String>();
        body.put("userid",userId);
        String resultString  = HttpClientUtil.doPost(url,body);
        Map<String,Object> resultMap = JSON.parseObject(resultString);
        if (!isSuccessResult(resultMap)){
            return null;
        }
        return (Map<String,Object>)resultMap.get("result");
    }

    private void insertUserInfoPrawn(Map<String, Object> dingUserMap) throws Exception {
        PrawnUserEntity entity = PrawnUserEntity.fromDingDingUser(dingUserMap);
        if (0 ==this.userMapper.insert(entity)){
            throw new Exception("DingDingUser 注册PrawnUser 失败");
        }
        return;
    }

    private Map<String,Object> requestDingUserInfo(String dingToken,String code) {
        String url = String.format("https://oapi.dingtalk.com/topapi/v2/user/getuserinfo?access_token=%s",dingToken);
        Map<String,String> param = new HashMap<String,String>();
        param.put("code",code);
        String resultString = HttpClientUtil.doPost(url,param);
        if(!StringUtils.hasLength(resultString)){
            throw new PrawnMallException("Request Ding UserInfo failed");
        }

        Map<String ,Object> resultMap = JSON.parseObject(resultString);
        if (!isSuccessResult(resultMap)){
            throw new PrawnMallException("Code is not valid");
        }
        return  (Map<String, Object>) resultMap.get("result");
    }

    private  String requestDingTicket(String token) {

        //https://oapi.dingtalk.com/get_jsapi_ticket?access_token=797a8d74272431f0b75a7615fcf315cb
        String url = String.format("https://oapi.dingtalk.com/get_jsapi_ticket?access_token=%s",token);
        String resultString = HttpClientUtil.doGet(url);
        if (StringUtils.isEmpty(resultString)){
            return  null;
        }

        Map<String,Object> resultMap = (Map<String,Object>)JSON.parse(resultString);
        if (!isSuccessResult(resultMap)){
            return null;
        }
        String ticket = resultMap.get("ticket").toString();
        return ticket;
     }

    private String requestDingToken() {
        String appKey = "dingflsodlddtler2d3w";
        String appSecret = "HE-o7xOXsrLEJChJ8MYipeht5sBSTFvcE3NSGrYVvfXTmWEzcXgE9tZ_26_iRwJZ";
        String url = String.format("https://oapi.dingtalk.com/gettoken?appkey=%s&appsecret=%s",appKey,appSecret);
        String resultString = HttpClientUtil.doGet(url);
        if (StringUtils.isEmpty(resultString)){
            return  null;
        }

        Map<String,Object> resultMap = (Map<String,Object>)JSON.parse(resultString);
        if (!isSuccessResult(resultMap)){
            return null;
        }
        String dingToken = resultMap.get("access_token").toString();
        return dingToken;
    }

    private List<String> dingApiList() {
        ArrayList<String> apiList = new ArrayList<String>();
        apiList.add("biz.alipay.pay");
        return apiList;
    }

    private Boolean isSuccessResult(Map resultMap){
        if (null == resultMap) {
            return false;
        }
        Integer errorCode = (Integer) resultMap.get("errcode");
        if (null == errorCode) {
            return false;
        }
        return 0 == errorCode;
    }

}
