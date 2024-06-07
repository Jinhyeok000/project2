<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://code.jquery.com/jquery-3.7.1.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<title>Insert title here</title>
<style>
        * {
            box-sizing: border-box;
        }
        
        .container{
        	border: 1px solid black;
        }
        
        .header div {
            font-size: 1.5rem;
            display: flex;
            justify-content: center;
            align-items: center;
            border: 1px solid black;
        }

        .eachRow .seqCol, .titleCol, .genreCol, .dateCol, .btnCol{
            font-size: 1.5rem;
            display: flex;
            justify-content: center;
            align-items: center;
            border: 1px solid black;
        }

        .eachRow .btnCol {
            justify-content: space-evenly
        }

        .eachRow input{
            width:100%;
        }
    </style>
</head>

<body>

    <div class="container">
        <div class="row header">
            <div class="col-2 seqCol">No</div>
            <div class="col-4 titleCol">제목</div>
            <div class="col-2 genreCol">장르</div>
            <div class="col-2 dateCol">개봉일</div>
            <div class="col-2">비고</div>
        </div>
        <div class="row eachRow">
            <div class="col-2 seqCol">1</div>
            <div class="col-4 titleCol">
                <div class="title">범죄도시</div>
                <input type="hidden" class="corTitleInput" placeholder="수정할 제목">
            </div>
            <div class="col-2 genreCol">
                <div class="genre">공포</div>
                <input type="hidden" class="corGenreInput" placeholder="수정할 장르">
            </div>
            <div class="col-2 dateCol">
                <div class="date">2024.06.02</div>
                <input type="hidden" class="corDateInput" placeholder="yyyy.mm.dd">
            </div>
            <div class="col-2 btnCol">
                <button type="button" class="btn btn-outline-success corBtn">수정</button>
                <button type="button" class="btn btn-outline-danger delBtn">삭제</button>
            </div>
        </div>
    </div>

    <script>
        $(".container").on("click", ".delBtn", function () {
            let isDel = confirm("정말 삭제하시겠습니까?");
            if (isDel) {
                $.ajax({
                    url: "/deleteMovie.movies",
                    data: {
                        seq: $(this).closest(".eachRow").find(".seqCol").text()
                    }
                }).done(function () {
                    
                });
            }
            $(this).closest(".eachRow").remove();
        });

        $(".container").on("click", ".corBtn", function () {
            $(this).html("취소");
            $(this).attr("class", "btn btn-outline-secondary corNoBtn");
            $(this).next().html("완료");  
            $(this).next().attr("class", "btn btn-outline-primary corYesBtn");

            $(this).closest(".eachRow").find(".title").css("display", "none");
            $(this).closest(".eachRow").find(".genre").css("display", "none");
            $(this).closest(".eachRow").find(".date").css("display", "none");

            $(this).closest(".eachRow").find(".corTitleInput").attr("type", "text");
            $(this).closest(".eachRow").find(".corGenreInput").attr("type", "text");
            $(this).closest(".eachRow").find(".corDateInput").attr("type", "text");


        });

        $(".container").on("click", ".corNoBtn", function (){
            $(this).closest(".eachRow").find(".corTitleInput").attr("type", "hidden");
            $(this).closest(".eachRow").find(".corGenreInput").attr("type", "hidden");
            $(this).closest(".eachRow").find(".corDateInput").attr("type", "hidden");

            $(this).closest(".eachRow").find(".title").css("display", "block");
            $(this).closest(".eachRow").find(".genre").css("display", "block");
            $(this).closest(".eachRow").find(".date").css("display", "block");

            $(this).html("수정");
            $(this).attr("class", "btn btn-outline-success corBtn");
            $(this).next().html("삭제");  
            $(this).next().attr("class", "btn btn-outline-danger delBtn");
        });

        $(".container").on("click", ".corYesBtn", function (){
            $.ajax({
                    url: "/corMovie.movies",
                    data: {
                        seq: $(this).closest(".eachRow").find(".seqCol").text(),
                        title: $(this).closest(".eachRow").find(".corTitleInput").val(),
                        genre: $(this).closest(".eachRow").find(".corGenreInput").val(),
                        date: $(this).closest(".eachRow").find(".corDateInput").val()
                    }
                }).done(function() {
                    
                });
        });
    </script>
</body>
</html>