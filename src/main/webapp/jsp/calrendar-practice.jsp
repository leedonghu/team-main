<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="pr" tagdir="/WEB-INF/tags" %>

<% request.setCharacterEncoding("utf-8"); %>

<!DOCTYPE html>
<html>
<head>

<%@ include file="/WEB-INF/subModules/bootstrapHeader.jsp" %>

<title>Insert title here</title>
</head>
<body>
<div class="container">
	
	
	<div class="main">
    <div class="content-wrap">
      <div class="content-left">
        <div class="main-wrap">
          <div id="main-day" class="main-day"></div>
          <div id="main-date" class="main-date"></div>
        </div>
        <div class="todo-wrap">
          <div class="todo-title">Todo List</div>
          <div class="input-wrap">
            <input type="text" placeholder="please write here!!" id="input-box" class="input-box">
            <button type="button" id="input-data" class="input-data">INPUT</button>
            <div id="input-list" class="input-list"></div>
          </div>
        </div>
      </div>
      <div class="content-right">
        <table id="calendar" align="center">
          <thead>
            <tr class="btn-wrap clearfix">
              <td>
                <label id="prev">
                    &#60;
                </label>
              </td>
              <td align="center" id="current-year-month" colspan="5"></td>
              <td>
                <label id="next">
                    &#62;
                </label>
              </td>
            </tr>
            <tr>
                <td class = "sun" align="center">Sun</td>
                <td align="center">Mon</td>
                <td align="center">Tue</td>
                <td align="center">Wed</td>
                <td align="center">Thu</td>
                <td align="center">Fri</td>
                <td class= "sat" align="center">Sat</td>
              </tr>
          </thead>
          <tbody id="calendar-body" class="calendar-body"></tbody>
        </table>
      </div>
    </div>
  </div>
	
	
</div>


<!-- 스크립트 코드 -->

<script>
var calrendarTitle = $("#current-year-month");
var calrendarBody = $("#calendar-body");
var today = new Date();
//오늘기준 현재 월의 첫날을 나타내는 변수
var firstDay = new Date(today.getFullYear(), today.getMonth(), 1);
var dayList = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"];
var monthList = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
var leapYear = [31, 29, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
var notLeapYear = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
var pageFirst = firstDay;
var pageYear;

if(firstDay.getFullYear() % 4 === 0){
	//윤년일 때
	pageYear = leapYear;
}else{
	//윤년이 아닐때
	pageYear = notLeapYear;
}

function showCalrendar(){
	//각 주와 일에 해당하는 element에 id를 부여하기 위한 변수
	var weekId = 100;
	var dayId = 1;
	
	for(var i = 0; i < 6; i++){
		//주는 최대 6주이기 때문에 6번 반복
		//주에 해당하는 tr을 만들고 id부여
		var weekTr = document.createElement('tr');
		weekTr.setAttribute("id", weekId);
		
		for(var j = 0; j < 7; j++){
			//한주에 7일이기 때문에 7번 반복
			if((i === 0 && j < firstDay.getDay()) || dayId > pageYear[firstDay.getMonth()]){
				var dayTd = document.createElement('td');
				weekTr.append(dayTd);
			}else{
				var dayTd = document.createElement('td');
				dayTd.textContent = dayId;
				dayTd.setAttribute("id", dayId);
				weekTr.append(dayTd);
				dayId++;
			}
		}
		weekId++;
		calrendarBody.append(weekTr);
	}
	calrendarTitle.html(monthList[firstDay.getMonth()] + "&nbsp;&nbsp;&nbsp;&nbsp;" + firstDay.getFullYear());
}

showCalrendar();
showMain();

function removeCalrendar(){
	//6주에 해당하는 tr들 삭제
	var getTr = 100;
	for(var i =100; i<106; i++){
		$("#" + getTr).remove();
		getTr++;
	}
}


function prev(){
	//오늘기준 1월이면 prev를 눌렀을때 이전 년도로 넘어가야 함
	if(firstDay.getMonth() === 0){
		firstDay = new Date(firstDay.getFullYear()-1, 12, 1);
			
		if(firstDay.getFullYear() % 4 === 0){
			pageYear = leapYear;
		}else{
			pageYear = notLeapYear;
		}
	}else{
		//오늘기준 1월이 아니면 월에서 -1을 해줌
		firstDay = new Date(firstDay.getFullYear(), firstDay.getMonth()-1, 1);
	}
		
	today = new Date(today.getFullYear(), today.getMonth()-1, today.getDate());
	calrendarTitle.html(monthList[firstDay.getMonth()] + "&nbsp;&nbsp;&nbsp;&nbsp;" + firstDay.getFullYear());
	
	removeCalrendar();
	
	showCalrendar();
	showMain();
}

//prev 클릭하면 prev함수 작동
var prevBtn = $("#prev");
prevBtn[0].addEventListener("click", prev);

function next(){
	//오늘기준 12월이면 next 눌렀을때 다음 년도로 넘어가야함
	if(firstDay.getMonth() === 11){
		firstDay = new Date(firstDay.getFullYear()+1, 1, 1);
		
		if(firstDay.getFullYear() % 4 === 0){
			pageYear = leapYear;
		}else{
			pageYear = notLeapYear;
		}
	}else{
		//오늘기준 12월이 아니면 월에 +1을 해줌
		firstDay = new Date(firstDay.getFullYear(), firstDay.getMonth()+1, 1);
	}
	
	today = new Date(today.getFullYear(), today.getMonth()+1, today.getDate());
	calrendarTitle.html(monthList[firstDay.getMonth()] + "&nbsp;&nbsp;&nbsp;&nbsp;" + firstDay.getFullYear());
	
	removeCalrendar();
	
	showCalrendar();
	showMain();
}

//next 클릭하면 next함수 작동
var nextBtn = $("#next");
nextBtn[0].addEventListener("click", next);

//왼쪽에 뜨는 화면
//함수안에 아래 변수를 넣어주지 않으면 오류발생
//위에서 함수가 실행될 때 변수가 없어서 html()메소드 실행 불가
//var mainDay = $("#main-day");
//var mainDate = $("#main-date");

function showMain(){
	var mainDay = $("#main-day");
	var mainDate = $("#main-date");
	
	mainDay.html(dayList[today.getDay()]);
	mainDate.html(today.getDate());

}

//날짜를 클릭했을때
/*
var dayTd = document.getElementById(today.getDate());
dayTd.addEventListener("click", clickDayTd);

function clickDayTd(){
	console.log("click");
	dayTd.classList.add("active");
	today = new Date(today.getFullYear(), today.getMonth(), dayTd[0].id);
	showMain();
}
*/











</script>
</body>
</html>