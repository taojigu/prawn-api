package ltd.prawn.common;

//出售的商品状态
public enum PrawnProductStatusEnum {

    Default(0,"默认状态"),
    PrawnProductStatusSaved(1,"保存中"),
    PrawnProductStatusApproving(2,"审核中"),
    PrawnProductStatusOnSale(3,"出售中"),
    PrawnProductStatusSaled(4,"已出售"),
    PrawnProductStatusRevoked(5,"已撤销");

    final private int statusCode;
    final private String statusName;

    PrawnProductStatusEnum(int statusCode, String statusName) {
        this.statusCode = statusCode;
        this.statusName = statusName;
    }

    public int getStatusCode() {
        return statusCode;
    }

    public String getStatusName() {
        return statusName;
    }
}
