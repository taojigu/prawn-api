package ltd.newbee.mall.api.prawn;

import cn.hutool.core.util.StrUtil;
import com.qcloud.cos.COSClient;
import com.qcloud.cos.ClientConfig;
import com.qcloud.cos.auth.BasicCOSCredentials;
import com.qcloud.cos.auth.COSCredentials;
import com.qcloud.cos.model.CannedAccessControlList;
import com.qcloud.cos.model.PutObjectRequest;
import com.qcloud.cos.region.Region;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import ltd.newbee.mall.common.Constants;
import ltd.newbee.mall.util.NewBeeMallUtils;
import ltd.newbee.mall.util.Result;
import ltd.newbee.mall.util.ResultGenerator;
import ltd.prawn.config.annotation.TokenToPrawnUser;
import ltd.prawn.entity.PrawnUserEntity;
import org.joda.time.DateTime;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.util.CollectionUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.multipart.support.StandardServletMultipartResolver;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.net.URI;
import java.net.URISyntaxException;
import java.text.SimpleDateFormat;
import java.util.*;

@RestController
@Api(value = "文件上传相关API", tags = "文件上传")
@RequestMapping("/api/v1")
public class PrawnUploadAPI {
    @Autowired
    private StandardServletMultipartResolver standardServletMultipartResolver;

    @Value("${spring.tengxun.SecretId}")
    private String secretId;
    @Value("${spring.tengxun.SecretKey}")
    private String secretKey;
    @Value("${spring.tengxun.region}")
    private String region;
    @Value("${spring.tengxun.bucketName}")
    private String bucketName;
    @Value("${spring.tengxun.url}")
    private String path;

    /**
     * 图片上传
     */
    @RequestMapping(value = "prawn/upload/image", method = RequestMethod.POST)
    @ApiOperation(value = "单图上传", notes = "file Name \"file\"")
    public Result uploadImage(HttpServletRequest httpServletRequest, @RequestParam("file") MultipartFile file, @TokenToPrawnUser PrawnUserEntity prawnUserEntity) throws URISyntaxException, IOException {
        COSClient cosClient = initCOSClient();
        try {

            String originalfileName = file.getOriginalFilename();
            // 获得文件流
            InputStream inputStream = file.getInputStream();
            //设置文件key
            String filePath = getFileKey(originalfileName);
            // 上传文件
            cosClient.putObject(new PutObjectRequest(bucketName, filePath, inputStream, null));
            cosClient.setBucketAcl(bucketName, CannedAccessControlList.PublicRead);
            String url = path + "/" + filePath;
            Map<String, String> map = new HashMap<>();
            map.put("fileName", originalfileName);
            map.put("url", url);
            Result resultSuccess = ResultGenerator.genSuccessResultData(map);
            return resultSuccess;

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            cosClient.shutdown();
        }

        return ResultGenerator.genFailResult("Failed to upload image");
    }

    private COSClient initCOSClient() {
        COSCredentials cred = new BasicCOSCredentials(secretId, secretKey);
        Region region = new Region(this.region);
        ClientConfig clientConfig = new ClientConfig(region);
        // 生成 cos 客户端。
        COSClient cosClient = new COSClient(cred, clientConfig);
        return cosClient;
    }

    /**
     * 生成文件路径
     *
     * @return
     */
    private String getFileKey(String originalfileName) {
        String filePath = "test/";
        //1.获取后缀名 2.去除文件后缀 替换所有特殊字符
        String fileType = originalfileName.substring(originalfileName.lastIndexOf("."));
        String fileStr = StrUtil.removeSuffix(originalfileName, fileType).replaceAll("[^0-9a-zA-Z\\u4e00-\\u9fa5]", "_");
        filePath += new DateTime().toString("yyyyMMddHHmmss") + "_" + fileStr + fileType;
        return filePath;
    }

