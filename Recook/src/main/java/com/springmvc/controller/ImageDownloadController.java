package com.springmvc.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.InputStream;
import java.nio.file.Files;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.ResponseBody;
import jakarta.servlet.ServletOutputStream;
import jakarta.servlet.http.HttpServletResponse;

@Controller
public class ImageDownloadController {

    private String uploadPath = "C:\\RE_cook\\upload";

    @GetMapping("/recipeimage/{fileName}")
    @ResponseBody
    public void download(@PathVariable("fileName") String fileName,
                         HttpServletResponse response) throws Exception {
        File downloadFile = new File(uploadPath, fileName);

        if (!downloadFile.exists()) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
            return;
        }

        String mimeType = Files.probeContentType(downloadFile.toPath());
        response.setContentType(mimeType);

        byte[] buffer = new byte[1024];
        ServletOutputStream out = response.getOutputStream();
        try (InputStream in = new FileInputStream(downloadFile)) {
            for (int size; (size = in.read(buffer)) != -1;) {
                out.write(buffer, 0, size);
            }
        }
        response.flushBuffer();
    }
}