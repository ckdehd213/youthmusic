package com.youthmusic.controller;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.youthmusic.domain.ChartVO;
import com.youthmusic.service.ChartService;

import lombok.extern.log4j.Log4j;

@Log4j
@RequestMapping("/admin/chart/*")
@Controller
public class ChartManage {

	@Inject
	private ChartService service;
	
	//(전체) 통계차트 페이지
	@GetMapping("/overall")
	public ModelAndView coerallChart() throws Exception{
		
		// 통계차트 데이터
		/*2차원 배열구조
		  ['Task', 'Hours per Day'],
          ['Work',     11],
          ['Eat',      2],
          ['Commute',  2],  
          ['Watch TV', 2],
          ['Sleep',    7]
		 */
		
		ModelAndView mv = new ModelAndView();
		
		// 1차 카테고리 차트작업
		List<ChartVO> primary_list = service.primaryChart();
		
		String primaryData = "[['1차 카테고리', '매출'],";
		
		int i = 0;
		for(ChartVO vo : primary_list) {
			primaryData += "['" + vo.getCg_name() + "'," + vo.getSales() + "]";
			i++;
			if(i < primary_list.size()) primaryData += ",";
		}
		
		primaryData += "]";
		
		// 2차 카테고리 차트작업
		List<ChartVO> second_list = service.secondaryChart();
		
		String secondData =  "[['2차 카테고리', '매출'],";
		
		int j = 0;
		for(ChartVO vo : second_list) {
			secondData += "['" + vo.getCg_name() + "'," + vo.getSales() + "]";
			j++;
			if(j < second_list.size()) secondData += ",";
		}
		
		secondData += "]";
		
		// 년도별 매출 차트작업
		List<ChartVO> salesByYearList = service.salesByYearChart();
		
		String salesYearData = "[['연도', '총매출'],";
		
		int k = 0;
		for(ChartVO vo : salesByYearList) {
			salesYearData += "['" + vo.getYear() + "'," + vo.getTotalprice() + "]";
			k++;
			if(k < salesByYearList.size()) salesYearData += ",";
		}
		
		salesYearData += "]";
		
		mv.addObject("prime_chart", primaryData);
		mv.addObject("second_chart", secondData);
		mv.addObject("salesYear_chart", salesYearData);
		
		mv.setViewName("/admin/chart/overall");
		
		return mv;
	}
}
