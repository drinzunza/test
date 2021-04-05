package com.uav_recon.app.api.services.report.document.main;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;

import org.springframework.core.io.ClassPathResource;
import org.springframework.util.FileCopyUtils;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;

class CustomReportManager {

    private static CustomReportManager instance = null;
    private static JsonNode stringRootNode = null;
    private static JsonNode customizationRootNode = null;

    public static CustomReportManager getInstance() {
        if (instance == null) {
            try {
                instance = new CustomReportManager();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
        return instance;
    }

    private CustomReportManager() throws IOException {
        InputStream inputStream = new ClassPathResource("report/strings.json").getInputStream();
        byte[] bdata = FileCopyUtils.copyToByteArray(inputStream);
        String text = new String(bdata, StandardCharsets.UTF_8);
        stringRootNode = new ObjectMapper().readTree(text);

        inputStream = new ClassPathResource("report/customizations.json").getInputStream();
        bdata = FileCopyUtils.copyToByteArray(inputStream);
        text = new String(bdata, StandardCharsets.UTF_8);
        customizationRootNode = new ObjectMapper().readTree(text);
    }

    public String getString(String key, String flavor) {
        if (stringRootNode.has(flavor) && stringRootNode.get(flavor).has(key)) {
            return stringRootNode.get(flavor).get(key).asText();
        }

        return stringRootNode.get("default").get(key).asText();
    }

    public boolean isVisible(String key, String flavor) {
        if (customizationRootNode.has(flavor) && customizationRootNode.get(flavor).has(key)) {
            return customizationRootNode.get(flavor).get(key).asBoolean();
        }

        return customizationRootNode.get("default").get(key).asBoolean();
    }
}
