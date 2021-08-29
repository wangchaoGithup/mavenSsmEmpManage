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
	$('#win').window('close');  // close a window  
	//获取后台传递的页面初始化数据
	$.getJSON("doinit_Emp.do",function(map){
		var lswf=map.lswf;
		var lsdep=map.lsdep;
		//处理复选框
		for(var i=0;i<lswf.length;i++){
			var wf=lswf[i];
			$("#wf").append("<input type='checkbox' id='wids' name='wids' value='"+wf.wid+"'/>"+wf.wname)
		}
		//处理下拉列表
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
/********员工分页列表begin***********/
$(function(){
	$('#ffemp').hide();
	 //$("#btupdate").css("visibility","hidden")
	$('#dg').datagrid({    
	    url:'findPageAll_Emp.do',
	     pagination:true,
	    pageNumber:1,
	    pageSize:3,
	    pageList:[5,10,],
	    striped:true, 
	    columns:[[    
	         {field:'depid',title:'编号',width:100,align:'center'},
	        /*{field:'ename',title:'姓名',width:100,align:'center'},
	        {field:'sex',title:'性别',width:100,align:'center'},
	        {field:'address',title:'地址',width:100,align:'center'},
	        {field:'sdate',title:'生日',width:100,align:'center'},
	        {field:'photo',title:'照片',width:100,align:'center',
	        	formatter: function(value,row,index){
	        		return '<img src=uppic/'+row.photo+'  width=40 height=50>'
	        	}	
	        }, */
	        
	        
	        {field:'depname',title:'部门名称',width:100,align:'center'},
	        {field:'depname',title:'详细信息',width:100,align:'center'},
	        {field:'opt',title:'操作',width:160,align:'center',
	        	formatter: function(value,row,index){
	        		var bt3="<input type='button' onclick=saveById("+row.eid+") value='新增'/>"
	        		var bt4="<input type='button' onclick=findById("+row.eid+") value='修改'/>"
	        		return bt3+bt4;
	        	}		
	        
	         }
	        
	        
	    ]]    
	});  

}); 
 
 
/********员工分页列表end***********/
/*********保存和修改begin**************/
$(function(){
	//添加保存
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
					$('#dg').datagrid('reload');    // 重新载入当前页面数据  
				}else{
					$.messager.alert('提示','保存失败!!!');
				}
				$.messager.progress('close');	// 如果提交成功则隐藏进度条
			}
		});


	});
	//修改
	$("#btupdate").click(function(){
		$('#ffemp').hide();
		$.messager.progress();	// 显示进度条
		$('#ffemp').form('submit', {
			url:'update_Emp.do',
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
					$.messager.alert('提示','修改成功!!!');
					$('#dg').datagrid('reload');    // 重新载入当前页面数据  
				}else{
					$.messager.alert('提示','修改失败!!!');
				}
				$.messager.progress('close');	// 如果提交成功则隐藏进度条
			}
		});


	});
});
/*********保存和修改end**************/
/**********删除和查询单个以及详情begin***************/
 //删除
 function delById(eid){
	 $.messager.confirm('确认','您确认想要删除记录吗？',function(r){    
		    if (r){    
		    	$.get("delById_Emp.do?eid="+eid,function(code){
		    		if(code=='1'){
						$.messager.alert('提示','删除成功!!!');
						$('#dg').datagrid('reload');    // 重新载入当前页面数据  
					}else{
						$.messager.alert('提示','删除失败!!!');
					}

		    	});  
		    }    
		});  

} 
//查看详情
 function editById(eid){
	 $.getJSON("findDatail_Emp.do?eid="+eid,function(emp){
		 //赋值
		 $("#enametxt").html(emp.ename);
		 $("#sextxt").html(emp.sex);
		 $("#addresstxt").html(emp.address);
		 $("#sdatetxt").html(emp.sdate);
		 $("#phototxt").html(emp.photo);
		 $("#deptxt").html(emp.depname);
		 $("#emoneytxt").html(emp.emoney);
		 $("#eidtxt").html(emp.eid);
		 //获取福利
		  var lswf=emp.lswf;
		 var wnames=[];//福利名称数组
		 for(var i=0;i<lswf.length;i++){
			 var wf=lswf[i];
			 wnames.push(wf.wname);
		 }
		 var strwname=wnames.join(',');
		 $("#wftxt").html(strwname); 
		 $("#domyphoto").attr('src','uppic/'+emp.photo); 
		 $('#win').window('open');  // open a window 
	 });	
	}
