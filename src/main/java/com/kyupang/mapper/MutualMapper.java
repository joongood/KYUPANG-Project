package com.kyupang.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.kyupang.model.BannerVO;
import com.kyupang.model.CartTranDTO;
import com.kyupang.model.CategoryNameDTO;
import com.kyupang.model.CategoryVO;
import com.kyupang.model.Criteria;
import com.kyupang.model.MemberVO;
import com.kyupang.model.ProductVO;
import com.kyupang.model.StoreVO;

public interface MutualMapper {
	//Product
    int countAllProducts(@Param("session_id")String session_id, @Param("session_label") String session_label);
    List<ProductVO> findProductsByCriteria(@Param("session_id") String session_id, @Param("session_label") String session_label, @Param("criteria") Criteria criteria);
	public void create(ProductVO vo);
	public ProductVO read(Integer pid);
	public void update(ProductVO vo);
	public void delete(Integer pid);
	public CategoryNameDTO categoryJoin(Integer pid);
	List<CategoryVO>cateMain(); 
	List<CategoryVO>cateMiddle(String cid);
	
	//mutual
	public StoreVO readStore(String session_id); // 한개의 상점 정보 불러오기
	public void updateStore(StoreVO vo); // 가맹점 회원수정
	
	//banner
	int countAllBanners(@Param("session_id")String session_id, @Param("session_label") String session_label);
    List<BannerVO> findBannersByCriteria(@Param("session_id") String session_id, @Param("session_label") String session_label,@Param("criteria") Criteria criteria);
    public void create_b(BannerVO vo);
    public BannerVO readBanner(Integer bid);
    public void updateBanner(BannerVO vo);
    public void delBanner(Integer bid);

	//member
    int countAllMembers(String session_label);
    List<MemberVO> findMembersByCriteria(@Param("session_label") String session_label, @Param("criteria") Criteria criteria);
	public void create_m(MemberVO vo);
	public MemberVO read_m(Integer mid);
	public void update_m(MemberVO vo);
	public void delete_m(Integer mid);
	
	//cal
    int countAllCal(String session_label);
    List<CartTranDTO> findCalByCriteria(@Param("session_label") String session_label, @Param("criteria") Criteria criteria);
    public void updateCal(Integer ctid);
}
