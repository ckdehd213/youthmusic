package com.youthmusic.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.youthmusic.domain.CategoryVO;
import com.youthmusic.domain.Criteria;
import com.youthmusic.domain.ProductVO;

public interface UserProductMapper {

	public List<CategoryVO> mainCategory();
	
	public List<CategoryVO> subCategory(Integer cg_code);
	
	public List<ProductVO> getListWithPaging(@Param("cg_code")Integer cg_code, @Param("cri") Criteria cri);
	
	public int getTotalCount(Integer cg_code);
	
	public ProductVO productDetail(Integer pro_num);
}
