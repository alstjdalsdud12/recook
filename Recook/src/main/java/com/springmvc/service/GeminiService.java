package com.springmvc.service;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.stereotype.Service;

@Service
public class GeminiService {

    private final String API_KEY =
            "AIzaSyCwL2i9HGRmyw_Oi-kOeWIyba7c5YdrJJU";

    public String summarizeComments(
            String comments)
            throws Exception {

        String endpoint =
        "https://generativelanguage.googleapis.com/v1beta/models/gemini-2.5-flash:generateContent?key="
        + API_KEY;

        URL url =
                new URL(endpoint);

        HttpURLConnection conn =
                (HttpURLConnection)
                url.openConnection();

        conn.setRequestMethod("POST");

        conn.setRequestProperty(
                "Content-Type",
                "application/json");

        conn.setDoOutput(true);

        String prompt =
                "다음 레시피 댓글을 "
              + "한국어로 핵심만 3줄 요약해줘.\n"
              + comments;

        String json =
        """
        {
          "contents":[
            {
              "parts":[
                {
                  "text":"%s"
                }
              ]
            }
          ]
        }
        """.formatted(
                prompt.replace(
                "\"",
                "\\\""));

        OutputStream os =
                conn.getOutputStream();

        os.write(
                json.getBytes());

        os.flush();

        BufferedReader br =
                new BufferedReader(
                new InputStreamReader(
                conn.getInputStream()));

        String line;

        StringBuilder result =
                new StringBuilder();

        while(
        (line = br.readLine())
        != null){

            result.append(line);
        }

        br.close();

        // Gemini JSON 파싱
        JSONObject obj =
                new JSONObject(
                result.toString());

        JSONArray candidates =
                obj.getJSONArray(
                "candidates");

        JSONObject first =
                candidates.getJSONObject(0);

        JSONObject content =
                first.getJSONObject(
                "content");

        JSONArray parts =
                content.getJSONArray(
                "parts");

        String summary =
                parts.getJSONObject(0)
                .getString("text");

        return summary;
    }
}