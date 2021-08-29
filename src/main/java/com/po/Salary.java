package com.po;

import java.io.Serializable;

public class Salary implements Serializable {//薪资表
	private Integer sid;//薪资编号
	private Integer eid;//薪资对应的员工编号
	private Float emoney;//薪资
	public Salary() {
		super();
		// TODO Auto-generated constructor stub
	}
	/**添加薪资专用**/
	public Salary(Integer eid, Float emoney) {
		super();
		this.eid = eid;
		this.emoney = emoney;
	}

	public Salary(Integer sid, Integer eid, Float emoney) {
		super();
		this.sid = sid;
		this.eid = eid;
		this.emoney = emoney;
	}
	public Integer getSid() {
		return sid;
	}
	public void setSid(Integer sid) {
		this.sid = sid;
	}
	public Integer getEid() {
		return eid;
	}
	public void setEid(Integer eid) {
		this.eid = eid;
	}
	public Float getEmoney() {
		return emoney;
	}
	public void setEmoney(Float emoney) {
		this.emoney = emoney;
	}
	@Override
	public String toString() {
		return "Salary [sid=" + sid + ", eid=" + eid + ", emoney=" + emoney + "]";
	}
	

}
