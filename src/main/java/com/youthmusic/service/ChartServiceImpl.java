package com.youthmusic.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.youthmusic.domain.ChartVO;
import com.youthmusic.mapper.ChartMapper;

@Service
public class ChartServiceImpl implements ChartService {

	@Inject
	private ChartMapper chartMapper;
	
	@Override
	public List<ChartVO> primaryChart() {
		// TODO Auto-generated method stub
		return chartMapper.primaryChart();
	}

	@Override
	public List<ChartVO> secondaryChart() {
		// TODO Auto-generated method stub
		return chartMapper.secondaryChart();
	}

	@Override
	public List<ChartVO> salesByYearChart() {
		// TODO Auto-generated method stub
		return chartMapper.salesByYearChart();
	}

	@Override
	public List<ChartVO> primaryChartByMonth(String ord_date) {
		// TODO Auto-generated method stub
		return chartMapper.primaryChartByMonth(ord_date);
	}

}
