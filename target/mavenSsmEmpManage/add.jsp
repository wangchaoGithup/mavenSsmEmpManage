<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>添加页面</title>
<!--easyui支持引入  -->
<link rel="stylesheet" type="text/css" href="easyui/themes/default/easyui.css"/>
<link rel="stylesheet" type="text/css" href="easyui/themes/icon.css"/>
<script type="text/javascript" src="easyui/jquery-1.9.1.js"></script>
<script type="text/javascript" src="easyui/jquery.easyui.min.js"></script>
<script type="text/javascript" src="easyui/locale/easyui-lang-zh_CN.js"></script>
<script type="text/javascript">
/********初始化begin***********/
$(function(){
	//获取后台传递的页面初始化值
	$.getJSON("doinit_Emp.do",function(map){
		var lswf=map.lswf;
		var lsdep=map.lsdep;
		//复选框的处理
		
		for(var i=0;i<lswf.length;i++){
			var wf=lswf[i];
			$("#wf").append("<input type='checkbox' name='wids' value='"+wf.wid+"'/>"+wf.wname)
		}
		//下拉列表的处理
		$('#cc').combobox({    
		    data:lsdep,    
		    valueField:'depid',    
		    textField:'depname',
		    value:4,
		    panelHeight:88
		});  

	});
});
/********初始化end***********/
/*********员工分页列表begin**************/
/* $(function(){
	$('#dg').datagrid({    
	    url:'findPageAll_Emp.do', 
	    pagination:true,
	    columns:[[    
	        {field:'eid',title:'编号',width:100,align:'center'}, 
	        {field:'ename',title:'姓名',width:100,align:'center'},
	        {field:'sex',title:'性别',width:100,align:'center'},
	        {field:'address',title:'地址',width:100,align:'center'},
	        {field:'sdate',title:'生日',width:100,align:'center'},
	        {field:'photo',title:'照片',width:100,align:'center',
	        	formatter: function(value,row,index){
                      return'<img src=uppic/'+row.photo+'  width=50 hight=50>'
	        	}
	        },
	        {field:'depname',title:'部门名称',width:100,align:'center'},
	        {field:'opt',title:'操作',width:100,align:'center',
	        	formatter: function(value,row,index){
                    var bt1="<input type='button' onclick=delById("+row.eid+") value='删除'/>"
	        		return bt1;
	        }
	        }  
	    ]]    
	});  
}); */
/********员工分页列表end***********/
/*********保存begin**************/
$(function(){
	$("#btsave").click(function(){
		$.messager.progress();	// 显示进度条
		$('#ffemp').form('submit', {
			url:'save_Emp.do',
			onSubmit: function(){
				var isValid = $(this).form('validate');
				if (!isValid){
					$.messager.progress('close');	// 如果表单是无效的则隐藏进度条
				}
				return isValid;	// 返回false终止表单提交
			},
			//回调函数
			success: function(code){
				if(code=='1'){
					$.messager.alert('提示','保存成功!!!');
				}else{
					$.messager.alert('提示','保存失败!!!');
				}
				$.messager.progress('close');	// 如果提交成功则隐藏进度条
			}
		});
	});
});
/*********保存end**************/
 function delById(eid){
	alert(eid);
} 
</script>
</head>
<body>
<p align="center" >员工列表</p>
<hr />
<table id="dg"></table> 
<form action="" name="ffemp" id="ffemp" method="post" enctype="multipart/form-data">
  <table border="1px" width="550px" align="center">
    <tr bgcolor="#66CDAA" align="center">
     <td colspan="3" >员工管理</td>
    </tr>
     <tr>
     <td bgcolor="#E0FFFF">姓名</td>
     <td>
     <input type="text" id="ename" name="ename" class="easyui-validatebox" data-options="required:true">
     </td>
     <td rowspan="7">
      <a href="uppic/default.jpg">
      <img alt="图片不存在" src="uppic/default.jpg" width="252px" height="270px">
      </a>
     </td>
    </tr>
     <tr>
     <td bgcolor="#E0FFFF">性别</td>
     <td>
      <input type="radio" id="sex" name="sex" value="男" checked="checked">男
      <input type="radio" id="sex" name="sex" value="女" >女
     </td>
    </tr>
     <tr>
     <td bgcolor="#E0FFFF">地址</td>
     <td>
     <input type="text" id="address" name="address">
     </td>
     
    </tr>
     <tr>
     <td bgcolor="#E0FFFF">生日</td>
     <td>
     <input type="date" id="sdate" name="sdate">
     </td>
     
    </tr>
     <tr>
     <td bgcolor="#E0FFFF">照片</td>
     <td>
     <input type="file" id="pic" name="pic">
     </td>
     
    </tr>
     <tr>
     <td bgcolor="#E0FFFF">部门</td>
     <td>
     <input type="text" id="cc" name="depid">
     </td>
    
    </tr>
     <tr>
     <td bgcolor="#E0FFFF">薪资</td>
     <td>
     <input type="text" id="emoney" name="emoney" value="2000">
     </td>
    </tr>
     <tr>
     <td bgcolor="#E0FFFF">福利</td>
     <td colspan="2">
     <span id="wf"></span>
     </td>
    </tr>
    <tr bgcolor="#66CDAA" align="center">
     <td colspan="3">
     <input type="button" id="btsave" name="btsave" value="保存">
     <input type="reset" id="btrest" name="btrest" value="取消">
     </td>
    </tr>
  </table>
</form>
<p align="center">
<a href="emp.jsp">查看列表</a>
</p>
</body>
</html>