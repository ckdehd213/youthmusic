package com.youthmusic.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.youthmusic.domain.CategoryVO;
import com.youthmusic.domain.Criteria;
import com.youthmusic.domain.ProductVO;
import com.youthmusic.mapper.UserProductMapper;

import lombok.AllArgsConstructor;

@AllArgsConstructor
@Service
public class UserProductServiceImpl implements UserProductService {

	private UserProductMapper mapper;
	
	@Override
	public List<CategoryVO> mainCategory() {
		// TODO Auto-generated method stub
		return mapper.mainCategory();
	}

	@Override
	public List<CategoryVO> subCategory(Integer cg_code) {
		// TODO Auto-generated method stub
		return mapper.subCategory(cg_code);
	}

	@Override
	public List<ProductVO> getListWithPaging(Integer cg_code, Criteria cri) {
		// TODO Auto-generated method stub
		return mapper.getListWithPaging(cg_code, cri);
	}

	@Override
	public int getTotalCount(Integer cg_code) {
		// TODO Auto-generated method stub
		return mapper.getTotalCount(cg_code);
	}

	@Override
	public ProductVO productDetail(Integer pro_num) {
		// TODO Auto-generated method stub
		return mapper.productDetail(pro_num);
	}

}
