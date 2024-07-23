package com.kyupang.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.kyupang.model.BannerVO;
import com.kyupang.model.CartTranDTO;
import com.kyupang.model.CategoryNameDTO;
import com.kyupang.model.CategoryVO;
import com.kyupang.model.CommentsVO;
import com.kyupang.model.CoupontempVO;
import com.kyupang.model.Criteria;
import com.kyupang.model.MemberVO;
import com.kyupang.model.ProductVO;
import com.kyupang.model.StoreVO;

public interface AdminMapper {
	
	//Member
    int countAllMembers();
    List<MemberVO> findMembersByCriteria(Criteria criteria);
	public void create(MemberVO vo);
	public MemberVO read(Integer mid);
	public void update(MemberVO vo);
	public void delete(Integer mid);
	
	//Store
	int countAllStores();
	List<StoreVO> findStoresByCriteria(Criteria criteria);
	public void create_s(StoreVO vo);
	public StoreVO read_s(Integer sid);
	public void update_s(StoreVO vo);
	public void delete_s(Integer sid);
	
	//Category
	int countAllCategories();
	List<CategoryVO> findCategoriesByCriteria(Criteria criteria);
	public void create_c(CategoryVO vo);
	public CategoryVO read_c(String cid);
	public void update_c(CategoryVO vo);
	public void delete_c(String cid);
	
	//Banner
	int countAllBanners();
    List<BannerVO> findBannersByCriteria(Criteria criteria);
    public void delBanner(Integer bid);
    public void okBanner(Integer bid);
    List<BannerVO> getApprovedBanners();
    public void updateBannerStatus(@Param("bid") Integer bid, @Param("status") String status);
    
	//Product
    int countAllProducts();
    List<ProductVO> findProductsByCriteria(Criteria criteria);
	public ProductVO read_p(Integer pid);
	public void delete_p(Integer pid);
	public CategoryNameDTO categoryJoin(Integer pid);
	List<CategoryVO>cateMain();
	
	//Coupon
	int countAllCoupon();
    List<CoupontempVO> findCouponByCriteria(Criteria criteria);
    public void insertCoupon(CoupontempVO vo);
    
    //Commnet
    int countAllComments();
    List<CommentsVO> findCommentsByCriteria(Criteria criteria);
    public void deleteComments(Integer cmid);
    
    //Tran
    int countAllTran();
    List<CartTranDTO> findTranByCriteria(Criteria criteria);
    public void updateTranStatus(Integer tranid);
    
	//cal
    int countAllCal();
    List<CartTranDTO> findCalByCriteria(Criteria criteria);
    public void updateCal(Integer ctid);
}
