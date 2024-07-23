package com.kyupang.controller;

import java.io.File;
import java.io.IOException;
import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kyupang.mapper.BoardMapper;
import com.kyupang.model.BoardVO;
import com.kyupang.model.Criteria;
import com.kyupang.model.PageMaker;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/board/")
@AllArgsConstructor
public class BoardController {
	private BoardMapper mapper;
	private static final String FILE_UPLOAD_PATH = "D:\\Dev\\Project_KTE\\KYUPANG_Project\\src\\main\\webapp\\resources\\board_upload";

	
	@GetMapping("/boardlist")
	public void boardlist(Model model,@RequestParam(value = "page", defaultValue = "1") int page) {
		log.info("==boardlist==");
		
		Criteria criteria = new Criteria();
        criteria.setPage(page);
        
        List<BoardVO> list = mapper.boardlist(criteria);
		
		int totalCount = mapper.countBoard();
		
		PageMaker pageMaker = new PageMaker();
        pageMaker.setCriteria(criteria);
        pageMaker.setTotalCount(totalCount);
		
		model.addAttribute("list", list);
		model.addAttribute("pageMaker", pageMaker);
	}
	@GetMapping("/boardwrite")
	public void boardwrite() {
		log.info("==get boardwrite==");
	}
	
	@PostMapping("/boardwrite")
	public String postboardwrite(RedirectAttributes rttr,
								@RequestParam("title") String title,
								@RequestParam("contenttext") String contenttext,
								@RequestParam("file1") MultipartFile file1
								) throws IOException {
		log.info("==boardwrite==");
		
		BoardVO vo = new BoardVO();
		vo.setTitle(title);
		vo.setContenttext(contenttext);
		try {
	        if (!file1.isEmpty()) {
	            String fileName1 = saveFile(file1);
	            vo.setFile1(fileName1);
	        }
	    } catch (Exception e) {
	        rttr.addFlashAttribute("msg", "err");
	        return "error";
	    }
		
		mapper.boardcreate(vo);
		rttr.addFlashAttribute("msg", "게시글이 등록되었습니다."); 
		return "redirect:/board/boardlist";
	}
	private String saveFile(MultipartFile file) throws IOException {
	    // 파일 저장 로직 구현 (예: 파일을 특정 경로에 저장하고, 파일명을 반환)
	    String fileName = file.getOriginalFilename();
	    String savePath = "D:\\Dev\\Project_KTE\\KYUPANG_Project\\src\\main\\webapp\\resources\\\\board_upload\\" + fileName; // 슬래시 추가
	    File saveDir = new File("D:\\Dev\\Project_KTE\\KYUPANG_Project\\src\\main\\webapp\\resources\\board_upload");
	    if (!saveDir.exists()) {
	        saveDir.mkdirs(); // 폴더가 존재하지 않으면 생성
	    }
	    file.transferTo(new File(savePath));
	    return fileName;
	}
	
	@GetMapping("/boardview")
	public void boardview(Model model, @RequestParam("bid") int bid) {
		log.info("==boardlist==");
		BoardVO view = mapper.boardread(bid);
		
		model.addAttribute("view", view);
	}
	
	@GetMapping("/boardmodify")
	public void boardmodify(Model model, @RequestParam("bid") int bid) {
		log.info("==get boardmodify==");
		
		BoardVO modify = mapper.boardread(bid);
		
		model.addAttribute("modify", modify);
	}
	
	@PostMapping("/boardmodify")
	public String postboardmodify(@RequestParam("bid") Integer bid,
								@RequestParam("title") String title,
								@RequestParam("contenttext") String contenttext,
								@RequestParam("file1") MultipartFile file1,
								RedirectAttributes rttr) throws IOException {
		log.info("==get boardmodify==");
		
		BoardVO vo = new BoardVO();
		vo.setBid(bid);
		vo.setTitle(title);
		vo.setContenttext(contenttext);
		try {
	        if (!file1.isEmpty()) {
	            String fileName1 = saveFile(file1);
	            vo.setFile1(fileName1);
	        }
	    } catch (Exception e) {
	        rttr.addFlashAttribute("msg", "err");
	    }
		mapper.boardupdate(vo);
		rttr.addFlashAttribute("msg", "게시글이 수정되었습니다.");
		return "redirect:/board/boardview?bid="+bid;
	}
	
	@GetMapping("/deleteBoard")
	public String deleteBoard(@RequestParam("bid") int bid, RedirectAttributes rttr){
		log.info("==get deleteBoard==");
		
		mapper.deleteBoard(bid);
		rttr.addFlashAttribute("msg", "게시글이 삭제되었습니다.");
		return "redirect:/board/boardlist";
	}
}
