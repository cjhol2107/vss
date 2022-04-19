<%@ page language="java" contentType="text/html; charset=UTF-8"
  pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>

<%@include file="../includes/header.jsp"%>
   
<style>
.get-writer-font{
	font-size:16px;
	font-weight:bold;
	float:left;
}
.get-grd{
	margin-left:5px;
	font-size:15px;
	font-weight:normal;
	float:left;
}
.personImg{
	width:45px;
	height:45px;
}
.title-table{
	margin-top:15px;
	margin-bottom:35px;
}

.title-table td, .title-table th{
    padding-left:20px;
}

.title-header{
	border-bottom:1px solid #b8b8b8;
}

.panel-interval{
	padding-top:15px;
}

.get-content-head{
	height:175px;
} 
.get-content-body{
	min-height:300px;
	max-height:3000px;
}
.get-btndiv{
	text-align:center;
	padding-bottom:20px;
}

.uploadResult {
  width:100%;
}
.uploadResult ul{
  flex-flow: row;
  justify-content: center;
  align-items: center;
}
.uploadResult ul li {
  list-style: none;
  padding: 10px;
  align-content: center;
  text-align: left;
}
.uploadResult ul li img{
  width: 100px;
}
.uploadResult ul li span {
  color:white;
}
.bigPictureWrapper {
  position: absolute;
  display: none;
  justify-content: center;
  align-items: center;
  top:0%;
  width:100%;
  height:100%;
  background-color: gray; 
  z-index: 100;
  background:rgba(255,255,255,0.5);
}
.bigPicture {
  position: relative;
  display:flex;
  justify-content: center;
  align-items: center;
}

.bigPicture img {
  width:600px;
}

.get-replyMod{
  color: black;
  font-size: 10px;
  cursor: pointer;
  font-weight: bold;
}

.get-replyMod:hover{
  text-decoration: none;
}

.get-replyDel{
  color: black;
  font-size: 10px;
  cursor: pointer;
  font-weight: bold;
}

.get-replyDel:hover{
  text-decoration: none;
}

.knwShrTextArea{
  width:100%;
  height:250px;
  min-height:250px;
}

.btn-circle-reply-like {
  width: 20px;
  height: 20px;
  padding: 2px 0;
  border-radius: 15px;
  text-align: center;
  font-size: 12px;
  line-height: 1.428571429;
}

.header-reply{
	border-bottom:1px dotted #DCDCDC;
	margin-bottom:10px;
	padding-bottom:5px;
}
</style>
   
<div class="row">
	<div class="col-lg-12 panel-interval">
		<div class="panel panel-default">

			<div class="panel-heading get-content-head">
				<div
					style="color: gray; font-size: 14px; float: left; padding-right: 10px;">
					#
					<c:out value="${board.bno}" />
				</div><br>
				
				<c:if test="${board.category1 != null}">
					<button type="button" class="btn btn-primary btn-xs" id='<c:out value="${board.category1}"/>'>${board.category1}
					</button>
				</c:if>    
				<c:if test="${board.category2 != null}">
					<button type="button" class="btn btn-primary btn-xs" id='<c:out value="${board.category2}"/>'>${board.category2}
					</button>
				</c:if>
				<c:if test="${board.category3 != null}">
					<button type="button" class="btn btn-primary btn-xs" id='<c:out value="${board.category3}"/>'>${board.category3}
					</button>
				</c:if>
				
				<div class="title-header">
					<h2>
						<c:out value="${board.title}" />
					</h2>
				</div>

				<table class="title-table">
					<tr>
						<td rowspan="2" style="padding-left: 0px;">
							<div>
								<img src="/resources/img/personImg.png" class="personImg" />
							</div>
						</td>
						<td>
							<div class="get-writer-font">
								<c:out value="${board.writer}" />
							</div>
						</td>
					</tr>
					<tr>
						<td><i class="fa fa-eye"> <c:out value="${board.views}" /></i></td>
						<td><fmt:formatDate pattern="yyyy-MM-dd hh:mm:ss" value="${board.regdate}" /></td>
					</tr>
				</table>
			</div>
			<div class="panel-body get-content-body">
				<div>${board.content}</div>

				<form id='operForm' action="/boad/modify" method="get">
					<input type='hidden' id='bno' name='bno' value='<c:out value="${board.bno}"/>'> 
					<input type='hidden' name='pageNum' value='<c:out value="${cri.pageNum}"/>'> 
					<input type='hidden' name='amount' value='<c:out value="${cri.amount}"/>'>
					<input type='hidden' name='keyword' value='<c:out value="${cri.keyword}"/>'> 
					<input type='hidden' name='type' value='<c:out value="${cri.type}"/>'>
					<input type='hidden' name='libCls' value='<c:out value="${cri.libCls}"/>'>
					
					<sec:authentication property="principal" var="pinfo" />
					<input type='hidden' id='userid' name='userid' value='<c:out value="${pinfo.username}"/>'>
				</form>
			</div>
			<div class="get-btndiv">
				<sec:authentication property="principal" var="pinfo" />
				<sec:authorize access="isAuthenticated()">
					<c:if test="${pinfo.username eq board.writer}">
						<button data-oper='modify' class="btn btn-default"><i class="fa fa-pencil"></i> 수정</button>
					</c:if>   
				</sec:authorize>
				<button data-oper='list' class="btn btn-default"><i class="fa fa-list"></i> 목록</button>
			</div>
		</div>
	</div>
