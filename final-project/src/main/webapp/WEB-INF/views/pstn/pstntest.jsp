<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>

<meta name="_csrf" th:content="${_csrf.token}">
<meta name="_csrf_header" th:content="${_csrf.headerName}">

<!-- 
수정할 부분 
	직위 ->
	pstn ->
	

 -->

<h5 id="offcanvasEndLabel1" class="offcanvas-title">직위</h5>
<div id="originTree">

</div>

    <button id="btn_openForm"
      class="btn btn-primary"
      type="button"
      data-bs-toggle="offcanvas"
      data-bs-target="#offcanvasEnd"
      aria-controls="offcanvasEnd"
    >
      직위 설정
    </button>
    <div 
      class="offcanvas offcanvas-end"
      tabindex="-1"
      id="offcanvasEnd"
      aria-labelledby="offcanvasEndLabel"
    >
	
      <div class="offcanvas-header border-bottom">
        <h5 id="offcanvasEndLabel" class="offcanvas-title">직위 설정</h5>
        <button 
          type="button"
          class="btn-close text-reset"
          data-bs-dismiss="offcanvas"
          aria-label="Close"
        ></button>
      </div>
      
      
      <nav class="navbar navbar-example navbar-expand-lg bg-light p-1">
	    <div class="container-fluid d-flex">
	      
	      <div class="mx-2">
	        <div class="d-flex">
				<button id="btn_addNode" class="btn ms-auto" type="button" style="background-color:#B6E2A1;color:white"><i class='bx bx-plus' ></i> Create</button>
				<button id="btn_reName" class="btn ms-auto" type="button"  style="background-color:#FDBE8C;color:white"><i class='bx bx-edit-alt' ></i> Rename</button>
				<button id="btn_reMove" class="btn ms-auto" type="button"  style="background-color:#F49E9E;color:white"><i class='bx bx-x'></i> Delete</button>
	        </div>
	
<!-- 	        <form class="d-flex"> -->
	          <div class="input-group">
	            <span class="input-group-text"><i class="tf-icons bx bx-search"></i></span>
	            <input id="inp_search" type="text" class="form-control" placeholder="Search...">
	          </div>
<!-- 	        </form> -->
	      </div>
	    </div>
	  </nav>


	<div class="d-flex "></div>

	<div class="offcanvas-body my-auto mx-0">
		<div class="d-flex ">
			<h5 id="offcanvasEndLabel2" class="offcanvas-title">0</h5>
		</div>

		<div id="formTree"></div>
	</div>

	<div class="offcanvas-footer p-3 border-top">
	        <button id="btn_allSubmit" type="button" class="btn btn-primary mb-2 d-grid w-100">저장하기</button>
	        <button
	          type="button"
	          class="btn btn-outline-secondary d-grid w-100"
	          data-bs-dismiss="offcanvas"
	        >
	          Cancel
	        </button>
        </div>
    </div>
    
