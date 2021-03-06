<%@ page language="java" contentType="text/html; charset=gb2312"
    pageEncoding="gb2312"%>
<!DOCTYPE HTML>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
	<title>组织机构设置</title>
	
<link href="css/tq.css" rel="stylesheet" type="text/css">
<link href="css/iconbuttons.css" rel="stylesheet" type="text/css">
	
	<script type="text/javascript" src="js/tq.js"></script>
	<script type="text/javascript" src="js/tq.hash.js"></script>
	<script type="text/javascript" src="js/tq.newtree.js"></script>
	<script type="text/javascript" src="js/tq.window.js"></script>
	<script language="javascript" src="js/tq.scrollbar.js"></script>
	
	
	<STYLE type="text/css">
    	html,body{overflow:hidden;margin:0px;padding:0px;width:100%;}
    	#sysmenu_bar {position:absolute;top:2px;width:10px;left:205px;border-left:0px solid #B5B5B5;z-index:999998;}
    	#sysmenu_bar .Scrollbar-Track{position:absolute;left:0;top:0px;width:10px;cursor:pointer;_cursor:hand}
    	#sysmenu_bar .Scrollbar-Track:hover{background:#f0f0f0}
    	#sysmenu_bar .Scrollbar-Handle{position:absolute;width:10px;height:50px;background:#999;border-radius:7px;-webkit-border-radius:7px;-moz-border-radius: 7px;cursor:pointer;_cursor:hand;}
    	#sysmenu_bar .Scrollbar-Handle:hover{background:#666}
    	div.hideleft{ background:#fff url(images/showhide.png) 0 0;border-radius:7px;-webkit-border-radius:7px;-moz-border-radius: 7px;}
    	div.showleft{ background:#fff url(images/showhide.png) -12px 0;border-radius:7px;-webkit-border-radius:7px;-moz-border-radius: 7px;}
	</STYLE>
</head>

<body>
<div id = "constructor" style="margin:0px;padding:0px;overflow:hidden;width:100%;height:100%;position:relative;float:left">
	<div id="top" style="width: 98%; height: 100px; position: relative; float: left;margin-left:10px; border-bottom: 0px solid #ccc;"></div>
	<div id="left" style="overflow:hidden;overflow-x:auto; margin:0px;padding:0px; position: absolute; top:40px;left:0;z-index:1;border-top: 1px solid #ccc; border-right: 1px solid #ccc;">
		<div id = "sysmenu"  style="overflow:hidden;  position:absolute ;">
		</div>
	</div>
	<DIV id="sysmenu_bar">
		<DIV id="sysmenu_track" class="Scrollbar-Track" title="点击移到此处">
			<DIV id="sysmenu_bar_icon" class="Scrollbar-Handle" title="按住上下拖动">
				&nbsp;
			</DIV>
		</DIV>
	</DIV>
		
	<div id="right" style="position:absolute;padding:0px;margin:0px;top:40px;right:0px;overflow:hidden;border-top: 1px solid #ccc">
		<div id="righttop" style="width: 100%; margin:0px;padding:0px;height: 230px; position: relative; float: left"></div>
		<div id="rightbot" style="width: 100%; margin:0px;padding:0px;border-top: 0px solid #ccc; position: relative; float: left">
			<iframe id="framePage" name="framePage" style="width: 100%;" frameborder="0" scrolling="auto" style="margin:0px;padding:0px;"></iframe>
		</div>
	</div>
</div>
<div id = "scrollMask" style="position:absolute;left:0px;top:0px;background:#fff;filter:alpha(opacity=0);opacity:0;display:none"></div>
<div id = "hideShow" style="position:absolute;left:0px;top:0px;background:none;width:12px;"><div style="position:relative;width:12px;float:left;height:82px;cursor:pointer;display:none;color:#fff;font-weight:700" title="显示/隐藏左栏"></div></div>


<script type="text/javascript">
	var groupid=${groupid};
	//框架
	var t_h = 40;
	var l_w = 215;
	var r_t_h = 0;//240;
	
	var Constructor = T("#constructor");
	var topO = T("#top");
	var leftO = T("#left");
	var menuContent = T("#sysmenu");	
	var menuTrack = T("#sysmenu_track");
	var rightO = T("#right");
	var rightTopO = T("#righttop");
	var rightBotO = T("#rightbot");
	var frameO = T("#framePage")
	
	topO.style.height = t_h  + "px";
	leftO.style.width = l_w  + "px";
	menuContent.style.width = l_w  + "px";
	leftO.style.paddingLeft = 0 + "px";
	
	leftO.style.paddingTop = 5 + "px";
	leftO.style.background = "#F9F9F9";
	leftO.style.height = T.gwh() - t_h - 6 + "px";
	menuTrack.style.height = T.gwh() - t_h - 6 + "px";
	rightO.style.width = T.gww() - l_w - 1  + "px";
	rightTopO.style.height = r_t_h  + "px";
	frameO.style.height = T.gwh() - t_h - r_t_h + "px";
	T("#scrollMask").style.height = T.gwh() + "px";
	T("#scrollMask").style.width = T.gww() + "px";
	
	var showO = T("#hideShow");
	showO.style.left = l_w + "px";
	showO.style.height = T.gwh() + "px";
	showO.onmouseover = function(e){
		this.firstChild.style.marginTop = mousePos(e).y - 50 + "px";
		this.firstChild.style.display = "block";
		if(leftO.style.width == "0px"){
			this.firstChild.className = "showleft";
			this.firstChild.title = "展开左栏";
		}else{
			this.firstChild.className = "hideleft";
			this.firstChild.title = "隐藏左栏";
		}
	};
	showO.onmouseout = function(){
		this.firstChild.style.display = "none";
	};
	showO.firstChild.onclick = function(){
		if(leftO.style.width == "0px"){
			l_w = 215;
			leftO.style.width = l_w  + "px";
			T("#sysmenu_bar").style.zIndex = "999";
			rightO.style.width = T.gww() - l_w - 1  + "px";
			this.parentNode.style.left = l_w + "px";
		}else{
			l_w = 0;
			leftO.style.width = l_w  + "px";
			T("#sysmenu_bar").style.zIndex = "-999";
			rightO.style.width = T.gww() - l_w - 1  + "px";
			this.parentNode.style.left = "0px";
		}
	};
	T.bind(window,"resize",function(){
		topO.style.height = t_h  + "px";
		leftO.style.width = l_w  + "px";
		leftO.style.height = T.gwh() - t_h - 6 + "px";
		menuTrack.style.height = T.gwh() - t_h - 6 + "px";
		rightO.style.width = T.gww() - l_w - 1  + "px";
		rightTopO.style.height = r_t_h  + "px";
		frameO.style.height = T.gwh() - t_h - r_t_h + "px";
		T("#scrollMask").style.height = T.gwh() + "px";
		T("#scrollMask").style.width = T.gww() + "px";
		scroller.reset();
		scrollbar.reset();
	})
	
    function mousePos(e){
        var x,y;
        var e = e||window.event;
        return {
            x:e.clientX+document.body.scrollLeft+document.documentElement.scrollLeft,
            y:e.clientY+document.body.scrollTop+document.documentElement.scrollTop
        };
    };
</script>

<script type="text/javascript">
	var _localData = {
			"root_sys":{"id":"sys","name":"组织机构设置",icon:"home"}
			,"sys_1":{"id":1, "name":"员工管理", fn:function(){GotoUrl('groupmember.do?groupid='+groupid)}}
		};
		
		sysMenuTree = new tqTree({
		treeId:"sysMenuTree",
		treeH:"auto",
		dataType:0,
		localData:_localData,
		treeObj:T("#sysmenu"),
		focusExec:true,
		nodeFnArgs:"id",
		nodeClick:function(){
			var args = arguments;
			switch(args[0]){
				case 920 :
				break;
			}
		},
		expandFun:function(){
			try{
				scroller.reset();
				scrollbar.reset();
			}catch(e){}
		},
		loadfun:function(v){
			var initID = 1;
			sysMenuTree.focusNode(initID);//定位到节点
			sysMenuTree.expandLevel(2);
		}
	});
	sysMenuTree.C();
</script>
</body>
<script>
var tqpagetip = function(c){
	T.maskTip(1,c);
}

var tip = {
	close: function(){T.maskTip(0)}
};

function GotoUrl(url,opentip){
	if(opentip=='1'){
		try{tqpagetip('正在打开页面,请稍后...');}catch(e){};
	}
	document.getElementById("framePage").setAttribute('src',url);
}
</script>
<script>	
//系统菜单滚动
var scroller  = null;
var scrollbar = null;
var scrollTween = null;
window.onload = function () {
  scroller  = new Scroller(document.getElementById("sysmenu"), 20 ,leftO);
  scrollbar = new Scrollbar(document.getElementById("sysmenu_bar"), scroller, true);
  scrollTween = new ScrollerTween(scrollbar, true);
}
</script>	
</html>