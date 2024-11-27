package ltd.newbee.mall.util;

import org.springframework.web.multipart.MultipartFile;
import software.amazon.awssdk.auth.credentials.ProfileCredentialsProvider;
import software.amazon.awssdk.core.sync.RequestBody;
import software.amazon.awssdk.regions.Region;
import software.amazon.awssdk.services.s3.S3Client;
import software.amazon.awssdk.services.s3.model.PutObjectRequest;
import software.amazon.awssdk.services.s3.model.S3Exception;

import java.io.File;
import java.io.IOException;

/// Image uploader to S3 bucket
public class S3ImageUploader {

    public static String uploadImageToS3(String bucketName, MultipartFile file, String objectKey) {
        Region region = Region.AP_SOUTHEAST_2; // Replace with your desired region
        S3Client s3Client = S3Client.builder()
                .region(region)
                .credentialsProvider(ProfileCredentialsProvider.create())
                .build();

        try {
            // Create the PutObjectRequest
            PutObjectRequest putObjectRequest = PutObjectRequest.builder()
                    .bucket(bucketName)
                    .key(objectKey)
                    //.acl("public-read") // Makes the object publicly accessible
                    .build();

            // Upload the file
            s3Client.putObject(putObjectRequest, RequestBody.fromBytes(file.getBytes()));

            // Return the public URL of the uploaded object
            String publicUrl = "https://" + bucketName + ".s3." + region.id() + ".amazonaws.com/" + objectKey;
            return publicUrl;

        } catch (S3Exception | IOException e) {
            System.err.println("Failed to upload file to S3: " + e.getMessage());
            throw new RuntimeException(e);
        } finally {
            s3Client.close();
        }
    }

}


