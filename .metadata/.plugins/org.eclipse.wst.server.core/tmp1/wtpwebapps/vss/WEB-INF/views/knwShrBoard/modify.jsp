<%@ page language="java" contentType="text/html; charset=UTF-8"
  pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>

<%@include file="../includes/header.jsp"%>

<style>
.form-control-title2 {
	width: 100%;
	height: 120px;
	font-size: 50px;
	border: none;
	border-right:0px; 
	border-top:0px; 
	border-left:0px; 
	border-bottom:1px solid #CCC;
	padding-bottom:5px;
}

.register-btndiv{
	text-align:center;
	padding-top:10px;
	padding-bottom:15px;
}  
.uploadResult {
  width:100%;
}
.uploadResult ul{
  flex-flow: row;
  justify-content: center;
  align-items: left;
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

.reg-category-mod{
	width:300px;
	float:left;
}

.category-select-mod{
	width:150px;
	margin-bottom:10px;
}   

.category-div-mod{
	width:1300px;
}

.category-remove-mod{
	color:white;
	font-weight:bold;
}

.category-btn-mod{
	margin-right:5px;
}

</style>
        
<div class="row">  
	<div class="col-lg-12">  
		<div class="panel panel-default">
			<div class="panel-body">  
				<label>category</label>
				<form role="form" action="/knwShrBoard/modify" method="post">
				
					<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>  
					<input type='hidden' name='pageNum' value='<c:out value="${cri.pageNum }"/>'>
					<input type='hidden' name='amount' value='<c:out value="${cri.amount }"/>'>
					<input type='hidden' name='type' value='<c:out value="${cri.type }"/>'>
					<input type='hidden' name='keyword' value='<c:out value="${cri.keyword }"/>'>
					<input type='hidden' name='libCls' value='<c:out value="${cri.libCls}"/>'>
					
					<input name='bno' style="display:none;" value='<c:out value="${board.bno }"/>' > 
					<input name='writer' style="display:none;" value='<c:out value="${board.writer }"/>'>
					<input name='regDate' style="display:none;" value='<fmt:formatDate pattern = "yyyy/MM/dd" value = "${board.regdate}" />' >
					<input name='updateDate' style="display:none;" value='<fmt:formatDate pattern = "yyyy/MM/dd" value = "${board.updateDate}" />'>
					
					<div class="form-group reg-category-mod">
						<div style="float:left;">
	                        <select class="form-control category-select-mod" id="category" name="category" onchange="chageSelect()">
	                            <option>spring</option>
	                            <option>java</option>  
	                            <option>oracle</option>
	                            <option>javaScript</option>
	                            <option>css</option>
	                        </select>
                        </div>
                        <div style="float:left;">
                        	<span><i class="fa fa-refresh" style="padding-left:10px; padding-top:10px;" id="refresh-category"></i></span>
                        </div>
                        <br><br><br>
                        <div class="category-div-mod" id="category-div-mod">
                        	<div class="category-div-body" id="category-div-body">
		                        <c:if test="${board.category1 != null}">
									<button type="button" class="btn btn-primary btn-xs category-btn-mod" 
										name="category1" id='<c:out value="${board.category1}"/>'>${board.category1}
									</button>
									<input type="hidden" name="category1" value='<c:out value="${board.category1}"/>' id='<c:out value="${board.category1}"/>'/>
								</c:if>
								<c:if test="${board.category2 != null}">
									<button type="button" class="btn btn-primary btn-xs category-btn-mod" 
										name="category2" id='<c:out value="${board.category2}"/>'>${board.category2}
									</button>
									<input type="hidden" name="category2" value='<c:out value="${board.category2}"/>' id='<c:out value="${board.category2}"/>'/>
								</c:if>
								<c:if test="${board.category3 != null}">
									<button type="button" class="btn btn-primary btn-xs category-btn-mod" 
										name="category3" id='<c:out value="${board.category3}"/>'>${board.category3}
									</button>
									<input type="hidden" name="category3" value='<c:out value="${board.category3}"/>' id='<c:out value="${board.category3}"/>'/>
								</c:if>
							</div>
                    	</div>
                    </div>
                    
					<input class="form-control-title2" name='title' value='<c:out value="${board.title}"/>'>
					<div class="row" style="padding-bottom: 30px;"></div>

					<textarea id="summernote" name="content">
						<c:out value="${board.content}"/>
					</textarea>
			
					<sec:authentication property="principal" var="pinfo" />
					<sec:authorize access="isAuthenticated()">
						<c:if test="${pinfo.username eq board.writer}">
							<div class="register-btndiv">
								<button type="submit" data-oper='modify' class="btn btn-success submitBtn"><i class="fa fa-pencil"></i> ??????</button>
								<button type="submit" data-oper='remove' class="btn btn-danger submitBtn"><i class="fa fa-pencil"></i> ??????</button>
								<button type="submit" data-oper='list' class="btn btn-primary submitBtn"><i class="fa fa-pencil"></i> ??????</button>
							</div>
						</c:if>
					</sec:authorize>
				</form>
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
				<i class="fa fa-file-text"> ????????????</i>
			</div>
			<div class="panel-body">
				<div class="form-group uploadDiv">
					<input type="file" name='uploadFile' multiple="multiple">
				</div>
				<div class='uploadResult'>
					<ul>
					</ul>
				</div>
			</div>
		</div>
	</div>
</div>

<div class="modal fade" id="myModal" tabindex="-1" role="dialog"
			aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"
					aria-hidden="true">&times;</button>
				<h4 class="modal-title" id="myModalLabel">??????</h4>
			</div>
			<div class="modal-body">?????????????????????????</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-info" id="modal-submit" data-dismiss="modal">??????</button>
				<button type="button" class="btn btn-danger" id="modal-cancel" data-dismiss="modal">??????</button>
			</div>
		</div>
	</div>
</div>

<script type="text/javascript">


$(document).ready(function() {
	$('#summernote').summernote({
		  toolbar: [
				['highlight', ['highlight']],
			    ['fontname', ['fontname']],
			    ['fontsize', ['fontsize']],
			    ['style', ['bold', 'italic', 'underline','strikethrough', 'clear']],
			    ['color', ['forecolor','color']],
			    ['table', ['table']],
			    ['para', ['ul', 'ol', 'paragraph']],
			    ['height', ['height']],
			    ['insert',['picture','link','video']],
			    ['view', ['fullscreen', 'help']]
			  ],
			fontNames: ['Arial', 'Arial Black', 'Comic Sans MS', 'Courier New','?????? ??????','??????','?????????','??????','?????????','?????????'],
			fontSizes: ['8','9','10','11','12','14','16','18','20','22','24','28','30','36','50','72'],
			height: 330,                 // ????????? ??????
			minHeight: 330,             // ?????? ??????
			maxHeight: 330,             // ?????? ??????
			focus: true,                  // ????????? ????????? ???????????? ????????? ??????
			lang: "ko-KR",					// ?????? ??????
			placeholder: '?????? 2048????????? ??? ??? ????????????.',	//placeholder ??????
			tabsize: 2,
			prettifyHtml:true,
			lineNumbers:true
	});
	

	var content = "<p><br></p>";
	 
	$('.note-editable').append(content);

	var formObj = $("form");

});

$('.submitBtn').on("click", function(e){
	
	var formObj = $("form");
	   
	e.preventDefault(); 

	var operation = $(this).data("oper");
	
	if(operation != 'remove' && operation != 'list' && operation != 'modify'){
		return;
	}

	if(operation === 'remove'){
		
		$(".modal-body").html("?????????????????????????");
		$("#myModal").modal("show");
		formObj.attr("action", "/knwShrBoard/remove");
	
		return;
	  
	}else if(operation === 'list'){

		formObj.attr("action", "/knwShrBoard/list").attr("method","get");
		
		var pageNumTag = $("input[name='pageNum']").clone();
		var amountTag = $("input[name='amount']").clone();
		var keywordTag = $("input[name='keyword']").clone();
		var typeTag = $("input[name='type']").clone();    
		var libCls = $("input[name='libCls']").clone();      
		
		formObj.empty();
		
		formObj.append(pageNumTag);
		formObj.append(amountTag);
		formObj.append(keywordTag);
		formObj.append(typeTag);	  
		formObj.append(libCls);	  
 
	}else if(operation === 'modify'){

		$("#myModal").modal("show");
		var str = "";

		$(".uploadResult ul li").each(function(i, obj){
		  
		var jobj = $(obj);
		str += "<input type='hidden' name='attachList["+i+"].fileName' value='"+jobj.data("filename")+"'>";
		str += "<input type='hidden' name='attachList["+i+"].uuid' value='"+jobj.data("uuid")+"'>";
		str += "<input type='hidden' name='attachList["+i+"].uploadPath' value='"+jobj.data("path")+"'>";
		str += "<input type='hidden' name='attachList["+i+"].fileType' value='"+ jobj.data("type")+"'>";
		  
		});
		
		return;
		}
	
		formObj.submit();
		
});
</script>


<script>

$(document).ready(function() {
	  
  (function(){	
    var bno = '<c:out value="${board.bno}"/>';
    
    $.getJSON("/knwShrBoard/getAttachList", {bno: bno}, function(arr){
      
      var str = "";
      
      var str = "";
      
      $(arr).each(function(i, attach){
          
          // ???????????????
          if(attach.fileType){
            var fileCallPath =  encodeURIComponent( attach.uploadPath+ "/s_"+attach.uuid +"_"+attach.fileName);
            
            str += "<li data-path='"+attach.uploadPath+"' data-uuid='"+attach.uuid+"' "
            str +=" data-filename='"+attach.fileName+"' data-type='"+attach.fileType+"' ><div>";
            str += "<span style='color:black; font-size:12px;'> "+ attach.fileName+"</span>";
            str += "<button type='button' data-file=\'"+fileCallPath+"\' data-type='image' "
            str += "class='btn btn-default-close' style='background-color:white;'><i class='fa fa-times' style='color:red; background-color:white;'></i></button><br>";
            str += "<img src='/display?fileName="+fileCallPath+"'>";
            str += "</div>";
            str +"</li>";
            
            //????????? ?????????
          }else{
              
            str += "<li data-path='"+attach.uploadPath+"' data-uuid='"+attach.uuid+"' "
            str += "data-filename='"+attach.fileName+"' data-type='"+attach.fileType+"' ><div>";
            str += "<span> ";
			str += "<i class='fa fa-paperclip' style='color:black'> "+attach.fileName + "</i></span>";
            str += "<button type='button' data-file=\'"+fileCallPath+"\' data-type='file' "
            str += " class='btn btn-default-close'><i class='fa fa-times' style='color:red'></i></button><br>";
            str += "</a>";
            str += "</div>";
            str +"</li>";
          }
       });

      
      $(".uploadResult ul").html(str);
      
    });
    
    $("#java").attr("class", "btn btn-primary btn-xs java");
	$("#css").attr("class", "btn btn-info btn-xs css");
	$("#oracle").attr("class", "btn btn-warning btn-xs oracle");
	$("#javaScript").attr("class", "btn btn-danger btn-xs javaScript");
	$("#spring").attr("class", "btn btn-success btn-xs spring");
	
  })();
  
  
  $(".uploadResult").on("click", "button", function(e){
	    
    console.log("delete file");
      
    if(confirm("Remove this file? ")){
    
      var targetLi = $(this).closest("li");
      targetLi.remove();
    }
  });  
  
  var regex = new RegExp("(.*?)\.(exe|sh|zip|alz)$");
  var maxSize = 5242880; //5MB
  
  function checkExtension(fileName, fileSize){
    
    if(fileSize >= maxSize){
      alert("?????? ????????? ??????");
      return false;
    }
    
    if(regex.test(fileName)){
      alert("?????? ????????? ????????? ???????????? ??? ????????????.");
      return false;
    }
    return true;
  }
  
  var csrfHeaderName ="${_csrf.headerName}"; 
  var csrfTokenValue="${_csrf.token}";

  
  $("input[type='file']").change(function(e){

    var formData = new FormData();
    
    var inputFile = $("input[name='uploadFile']");
    
    var files = inputFile[0].files;
    
    for(var i = 0; i < files.length; i++){

      if(!checkExtension(files[i].name, files[i].size) ){
        return false;
      }
      formData.append("uploadFile", files[i]);
      
    }
    
    $.ajax({
      url: '/uploadAjaxAction',
      processData: false, 
      contentType: false,data: 
      formData,type: 'POST',
      beforeSend: function(xhr) {
          xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
      },
      dataType:'json',
        success: function(result){
          console.log(result); 
		  showUploadResult(result); //????????? ?????? ?????? ?????? 

      }
    }); //$.ajax
    
  });    

  function showUploadResult(uploadResultArr){
	    
    if(!uploadResultArr || uploadResultArr.length == 0){ return; }
    
    var uploadUL = $(".uploadResult ul");
    
    var str ="";
    
    $(uploadResultArr).each(function(i, obj){
		
		if(obj.image){
			var fileCallPath =  encodeURIComponent( obj.uploadPath+ "/s_"+obj.uuid +"_"+obj.fileName);
			str += "<li data-path='"+obj.uploadPath+"'";
			str +=" data-uuid='"+obj.uuid+"' data-filename='"+obj.fileName+"' data-type='"+obj.image+"'"
			str +" ><div>";
			str += "<span> "+ obj.fileName+"</span>";
			str += "<button type='button' data-file=\'"+fileCallPath+"\' "
			str += "data-type='image' class='btn btn-warning btn-circle'><i class='fa fa-times'></i></button><br>";
			str += "<img src='/display?fileName="+fileCallPath+"'>";
			str += "</div>";
			str +"</li>";
		}else{
			var fileCallPath =  encodeURIComponent( obj.uploadPath+"/"+ obj.uuid +"_"+obj.fileName);			      
		    var fileLink = fileCallPath.replace(new RegExp(/\\/g),"/");
		      
			str += "<li "
			str += "data-path='"+obj.uploadPath+"' data-uuid='"+obj.uuid+"' data-filename='"+obj.fileName+"' data-type='"+obj.image+"' ><div>";
			str += "<span> "+ obj.fileName+"</span>";
			str += "<button type='button' data-file=\'"+fileCallPath+"\' data-type='file' " 
			str += "class='btn btn-warning btn-circle'><i class='fa fa-times'></i></button><br>";
			str += "<img src='/resources/img/attach.png'></a>";
			str += "</div>";
			str +"</li>";
		}

    });
    
    uploadUL.append(str);
  }
  
});

 
//???????????? ?????? ?????????
function chageSelect(){  
   
	var category = $('#category option:selected').val();
	var arr_tmp = $(".category-div-body").find(".btn-xs").get();
	var tag_name = "category" + (arr_tmp.length+1);
	var el = document.querySelector('.category-div-body');
	var html = "";
	var bodyTag = "";
	
	// ???????????? ?????? 
	if(checkCategory(category)){
		
		if(el == null){
			bodyTag += '<div class="category-div-body">';
			bodyTag += '</div>';
		}
		
		$('.category-div-mod').append(bodyTag);  
		
		html += '<button type="button" class="btn btn-primary btn-xs category-btn-mod" name="'+tag_name+'"id="'+category+'">'+category+'&nbsp';
		html += '</button>';
		html += '	<input type="hidden" name="'+tag_name+'"value="'+category+'"id="'+category+'"';
		html += '</input>';
		$('.category-div-body').append(html);  
		
		$("#java").attr("class", "btn btn-primary btn-xs java");
		$("#css").attr("class", "btn btn-info btn-xs css");
		$("#oracle").attr("class", "btn btn-warning btn-xs oracle");
		$("#javaScript").attr("class", "btn btn-danger btn-xs javaScript");
		$("#spring").attr("class", "btn btn-success btn-xs spring");
	}
	
}  

//???????????? ?????? span ????????? 
$(document).on("click", "#refresh-category", function(e) {
  
	$(".category-div-body").remove();
});


$(document).on("click", "#modal-submit", function(e) {
	
	var formObj = $("form");
	formObj.submit();
});


//???????????? ?????? ?????? 
function checkCategory(category){
	
	var arr_tmp = $(".category-div-body").find(".btn-xs").get();
	var arr = [];
	
	if(arr_tmp.length==3){
		alert("??????????????? ?????? 3???????????? ?????? ???????????????.");
		return false;
	}
	
	for(var i=0; i<arr_tmp.length; i++){
		arr[i]=arr_tmp[i].id;
	}
	
	if(arr.includes(category)){
		return false;
	}else{
		 return true;
	}
	
}


</script>

<%@include file="../includes/footer.jsp"%>
