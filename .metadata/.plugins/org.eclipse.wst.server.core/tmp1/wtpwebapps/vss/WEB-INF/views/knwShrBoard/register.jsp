<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<%@ taglib uri="http://www.springframework.org/security/tags"
	prefix="sec"%>

<%@include file="../includes/header.jsp"%>

<style>
.uploadResult {
	width: 100%;
	background-color: gray;
}

.uploadResult ul {
	display: flex;
	flex-flow: row;
	justify-content: center;
	align-items: center;
}

.uploadResult ul li {
	list-style: none;
	padding: 10px;
}

.uploadResult ul li img {
	width: 100px;
}

.bigPictureWrapper {
	position: absolute;
	display: none;
	justify-content: center;
	align-items: center;
	top: 0%;
	width: 100%;
	height: 100%;
	background-color: gray;
	z-index: 100;
}

.bigPicture {
	position: relative;
	display: flex;
	justify-content: center;
	align-items: center;
}



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

.reg-category{
	width:300px;
	float:left;
}

.category-select{
	width:150px;
	margin-bottom:10px;
}   

.category-remove{
	color:white;
	font-weight:bold;
}

.category-btn{
	margin-right:5px;
}

.category-div{
	width:1300px;
}

.panel-reg{
	border-color:white;
}
</style>


<div class="row">  
	<div class="col-lg-12">
		<div class="panel panel-default panel-reg">
			<div class="panel-body">
				<label>category</label>
				<form role="form" action="/knwShrBoard/register" method="post">
					<div class="form-group reg-category">
						<div style="float:left;">
	                        <select class="form-control category-select" id="category" name="category" onchange="chageSelect()">
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
                        <div class="category-div" id="category-div">
                        	<div class="category-div-body"></div>
                    	</div>
                    </div>    
					<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" /> 
					<input class="form-control-title2" name='title' placeholder="????????? ??????????????????.">
					<input type="hidden" class="form-control" name='writer' value='<sec:authentication property="principal.username"/>'>
					<div class="row" style="padding-bottom: 30px;"></div>

					<textarea class="summernote" id="summernote" name="content">
					</textarea>
					
					<div class="register-btndiv">
						<button type="submit" class="btn btn-primary"><i class="fa fa-pencil"></i> ??????</button>
						<button type="reset" class="btn btn-warning"><i class="fa fa-pencil"></i> ??????</button>
					</div>
				</form>
			</div>
		</div>
	</div>
</div>
  
   
<div class="row">    
	<div class="col-lg-12">
		<div class="panel panel-default">
			<div class="panel-heading"><i class="fa fa-file-text"> ????????????</i></div>
			<div class="panel-body">
				<div class="form-group uploadDiv">
					<input type="file" name='uploadFile' multiple>
				</div>  
				<div class='uploadResult'>   
					<ul>
					</ul>
				</div>
			</div>
		</div>
	</div>
</div>  

<script>  
 
$(document).ready(function(e){
	
	initFunction();
	
  var formObj = $("form[role='form']");
  
  $("button[type='submit']").on("click", function(e){
    e.preventDefault();
    
    console.log("submit clicked");
    
    var str = "";
    
    $(".uploadResult ul li").each(function(i, obj){
      
      var jobj = $(obj);
      
      console.dir(jobj);
      console.log("-------------------------");
      console.log(jobj.data("filename"));
      
      
      str += "<input type='hidden' name='attachList["+i+"].fileName' value='"+jobj.data("filename")+"'>";
      str += "<input type='hidden' name='attachList["+i+"].uuid' value='"+jobj.data("uuid")+"'>";
      str += "<input type='hidden' name='attachList["+i+"].uploadPath' value='"+jobj.data("path")+"'>";
      str += "<input type='hidden' name='attachList["+i+"].fileType' value='"+ jobj.data("type")+"'>";
      
    });
    
    console.log(str);
    
     var content = $("#summernote").val();
    alert(content); 
    
    formObj.append(str).submit();
    
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
      contentType: false,
      beforeSend: function(xhr) {
          xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
      },
      data:formData,
      type: 'POST',
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

  $(".uploadResult").on("click", "button", function(e){
	    
    console.log("delete file");
      
    var targetFile = $(this).data("file");
    var type = $(this).data("type");
    
    var targetLi = $(this).closest("li");
    
    $.ajax({
      url: '/deleteFile',
      data: {fileName: targetFile, type:type},
      beforeSend: function(xhr) {
          xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
      },

      dataType:'text',
      type: 'POST',
        success: function(result){
           alert(result);
           
           targetLi.remove();
         }
    }); //$.ajax      
   });
  
  $(document).on("click", ".ext-highlight-btn", function(e) {
	  e.preventDefault();
	  $(".close").trigger("click");
  });
  
});

// ???????????? ?????? ?????????
function chageSelect(){  
	   
	var category = $('#category option:selected').val();
	var arr_tmp = $("#category-div").find(".category-btn").get();
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
		
		$('.category-div').append(bodyTag);  
		
		html += '<button type="button" style="margin-right:3px;" class="btn btn-primary btn-xs category-btn" name="'+tag_name+'"id="'+category+'">'+category+'&nbsp';
		html += '</button>';
		html += '<input type="hidden" name="'+tag_name+'"value="'+category+'"';
		html += '</input>';
		
		$('.category-div-body').append(html);  
		
		$("#java").attr("class", "btn btn-primary btn-xs java");
		$("#css").attr("class", "btn btn-info btn-xs css");
		$("#oracle").attr("class", "btn btn-warning btn-xs oracle");
		$("#javaScript").attr("class", "btn btn-danger btn-xs javaScript");
		$("#spring").attr("class", "btn btn-success btn-xs spring");
	}
	
}  

// ???????????? ?????? span ????????? 
$(document).on("click", "#category-remove", function(e) {

    $(this).closest("button").remove();
    
    
});

//???????????? ?????? span ????????? 
$(document).on("click", "#refresh-category", function(e) {
	
	$(".category-div-body").remove();
});


    
// ???????????? ?????? ?????? 
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
  
function initFunction() {    
	$('.summernote').summernote({
		  toolbar: [
			    ['fontname', ['fontname']],
			    ['fontsize', ['fontsize']],
			    ['style', ['bold', 'italic', 'underline','strikethrough', 'clear']],
			    ['color', ['forecolor','color']],
			    ['table', ['table']],
			    ['para', ['ul', 'ol', 'paragraph']],
			    ['height', ['height']],
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
	
} 

</script>


<%@include file="../includes/footer.jsp"%>

