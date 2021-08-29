package com.mapper;
import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Service;
import com.po.Emp;

@Service("EmpDAO")
public interface IEmpMapper {
   //Ա�����
	public int save(Emp emp);
   //��ȡid���ı��
	public Integer findMaxEid();
   //��ҳ��ѯ
	public List<Emp> findPageAll(@Param(value = "page") Integer page, @Param(value = "rows") Integer rows);
   //�ܼ�¼��
	public Integer findMaxRows();
   //ɾ��
	public int delById(Integer eid);
	//��ѯ����
	public Emp findById(Integer eid);
	//�޸�
	public int update(Emp emp);
}
