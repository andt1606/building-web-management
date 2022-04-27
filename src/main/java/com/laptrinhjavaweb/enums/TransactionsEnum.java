package com.laptrinhjavaweb.enums;

public enum TransactionsEnum {
    QUA_TRINH_CSKH("QUÁ TRÌNH CSKH"),
    DAN_DI_XEM("DẪN ĐI XEM");

    private final String transactionValue;

    TransactionsEnum(String transactionValue) {
        this.transactionValue = transactionValue;
    }

    public String getTransactionValue() {
        return transactionValue;
    }
}
