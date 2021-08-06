<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="pr" tagdir="/WEB-INF/tags" %>

<% request.setCharacterEncoding("utf-8"); %>

<!DOCTYPE html>
<html>
<head>

<%@ include file="/WEB-INF/subModules/bootstrapHeader.jsp" %>
    <link href='${appRoot }/resources/calrendar/fullcalendar-5.9.0/lib/main.css' rel='stylesheet' />
    <script src='${appRoot }/resources/calrendar/fullcalendar-5.9.0/lib/main.js'></script>
<title>Insert title here</title>
</head>
<body>
<div class="container">
	<div id='calendar'></div>
</div>


<script>

   document.addEventListener('DOMContentLoaded', function() {
     var calendarEl = document.getElementById('calendar');
     var calendar = new FullCalendar.Calendar(calendarEl, {
       initialView: 'dayGridMonth'
     });
     calendar.render();
   });

 </script>
</body>
</html>