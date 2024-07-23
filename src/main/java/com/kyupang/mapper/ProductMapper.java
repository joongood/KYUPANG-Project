package com.kyupang.mapper;

import java.util.List;
import java.util.Map;

import com.kyupang.model.CategoryNameDTO;
import com.kyupang.model.CategoryVO;
import com.kyupang.model.ProductVO;
import com.kyupang.model.StoreVO;

public interface ProductMapper {
	public ProductVO read(Integer pid);
	int countAllProductIndex();
	int countAllProduct(Map<String, Object> map);
	int countAllProductp(Map<String, Object> map);
	int countAllProducts(Map<String, Object> map);
	int countAllProducts2(Map<String, Object> map);
	int countAllProductb(Map<String, Object> map);
	int countSearchProduct(Map<String, Object> map);
	List<ProductVO> productlistIndex();
	List<ProductVO> productlist(Map<String, Object> map);
	List<ProductVO> productlistp(Map<String, Object> map);
	List<ProductVO> productlists(Map<String, Object> map);
	List<ProductVO> productlists2(Map<String, Object> map);
	List<ProductVO> productlistb(Map<String, Object> map);
	List<CategoryVO> catelist();
	List<StoreVO> brandlist();
	List<ProductVO> SearchProductList(Map<String, Object> map);
	List<ProductVO> option(Integer pid);
	public CategoryNameDTO cateview(Integer pid);
	public void update(ProductVO vo); // 상품 클릭시 조회수 1 증가

}