    /**
     * 图片上传
     */
    @RequestMapping(value = "prawn/upload/file", method = RequestMethod.POST)
    @ApiOperation(value = "单图上传", notes = "file Name \"file\"")
    public Result upload(HttpServletRequest httpServletRequest, @RequestParam("file") MultipartFile file, @TokenToPrawnUser PrawnUserEntity prawnUserEntity) throws URISyntaxException {

        String fileName = file.getOriginalFilename();
        int suffIndex = fileName.lastIndexOf(".");
        String suffixName = ".jpg";
        if (-1 < suffIndex) {
            suffixName = fileName.substring(fileName.lastIndexOf("."));
        }
        //生成文件名称通用方法
        SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd_HHmmss");
        Random r = new Random();
        StringBuilder tempName = new StringBuilder();
        tempName.append(sdf.format(new Date())).append(r.nextInt(100)).append(suffixName);
        String newFileName = tempName.toString();
        File fileDirectory = new File(Constants.FILE_UPLOAD_DIC);
        //创建文件
        File destFile = new File(Constants.FILE_UPLOAD_DIC + newFileName);
        try {
            if (!fileDirectory.exists()) {
                if (!fileDirectory.mkdir()) {
                    throw new IOException("文件夹创建失败,路径为：" + fileDirectory);
                }
            }
            file.transferTo(destFile);
            Result resultSuccess = ResultGenerator.genSuccessResult();
            String targetURL = Constants.getImageURL(newFileName);
            resultSuccess.setData(targetURL);
            // resultSuccess.setData(NewBeeMallUtils.getHost(new URI(httpServletRequest.getRequestURL() + "")) + "/upload/" + newFileName);
            return resultSuccess;
        } catch (IOException e) {
            e.printStackTrace();
            return ResultGenerator.genFailResult("文件上传失败");
        }
    }

    /**
     * 图片上传
     */
    @RequestMapping(value = "prawn/upload/files", method = RequestMethod.POST)
    @ApiOperation(value = "多图上传", notes = "wangEditor图片上传")
    public Result uploadV2(HttpServletRequest httpServletRequest, @TokenToPrawnUser PrawnUserEntity prawnUserEntity) throws URISyntaxException {

        List<MultipartFile> multipartFiles = new ArrayList<>(8);
        if (standardServletMultipartResolver.isMultipart(httpServletRequest)) {
            MultipartHttpServletRequest multiRequest = (MultipartHttpServletRequest) httpServletRequest;
            Iterator<String> iter = multiRequest.getFileNames();
            int total = 0;
            while (iter.hasNext()) {
                if (total > 5) {
                    return ResultGenerator.genFailResult("最多上传5张图片");
                }
                total += 1;
                MultipartFile file = multiRequest.getFile(iter.next());
                multipartFiles.add(file);
            }
        }
        if (CollectionUtils.isEmpty(multipartFiles)) {
            return ResultGenerator.genFailResult("参数异常");
        }
        if (multipartFiles != null && multipartFiles.size() > 5) {
            return ResultGenerator.genFailResult("最多上传5张图片");
        }
        List<String> fileNames = new ArrayList(multipartFiles.size());
        for (int i = 0; i < multipartFiles.size(); i++) {
            String fileName = multipartFiles.get(i).getOriginalFilename();
            String suffixName = fileName.substring(fileName.lastIndexOf("."));
            //生成文件名称通用方法
            SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd_HHmmss");
            Random r = new Random();
            StringBuilder tempName = new StringBuilder();
            tempName.append(sdf.format(new Date())).append(r.nextInt(100)).append(suffixName);
            String newFileName = tempName.toString();
            File fileDirectory = new File(Constants.FILE_UPLOAD_DIC);
            //创建文件
            File destFile = new File(Constants.FILE_UPLOAD_DIC + newFileName);
            try {
                if (!fileDirectory.exists()) {
                    if (!fileDirectory.mkdir()) {
                        throw new IOException("文件夹创建失败,路径为：" + fileDirectory);
                    }
                }
                multipartFiles.get(i).transferTo(destFile);
                fileNames.add(NewBeeMallUtils.getHost(new URI(httpServletRequest.getRequestURL() + "")) + "/upload/" + newFileName);
            } catch (IOException e) {
                e.printStackTrace();
                return ResultGenerator.genFailResult("文件上传失败");
            }
        }
        Result resultSuccess = ResultGenerator.genSuccessResult();
        resultSuccess.setData(fileNames);
        return resultSuccess;
    }
}
