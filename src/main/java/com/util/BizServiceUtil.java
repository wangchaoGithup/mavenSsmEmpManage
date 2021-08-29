package com.util;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.mapper.IDepMapper;
import com.mapper.IWelfareMapper;
import com.service.IDepService;
import com.service.IEmpService;
import com.service.IWelfareService;

@Service("BizService")
public class BizServiceUtil {
  @Resource(name="DepBiz")
  private  IDepService depService;
  @Resource(name="WelfareBiz")
  private  IWelfareService welfareService;
  @Resource(name="EmpBiz")
  private  IEmpService empService;
public IDepService getDepService() {
	return depService;
}
public void setDepService(IDepService depService) {
	this.depService = depService;
}
public IWelfareService getWelfareService() {
	return welfareService;
}
public void setWelfareService(IWelfareService welfareService) {
	this.welfareService = welfareService;
}
public IEmpService getEmpService() {
	return empService;
}
public void setEmpService(IEmpService empService) {
	this.empService = empService;
}
  
   
}
