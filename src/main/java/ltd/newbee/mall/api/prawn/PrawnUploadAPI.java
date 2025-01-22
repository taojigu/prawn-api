package ltd.newbee.mall.api.prawn;


import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import ltd.newbee.mall.common.Constants;
import ltd.newbee.mall.util.*;
import ltd.prawn.config.annotation.TokenToPrawnUser;
import ltd.prawn.entity.PrawnUserEntity;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.util.CollectionUtils;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.*;
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

    //@RequestMapping(value = "/prawn/aws/upload/image", method = RequestMethod.POST)
    @PostMapping("/prawn/aws/upload/image")
    @ApiOperation(value = "AWS单图上传", notes = "file Name \"file\"")
    public Result awsUploadImage(HttpServletRequest httpServletRequest, @RequestParam("file") MultipartFile file, @TokenToPrawnUser PrawnUserEntity prawnUserEntity) throws URISyntaxException, IOException{
        if (file.isEmpty()) {
            return ResultGenerator.genFailResult("image file is empty");
        }

        String filePath = file.getOriginalFilename();
        String key = "product_image/"+getFileKey(filePath);
        String bucketName = "prawn-image-bucket1";
        String imageUrl = S3ImageUploader.uploadImageToS3(bucketName,file,key);
        if (StringUtils.hasLength(imageUrl)){
            return ResultGenerator.genSuccessResult(imageUrl);
        } else {
            return ResultGenerator.genFailResult("Aws upload image failed");
        }
    }

    /**
     * 生成文件路径
     *
     * @return
     */
    private String getFileKey(String originalfileName) {
        String filePath = "";
        //1.获取后缀名 2.去除文件后缀 替换所有特殊字符
        String fileName = processFileName(originalfileName);
        filePath += UUID.randomUUID()+ "_" + fileName;
        return filePath;
    }


    /**
     * 处理文件名：去除后缀并替换特殊字符
     *
     * @param fileName 原始文件名
     * @return 处理后的文件名
     */
    public static String processFileName(String fileName) {
        // 1. 去除后缀
        String nameWithoutExtension = removeFileExtension(fileName);

        // 2. 替换所有特殊字符
        String sanitizedFileName = nameWithoutExtension.replaceAll("[^a-zA-Z0-9_-]", "_");

        return sanitizedFileName;
    }

    /**
     * 去除文件的扩展名
     *
     * @param fileName 文件名
     * @return 没有扩展名的文件名
     */
    public static String removeFileExtension(String fileName) {
        int lastDotIndex = fileName.lastIndexOf(".");
        if (lastDotIndex > 0) {
            return fileName.substring(0, lastDotIndex);
        }
        return fileName; // 如果没有后缀，返回原文件名
    }
}
