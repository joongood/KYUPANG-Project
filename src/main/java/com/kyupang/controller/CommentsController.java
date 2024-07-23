package com.kyupang.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kyupang.mapper.CommentsMapper;
import com.kyupang.model.CommentsCriteria;
import com.kyupang.model.CommentsPageMaker;
import com.kyupang.model.CommentsVO;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/comments/")
@AllArgsConstructor
public class CommentsController {

	private CommentsMapper mapper;
	
	
	//글 목록
	@RequestMapping(value = "/count/{pid}", method = RequestMethod.GET)
	public @ResponseBody List<CommentsVO> list(@PathVariable("pid") Integer pid) {
		log.info("==리뷰 불러오기==");
		
		return mapper.CommentsList(pid);
	}
	
	//글 등록
	@RequestMapping(value = "", method = RequestMethod.POST)
	public @ResponseBody String register(@RequestBody CommentsVO vo) {
		log.info("==리뷰 등록==");

		mapper.addComments(vo);

		return "success";
	}
	
	//글 수정
	@RequestMapping(value = "/modify/{cmid}", method = { RequestMethod.PUT, RequestMethod.PATCH })
	public @ResponseBody String update(@PathVariable("cmid") Integer cmid, @RequestBody CommentsVO vo) {
		log.info("==리뷰 수정==");
		
		vo.setCmid(cmid);
		mapper.modifyComments(vo);

		return "success";
	}
	
	//글 삭제
	@RequestMapping(value = "/delete/{cmid}", method = RequestMethod.DELETE)
	public @ResponseBody String remove(@PathVariable("cmid") Integer cmid) {

		mapper.deleteComments(cmid);

		return "success";
	}
	
	//페이징
	@RequestMapping(value = "/{pid}/{page}", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> listPage2(
		@PathVariable("pid") Integer pid,
		@PathVariable("page") Integer page) {

		log.info("==리뷰 페이징==");
		
		CommentsCriteria criteria = new CommentsCriteria();
		criteria.setPage(page);

		CommentsPageMaker pageMaker = new CommentsPageMaker();
		pageMaker.setCriteria(criteria);

		int replyCount = mapper.count(pid);
		pageMaker.setTotalCount(replyCount);

		List<CommentsVO> list = mapper.commentsPage(pid, criteria);

		Map<String, Object> map = new HashMap<String, Object>();

		map.put("pid", pid);
		map.put("criteria", criteria);
		map.put("list", list);
		map.put("pageMaker", pageMaker);

		return map;
	}
}