<script id="wrapScript" type="text/javascript" defer="defer">
$(document).ready(function() { 

	// 전역 데이터 선언
	$tree = $('#originTree');	//원본 트리
	$formT = $('#formTree');	//수정 트리

	var $selNode;	//선택 노드

	var leftData;	//삭제할 노드
	var rightData;	//추가할 노드
	var midData;	//수정할 노드

	newData = [];	// 변경 정보
	var maxNum;		// 부여할 id
	var totalNum;	// 전체 노드 개수
	var searchString // 검색값
	var isSubmit = false;	// 저장유무

	//ajax
	let pstnList;	// ajax selectList
	let object;		// 노드 정보
	let data = [];	// 노드 정보 리스트
	
	$("#btn_reName").on('click', function () { reName(); })
	$("#btn_reMove").on('click', function () { reMove(); })
	$("#btn_addNode").on('click', function () { addNode(); })
	
	$("#btn_allSubmit").on('click', function () { allSubmit(); })
	

// 삭제 수정 추가 통합 ajax
function allSubmit(){
	console.log("allSubmit호출")
	isSubmit=true;
	
	getData();			// newData생성
	getDiagramData();	// diagramData생성
	
	var jsonLeftData = JSON.stringify(leftData);
	var jsonMidData = JSON.stringify(midData);
	var jsonRightData = JSON.stringify(rightData);
	
	console.log("jsonLeftData : ", jsonLeftData )
	console.log("midData : ", midData )
	console.log("jsonRightData : ", jsonRightData )
	
	$.ajax({
		url : "${cPath }/pstn/pstnSave.do",
		method : "POST",
		contentType: "application/x-www-form-urlencoded; charset=UTF-8",
		traditional: true,
		async: false,
		data : {
			'jsonLeftData':jsonLeftData 
			, 'jsonMidData':jsonMidData
			, 'jsonRightData':jsonRightData
		},
		dataType : "json",
		beforeSend: function (jqXHR, settings) {
	           var header = $("meta[name='_csrf_header']").attr("content");
	           var token = $("meta[name='_csrf']").attr("content");
	           jqXHR.setRequestHeader(header, token);
		},
		success : function(resp) {
			console.log("ajax success")
		},
		error : function(errorResp) {
			console.log(errorResp.status);
		},
		complete: function() {
			console.log("ajax complete")
			toastr.success('인사정보를 수정하였습니다');
			
	         oldData= newData;
	         $tree.jstree(true).settings.core.data = newData;
			$formT.jstree(true).settings.core.data = oldData;
			
	         $tree.jstree(true).refresh(true);
			$('.offcanvas').offcanvas('hide');
		}
	});
}
	

// 로드시 oldData 초기화
$tree.bind("loaded.jstree", function(e) {
	oldData = $tree.jstree(true).settings.core.data;
	totalNode();
}.bind(this));


// 현재 트리구조 + 원본 데이터를 Merge 하여 newData를 리턴
getData = function() {
	console.log("getData호출")
	newData = [];
	var jdata = $formT.jstree(true).get_json("#", {flat:true});
	console.log("jdata", jdata)
	for (var i=0; i<jdata.length; i++) {
		var current = jdata[i];
		var id = current.id;
		var data = this.findCoreData(id);

		newData.push($.extend(data, current));
	}
	console.log("newData", newData)
	return newData; 
};

//↑ 해당 ID 값의 데이터를 리턴 	id : node.id
findCoreData = function(id) {
	var coreData = $formT.jstree(true).settings.core.data;
	for (var i=0; i<coreData.length; i++) {
		var data = coreData[i];
		if (data.id == id) {
			return data;
		}
	}
	return null;
};


// 다이어그램 데이터 추출
getDiagramData = function(){
	console.log("getDiagramData호출")
	console.log("OLD", oldData);
	console.log("NEW", newData);
	
	leftData = oldData.filter(x=> !newData.some(o=> o.id==x.id));
	console.log("leftData", leftData);

	rightData = newData.filter(x=> !oldData.some(o=> o.id==x.id));
	console.log("rightData", rightData);
	
	midData = newData.filter(x=> oldData.some(o=> 
			o.id==x.id && o.text != x.text 
			|| o.id==x.id && o.parent != x.parent ) );
	
	console.log("midData",midData);
}


// offcanvas 열었을 때 이벤트
$('.offcanvas').on('show.bs.offcanvas', function() {
    console.log("openCanvas호출")
	isSubmit=false;
    
    //formT 초기화
	data = [];
	selectPstnList();	//ajax pstnList최신화
    console.log("selectPstnList()호출 후 pstnList : ",pstnList);
    console.log("열었을때 oldData", oldData)
	
  	$(pstnList).each(function(index, pstn){
  		object ={
    		"text" : pstn.ptnNm,
    		"id" : pstn.ptnCode,
    		"parent" : "#"
    	}
		
		data.push(object);
  	})

  	// 검색 기능 초기화
  	$('#inp_search').val('');
    $("#formTree").jstree("clear_search");	//검색창 초기화
    $formT.jstree("deselect_all");			//노드 선택 해제
    
  	formTree();
    $formT.jstree(true).refresh(true);
    
});


//offcanvas 닫았을 때 이벤트
$('.offcanvas').on('hide.bs.offcanvas', function() {
 	console.log("닫는다")
	 
	//수정 안하고 닫았을때
	if(!isSubmit){
		console.log("닫음 isSubmit", isSubmit)
	// 	$('#basicModal').modal('show')
		console.log("닫oldData", oldData)
		$formT.jstree(true).refresh(true);
	}
		$formT.jstree(true).settings.core.data = oldData;
		$formT.jstree(true).refresh(true);
		closeAll();	//수정 트리 전체 닫기
})

// 원본 트리 전체 열기
openAll = function() {
	$tree.jstree("open_all");
};

// 수정 트리 전체 닫기
closeAll = function() {
	$formT.jstree("close_all");
};

// 현재 선택된 노드 정보 가져오기
$formT.on('select_node.jstree', function(e,data){
	
	$selNode = $formT.jstree("get_selected", true);

	console.log("id", $selNode[0].id )
	console.log("text", $selNode[0].text )
	console.log("parent", $selNode[0].parent )
 });
 
 
 // 노드 움직인 후 이벤트
$formT.bind("move_node.jstree", function(e,d) {
	console.log(d.parent)
});
 	
 
//노드 이름 수정 폼
edit = function(id) {
	console.log("edit()호출")
	$formT.jstree(true).edit(id);
	console.log("수정id는",id);
};
// ↑ 수정 호출 버튼
function reName(){
	if($selNode)
		edit($selNode[0].id)
}


// 특정노드 삭제
removeNode = function(id) {
	$formT.jstree(true).delete_node(id);
	totalNode();	//전체 노드 개수
	$formT.jstree("deselect_all");	//삭제후 선택 해제
};
// ↑ 삭제 호출 버튼
function reMove(){
	if($selNode){
		for(var i = 0; i< $selNode.length; i++){
			removeNode($selNode[i].id)
		}
	}
}


// 데이터 추가
addData = function(d){
	console.log("addData()호출")
	var data = this.getData();
	console.log("d확인",d)
    data.splice(data.length,0,d);
	this.setCoreData(data);
	console.log("추가할data확인",data)
	this.refresh(data);
}
// ↑ 추가 호출 버튼
function addNode(){
	console.log("addNode호출") 
	var selectNodeId="";

	// 추가 검증
	if($selNode){
		console.log("selNode있다", $selNode)
		var jdata = $formT.jstree(true).get_json("#", {flat:true});
		
		for (var i=0; i<jdata.length; i++) {
			if(jdata[i].id == $selNode[0].id){
				
				selectNodeId = $selNode[0].id;
				openNode(selectNodeId);
			}
		}
		if(selectNodeId==""){
			selectNodeId = "#";
		}
	}else{
		selectNodeId = "#";
	}
	
	// 데이터 추가
	addData(
		{
			"text" : "직위명 입력",
			"id" : setId(),
			"parent" : "#"
		}
	);
}

// ↑ 큰id 비교해서 부여
var setId = function(){
	console.log("setId호출")
	var dbNum =0;
	var trNum =0;
	
	//db조회
	$.ajax({
		url : "${cPath }/pstn/maxPtnCode.do",
		method : "GET",
		dataType : "json",
		async: false,
		success : function(resp) {
			dbNum = Number(resp)
			
		},
		error : function(errorResp) {
			console.log(errorResp.status);
		}
	});
	
	console.log("dbNum",dbNum);
	
	//트리조회
	var jdata = $formT.jstree(true).get_json("#", {flat:true});
	console.log("jdata", jdata)
	for (var i=0; i<jdata.length; i++) {
		
		trNum = jdata[i].id.substr(4);
	}
	console.log("trNum",trNum);
	
	maxNum = dbNum > trNum ? dbNum : trNum;
	console.log("maxNum", maxNum);
	maxNum++;
	maxNum = "PTN0"+maxNum;
	console.log("maxNum", maxNum);
	
	return maxNum;
}


//특정 노드 열기,  id
openNode = function(id) {
	$formT.jstree("open_node", id)
};

//새로고침
refresh = function() {
	$formT.jstree(true).refresh();
}

//트리 구조 새로고침 시
$formT.bind("refresh.jstree", function(e,d) {
	console.log("-formT 새로고침 호출-")
	edit(maxNum);	//추가 했을때
	totalNode();	//전체 노드 개수
}.bind(this));


// 노드의 원시 데이터 set,  data : arry
setCoreData = function(data) {
	$formT.jstree(true).settings.core.data = data;
};


//pstnList 최신화
selectPstnList = function(){
	console.log("selectPstnList ajax호출")
	$.ajax({
		url : "${cPath}/pstn/pstnList.do",
		method : "GET",
		dataType : "json",
		async: false,
		success : function(resp) {
			console.log("ajax resp :", resp);
			pstnList = resp;
		},
		error : function(errorResp) {
			console.log(errorResp.status);
		}
	});
}

	//총 노드 개수
totalNode = function(){
	console.log("totlaNode호출");
	if($formT.jstree(true)){
		var totalNode = $formT.jstree(true).get_json("#", {flat:true});
		totalNum = totalNode.length;
		console.log("totalNum!!", totalNum);
		
		$("#offcanvasEndLabel1").text("전체 직위 ("+ totalNum + ")");
		$("#offcanvasEndLabel2").text("전체 "+ totalNum);
	}else{
		var totalNode = $tree.jstree(true).get_json("#", {flat:true});
		totalNum = totalNode.length;
		console.log("totalNum!!", totalNum);
		
		$("#offcanvasEndLabel1").text("전체 직위 ("+ totalNum + ")");
		$("#offcanvasEndLabel2").text("전체 "+ totalNum);
	}
}


//트리 생성
$('#originTree').jstree({

    "core" : {
        "themes" : {
            "responsive": false
        },
      //추가된 부분 시작
        "data":[
			<c:forEach items="${pstnList }" var="pstn" >
			{
        		"text" : "${pstn.ptnNm}",
        		"id" : "${pstn.ptnCode}",
        		"parent" : "#"
        	},
			</c:forEach>
			] //추가된 부분 끝
        , "check_callback" : true 
    },
    "types" : {
	      "default" : {
	      }
    },
    "plugins": ["types","search","contextmenu"]
    
});


//수정tree 생성1
function formTree(){
	console.log("formTree호출")
	
	$('#formTree').jstree({
	    "core" : {
	        "themes" : {
	            "responsive": false
	        },
	      //추가된 부분 시작
	        "data": data

	        , "check_callback" : true 
	    },
	    "types" : {
	        "default" : {
	            "icon" : "fa fa-folder"
	        },
	        "file" : {
	            "icon" : "fa fa-file"
	        },
	      "valid_children" : [ "default" ],
	      "default" : {
	        "max_depth" : 0// 하위 depth 제한
	      }
	    },
	    "plugins": ["types","contextmenu","search"],
	    "search":{
	    	"show_only_matches" : true,
	    	"show_only_matches_children" : true,
	    }
	    
	});
	
}
// 검색 기능
$("#inp_search").keyup(function () {
	console.log("keyup")
    searchString = $(this).val();
    $('#formTree').jstree('search', searchString);
});





});// end onload
</script>
