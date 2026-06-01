package com.springmvc.controller;

import java.io.File;
import java.io.IOException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.springmvc.domain.Board;
import com.springmvc.domain.Comment;

@Controller
public class BoardController {

    public static List<Board> boardList =
            new ArrayList<>();

    private int nextId = 38;

    private int nextCommentId = 1;

    static {

        for(int i = 1; i <= 37; i++) {

            Board b = new Board();

            b.setId(i);

            b.setTitle(
                    "테스트 게시글 " + i);

            b.setWriter("민성");

            b.setContent(
                    "테스트 내용 " + i);

            b.setHit(i * 3);

            b.setLikeCount(i);

            b.setRegDate(
                    "2026-05-15");

            boardList.add(b);
        }
    }

    // 게시판 목록 + 검색 + 정렬 + 페이징
    @GetMapping("/board")
    public String boardList(

            @RequestParam(
            value="page",
            defaultValue="1")
            int page,

            @RequestParam(
            value="keyword",
            defaultValue="")
            String keyword,

            @RequestParam(
            value="sort",
            defaultValue="latest")
            String sort,

            Model model) {

        List<Board> filteredList =
                new ArrayList<>(boardList);

        // 검색
        if(!keyword.trim().isEmpty()) {

            filteredList =
                    filteredList.stream()

                    .filter(b ->
                    b.getTitle()
                    .contains(keyword))

                    .collect(Collectors.toList());
        }

        // 정렬
        if(sort.equals("hit")) {

            filteredList.sort(
                (a, b) ->
                b.getHit() - a.getHit());
        }

        else if(sort.equals("like")) {

            filteredList.sort(
                (a, b) ->
                b.getLikeCount()
                - a.getLikeCount());
        }

        else {

            filteredList.sort(
                (a, b) ->
                b.getId() - a.getId());
        }

        int pageSize = 10;

        int totalCount =
                filteredList.size();

        int totalPage =
                (int)Math.ceil(
                        (double)totalCount
                        / pageSize);

        int start =
                (page - 1) * pageSize;

        int end =
                Math.min(
                        start + pageSize,
                        totalCount);

        List<Board> pagingList =
                filteredList.subList(start, end);

        model.addAttribute(
                "boardList",
                pagingList);

        model.addAttribute(
                "currentPage",
                page);

        model.addAttribute(
                "totalPage",
                totalPage);

        model.addAttribute(
                "keyword",
                keyword);

        model.addAttribute(
                "sort",
                sort);

        return "board_list";
    }

    // 글쓰기 페이지
    @GetMapping("/board/write")
    public String writeForm() {

        return "board_write";
    }

    // 글 등록
    @PostMapping("/board/save")
    public String save(

            @RequestParam("title")
            String title,

            @RequestParam("content")
            String content,

            @RequestParam(
            value="imageFiles",
            required=false)
            MultipartFile[] imageFiles)

            throws IllegalStateException,
            IOException {

        Board board = new Board();

        board.setId(nextId++);

        board.setTitle(title);

        board.setContent(content);

        board.setWriter("민성");

        board.setRegDate(
                LocalDate.now().toString());

        board.setHit(0);

        board.setLikeCount(0);

        String uploadPath =
                "C:/springworkspace/upload/";

        File dir =
                new File(uploadPath);

        if(!dir.exists()) {

            dir.mkdirs();
        }

        if(imageFiles != null) {

            for(MultipartFile file
                    : imageFiles) {

                if(!file.isEmpty()) {

                    String fileName =
                            file.getOriginalFilename();

                    file.transferTo(

                        new File(
                        uploadPath + fileName));

                    board.getImageList()
                    .add(fileName);
                }
            }
        }

        // 대표 이미지
        if(!board.getImageList()
                .isEmpty()) {

            board.setImage(

                board.getImageList()
                .get(0));
        }

        boardList.add(board);

        return "redirect:/board";
    }

