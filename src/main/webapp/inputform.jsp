<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

   <style>
        div {
            border: 1px solid black;
        }

        .container {
            width: 170px;
            height: 100px;
        }

        .container button {
            width: 170px;
        }
    </style>
<script src="https://code.jquery.com/jquery-3.7.1.js"></script>
</head>
<body>
	<form action="input.movie" method="post">
	    <div class="container">
        <input type="text" placeholder="영화제목" name="title"><br>
        <input type="text" placeholder="장르" name="genre"><br>
        <button>제출</button>
    </div>
	</form>
</body>
</html>