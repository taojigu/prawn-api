package ltd.newbee.mall.api.prawn;

import com.alibaba.fastjson.JSONObject;
import com.alipay.api.AlipayApiException;
import com.alipay.api.AlipayClient;
import com.alipay.api.DefaultAlipayClient;
import com.alipay.api.request.AlipayTradeWapPayRequest;
import com.alipay.api.response.AlipayTradeWapPayResponse;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import io.swagger.annotations.ApiParam;
import ltd.newbee.mall.util.BeanUtil;
import ltd.newbee.mall.util.Result;
import ltd.newbee.mall.util.ResultGenerator;
import ltd.prawn.api.param.PrawnPublishProductOrderParam;
import ltd.prawn.common.PrawnMallException;
import ltd.prawn.common.PrawnOrderPayStatusEnum;
import ltd.prawn.common.PrawnPayTypeEnum;
import ltd.prawn.config.annotation.TokenToPrawnUser;
import ltd.prawn.dao.PrawnProductMapper;
import ltd.prawn.dao.PrawnPublishProductOrderMapper;
import ltd.prawn.entity.PrawnProductEntity;
import ltd.prawn.entity.PrawnPublishOrderEntity;
import ltd.prawn.entity.PrawnUserEntity;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpServletRequest;
import java.util.Date;
import java.util.UUID;

@RestController
@Api(value = "prawn", tags = "订单api")
@RequestMapping("/api/v1")
public class PrawnPublishOrderAPI {

    @Autowired
    private PrawnPublishProductOrderMapper orderMapper;

    @Autowired
    private PrawnProductMapper productMapper;

    @PostMapping(value = {"/prawn/order/publish"})
    @ApiOperation(value = "Prawn产品保存", notes = "保存产品信息")
    public Result<PrawnProductEntity> createPublishProductOrder(HttpServletRequest httpServletRequest,@ApiParam(value = "发布产品参数") @RequestBody
                                                                            PrawnPublishProductOrderParam orderParam, @TokenToPrawnUser
                                                            PrawnUserEntity prawnUserEntity) throws AlipayApiException {
        // 获取产品信息，读取price
        long productId = orderParam.getProductId();
        PrawnProductEntity ppe = this.productMapper.selectByProductId(productId);
        if (null == ppe) {
            throw new PrawnMallException("没有发现待发布的产品信息");
        }
        //ppe.setProductStatus(PrawnProductStatusEnum.PrawnProductStatusOnSale.getStatusCode());
        //this.productMapper.updateProduct(ppe);
        //return ResultGenerator.genSuccessResultData(ppe);
        //需要支付，生成订单信息，然后返回调用支付宝的H5 url

         //生成新的订单，并且保存，调用支付宝或者微信支付
        PrawnPublishOrderEntity orderEntity = publishOrderEntityFrom(ppe,orderParam);
        int result = this.orderMapper.insertOrder(orderEntity);
        if (result <=0){
            throw  new PrawnMallException("保存订单失败");
        }
        long orderId = orderEntity.getOrderId();
        String orderTitle = String.format("二手虾：%s",ppe.getTitle());
        String orderDesc = String.format("发布费用：%.02f",orderEntity.getCost());
        if (orderParam.getPayType() == PrawnPayTypeEnum.Ali_Pay.getPayType()) {
            return aliPlayPublishOrder(orderId,orderEntity.getCost(),orderTitle,orderDesc);
        }

        return ResultGenerator.genSuccessResult();
    }

    private Result preparePayOrder(PrawnProductEntity ppe,PrawnPublishProductOrderParam orderParam) throws AlipayApiException {
        PrawnPublishOrderEntity orderEntity = publishOrderEntityFrom(ppe,orderParam);
        int result = this.orderMapper.insertOrder(orderEntity);
        if (result <=0){
            throw  new PrawnMallException("保存订单失败");
        }
        long orderId = orderEntity.getOrderId();
        String orderTitle = String.format("发布产品：%s",ppe.getTitle());
        String orderDesc = String.format("发布费用：%.02f",orderEntity.getCost());
        if (orderParam.getPayType() == PrawnPayTypeEnum.Ali_Pay.getPayType()) {
            return aliPlayPublishOrder(orderId,orderEntity.getCost(),orderTitle,orderDesc);
        }

        return ResultGenerator.genSuccessResult();
    }