    // 상세
    @GetMapping("/board/detail/{id}")
    public String detail(

            @PathVariable("id")
            int id,

            Model model) {

        Board findBoard = null;

        for(Board b : boardList) {

            if(b.getId() == id) {

                b.setHit(
                        b.getHit() + 1);

                findBoard = b;

                break;
            }
        }

        model.addAttribute(
                "board",
                findBoard);

        return "board_detail";
    }

    // 삭제
    @GetMapping("/board/delete")
    public String delete(

            @RequestParam("id")
            int id) {

        boardList.removeIf(
                b -> b.getId() == id);

        return "redirect:/board";
    }

    // 좋아요
    @GetMapping("/board/like")
    public String like(

            @RequestParam("id")
            int id) {

        for(Board b : boardList) {

            if(b.getId() == id) {

                b.setLikeCount(
                        b.getLikeCount() + 1);
            }
        }

        return "redirect:/board/detail/" + id;
    }

    // 댓글
    @PostMapping("/board/comment")
    public String comment(

            @RequestParam("boardId")
            int boardId,

            @RequestParam("content")
            String content) {

        for(Board b : boardList) {

            if(b.getId() == boardId) {

                Comment comment =
                        new Comment();

                comment.setId(
                        nextCommentId++);

                comment.setWriter("민성");

                comment.setContent(content);

                comment.setRegDate(
                        LocalDate.now()
                        .toString());

                b.getComments()
                .add(comment);

                break;
            }
        }

        return "redirect:/board/detail/" +
                boardId;
    }

    // 수정 페이지
    @GetMapping("/board/edit/{id}")
    public String editForm(

            @PathVariable("id")
            int id,

            Model model) {

        Board findBoard = null;

        for(Board b : boardList) {

            if(b.getId() == id) {

                findBoard = b;

                break;
            }
        }

        model.addAttribute(
                "board",
                findBoard);

        return "board_edit";
    }

    // 수정 저장
    @PostMapping("/board/update")
    public String update(

            @RequestParam("id")
            int id,

            @RequestParam("title")
            String title,

            @RequestParam("content")
            String content) {

        for(Board b : boardList) {

            if(b.getId() == id) {

                b.setTitle(title);

                b.setContent(content);

                break;
            }
        }

        return "redirect:/board/detail/" + id;
    }

    // 댓글 삭제
    @GetMapping("/board/comment/delete")
    public String deleteComment(

            @RequestParam("boardId")
            int boardId,

            @RequestParam("commentId")
            int commentId) {

        for(Board b : boardList) {

            if(b.getId() == boardId) {

                b.getComments().removeIf(
                    c -> c.getId() == commentId
                );

                break;
            }
        }

        return "redirect:/board/detail/" +
                boardId;
    }

    // 댓글 수정 페이지
    @GetMapping("/board/comment/edit")
    public String editCommentForm(

            @RequestParam("boardId")
            int boardId,

            @RequestParam("commentId")
            int commentId,

            Model model) {

        Board findBoard = null;

        Comment findComment = null;

        for(Board b : boardList) {

            if(b.getId() == boardId) {

                findBoard = b;

                for(Comment c : b.getComments()) {

                    if(c.getId() == commentId) {

                        findComment = c;

                        break;
                    }
                }
            }
        }

        model.addAttribute(
                "board",
                findBoard);

        model.addAttribute(
                "comment",
                findComment);

        return "board_edit_comment";
    }

    // 댓글 수정 저장
    @PostMapping("/board/comment/update")
    public String updateComment(

            @RequestParam("boardId")
            int boardId,

            @RequestParam("commentId")
            int commentId,

            @RequestParam("content")
            String content) {

        for(Board b : boardList) {

            if(b.getId() == boardId) {

                for(Comment c : b.getComments()) {

                    if(c.getId() == commentId) {

                        c.setContent(content);

                        break;
                    }
                }
            }
        }

        return "redirect:/board/detail/" +
                boardId;
    }
}