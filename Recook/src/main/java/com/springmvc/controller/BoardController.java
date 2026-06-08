package com.springmvc.controller;

import java.io.File;
import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.springmvc.dao.BoardDAO;
import com.springmvc.domain.Board;
import com.springmvc.domain.Comment;

import jakarta.servlet.http.HttpSession;

@Controller
public class BoardController {

    private BoardDAO boardDAO = new BoardDAO();
    private String uploadDir = "C:\\RE_cook\\upload";

    // 게시판 목록 + 검색 + 정렬 + 페이징
    @GetMapping("/board")
    public String boardList(
            @RequestParam(value = "page", defaultValue = "1") int page,
            @RequestParam(value = "keyword", defaultValue = "") String keyword,
            @RequestParam(value = "sort", defaultValue = "latest") String sort,
            Model model) {

        List<Board> list = boardDAO.selectAll(keyword, sort);

        int pageSize = 10;
        int totalCount = list.size();
        int totalPage = (int) Math.ceil((double) totalCount / pageSize);
        int start = (page - 1) * pageSize;
        int end = Math.min(start + pageSize, totalCount);

        List<Board> pagingList = list.subList(start, end);

        model.addAttribute("boardList", pagingList);
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPage", totalPage);
        model.addAttribute("keyword", keyword);
        model.addAttribute("sort", sort);

        return "board_list";
    }

    // 글쓰기 페이지
    @GetMapping("/board/write")
    public String writeForm(HttpSession session) {
        if (session.getAttribute("m_nickname") == null) {
            return "redirect:/login";
        }
        return "board_write";
    }

    // 글 등록
    @PostMapping("/board/save")
    public String save(
            @RequestParam("title") String title,
            @RequestParam("content") String content,
            @RequestParam(value = "imageFiles", required = false) MultipartFile[] imageFiles,
            HttpSession session) {

        String writer = (String) session.getAttribute("m_nickname");
        int m_no = (int) session.getAttribute("m_no");

        Board board = new Board();
        board.setB_title(title);
        board.setB_content(content);
        board.setB_writer(writer);
        board.setM_no(m_no);

        int b_id = boardDAO.insert(board);

        if (imageFiles != null) {
            for (MultipartFile file : imageFiles) {
                if (!file.isEmpty()) {
                    try {
                        String fileName = System.currentTimeMillis() + "_" + file.getOriginalFilename();
                        File dir = new File(uploadDir);
                        if (!dir.exists()) dir.mkdirs();
                        file.transferTo(new File(uploadDir + "\\" + fileName));
                        boardDAO.insertImage(b_id, fileName);
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                }
            }
        }

        return "redirect:/board";
    }

    // 상세
    @GetMapping("/board/detail/{b_id}")
    public String detail(@PathVariable("b_id") int b_id, Model model, HttpSession session) {
        boardDAO.updateHit(b_id);
        Board board = boardDAO.selectOne(b_id);
        board.setImageList(boardDAO.selectImages(b_id));
        board.setComments(boardDAO.selectComments(b_id));
        model.addAttribute("board", board);

        // 좋아요 여부 확인
        Integer m_no = (Integer) session.getAttribute("m_no");
        if (m_no != null) {
            model.addAttribute("isLiked", boardDAO.isLiked(b_id, m_no));
        } else {
            model.addAttribute("isLiked", false);
        }

        return "board_detail";
    }
    // 삭제
    @GetMapping("/board/delete")
    public String delete(@RequestParam("id") int b_id) {
        boardDAO.delete(b_id);
        return "redirect:/board";
    }

    // 좋아요
    @GetMapping("/board/like")
    public String like(@RequestParam("id") int b_id, HttpSession session) {
        int m_no = (int) session.getAttribute("m_no");
        boardDAO.toggleLike(b_id, m_no);
        return "redirect:/board/detail/" + b_id;
    }

    // 댓글 등록
    @PostMapping("/board/comment")
    public String comment(
            @RequestParam("boardId") int b_id,
            @RequestParam("content") String content,
            HttpSession session) {

        String writer = (String) session.getAttribute("m_nickname");
        int m_no = (int) session.getAttribute("m_no");

        Comment comment = new Comment();
        comment.setB_id(b_id);
        comment.setM_no(m_no);
        comment.setBc_writer(writer);
        comment.setBc_content(content);

        boardDAO.insertComment(comment);

        return "redirect:/board/detail/" + b_id;
    }

    // 수정 페이지
    @GetMapping("/board/edit/{b_id}")
    public String editForm(@PathVariable("b_id") int b_id, Model model) {
        Board board = boardDAO.selectOne(b_id);
        model.addAttribute("board", board);
        return "board_edit";
    }

    // 수정 저장
    @PostMapping("/board/update")
    public String update(
            @RequestParam("id") int b_id,
            @RequestParam("title") String title,
            @RequestParam("content") String content) {

        Board board = new Board();
        board.setB_id(b_id);
        board.setB_title(title);
        board.setB_content(content);

        boardDAO.update(board);

        return "redirect:/board/detail/" + b_id;
    }

    // 댓글 삭제
    @GetMapping("/board/comment/delete")
    public String deleteComment(
            @RequestParam("boardId") int b_id,
            @RequestParam("commentId") int bc_id) {

        boardDAO.deleteComment(bc_id);

        return "redirect:/board/detail/" + b_id;
    }

    // 댓글 수정 페이지
    @GetMapping("/board/comment/edit")
    public String editCommentForm(
            @RequestParam("boardId") int b_id,
            @RequestParam("commentId") int bc_id,
            Model model) {

        Board board = boardDAO.selectOne(b_id);
        List<Comment> comments = boardDAO.selectComments(b_id);

        Comment findComment = null;
        for (Comment c : comments) {
            if (c.getBc_id() == bc_id) {
                findComment = c;
                break;
            }
        }

        model.addAttribute("board", board);
        model.addAttribute("comment", findComment);

        return "board_edit_comment";
    }

    // 댓글 수정 저장
    @PostMapping("/board/comment/update")
    public String updateComment(
            @RequestParam("boardId") int b_id,
            @RequestParam("commentId") int bc_id,
            @RequestParam("content") String content) {

        boardDAO.updateComment(bc_id, content);

        return "redirect:/board/detail/" + b_id;
    }
    
    @PostMapping("/board/reply")
    public String reply(
            @RequestParam("boardId") int b_id,
            @RequestParam("parentId") int parent_id,
            @RequestParam("content") String content,
            @RequestParam("depth") int depth,
            HttpSession session) {

        String writer = (String) session.getAttribute("m_nickname");
        Integer m_no = (Integer) session.getAttribute("m_no");

        if (writer == null || m_no == null) {
            return "redirect:/login";
        }

        Comment comment = new Comment();
        comment.setB_id(b_id);
        comment.setM_no(m_no);
        comment.setBc_writer(writer);
        comment.setBc_content(content);
        comment.setParent_id(parent_id);
        comment.setBc_depth(depth + 1);

        boardDAO.insertComment(comment);

        return "redirect:/board/detail/" + b_id;
    }
}