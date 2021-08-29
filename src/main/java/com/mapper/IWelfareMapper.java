package com.mapper;

import java.util.List;

import org.springframework.stereotype.Service;

import com.po.Dep;
import com.po.Welfare;

@Service("WelfareDAO")
public interface IWelfareMapper {
      //查询福利所有
	public List<Welfare> findAll();
}
