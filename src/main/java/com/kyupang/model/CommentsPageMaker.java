package com.kyupang.model;

import lombok.Data;

@Data
public class CommentsPageMaker {

	private int totalCount;     // 총 게시글 수
    private int startPage;      // 시작 페이지
    private int endPage;        // 끝 페이지
    private boolean prev;       // 이전 페이지 여부
    private boolean next;       // 다음 페이지 여부
    private int displayPageNum = 10; // 화면에 보여질 페이지 번호의 수
    private CommentsCriteria criteria;

    public void setCriteria(CommentsCriteria criteria) {
        this.criteria = criteria;
    }

    public void setTotalCount(int totalCount) {
        this.totalCount = totalCount;
        calcData();
    }

    private void calcData() {
        endPage = (int) (Math.ceil(criteria.getPage() / (double) displayPageNum) * displayPageNum);
        startPage = (endPage - displayPageNum) + 1;

        int tempEndPage = (int) (Math.ceil(totalCount / (double) criteria.getPerPageNum()));
        if (endPage > tempEndPage) {
            endPage = tempEndPage;
        }

        prev = startPage > 1;
        next = endPage * criteria.getPerPageNum() < totalCount;
    }
}
