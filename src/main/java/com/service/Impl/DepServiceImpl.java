package com.service.Impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.po.Dep;
import com.service.IDepService;
import com.util.DaoServiceUtil;

import jdk.nashorn.internal.ir.annotations.Reference;


@Service("DepBiz")
@Transactional
public class DepServiceImpl implements IDepService {
    @Resource(name="DaoService")
	private DaoServiceUtil daoservice;
	public DaoServiceUtil getDaoservice() {
		return daoservice;
	}
	public void setDaoservice(DaoServiceUtil daoservice) {
		this.daoservice = daoservice;
	}

	@Override
	public List<Dep> findAll() {
		// TODO Auto-generated method stub
		return daoservice.getDepMapper().findAll();
	}

}