    private Result aliPlayPublishOrder(long orderId,double totalAmount,String orderTitle,String orderDesc) throws AlipayApiException {
        String alipayAppId = "2021003109638834";
        String alipayPrivateKey = "MIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQC8/y/hm5YFylejoevZiwriIGhPnfwSzpd2B9FaQb4iJAsIaxzrQrv4tZkACqOERoUMssCicfhMRLyogQBeUS65nsRofj1NB2O358ZoGJlNzxW+6WiSKDZLYJBzFAh2UKQgc+cBH8LtD+2vqXSGTdhIFg1c4qZASvCUJw/17bQUA7hDPtznrO1gxXQ4cNON+cFSwMoNCTG2dpXWZR0G5vUk/sKLwDHH06eGl+rdXg/jQFnejLhYSherBJF9XfxzApWEGrQodgxvoIK9WmJ2oYsj5SXmL4Y3HCMkZPvZYGe8r4o29a4uLPv1n+eye7vt+EtOv1B8QE1oRSWjoftH9/7nAgMBAAECggEBAIBhA0BHtEdoo9FV+uQBq7ngc5qpYQHRbVbShqW9hI6iVxA32iQAZ7jQegZqM5p1YIk4ntt5eUUtZ806G2r10DxsGVQ1dCRvwY+5k69ADlqpMUdGOy8Uu5TGGjjhQcJEksgskpzT20+2gyjQfYOBO0n0GM2gc3e2r+ajBhdyiOESW5asgdRoa3o/7fBB3ictg/87lWODDhIZ0TVzPkza5DLAvFC/0cE1rOhABq+EyY9V+bCqJrcGmJQWIZnriZcOxZhRKhbp4XwfC0seS7ay/jJDaYoJM0R6lOOezj4ZehLk6884OrbjK2jA8ih1Q+ji3qSNFuCgHvNPng+AFkJYb6kCgYEA/4IIVE3b3KAwWKR0DDOZtgKWAR0mzwXSt9Nx4/CllZCWjq0dS3Gh1Rf8q/yOv6qaoTx650FPCKMqYBG7x0zVMabVNWCLxcKdUzoB+PW7zBIn5y0rVwZLWQ6KhH1o4Sv/NB7t+FA/7e0+wj6siT1eqdQYENXevkIosZBg3A5zRTUCgYEAvVxdLjmG5/zzNaxcEGKyviQx0fEkInjWOTtg1MLdWM666cyLS90UGK6VFkr/dnlAnSK/B1zvYyKckMbcTCAKEOrAlbJYQo7x+LzQR2KZYnRHOfD+io7p6WVzCVm/r6seYD+m0B+fJNEtZCwHHWZz94vNnT+fl+11Ztke32nUwysCgYAiW+0c0R+Iyq3Vrb/BSEsaU7yyR6ZJXqIYgEGnglvyAfCNHTB8TbqSelhLFHppwdprZkOsx3aGVdLD+n6C7Y0Z0TKIrAP/wwz+/ST4wqrPZX2iM8vJNxp4zmDIMkkhRpZZ/vLHWptONoIjAuSWy/7n3ZKi6O+8LA9m2WB9FyBfJQKBgHHSMAxV9dpCOGqdxOTwfqI+HVglS2QRICtcnrKkwunbsYxRL7WVGLxRTDoPMIklDwqk1RB280myh0uazNZRN9u9T69reRPg2l96FvOht7LvU9TnIAlnKADrwv7u3IKaJ/MQr5NQPpehyFf7AvfQGorElP4dPS/UQwpkHeOKuKHrAoGAVBbZYjAtyRJz/3V6jWn6nsLZ6odBu8L6qkYcJYztrZGFScCG80ziNvnj4UGsQXWBzNngyuM+xXMJuW7E1+3S8Xmt4uJYjcVz3dVxUnp4EIzMr+2u4w4GLeXuqjYVT9QQMKjlPJbIQUUi1LaKGqUwk87hVW+fD3iOshBNOfn5RcI=";
        String alipayPublicKey = "MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAvP8v4ZuWBcpXo6Hr2YsK4iBoT538Es6XdgfRWkG+IiQLCGsc60K7+LWZAAqjhEaFDLLAonH4TES8qIEAXlEuuZ7EaH49TQdjt+fGaBiZTc8Vvulokig2S2CQcxQIdlCkIHPnAR/C7Q/tr6l0hk3YSBYNXOKmQErwlCcP9e20FAO4Qz7c56ztYMV0OHDTjfnBUsDKDQkxtnaV1mUdBub1JP7Ci8Axx9Onhpfq3V4P40BZ3oy4WEoXqwSRfV38cwKVhBq0KHYMb6CCvVpidqGLI+Ul5i+GNxwjJGT72WBnvK+KNvWuLiz79Z/nsnu77fhLTr9QfEBNaEUlo6H7R/f+5wIDAQAB";
        AlipayClient alipayClient = new DefaultAlipayClient("https://openapi.alipay.com/gateway.do",alipayAppId,alipayPrivateKey,"json","utf8",alipayPublicKey,"RSA2");
        Long orderIdLong = Long.valueOf(orderId);
        AlipayTradeWapPayRequest request = new AlipayTradeWapPayRequest();
        request.setNotifyUrl("");
        request.setReturnUrl("https://m.alipay.com/Gk8NF23");
        JSONObject bizContent = new JSONObject();
        bizContent.put("out_trade_no", orderIdLong.toString());
        bizContent.put("total_amount", totalAmount);
        bizContent.put("subject", orderTitle);
        bizContent.put("product_code", "QUICK_WAP_WAY");
        request.setBizContent(bizContent.toString());
        AlipayTradeWapPayResponse response = alipayClient.pageExecute(request,"GET");
        if(response.isSuccess()){
            System.out.println("调用成功");
            String bodyString = response.getBody();
            return ResultGenerator.genSuccessResultData(bodyString);
        } else {
            System.out.println("调用失败");
            return ResultGenerator.genFailResult(response.getMsg());
        }
    }

