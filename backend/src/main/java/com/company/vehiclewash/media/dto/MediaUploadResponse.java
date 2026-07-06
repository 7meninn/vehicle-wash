package com.company.vehiclewash.media.dto;

import java.util.UUID;

public class MediaUploadResponse {
    private UUID mediaId;
    private String storageKey;

    public UUID getMediaId() { return mediaId; }
    public void setMediaId(UUID mediaId) { this.mediaId = mediaId; }

    public String getStorageKey() { return storageKey; }
    public void setStorageKey(String storageKey) { this.storageKey = storageKey; }
}
