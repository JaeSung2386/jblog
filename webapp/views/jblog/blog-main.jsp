<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!doctype html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>JBlog</title>
<Link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/jblog.css">
</head>
<body>
	<div id="container">
		<c:import url="/views/include/header.jsp"/>
		<div id="wrapper">
			<div id="content">
			<c:if test="${!empty postVo}">
				<div class="blog-content">
					<h4>${postVo.title } </h4>
					<p>
						${fn:replace(postVo.content, newline, "<br>") }
					<p>
				</div>
			</c:if>
			<c:if test ="${empty postVo }">
				<h1>게시글이 존재하지 않습니다. </h1>
			</c:if>
			
			<c:forEach items="${commentlist }" var="vo" >
			<c:if test="${postVo.no eq vo.post_no }">
			<table class="tbl-ex">
				<tr>
					<td>
						${vo.reg_date }
					</td>
					<td>
						<!-- 삭제 미구현 -->
						<a href="">삭제</a>
					</td>
				</tr>
				<tr>
					<td>
						<div class="view-content">${vo.content } </div>
					</td>
				</tr>
			</table>
			</c:if>
			</c:forEach>
			<c:if test="${!empty postVo }">
			<div id="board">
				<form class="board-form" method="post" action="${pageContext.servletContext.contextPath }/${id }/comment/write">
					<input type="hidden" name="post_no" value="${postVo.no }">
					<table class="tbl-ex">
						<tr>
							<td>
								<textarea id="content" name="content" style="width:460px;"></textarea>
							</td>
							<td class ="bottom">
								<input type="submit" value="등록">
							</td>
						</tr>
					</table>
				</form>				
			</div>
			</c:if>
				<ul class="blog-list">
				<c:forEach items="${postlist }" var="vo" >
					<li>
						<a href="${pageContext.servletContext.contextPath }/${id }/${categoryNo }/${vo.no}?page=${pageVo.pageNo}"> ${vo.title } </a> 
						<span>${vo.reg_date }</span>	
					</li>
				</c:forEach>
				</ul>
				<!-- pager 추가 -->
				<div id="pager">
					<ul>
						<c:if test ="${pageVo.pageNo > 5 }">	
							<li><a href="${pageContext.servletContext.contextPath }/${id }/${categoryNo }?page=${pageVo.firstPageNo}">◀◀</a></li>
							<li><a href="${pageContext.servletContext.contextPath }/${id }/${categoryNo }?page=${pageVo.prevPageNo}">◀</a></li>
						</c:if>
							<c:forEach var="i" begin="${pageVo.startPageNo }" end="${pageVo.endPageNo }" step="1">
								<c:if test="${i ne 0 }">
									<c:choose>
										<c:when test="${i eq pageVo.pageNo }">
											<li class="selected"><a href="${pageContext.servletContext.contextPath }/${id }/${categoryNo }?page=${i}">${i}</a></li>
										</c:when>
										<c:otherwise>
											<li><a href="${pageContext.servletContext.contextPath }/${id }/${categoryNo }?page=${i}">${i}</a></li>
										</c:otherwise>
									</c:choose>
								</c:if>
							</c:forEach>
						<c:if test ="${pageVo.pageNo > 5 }">		
							<li><a href="${pageContext.servletContext.contextPath }/${id }/${categoryNo }?page=${pageVo.nextPageNo}">▶</a></li>
							<li><a href="${pageContext.servletContext.contextPath }/${id }/${categoryNo }?page=${pageVo.finalPageNo}">▶▶</a></li>
						</c:if>
					</ul>
				</div>
			</div>
		</div>
		
		<div id="extra">
			<div class="blog-logo">
				<img onerror="this.src='${pageContext.request.contextPath}/assets/images/spring-logo.jpg'" src="${pageContext.request.contextPath }${blogVo.logo }">
			</div>
		</div>

		<div id="navigation">
			<h2>카테고리</h2>
			<ul>
			<c:forEach items="${categorylist }" var="categoryVo">
				<li><a href="${pageContext.servletContext.contextPath }/${id }/${categoryVo.no}">${categoryVo.name }</a></li>
			</c:forEach>
			</ul>
		</div>
		<c:import url="/views/include/footer.jsp"/>
	</div>
</body>
</html>