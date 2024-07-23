package com.kyupang.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.kyupang.model.CouponVO;
import com.kyupang.model.CoupontempVO;
import com.kyupang.model.Criteria;

public interface CouponMapper {
	
	//Coupontemp
	int countAllCoupontemp();
	List<CoupontempVO> findCoupontempByCriteria(Criteria criteria);
	public void downloadCoupon(CouponVO vo);
	boolean checkCouponDownloadStatus(@Param("description") String description, @Param("memail") String memail);


}