</div>

<div class='bigPictureWrapper'>
  <div class='bigPicture'>
  </div>
</div>


<div class="row">
	<div class="col-lg-12">
		<div class="panel panel-default">
			<div class="panel-heading">
				<i class="fa fa-file-text"></i> 첨부파일
			</div>
			<div class="panel-body" id="file-div">
				<div class='uploadResult'>
					<ul>
					</ul>
				</div>
			</div>
		</div>
	</div>
</div>

 
<div class='row'>
	<div class="col-lg-12">
		<div class="panel panel-default">
			<div class="panel-heading">
				<i class="fa fa-comments fa-fw"></i> 답변
				<sec:authorize access="isAuthenticated()">
					<button id='addReplyBtn' class='btn btn-default btn-xs pull-right'>답변작성</button>
				</sec:authorize>
			</div>
			<div class="panel-body" id="reply-div">
				<ul class="chat">
				</ul>
			</div>
		</div>
	</div>
</div>



<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title" id="myModalLabel">답변하기</h4>
            </div>
            <div class="modal-body">
				<div class="form-group">
                	<label>답변</label> 
                	<textarea class="form-control knwShrTextArea" name="reply" value="New Reply!!!!"></textarea>
                </div>      
              	<div class="form-group">
                	<label>작성자</label> 
                	<input class="form-control" name='replyer' value='replyer' readonly="readonly" style="background-color:white;">
              	</div>
              	<div class="form-group">
	                <label style="display:none;">작성일</label> 
	                <input class="form-control" name='replyDate' value='2018-01-01 13:13'>
              	</div>
            </div>
			<div class="modal-footer">
		        <button id='modalModBtn' type="button" class="btn btn-warning">수정</button>
		        <button id='modalRegisterBtn' type="button" class="btn btn-primary">등록</button>
		        <button id='modalCloseBtn' type="button" class="btn btn-default">닫기</button>
     		</div>          
		</div>
	</div>
</div>



<div class="modal fade myModal2" id="myModal2" tabindex="-1" role="dialog"
	aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"
					aria-hidden="true">&times;</button>
				<h4 class="modal-title" id="myModalLabel">알림</h4>
			</div>
			<div class="modal-body myModal2-body">이미 추천을 누르셨습니다.</div>
			<div class="modal-footer">
				<button type='button' class='btn btn-default' style='visibility:hidden;' id='modalBtn-selectedAns'>채택하기</button>
				<button type="button" class="btn btn-primary" data-dismiss="modal">닫기</button>
			</div>
		</div>
	</div>
</div>


<script type="text/javascript" src="/resources/js/knwShrReply.js"></script>

<script>

