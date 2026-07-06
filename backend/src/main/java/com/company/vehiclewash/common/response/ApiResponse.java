package com.company.vehiclewash.common.response;

import java.time.Instant;
import java.util.UUID;

public class ApiResponse<T> {
    private boolean success;
    private T data;
    private ApiError error;
    private Instant timestamp;
    private String requestId;

    public ApiResponse() {}

    public ApiResponse(boolean success, T data, ApiError error) {
        this.success = success;
        this.data = data;
        this.error = error;
        this.timestamp = Instant.now();
        this.requestId = UUID.randomUUID().toString().substring(0, 8); // simplified
    }

    public static <T> ApiResponse<T> success(T data) {
        return new ApiResponse<>(true, data, null);
    }

    public static <T> ApiResponse<T> error(String code, String message) {
        return new ApiResponse<>(false, null, new ApiError(code, message));
    }

    public boolean isSuccess() {
        return success;
    }

    public void setSuccess(boolean success) {
        this.success = success;
    }

    public T getData() {
        return data;
    }

    public void setData(T data) {
        this.data = data;
    }

    public ApiError getError() {
        return error;
    }

    public void setError(ApiError error) {
        this.error = error;
    }

    public Instant getTimestamp() {
        return timestamp;
    }

    public void setTimestamp(Instant timestamp) {
        this.timestamp = timestamp;
    }

    public String getRequestId() {
        return requestId;
    }

    public void setRequestId(String requestId) {
        this.requestId = requestId;
    }

    public static class ApiError {
        private String code;
        private String message;

        public ApiError() {}

        public ApiError(String code, String message) {
            this.code = code;
            this.message = message;
        }

        public String getCode() {
            return code;
        }

        public void setCode(String code) {
            this.code = code;
        }

        public String getMessage() {
            return message;
        }

        public void setMessage(String message) {
            this.message = message;
        }
    }
}
