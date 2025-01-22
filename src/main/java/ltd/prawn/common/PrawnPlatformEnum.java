package ltd.prawn.common;
/// 平台类型Enum: 钉钉/企业微信
public enum PrawnPlatformEnum {
    FakePlatform(-1,"FakePlatform"),
    Default(0,"默认"),
    // 钉钉企业内应用
    DingDingEnterprise(1,"DingDingEnterprise"),
    // 钉钉第三方企业应用
    DingDingThirdEnterprise(2,"DingDingThirdEnterprise");


    final private int platformType;
    final private String platformName;

    PrawnPlatformEnum(int platformType, String platformName) {
        this.platformType = platformType;
        this.platformName = platformName;
    }

    public int getPlatformType() {
        return platformType;
    }

    public String getPlatformName() {
        return platformName;
    }
}
