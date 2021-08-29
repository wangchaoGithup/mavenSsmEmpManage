package com.service.Impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.mapper.IWelfareMapper;
import com.po.Dep;
import com.po.Welfare;
import com.service.IDepService;
import com.service.IWelfareService;
import com.util.DaoServiceUtil;

import jdk.nashorn.internal.ir.annotations.Reference;


@Service("WelfareBiz")
@Transactional
public class WelfareServiceImpl implements IWelfareService {
    @Resource(name="DaoService")
	private DaoServiceUtil daoservice;
	public DaoServiceUtil getDaoservice() {
		return daoservice;
	}
	public void setDaoservice(DaoServiceUtil daoservice) {
		this.daoservice = daoservice;
	}
	@Override
	public List<Welfare> findAll() {
		// TODO Auto-generated method stub
		return daoservice.getWelfareMapper().findAll();
	}

	

}
