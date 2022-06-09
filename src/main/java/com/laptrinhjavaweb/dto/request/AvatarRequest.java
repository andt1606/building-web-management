package com.laptrinhjavaweb.dto.request;

import org.springframework.web.multipart.MultipartFile;

public class AvatarRequest {
    private Long customerId;
    private MultipartFile multipartFile;

    public Long getCustomerId() {
        return customerId;
    }

    public void setCustomerId(Long customerId) {
        this.customerId = customerId;
    }

    public MultipartFile getMultipartFile() {
        return multipartFile;
    }

    public void setMultipartFile(MultipartFile multipartFile) {
        this.multipartFile = multipartFile;
    }
}
