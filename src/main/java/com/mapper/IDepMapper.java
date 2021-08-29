package com.mapper;

import java.util.List;

import org.springframework.stereotype.Service;

import com.po.Dep;

@Service("DepDAO")
public interface IDepMapper {
 //查询部门所有
	public List<Dep> findAll();
}
