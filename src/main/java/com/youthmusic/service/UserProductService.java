package com.youthmusic.service;

import java.util.List;

import com.youthmusic.domain.CategoryVO;
import com.youthmusic.domain.Criteria;
import com.youthmusic.domain.ProductVO;

public interface UserProductService {

	public List<CategoryVO> mainCategory();
	
	public List<CategoryVO> subCategory(Integer cg_code);
	
	public List<ProductVO> getListWithPaging(Integer cg_code, Criteria cri);
	
	public int getTotalCount(Integer cg_code);
	
	public ProductVO productDetail(Integer pro_num);
}
