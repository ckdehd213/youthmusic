package com.youthmusic.service;

import java.util.List;

import com.youthmusic.domain.CategoryVO;
import com.youthmusic.domain.Criteria;
import com.youthmusic.domain.ProductVO;

public interface AdminProductService {

	public int product_insert(ProductVO vo);
	
	public List<CategoryVO> mainCategory();
	
	public List<CategoryVO> subCategory(Integer cg_code);
	
	public List<ProductVO> getListWithPaging(Criteria cri);
	
	public int getTotalCount(Criteria cri);
	
	public ProductVO product_edit(Integer pro_num);
	
	public int product_editOk(ProductVO vo);
	
	public int product_delete(Integer pro_num);
}
