
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<%@include file="../includes/header.jsp"%>

<style>
.category-btn-list{
	float:left;   
	margin-right:3px;
}    
.list-criteria{
	
	float:right;
	margin-top:12px;
	margin-right:14px;
	font-size:12px;
	color:gray;
}
.list-criteria a {
	float:right;
	margin-left:7px;
	color:gray;
	font-weight:bold;
	text-decoration:none;
	cursor:pointer;
}
.title {
	font-size: 40px;
	float: left;
	font-weight:bold;
}

.subtitle{
	padding-top: 10px;
	padding-left: 5px;
	font-size: 17px;
	font-weight: bold;
}

.subtitle2{
	font-size: 15px;
	color:gray;
	padding-left: 5px;
}

.sortCls{
	font-family: 'Nanum Gothic', sans-serif;
	font-weight: 100;
}

.boardlist-Font2{
	font-family: 'Nanum Gothic', sans-serif;
	font-weight: 100;
	font-size : 12px;
	color:gray;
}

</style>     
   
<div class="row">
	<div class="col-lg-12">
		<div class="page-header title">Code Library
			<c:if test="${pageMaker.cri.libCls != null && !pageMaker.cri.libCls.equals('')}">
				- <c:out value="${pageMaker.cri.libCls}"/>
			</c:if>
			<div class="subtitle"> 기능 단위 코드를 공유하는 곳입니다.</div>
			<div class="subtitle2"> 함수 또는 기능단위 스크립트를 작성해주세요 :)</div>
		</div>
	</div>
</div>

<div class="row">
	<div class="list-criteria">
		<a class="sortCls" data-value="likes">추천순</a>
		<a class="sortCls" data-value="views">조회순</a>
		<a class="sortCls" data-value="regdate">최신순</a>
	</div>
</div>

<div class="row">
	<div class="col-xs-12">   
		<table class="table table-hover table-boardlist table-list">
		  <thead>
		  	<th style="width:23%"></th>
		  	<th style="width:37%"></th>
		  	<th style="width:5%"></th>
		  	<th style="width:5%"></th>
		  	<th style="width:15%"></th>
		  	<th style="width:20%"></th>
		  </thead>
          <c:forEach items="${list}" var="board">
            <tr>
              <td>
	              <div class="board_bno">#<c:out value="${board.bno}"/></div>
	              <c:if test="${board.category1 != null}">
					<button type="button" class="btn btn-primary btn-xs category-btn-list <c:out value="${board.category1}"/>" 
						id='<c:out value="${board.category1}"/>'>${board.category1}
					</button>
				</c:if>    
				<c:if test="${board.category2 != null}" >
					<button type="button" class="btn btn-primary btn-xs category-btn-list <c:out value="${board.category2}"/>" 
						id='<c:out value="${board.category2}"/>'>${board.category2}
					</button>
				</c:if>
				<c:if test="${board.category3 != null}">
					<button type="button" class="btn btn-primary btn-xs category-btn-list <c:out value="${board.category3}"/>" 
						id='<c:out value="${board.category3}"/>'>${board.category3}
					</button>
				</c:if>
              </td>
              <td style="text-align:left">
			      <a class='move' href='<c:out value="${board.bno}"/>'>
				  <c:out value="${board.title}"/><b> <i class="fa fa-comment"> </i> <c:out value="${board.replyCnt}"/> </b>
				  </a>
              </td>
              <td><i class="fa fa-thumbs-up"></i> <c:out value="${board.likes}" /></td>
              <td><i class="fa fa-eye"></i> <c:out value="${board.views}" /></td>
              <td class="boardlist-Font"><c:out value="${board.writer}" /></td>
              <td class="boardlist-Font2"><fmt:formatDate pattern="yyyy-MM-dd hh:mm:ss" value="${board.regdate}"/></td>
            </tr>
          </c:forEach>
		</table>

		<div class='row'>
			<div class="col-lg-12">
				<div class="col-xs-6 text-left search">
					<form id='searchForm' action="/board/list" method='get'>
						<div class="form-group input-group" style="width:40%">
							 <select class="form-control" name="type" >
								  <option value=""
								  <c:out value="${pageMaker.cri.type == null?'selected':'' }"/>>- 선택 -</option>
								  <option value="T"
									  <c:out value="${pageMaker.cri.type eq 'T'?'selected':'' }"/>>제목</option>
								  <option value="C"
									  <c:out value="${pageMaker.cri.type eq 'C'?'selected':'' }"/>>내용</option>
								  <option value="W"
									  <c:out value="${pageMaker.cri.type eq 'W'?'selected':'' }"/>>작성자</option>
								  <option value="TC"
									  <c:out value="${pageMaker.cri.type eq 'TC'?'selected':'' }"/>>제목or내용</option>
								  <option value="TW"
									  <c:out value="${pageMaker.cri.type eq 'TW'?'selected':'' }"/>>제목or작성자</option>
								  <option value="TWC"
									  <c:out value="${pageMaker.cri.type eq 'TCW'?'selected':'' }"/>>제목or내용or작성자</option>
							 </select>	
							 <span class="input-group-btn" style="width:60%">		
		                         <input class="form-control" type='text' name='keyword' value='<c:out value="${pageMaker.cri.keyword}"/>' /> 
		                         <input type='hidden' name='pageNum' value='<c:out value="${pageMaker.cri.pageNum}"/>' /> 
		                         <input type='hidden' name='amount' value='<c:out value="${pageMaker.cri.amount}"/>' />
								 <button class='btn btn-default' style="height:34px"><i class="fa fa-search"></i></button>
							 </span>
			            </div>
					</form>
				</div>
				<div class="col-xs-6 text-right">
					<button class='btn btn-default' id="regBtn" style="height:34px"><i class="fa fa-pencil"></i> 등록</button>
				</div>
			</div>
		</div>

		<div class="row">
			<div class="col-lg-12" style="text-align:center">
				<ul class="pagination">
					<c:if test="${pageMaker.prev}">
						<li class="paginate_button previous"><a href="${pageMaker.startPage -1}">Previous</a></li>
					</c:if>
					<c:forEach var="num" begin="${pageMaker.startPage}"
						end="${pageMaker.endPage}">
						<li class="paginate_button  ${pageMaker.cri.pageNum == num ? "active":""} ">
							<a href="${num}">${num}</a>
						</li>
					</c:forEach>
					<c:if test="${pageMaker.next}">
						<li class="paginate_button next"><a
							href="${pageMaker.endPage +1 }">Next</a></li>
					</c:if>
				</ul>
			</div>
		</div>
		
		<form id='actionForm' action="/board/list" method='get'>
			<input type='hidden' name='pageNum' value='${pageMaker.cri.pageNum}'>
			<input type='hidden' name='amount' value='${pageMaker.cri.amount}'>

			<input type='hidden' name='type' value='<c:out value="${ pageMaker.cri.type }"/>'> 
			<input type='hidden' name='keyword' value='<c:out value="${ pageMaker.cri.keyword }"/>'>
			<input type='hidden' name='libCls' value='<c:out value="${ pageMaker.cri.libCls }"/>'>
			<input type='hidden' name='sortCls' value='<c:out value="${ pageMaker.cri.sortCls }"/>'>
		</form>

		<div class="modal fade" id="myModal" tabindex="-1" role="dialog"
			aria-labelledby="myModalLabel" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal"
							aria-hidden="true">&times;</button>
						<h4 class="modal-title" id="myModalLabel">알림</h4>
					</div>
					<div class="modal-body">처리가 완료되었습니다.</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-primary" data-dismiss="modal">닫기</button>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>

