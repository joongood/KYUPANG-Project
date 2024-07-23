package com.kyupang.model;

import lombok.Data;

@Data
public class ProductCriteria {
    private int page = 1;
    private int perPageNum = 12;
    private String searchType;
    private String search;

    public void setPage(int page) {
        if (page <= 0) {
            this.page = 1;
            return;
        }
        this.page = page;
    }

    public void setPerPageNum(int perPageNum) {
        if (perPageNum <= 0 || perPageNum > 100) {
            this.perPageNum = 12;
            return;
        }
        this.perPageNum = perPageNum;
    }

    public int getPageStart() {
        return (this.page - 1) * perPageNum;
    }
    
    public String getSearchType() {
        return searchType;
    }

    public void setSearchType(String searchType) {
        this.searchType = searchType;
    }

    public String getSearch() {
        return search;
    }

    public void setSearch(String search) {
        this.search = search;
    }

    @Override
    public String toString() {
        return "ProductCriteria{" +
                "page=" + page +
                ", perPageNum=" + perPageNum +
                ", searchType='" + searchType + '\'' +
                ", search='" + search + '\'' +
                '}';
    }
}