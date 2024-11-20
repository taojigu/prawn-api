package ltd.prawn.common;

//订单的支付状态
public enum PrawnOrderPayStatusEnum {
    DEFAULT(0, "DEFAULT"),
    Unpaid(1,"未支付"),
    Paid(2,"已支付");


    private int orderPayStatus;
    private String orderPayStatusName;

    PrawnOrderPayStatusEnum(int orgType, String orgTypeName) {
        this.orderPayStatus = orgType;
        this.orderPayStatusName = orgTypeName;
    }

    public int getOrderPayStatus() {
        return orderPayStatus;
    }

    public String getOrderPayStatusName() {
        return orderPayStatusName;
    }
}