    private double totalOrderCost(PrawnPublishProductOrderParam param) {
        return 0.01;
    }

    private String publishProductOrderNo(PrawnPublishOrderEntity entity){
        return UUID.randomUUID().toString();
    }

    private PrawnPublishOrderEntity publishOrderEntityFrom(PrawnProductEntity ppe, PrawnPublishProductOrderParam param){
        PrawnPublishOrderEntity orderEntity = new PrawnPublishOrderEntity();
        orderEntity.setCost(this.totalOrderCost(param));
        Date now = new Date();
        orderEntity.setCreateTime(now);
        orderEntity.setUpdateTime(now);
        orderEntity.setIsDeleted((byte)0);
        String orderDetail = publishProductOrderDetail(ppe,param);
        orderEntity.setExtraInfo(orderDetail);
        orderEntity.setPayType(param.getPayType());
        orderEntity.setPayStatus(PrawnOrderPayStatusEnum.Unpaid.getOrderPayStatus());
        BeanUtil.copyProperties(ppe,orderEntity);
        String orderNo = publishProductOrderNo(orderEntity);
        orderEntity.setOrderNo(orderNo);
        double totalAmount = totalOrderCost(param);
        // 生成发布价格
        orderEntity.setCost(totalAmount);
        return orderEntity;
    }

    private String publishProductOrderDetail(PrawnProductEntity ppe, PrawnPublishProductOrderParam param){
        return ppe.getDescription();
    }


}