$(document).ready(function () {
  	
  var adpYn = '<c:out value="${board.adoptionYn}"/>';
  var bnoValue = '<c:out value="${board.bno}"/>';
  
  alert(adpYn);
  var replyUL = $(".chat");
  var userid = $("#userid").attr("value");
  
  showList(1);
  
  
  
    function showList(page){
    	
        replyService.getList({bno:bnoValue,page: page|| 1 }, function(replyCnt, list) {

        if(replyCnt==0){
     	   $("#reply-div").html("등록된 댓글이 없습니다.");
     	   $("#reply-div").attr("style", "font-size:12px;");
        }
        
        if(page == -1){
          pageNum = Math.ceil(replyCnt/10.0);
          showList(pageNum);
          return;
        }
          
         var str="";
         
         if(list == null || list.length == 0){
           return;
         }
         
         for (var i = 0, len = list.length || 0; i < len; i++) {
        	 
           str +="<li class='left clearfix' data-rno='"+list[i].rno+"'>";
           // 댓글 추천 
           str +="<div style='width:5%; height:85px; float:right;'>";
           str +="<table style='width:100%; height:100%;'>";
           str +="<tr>";
           str +="<td style='text-align:center;'>";
           str +="<button type='button' id='up' value='"+list[i].rno+"' class='btn btn-success btn-circle-reply-like'>";
           str +="<i class='fa fa-angle-double-up' style='font-size:18px;'></i></td>";
           str +="</button>";
           str +="</tr>";
           str +="<tr>";
           str +="<td style='text-align:center; font-size:18px;'><span id='"+list[i].rno+"'>"+list[i].likes+"</span></td>";
           str +="</tr>";
           str +="<tr>";
           str +="<td style='text-align:center;'>";
           str +="<button type='button' id='down' value='"+list[i].rno+"' class='btn btn-danger btn-circle-reply-like'>";
           str +="<i class='fa fa-angle-double-down' style='font-size:18px;'></i></td>";
           str +="</button>";
           str +="</tr>";
           str +="</table>";
           str +="</div>";
           // 댓글 추천end 
           
           
           
           
           
           str +="  <div style='width:95%; float:right;'><div class='header header-reply'><strong class='primary-font'>["
        	   +list[i].rno+"] "+list[i].replyer+"</strong>"; 
           str +="    <small class='pull-right text-muted'>"
               +replyService.displayTime(list[i].replyDate)+"</small></div>";
           str +="<div style='float:left'>";
           str +="    <p>"+list[i].reply+"</p></div>";
                  
           //본인만  && 채택완료되지 않은 건만  
           if(list[i].replyer==userid && adpYn!="Y"){
	           str +="<div style='float:right' id='reply-secdiv'> ";
	           str +="<a class='get-replyMod' data-rno='"+list[i].rno+"'>수정</a>&nbsp";
	           str +="<a class='get-replyDel' data-rno='"+list[i].rno+"'>삭제</a>";
	           str +="</div>";
           }    
           
           if(adpYn!="Y"){
        	   str += "<br>"+list[i].selectedYn;
               str += "  <div style='text-align:right; float:right; margin-top:7px; margin-bottom:7px; width:100%; font-size:17px;'>";
               str += "    <button type='button' id='selectReply' style='background-color:white; border:0; outline:0;'>";
               str += "      <i class='fa fa-check-circle-o'></i> 채택하기";
               str += "    </button>";
               str += "  </div>"; 
           }
           
           if(list[i].selectedYn=="Y"){
               str += "  <div style='text-align:right; float:right; margin-top:7px; margin-bottom:7px; width:100%; font-size:17px;'>";
               str += "    <button type='button' id='selectedReply' style='background-color:white; border:0; outline:0; color:red;'>";
               str += "      <i class='fa fa-check-circle-o'></i> 채택된 답변";
               str += "    </button>";
               str += "  </div>"; 
           }
           
           str +="</div>";
           str +="</li>";
           str +="</div>";
         } 
         
         /*////// 수정중
         for (var i = 0, len = list.length || 0; i < len; i++) {
        	 
        	 str+="<table style='width:100%'>";
        	 
        	 str+="  <tr>";
        	 str+="    <td style='width:80%'>user00</td>"
        	 str+="    <td style='width:10%'>11:25:05</td>"
        	 str+="    <td style='width:10%'>^</td>"
        	 str+="  </tr>";
        	 
        	 str+="  <tr>";
        	 str+="    <td style='width:80%'>댓글입니다~~!!</td>"
        	 str+="    <td style='width:10%'>수정  삭제</td>"
             str+="    <td style='width:10%'>0</td>"
        	 str+="  </tr>";
        	   
        	 str+="  <tr>";
        	 str+="    <td style='width:80%'></td>"
             str+="    <td style='width:10%'>채택하기</td>"
             str+="    <td style='width:10%'>^</td>"
        	 str+="  </tr>";
        	 
        	 str+="</table>";
        	 
        	 
        	 
        	 
        	 
             /* str +="<li class='left clearfix' data-rno='"+list[i].rno+"'>";
             
             str +="  <div style='width:90%'><div class='header'><strong class='primary-font'>["
          	   +list[i].rno+"] "+list[i].replyer+"</strong>"; 
             str +="    <small class='pull-right text-muted'>"
                 +replyService.displayTime(list[i].replyDate)+"</small></div>";
             str +="<div style='float:left'>";
             str +="    <p>"+list[i].reply+"</p></div>";
                    
             if(list[i].replyer==userid){
  	           str +="<div style='float:right' id='reply-secdiv'> ";
  	           str +="<a class='get-replyMod' data-rno='"+list[i].rno+"'>수정</a>&nbsp";
  	           str +="<a class='get-replyDel' data-rno='"+list[i].rno+"'>삭제</a>";
  	           str +="</div>";
             }    
             str += "<br>";
             str += "<div style='text-align:right; float:right; margin-top:7px; margin-bottom:7px; width:100%;'>";
             str += "<i class = 'fa fa-check-circle-o'></i> 채택하기";
             str += "</div>";
             
             str +="</div>";
              
             
             str +="</li>";
             str +="</div>"; 
           }
         
         //////// 수정중  */
         
         replyUL.html(str);
         
         showReplyPage(replyCnt);

     
       });
         
     }
    
    var pageNum = 1;
    var replyPageFooter = $(".panel-footer");
    
    function showReplyPage(replyCnt){
      
      var endNum = Math.ceil(pageNum / 10.0) * 10;  
      var startNum = endNum - 9; 
      
      var prev = startNum != 1;
      var next = false;
      
      if(endNum * 10 >= replyCnt){
        endNum = Math.ceil(replyCnt/10.0);
      }
      
      if(endNum * 10 < replyCnt){
        next = true;
      }
      
      var str = "<ul class='pagination pull-right'>";
      
      if(prev){
        str+= "<li class='page-item'><a class='page-link' href='"+(startNum -1)+"'>Previous</a></li>";
      }
      
       
      
      for(var i = startNum ; i <= endNum; i++){
        
        var active = pageNum == i? "active":"";
        
        str+= "<li class='page-item "+active+" '><a class='page-link' href='"+i+"'>"+i+"</a></li>";
      }
      
      if(next){
        str+= "<li class='page-item'><a class='page-link' href='"+(endNum + 1)+"'>Next</a></li>";
      }
      
      str += "</ul></div>";
      
      console.log(str);
      
      replyPageFooter.html(str);
    }
     
    replyPageFooter.on("click","li a", function(e){
        e.preventDefault();
        console.log("page click");
        
        var targetPageNum = $(this).attr("href");
        
        console.log("targetPageNum: " + targetPageNum);
        
        pageNum = targetPageNum;
        
        showList(pageNum);
      });     

   

    var modal = $("#myModal");
    var modalInputReply = modal.find("textarea[name='reply']");
    var modalInputReplyer = modal.find("input[name='replyer']");
    var modalInputReplyDate = modal.find("input[name='replyDate']");
    
    var modalModBtn = $("#modalModBtn");
    var modalRemoveBtn = $("#modalRemoveBtn");
    var modalRegisterBtn = $("#modalRegisterBtn");
    
    $("#modalCloseBtn").on("click", function(e){
    	
    	modal.modal('hide');
    });
    
    $("#addReplyBtn").on("click", function(e){
    	
    	if()
        
        modal.find("input").val("");
        modal.find("input[name='replyer']").val(replyer);
        modalInputReplyDate.closest("div").hide();
        modal.find("button[id !='modalCloseBtn']").hide();
        
        modalRegisterBtn.show();
        
        $("#myModal").modal("show");
        
      });

    
    $(document).ajaxSend(function(e, xhr, options) { 
        xhr.setRequestHeader(csrfHeaderName, csrfTokenValue); 
      }); 

    

    modalRegisterBtn.on("click",function(e){
      
      var reply = {
            reply: modalInputReply.val(),
            replyer:modalInputReplyer.val(),
            bno:bnoValue
          };
      replyService.add(reply, function(result){
        
        alert("댓글이 등록되었습니다.");
        
        modal.find("input").val("");
        modal.modal("hide");
        
        showList(1);
        //showList(-1);
        
      });
      
    });
	 
	 $(document).on("click", ".get-replyMod", function(e) {
		  e.preventDefault();
		  var rno = $(this).data("rno");
	        
	      replyService.get(rno, function(reply){
	        
	      modalInputReply.val(reply.reply);
	      modalInputReplyer.val(reply.replyer);
	      modalInputReplyDate.val(replyService.displayTime( reply.replyDate)).attr("style","display:none;");
	      modal.data("rno", reply.rno);
	      modal.find("button[id !='modalCloseBtn']").hide();
	      modalModBtn.show();
	      modalRemoveBtn.show();
	          
	      $(".modal").modal("show");
	              
	      });
	  });
	 
	 $(document).on("click", ".get-replyDel", function(e) {
		 
		 if(confirm("삭제하시겠습니까?")){
			  e.preventDefault();
			  var rno = $(this).data("rno");
		        
			  if(!replyer){
				    alert("로그인후 삭제가 가능합니다.");
				    modal.modal("hide");
				    return;
			    }
			  
			    var originalReplyer = modalInputReplyer.val();
			  
			    console.log("Original Replyer: " + originalReplyer);
			  
			    if(replyer  != originalReplyer){
				  
				    alert("자신이 작성한 댓글만 삭제가 가능합니다.");
				   modal.modal("hide");
				    return;
				  
			    }
		   	  
			   	    replyService.remove(rno, originalReplyer, function(result){
			   	       
			   	    alert("댓글이 삭제되었습니다.");
			   	    modal.modal("hide");
			   	    showList(pageNum);
		   	      
		   	    });
		 }
	  });
	 
	modalModBtn.on("click", function(e){
	
		var originalReplyer = modalInputReplyer.val();
		
	  	var reply = {
			      rno:modal.data("rno"), 
			      reply: modalInputReply.val(),
			      replyer: originalReplyer};
	  
		if(!replyer){
			 alert("로그인후 수정이 가능합니다.");
			 modal.modal("hide");
			 return;
		}
	
		if(replyer  != originalReplyer){
		 
			 alert("자신이 작성한 댓글만 수정이 가능합니다.");
			 modal.modal("hide");
			 return;
		 
		}
	  
		replyService.update(reply, function(result){
		      
		  alert("댓글이 수정되었습니다.");
		  modal.modal("hide");
		  showList(pageNum);
		  
		});
  
	});
      var replyer = null;
    
      <sec:authorize access="isAuthenticated()">
    
      replyer = '<sec:authentication property="principal.username"/>';   
    
</sec:authorize>
 
    var csrfHeaderName ="${_csrf.headerName}"; 
    var csrfTokenValue="${_csrf.token}";
   
    
    var originalReplyer = modalInputReplyer.val();
    
    $(document).on("click", ".btn-circle-reply-like", function(e) {
	  	var obj = $(".btn-circle-reply-like");
		var id = $(this).attr("id");
		
		var likes = 0;
		var rno = $(this).attr("value");;
		var user_id = $("#userid").attr("value");
		
		if(id!='up'){
			likes = -1;
		}else if(id=='up'){
			likes = 1;
		}
		
		$.ajax({
			type : 'POST',
			url : '/knwShr/replies/heart',
			contentType : "application/json; charset=utf-8",
			data : JSON.stringify({rno:rno, replyer:userid, likes:likes}),
			dataType : "json",
			success : function(data){	
				if(data.result=='Y'){
					$(".myModal2-body").html("이미 추천을 누르셨습니다.");
					$("#modalBtn-selectedAns").attr("style","visibility:hidden");
					$("#myModal2").modal("show");
					return;
				}else{
					$('#'+rno).html(data.like_cnt);	
				}
			}
		});   
	
    });
    
    $(document).on("click", "#selectReply", function(e) {
    	var modal = $("#myModal2");
    	$(".myModal2-body").html("답변을 채택하시겠습니까?");
    	$("#modalBtn-selectedAns").attr("style","visibility:visible");
    	modal.modal("show");
    	
    });
    
    $("#modalBtn-selectedAns").on("click", function(e){
    	alert("채택이벤트");
    	
    	$.ajax({
			type : 'POST',
			url : '/knwShr/replies/selectedAns',
			contentType : "application/json; charset=utf-8",
			data : JSON.stringify({rno:rno, userid:userid}),
			dataType : "json",
			success : function(data){	
				$(".myModal2-body").html("답변이 채택되었습니다.");
				$("#myModal2").modal("show");
				showList(1);
			}
		});  
    	
	});
    
});

