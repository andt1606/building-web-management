package com.laptrinhjavaweb.builder;

public class CustomerSearchBuilder {
    private String fullname;
    private String phone;
    private String email;
    private Long staffId;

    public String getFullname() {
        return fullname;
    }

    public String getPhone() {
        return phone;
    }

    public String getEmail() {
        return email;
    }

    public Long getStaffId() {
        return staffId;
    }

    private CustomerSearchBuilder(Builder builder) {
        this.fullname = builder.fullname;
        this.phone = builder.phone;
        this.email = builder.email;
        this.staffId = builder.staffId;
    }

    public static class Builder {

        private String fullname;
        private String phone;
        private String email;
        private Long staffId;

        public Builder  setFullname(String fullname) {
            this.fullname = fullname;
            return this;
        }

        public Builder setPhone(String phone) {
            this.phone = phone;
            return this;
        }

        public Builder setEmail(String email) {
            this.email = email;
            return this;
        }

        public Builder setStaffId(Long staffId) {
            this.staffId = staffId;
            return this;
        }

        public CustomerSearchBuilder build() {
            return new CustomerSearchBuilder(this);
        }
    }


}