<script type="text/javascript">
	$(document).ready(function() {

		var result = '<c:out value="${result}"/>';
		checkModal(result);
		history.replaceState({}, null, null);

		
		function checkModal(result) {
			if (result === '' || history.state) {
				return;
			}
			if (parseInt(result) > 0) {
				$(".modal-body").html("게시글 " + parseInt(result)+" 번이 등록되었습니다.");
			}

			$("#myModal").modal("show");
		}

		$("#regBtn").on("click", function() {
			self.location = "/board/register";
		});

		var actionForm = $("#actionForm");

		$(".paginate_button a").on("click",function(e) {

			e.preventDefault();
			console.log('click');
			actionForm.find("input[name='pageNum']").val($(this).attr("href"));
			actionForm.submit();
		});

		$(".move").on("click",function(e) {
			e.preventDefault();
			actionForm.append("<input type='hidden' name='bno' value='"+ $(this).attr("href")+ "'>");
			actionForm.attr("action","/board/get");
			actionForm.submit();
		});

		var searchForm = $("#searchForm");

		$("#searchForm button").on("click",function(e) {
			if (!searchForm.find("option:selected").val()) {
				alert("검색종류를 선택하세요");
				return false;
			}
			
			if (!searchForm.find("input[name='keyword']").val()) {
				alert("키워드를 입력하세요");
				return false;
			}
			
			searchForm.find("input[name='pageNum']").val("1");
			e.preventDefault();
			searchForm.submit();
		});
		
		$(".btn-xs").on("click", function(e) {
			
			var actionForm = $("#actionForm");
			var libCls = $(this).attr("id");
			var href = ""; 
			href += "/board/list.do?libCls="+libCls;
			actionForm.attr("action", href);
			actionForm.find("input[name='libCls']").attr("value", libCls);
			actionForm.submit();
		});
		
		$(".sortCls").on("click", function(){
			
			var actionForm = $("#actionForm");
			var sortCls = $(this).attr("data-value");
			actionForm.find("input[name='sortCls']").attr("value", sortCls);
			actionForm.submit();
		});
	});
	
</script>

<%@include file="../includes/footer.jsp"%>
