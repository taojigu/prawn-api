package ltd.prawn.common;

public enum PrawnOrgTypeEnum {
    DEFAULT(0, "DEFAULT"),
    Prawn_Org_Company(1, "公司"),
    Prawn_Org_Community(2, "社区");

    private int orgType;
    private String orgTypeName;

    PrawnOrgTypeEnum(int orgType, String orgTypeName) {
        this.orgType = orgType;
        this.orgTypeName = orgTypeName;
    }

    public int getOrgType() {
        return orgType;
    }

    public String getOrgTypeName() {
        return orgTypeName;
    }
}
