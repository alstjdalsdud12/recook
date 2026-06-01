package com.springmvc.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.springmvc.dao.EventDAO;
import com.springmvc.domain.Event;

@Controller
public class CustomerController {

    @GetMapping("/customer")
    public String customerPage() {

        return "customer";
    }

    @GetMapping("/notice")
    public String noticePage() {

        return "notice";
    }

    @GetMapping("/qna")
    public String qnaPage() {

        return "qna";
    }

    @GetMapping("/event")
    public String eventPage(
            Model model) {

        EventDAO dao =
                new EventDAO();

        List<Event> list =
                dao.getEventList();

        model.addAttribute(
                "eventList",
                list);

        return "event";
    }

    @GetMapping("/event_detail")
    public String eventDetail(

            @RequestParam("e_no")
            int e_no,

            Model model) {

        EventDAO dao =
                new EventDAO();

        Event event =
                dao.getEventDetail(
                        e_no);

        model.addAttribute(
                "event",
                event);

        return "event_detail";
    }

    @GetMapping("/inquiry")
    public String inquiryPage() {

        return "inquiry";
    }
}