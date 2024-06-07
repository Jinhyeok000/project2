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
        
        #movieContainer{
        	border-top : 0;
        }
        
        #btnContainer{
        	margin-top : 10px;
        	border : 0;
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
            justify-content: space-evenly;
            padding : 5px;
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
    </div>
    <div class="container" id="movieContainer">
    	
    </div>
    <div class="container" id="btnContainer">
    	<button type="button" id="back" class="btn btn-outline-dark">돌아가기</button>
    </div>

    <script>
    	$("#back").on("click", function(){
    		location.href = "/index.jsp"
    	});
    
	    function getReples(){
			$.ajax({
				url : "/output.movies",
				dataType:"json",
			}).done(function(resp){
				if(resp.length != 0){
					function formatDate(timestamp) {
		                let date = new Date(timestamp);
		                let year = date.getFullYear().toString().slice(2);
		                let month = ('0' + (date.getMonth() + 1)).slice(-2);
		                let day = ('0' + date.getDate()).slice(-2);
		                return year + "." + month + "." + day;
		            }
			
			$("#movieContainer").html("");
			resp.forEach(function(dto) {
				let formattedDate = formatDate(dto.open_date);
			                
				let rowDiv = document.createElement('div');
	            rowDiv.classList.add('row', 'eachRow');

	            let seqColDiv = document.createElement('div');
	            seqColDiv.classList.add('col-2', 'seqCol');
	            seqColDiv.textContent = dto.seq;

	            let titleColDiv = document.createElement('div');
	            titleColDiv.classList.add('col-4', 'titleCol');

	            let titleDiv = document.createElement('div');
	            titleDiv.classList.add('title');
	            titleDiv.textContent = dto.title;

	            let titleInput = document.createElement('input');
	            titleInput.type = 'hidden';
	            titleInput.classList.add('corTitleInput');
	            titleInput.placeholder = '수정할 제목';

	            let genreColDiv = document.createElement('div');
	            genreColDiv.classList.add('col-2', 'genreCol');

	            let genreDiv = document.createElement('div');
	            genreDiv.classList.add('genre');
	            genreDiv.textContent = dto.genre;

	            let genreInput = document.createElement('input');
	            genreInput.type = 'hidden';
	            genreInput.classList.add('corGenreInput');
	            genreInput.placeholder = '수정할 장르';

	            let dateColDiv = document.createElement('div');
	            dateColDiv.classList.add('col-2', 'dateCol');

	            let dateDiv = document.createElement('div');
	            dateDiv.classList.add('date');
	            dateDiv.textContent = formattedDate;

	            let dateInput = document.createElement('input');
	            dateInput.type = 'hidden';
	            dateInput.classList.add('corDateInput');
	            dateInput.placeholder = 'yyyy.mm.dd';

	            let btnColDiv = document.createElement('div');
	            btnColDiv.classList.add('col-2', 'btnCol');

	            let editButton = document.createElement('button');
	            editButton.type = 'button';
	            editButton.classList.add('btn', 'btn-outline-success', 'corBtn');
	            editButton.textContent = '수정';

	            let deleteButton = document.createElement('button');
	            deleteButton.type = 'button';
	            deleteButton.classList.add('btn', 'btn-outline-danger', 'delBtn');
	            deleteButton.textContent = '삭제';

	            titleColDiv.append(titleDiv, titleInput);
	            genreColDiv.append(genreDiv, genreInput);
	            dateColDiv.append(dateDiv, dateInput);
	            btnColDiv.append(editButton, deleteButton);

	            rowDiv.append(seqColDiv, titleColDiv, genreColDiv, dateColDiv, btnColDiv);

	            $("#movieContainer").append(rowDiv);
				 });
				}
			});
		}
	    
	    $(getReples());
    
        $(".container").on("click", ".delBtn", function () {
            let isDel = confirm("정말 삭제하시겠습니까?");
            if (isDel) {
                $.ajax({
                    url: "/delete.movies",
                    data: {
                        seq: $(this).closest(".eachRow").find(".seqCol").text()
                    }
                });
            }else{
            	return;
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
                    url: "/update.movies",
                    data: {
                        seq: $(this).closest(".eachRow").find(".seqCol").text(),
                        title: $(this).closest(".eachRow").find(".corTitleInput").val(),
                        genre: $(this).closest(".eachRow").find(".corGenreInput").val(),
                        date: $(this).closest(".eachRow").find(".corDateInput").val()
                    }
                }).done(function() {
                	$("#movieContainer").html();
                	getReples();
                });
        });
    </script>
</body>
</html>