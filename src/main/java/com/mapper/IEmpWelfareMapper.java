package com.mapper;
import java.util.List;
import org.springframework.stereotype.Service;
import com.po.Emp;
import com.po.EmpWelfare;
import com.po.Welfare;

@Service("EmpWelfareDAO")
public interface IEmpWelfareMapper {
   //员工福利添加
	public int save(EmpWelfare empWelfare);
	//通过员工编号删除该员工福利关系
	public int delByEid(Integer eid);
	//通过员工编号查询该员工福利关系
	public List<Welfare>  findByEid(Integer eid);
}
