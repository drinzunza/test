package com.uav_recon.app.api.services.report.document.main;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;

import org.springframework.core.io.ClassPathResource;

import java.io.File;
import java.io.IOException;
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
        File resource = new ClassPathResource("report/strings.json").getFile();
        String text = new String(Files.readAllBytes(resource.toPath()));
        stringRootNode = new ObjectMapper().readTree(text);

        resource = new ClassPathResource("report/customizations.json").getFile();
        text = new String(Files.readAllBytes(resource.toPath()));
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
