<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.7.1.js"></script>
    <style>
        div {
            border: 1px solid black;
        }

        .container {
            width: 400px;
            height: 100px;
            display: flex;
            flex-direction: column;
            margin: auto;
        }

        .title {
            flex: 1;
            display: flex;
            justify-content: center;
        }

        .contents {
            flex: 4;
            display: flex;
        }

        .input,
        .output {
            flex: 1;
            display: flex;
            justify-content: center;
            align-items: center;
        }

    </style>
</head>
<body>
	<script>
		function movePath(path){
			location.href=path;
		}
	</script>
	    	<div class="container">
        		<div class="title">Index</div>
        		<div class="contents">
            		<div class="input"><button onclick="movePath('/inputform.jsp')">toInput</button></div>
            		<div class="output"><button onclick="movePath('/output.jsp')">toOutput</button></div>
        		</div>
    		</div>
</body>
</html>