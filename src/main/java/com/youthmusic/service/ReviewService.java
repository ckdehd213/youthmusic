package com.youthmusic.service;

import java.util.List;

import com.youthmusic.domain.Criteria;
import com.youthmusic.domain.ReviewVO;

public interface ReviewService {

public List<ReviewVO> reviewListWithPaging(Criteria cri, Integer pro_num);
	
	public int getTotalCount(Integer pro_num);
	
	public void reviewInsert(ReviewVO vo);
	
	public void reviewEdit(ReviewVO vo);
	
	public void reviewDel(Integer rev_num);
}
