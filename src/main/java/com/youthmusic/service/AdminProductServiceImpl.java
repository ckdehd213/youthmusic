package com.youthmusic.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.youthmusic.domain.CategoryVO;
import com.youthmusic.domain.Criteria;
import com.youthmusic.domain.ProductVO;
import com.youthmusic.mapper.AdminProductMapper;

import lombok.Setter;

@Service
public class AdminProductServiceImpl implements AdminProductService {

	@Setter(onMethod_ = @Autowired)
	private AdminProductMapper mapper;
	
	@Override
	public int product_insert(ProductVO vo) {
		// TODO Auto-generated method stub
		return mapper.product_insert(vo);
	}

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
	public List<ProductVO> getListWithPaging(Criteria cri) {
		// TODO Auto-generated method stub
		return mapper.getListWithPaging(cri);
	}

	@Override
	public int getTotalCount(Criteria cri) {
		// TODO Auto-generated method stub
		return mapper.getTotalCount(cri);
	}

	@Override
	public ProductVO product_edit(Integer pro_num) {
		// TODO Auto-generated method stub
		return mapper.product_edit(pro_num);
	}

	@Override
	public int product_editOk(ProductVO vo) {
		// TODO Auto-generated method stub
		return mapper.product_editOk(vo);
	}

	@Override
	public int product_delete(Integer pro_num) {
		// TODO Auto-generated method stub
		return mapper.product_delete(pro_num);
	}

}
