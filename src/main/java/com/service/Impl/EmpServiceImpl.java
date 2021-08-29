package com.service.Impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.po.Emp;
import com.po.EmpWelfare;
import com.po.PageBean;
import com.po.Salary;
import com.po.Welfare;
import com.service.IEmpService;
import com.util.BizServiceUtil;
import com.util.DaoServiceUtil;
@Service("EmpBiz")
@Transactional
public class EmpServiceImpl implements IEmpService {
	@Resource(name="DaoService")
	private DaoServiceUtil daoservice;
	public DaoServiceUtil getDaoservice() {
		return daoservice;
	}
	public void setDaoservice(DaoServiceUtil daoservice) {
		this.daoservice = daoservice;
	}

	@Override
	public boolean save(Emp emp) {
		//1.����Ա�����
		int code=daoservice.getEmpMapper().save(emp);
		//2.�����Ա��н�ʺ�Ա�����������
		if(code>0){
			//����н�ʺ�Ա�������������ȡ��Ա���ı��
			Integer eid=daoservice.getEmpMapper().findMaxEid();
			/******н�ʱ���begin******/
			Salary sa=new Salary(eid,emp.getEmoney());
			daoservice.getSalaryMapper().save(sa);
			/******н�ʱ���end******/
			/******Ա����������begin******/
			  //��ȡԱ�������ı������
			String[] wids=emp.getWids();
			if(wids!=null&&wids.length>0){
				for(int i=0;i<wids.length;i++){
					EmpWelfare ewf=new EmpWelfare(eid,Integer.parseInt(wids[i]));
					daoservice.getEmpwelfareMapper().save(ewf);
				}
			}
			/******Ա����������end******/
			return true;
		}
		return false;
	}
	@Override
	public List<Emp> findPageAll(PageBean pb) {
		// TODO Auto-generated method stub
		return daoservice.getEmpMapper().findPageAll(pb.getPage(), pb.getRows());
	}
	@Override
	public Integer findMaxRows() {
		// TODO Auto-generated method stub
		return daoservice.getEmpMapper().findMaxRows();
	}
	@Override
	public boolean delById(Integer eid) {
		//Ҫɾ������ɾ�ӱ�
		   //н��
		daoservice.getSalaryMapper().delByEid(eid);
		  //Ա������
		daoservice.getEmpwelfareMapper().delByEid(eid);
		//ɾ��Ա��
		int code=daoservice.getEmpMapper().delById(eid);
		if(code>0){
			return true;
		}
		return false;
	}
	@Override
	public Emp findById(Integer eid) {
		//��ȡԱ������
		Emp oldemp=daoservice.getEmpMapper().findById(eid);
		/**��ȡн��**/
		Salary sa=daoservice.getSalaryMapper().findByEid(eid);
		if(sa!=null&&sa.getEmoney()!=null){
			oldemp.setEmoney(sa.getEmoney());
		}
		/***********/
		/**��ȡ����**/
		List<Welfare> lswf=daoservice.getEmpwelfareMapper().findByEid(eid);
		System.out.println("aaa:"+lswf.size());
		//������Id
		String[] wids=new String[lswf.size()];
		for(int i=0;i<wids.length;i++){
			Welfare wf=lswf.get(i);
			wids[i]=wf.getWid().toString();
		}
		oldemp.setWids(wids);
		oldemp.setLswf(lswf);
		return oldemp;
	}
	@Override
	public boolean update(Emp emp) {
		//�޸�Ա��
		int code=daoservice.getEmpMapper().update(emp);
		if(code>0){
			/***����н��***/
			  //��ȡԭ����н��
			Salary oldsa=daoservice.getSalaryMapper().findByEid(emp.getEid());
			if(oldsa!=null&&oldsa.getEmoney()!=null){
				//�޸�
				oldsa.setEmoney(emp.getEmoney());
				daoservice.getSalaryMapper().updateByEid(oldsa);
			}else{
				/******н�ʱ���begin******/
				Salary sa=new Salary(emp.getEid(),emp.getEmoney());
				daoservice.getSalaryMapper().save(sa);
			}
			/*******���¸���*******/
			 //��ȡԭ���ĸ���
			List<Welfare> lswf=daoservice.getEmpwelfareMapper().findByEid(emp.getEid());
			if(lswf!=null&&lswf.size()>0){
				//ɾ��ԭ�еĸ���
				daoservice.getEmpwelfareMapper().delByEid(emp.getEid());
			}
			/******Ա����������begin******/
			  //��ȡԱ�������ı������
			String[] wids=emp.getWids();
			if(wids!=null&&wids.length>0){
				for(int i=0;i<wids.length;i++){
					EmpWelfare ewf=new EmpWelfare(emp.getEid(),Integer.parseInt(wids[i]));
					daoservice.getEmpwelfareMapper().save(ewf);
				}
			}
			/******Ա����������end******/
			return true;
		}
		return false;
	}

}