</script>

<script type="text/javascript">
$(document).ready(function() {
  
  var operForm = $("#operForm"); 
  
  $("button[data-oper='modify']").on("click", function(e){
    
    operForm.attr("action","/knwShrBoard/modify").submit();
    
  });
  
    
  $("button[data-oper='list']").on("click", function(e){
    
    operForm.find("#bno").remove();
    operForm.attr("action","/knwShrBoard/list")
    operForm.submit();
    
  });  
  
  $("#java").attr("class", "btn btn-primary btn-xs java");
  $("#css").attr("class", "btn btn-info btn-xs css");
  $("#oracle").attr("class", "btn btn-warning btn-xs oracle");
  $("#javaScript").attr("class", "btn btn-danger btn-xs javaScript");
  $("#spring").attr("class", "btn btn-success btn-xs spring");
  
});
</script>


<script>


$(document).ready(function(){
  
  (function(){
  
    var bno = '<c:out value="${board.bno}"/>';
    
    $.getJSON("/knwShrBoard/getAttachList", {bno: bno}, function(arr){

       if(arr.length==0){
    	   $("#file-div").html("등록된 첨부파일이 없습니다.");
    	   $("#file-div").attr("style", "font-size:12px;");
       }
       
       var str = "";
       
       $(arr).each(function(i, attach){
       
         if(attach.fileType){
        	 //썸네일 출력을 위해 호출될 파일의 경로 
             var fileCallPath =  encodeURIComponent(attach.uploadPath+ "/s_"+attach.uuid +"_"+attach.fileName);
             
         	 str += "<li data-path='"+attach.uploadPath+"' data-uuid='"+attach.uuid+"' data-filename='"+attach.fileName+"' data-type='"+attach.fileType+"' ><div>";
             str += "<i class='fa fa-photo'><span style='color:black'> "+ attach.fileName+"</i></span><br>";
             str += "<img src='/display?fileName="+fileCallPath+"'>";
             str += "</div>";
             str +"</li>";
         }else{
             
        	 str += "<li data-path='"+attach.uploadPath+"' data-uuid='"+attach.uuid+"' data-filename='"+attach.fileName+"' data-type='"+attach.fileType+"' ><div>";
             str += "<i class='fa fa-paperclip' style='color:black; font-size:14px;' > "+attach.fileName + "</i></span>";
             str += "</div>";
             str +"</li>";
         }
       });
       
       $(".uploadResult ul").html(str);
       
       
     });

    
  })();
  
  $(".uploadResult").on("click","li", function(e){
      
    console.log("view image");
    
    var liObj = $(this);
    
    var path = encodeURIComponent(liObj.data("path")+"/" + liObj.data("uuid")+"_" + liObj.data("filename"));
    
    if(liObj.data("type")){
      showImage(path.replace(new RegExp(/\\/g),"/"));
    }else {
      self.location ="/download?fileName="+path
    }
    
    
  });
  
  function showImage(fileCallPath){
    
    $(".bigPictureWrapper").css("display","flex").show();
    
    $(".bigPicture")
    .html("<img src='/display?fileName="+fileCallPath+"' >")
    .animate({width:'100%', height: '100%'}, 1000);
    
  }

  $(".bigPictureWrapper").on("click", function(e){
    $(".bigPicture").animate({width:'0%', height: '0%'}, 1000);
    setTimeout(function(){
      $('.bigPictureWrapper').hide();
    }, 1000);
  });
  
  

  
});


</script>



<%@include file="../includes/footer.jsp"%>
