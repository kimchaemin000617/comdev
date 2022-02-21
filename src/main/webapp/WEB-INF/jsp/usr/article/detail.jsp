<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8" %> <%@ tagliburi="http://java.sun.com/jsp/jstl/core"
prefix="c"%>
<c:set var="pageTitle" value="게시물 상세페이지" />

<%@ include file="../common/head.jsp" %>
<c:choose>
    <c:when test="${empty article}">
        <span> 게시물이 존재하지 않습니다. </span>
    </c:when>
    <c:otherwise>
        <div class="overflow-y-auto">
            <table class="table w-full border border_table">
                <colgroup>
                    <col width="200" />
                </colgroup> 
                <tbody>
                    <tr>
                        <th>게시물 번호</th>
                        <td>${article.id}</td>
                    </tr>
                    <tr>
                        <th>작성날짜</th>
                        <td>${article.regDate.substring(0, 16)}</td>
                    </tr>
                    <tr>
                        <th>게시물 수정날짜</th>
                        <td>${article.updateDate.substring(0, 16)}</td>
                    </tr>
                    <tr>
                        <th>게시물 작성자</th>
                        <td>${article.memberId}</td>
                    </tr>
                    <tr>
                        <th>게시물 제목</th>
                        <td>${article.title}</td>
                    </tr>
                    <tr>
                        <th>게시물 내용</th>
                        <td>${article.body}</td>
                    </tr>
                </tbody>
            </table>
        </div>
    </c:otherwise>
</c:choose>
<div class="relative">
    <button class="btn mt-3 absolute right-0" onclick="history.back();">뒤로가기</button>
</div>

<%@ include file="../common/foot.jsp" %>
