<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security"%>

<h1>
	Hello world!  한글테스트
</h1>

<P>  The time on the server is ${serverTime}. </P>

<security:authorize access="isAuthenticated()">
	<security:authentication property="principal" var="principal"/>
	<h4>인증객체 : ${principal }</h4>
	<h4>인증객체 타입 : ${principal.getClass() }</h4>
</security:authorize>

<c:if test="${not empty sessionScope['authEmp'] }">
	<h4>session scope empNo : ${authEmp['empNo'] }</h4>
</c:if>
