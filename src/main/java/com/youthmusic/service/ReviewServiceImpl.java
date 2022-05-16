package com.youthmusic.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.youthmusic.domain.Criteria;
import com.youthmusic.domain.ReviewVO;
import com.youthmusic.mapper.ReviewMapper;

@Service
public class ReviewServiceImpl implements ReviewService {
	
	@Inject
	private ReviewMapper mapper;

	@Override
	public List<ReviewVO> reviewListWithPaging(Criteria cri, Integer pro_num) {
		// TODO Auto-generated method stub
		return mapper.reviewListWithPaging(cri, pro_num);
	}

	@Override
	public int getTotalCount(Integer pro_num) {
		// TODO Auto-generated method stub
		return mapper.getTotalCount(pro_num);
	}

	@Override
	public void reviewInsert(ReviewVO vo) {
		// TODO Auto-generated method stub
		mapper.reviewInsert(vo);
	}

	@Override
	public void reviewEdit(ReviewVO vo) {
		// TODO Auto-generated method stub
		mapper.reviewEdit(vo);
	}

	@Override
	public void reviewDel(Integer rev_num) {
		// TODO Auto-generated method stub
		mapper.reviewDel(rev_num);
	}

}
