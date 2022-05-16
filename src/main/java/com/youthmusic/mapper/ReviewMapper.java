package com.youthmusic.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.youthmusic.domain.Criteria;
import com.youthmusic.domain.ReviewVO;

public interface ReviewMapper {

	public List<ReviewVO> reviewListWithPaging(@Param("cri") Criteria cri, @Param("pro_num") Integer pro_num);
	
	public int getTotalCount(Integer pro_num);
	
	public void reviewInsert(ReviewVO vo);
	
	public void reviewEdit(ReviewVO vo);
	
	public void reviewDel(Integer rev_num);
	
}