//编辑
 function findById(eid){
	 $.getJSON("findById_Emp.do?eid="+eid,function(oldemp){
			//先删除福利复选矿中的所有选中
			$(":checkbox[name='wids']").each(function(){
				$(this).prop("checked",false);
			});
			//将返回值写入指定表单
			$('#ffemp').form('load',{
				'eid':oldemp.eid,
				'ename':oldemp.ename,
				'sex':oldemp.sex,
				'address':oldemp.address,
				'sdate':oldemp.sdate,
				'depid':oldemp.depid,
				'emoney':oldemp.emoney,
			});
            //处理图片
             $("#btsave").css("visibility","hidden")
            $("#myphoto").attr('src','uppic/'+oldemp.photo)
             $("#btupdate").css("visibility","show")
             $('#ffemp').show();
            //处理复选框
            var wids=oldemp.wids;
            $(":checkbox[name='wids']").each(function(){
				for(var i=0;i<wids.length;i++){
					if($(this).val()==wids[i]){
						$(this).prop("checked",true);	
					}
				}
			});

		});
	}
	//修改
	/* function updateById(eid){
	 $.getJSON("findById_Emp.do?eid="+eid,function(oldemp){
			//先删除福利复选矿中的所有选中
			$(":checkbox[name='wids']").each(function(){
				$(this).prop("checked",false);
			});
			//将返回值写入指定表单
			$('#ffemp').form('load',{
				'eid':oldemp.eid,
				'ename':oldemp.ename,
				'sex':oldemp.sex,
				'address':oldemp.address,
				'sdate':oldemp.sdate,
				'depid':oldemp.depid,
				'emoney':oldemp.emoney,
			});
            //处理图片
            $("#myphoto").attr('src','uppic/'+oldemp.photo)
             $("#btupdate").css("visibility","show")
             $('#ffemp').show();
            //处理复选框
            var wids=oldemp.wids;
            $(":checkbox[name='wids']").each(function(){
				for(var i=0;i<wids.length;i++){
					if($(this).val()==wids[i]){
						$(this).prop("checked",true);	
					}
				}
			});

		});
	} */
 /**********删除和查询单个以及详情end***************/
</script>
</head>
<body>
</p>
<p align="center">部门管理</p>
<hr />
<table id="dg"></table>  
<hr />
<form action="" name="ffemp" id="ffemp" method="post" enctype="multipart/form-data">
  <table border="1px" width="200px" >
    <tr bgcolor=#F5DEB3 align="center">
     <td colspan="3">部门管理</td>
    </tr>
     <tr>
     
     <tr>
     <td >部门</td>
     <td>
     <input type="text" id="cc" name="depid">
     </td>
    </tr>
    
    <tr bgcolor="#F5DEB3" align="center">
     <td colspan="3">
     <input type="hidden" id="eid" name="eid">
     <input type="button" id="btsave" name="btsave" value="保存">
     <input type="button" id="btupdate" name="btupdate" value="修改">
     <input type="reset" id="btrest" name="btrest" value="取消">
     </td>
    </tr>
  </table>
</form>
<!--详情窗口  -->
<div id="win" class="easyui-window" title="员工详情" style="width:600px;height:400px"   
        data-options="iconCls:'icon-save',modal:true">   
       <table border="1px" width="550px" align="center">
     <tr>
     <td width="100px">姓名</td>
     <td width="200px">
     <span id="enametxt"></span>
     </td>
     <td rowspan="7">
      <img id="domyphoto" alt="图片不存在" src="uppic/default.jpg" width="240px" height="260px">
     </td>
    </tr>
     <tr>
     <td>性别</td>
     <td>
      <span id="sextxt"></span>
     </td>
    </tr>
     <tr>
     <td>地址</td>
     <td>
     <span id="addresstxt"></span>
     </td>
     
    </tr>
     <tr>
     <td>生日</td>
     <td>
     <span id="sdatetxt"></span>
     </td>
     
    </tr>
     <tr>
     <td>照片</td>
     <td>
     <span id="phototxt"></span>
     </td>
     
    </tr>
     <tr>
     <td>部门</td>
     <td>
     <span id="deptxt"></span>
     </td>
    
    </tr>
     <tr>
     <td>薪资</td>
     <td>
     <span id="emoneytxt"></span>
     </td>
    </tr>
     <tr>
     <td>福利</td>
     <td colspan="2">
     <span id="wftxt"></span>
     </td>
    </tr>
    <tr >
     <td>编号</td>
     <td colspan="2">
     <span id="eidtxt"></span>
     </td>
    </tr>
  </table>
</div>  

</body>
</html>