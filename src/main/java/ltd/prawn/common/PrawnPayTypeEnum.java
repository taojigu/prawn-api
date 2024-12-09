package ltd.prawn.common;

public enum PrawnPayTypeEnum {
    Default(-1, "ERROR"),
    Not_Pay(0, "无"),
    Ali_Pay(1, "支付宝"),
    Weixin_Pay(2, "微信支付");

    private int payType;

    private String name;

    PrawnPayTypeEnum(int payType, String name) {
        this.payType = payType;
        this.name = name;
    }

    public static PrawnPayTypeEnum getPayTypeEnumByType(int payType) {
        for (PrawnPayTypeEnum payTypeEnum : PrawnPayTypeEnum.values()) {
            if (payTypeEnum.getPayType() == payType) {
                return payTypeEnum;
            }
        }
        return Default;
    }

    public int getPayType() {
        return payType;
    }

    public void setPayType(int payType) {
        this.payType = payType;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }
}
