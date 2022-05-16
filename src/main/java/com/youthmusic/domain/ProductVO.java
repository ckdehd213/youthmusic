package com.youthmusic.domain;

import java.util.Date;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class ProductVO {

	private Integer pro_num;		// 시퀀스
	private Integer cg_prt_code;		// 1차카테고리
	private Integer cg_code;		// 2차카테고리
	private String pro_name;
	private int pro_price;
	private int pro_discount;
	private String pro_company;
	private String pro_content;
	private String pro_img;	// 파일이미지는 업로드에서 파일이름을 가져와 처리해야 한다.
	private String pro_uploadpath;  // 22/02/22 추가. 날짜 폴더
	private int pro_stock;
	private String pro_ok_buy;
	private Date pro_loaddate;
	private Date pro_updatedate;
	
	
	// <input type="file" id="upload" name="upload"> ProductInsert.jsp 와 연관
	private MultipartFile upload;
	
}
