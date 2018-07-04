//	written	by Tan Ling	Wee	on 2 Dec 2001
//	last updated 20 Jun 2003
//	email :	fuushikaden@yahoo.com
//	website : www.pengz.com

var fixedX = -1 // x position (-1 if to appear below control)
var fixedY = -1 // y position (-1 if to appear below control)
var startAt = 0 // 0 - sunday ; 1 - mondayF
var showWeekNumber = 0	// 0 - don't show; 1 - show
var showToday = 0		// 0 - don't show; 1 - show
var imgDir = "/img/"	  // directory for images ... e.g. var imgDir="/img/"

var gotoString = "Go To Current Month"
var todayString = ""
var weekString = "Wk"
var scrollLeftMessage = "上一個月"
var scrollRightMessage = "下一個月"
var selectMonthMessage = "選擇月份"
var selectYearMessage = "選擇年份"
var selectDateMessage = "" // do not replace [date], it will be replaced by date.

var crossobj, crossMonthObj, crossYearObj, monthSelected, yearSelected, dateSelected, omonthSelected, oyearSelected, odateSelected, monthConstructed, yearConstructed, intervalID1, intervalID2, timeoutID1, timeoutID2, ctlToPlaceValue, ctlNow, dateFormat, nStartingYear

var bPageLoaded = false
var ie = document.all
var dom = document.getElementById

var ns4 = document.layers
var today = new Date()
var dateNow = today.getDate()
var monthNow = today.getMonth()
var yearNow = today.getFullYear()
var imgsrc = new Array("drop1.gif", "drop2.gif", "left1.gif", "left2.gif", "right1.gif", "right2.gif")
var img = new Array()

var bShow = false;
var bNeedShowElement = true;

/* hides <select> and <applet> objects (for IE only) */
function dateAddSeperator(aObject) {
    var aValue = trim(aObject.value);
    var len = aValue.length;
    var aYear, aMonth, aDay;

    if ((len != 0) && (aValue.indexOf("/") == -1)) {
        aDay = aValue.substr(len - 2, 2);
        aMonth = aValue.substr(len - 4, 2);
        aYear = aValue.substr(0, len - 4);
        aValue = aYear + "/" + aMonth + "/" + aDay;
        aObject.value = aValue;
    }

}

function timeAddSeperator(aObject) {
    var aValue = trim(aObject.value);
    var len = aValue.length;
    var aHour, aMinute, aSecond;

    if ((len != 0) && (aValue.indexOf(":") == -1)) {
        aHour = aValue.substr(0, 2);
        aMinute = aValue.substr(2, 2);
        aSecond = aValue.substr(4, 2);
        if (aSecond == "") aSecond = "00";
        aValue = aHour + ":" + aMinute + ":" + aSecond;
        aObject.value = aValue;
    }

}

function hideElement(elmID, overDiv) {
    if (ie) {
        for (i = 0; i < document.all.tags(elmID).length; i++) {
            obj = document.all.tags(elmID)[i];
            if (!obj || !obj.offsetParent) {
                continue;
            }

            // Find the element's offsetTop and offsetLeft relative to the BODY tag.
            objLeft = obj.offsetLeft;
            objTop = obj.offsetTop;
            objParent = obj.offsetParent;

            // Modify by Bohao
            do {
                if (null != objParent) {
                    if (objParent != document.body) {
                        objLeft += objParent.offsetLeft;
                        objTop += objParent.offsetTop;
                        objParent = objParent.offsetParent;
                    }
                }
                else {
                    break;
                }
            } while (objParent != document.body);
            //            while (objParent.tagName.toUpperCase() != "BODY") {
            //                objLeft += objParent.offsetLeft;
            //                objTop += objParent.offsetTop;
            //                objParent = objParent.offsetParent;
            //            }

            objHeight = obj.offsetHeight;
            objWidth = obj.offsetWidth;

            if ((overDiv.offsetLeft + overDiv.offsetWidth) <= objLeft);
            else if ((overDiv.offsetTop + overDiv.offsetHeight) <= objTop);
            /* CHANGE by Charlie Roche for nested TDs*/
            else if (overDiv.offsetTop >= (objTop + objHeight + obj.height));
            /* END CHANGE */
            else if (overDiv.offsetLeft >= (objLeft + objWidth));
            else {
                obj.style.visibility = "hidden";
            }
        }
    }
}

/*
* unhides <select> and <applet> objects (for IE only)
*/
function showElement(elmID) {
    if (ie) {
        for (i = 0; i < document.all.tags(elmID).length; i++) {
            obj = document.all.tags(elmID)[i];

            if (!obj || !obj.offsetParent) {
                continue;
            }

            obj.style.visibility = "";
        }
    }
}

function HolidayRec(d, m, y, desc) {
    this.d = d
    this.m = m
    this.y = y
    this.desc = desc
}

var HolidaysCounter = 0
var Holidays = new Array()

function addHoliday(d, m, y, desc) {
    Holidays[HolidaysCounter++] = new HolidayRec(d, m, y, desc)
}


if (dom) {
    for (i = 0; i < imgsrc.length; i++) {
        img[i] = new Image
        img[i].src = imgDir + imgsrc[i]
    }
    document.write("<div onclick='bShow=true' id='calendar'	class='div-style'><table width=" + ((showWeekNumber == 1) ? 250 : 220) + " class='table-style'><tr class='title-background-style' ><td><table width='" + ((showWeekNumber == 1) ? 248 : 218) + "'><tr><td class='title-style'><B><span id='caption'></span></B></td><td align=right><a href='javascript:hideCalendar()'><IMG SRC='" + imgDir + "close.gif' WIDTH='15' HEIGHT='13' BORDER='0' ALT='Close the Calendar'></a></td></tr></table></td></tr><tr><td class='body-style'><span id='content'></span></td></tr>")

    if (showToday == 1) {
        document.write("<tr class='today-style'><td><span id='lblToday'></span></td></tr>")
    }

    document.write("</table></div><div id='selectMonth' class='div-style'></div><div id='selectYear' class='div-style'></div>");
}

var monthName = new Array("1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12")
var monthName2 = new Array("一", "二", "三", "四", "五", "六", "七", "八", "九", "十", "十一", "十二")

if (startAt == 0) {
    dayName = new Array("日", "一", "二", "三", "四", "五", "六")
}
else {
    dayName = new Array("一", "二", "三", "四", "五", "六", "日")
}

function swapImage(srcImg, destImg) {
    if (ie) { document.getElementById(srcImg).setAttribute("src", imgDir + destImg) }
}

function init() {
    if (!ns4) {
        //if (!ie) { yearNow += 1900 }

        crossobj = (dom) ? document.getElementById("calendar").style : ie ? document.all.calendar : document.calendar
        hideCalendar()

        crossMonthObj = (dom) ? document.getElementById("selectMonth").style : ie ? document.all.selectMonth : document.selectMonth

        crossYearObj = (dom) ? document.getElementById("selectYear").style : ie ? document.all.selectYear : document.selectYear

        monthConstructed = false;
        yearConstructed = false;

        if (showToday == 1) {
            document.getElementById("lblToday").innerHTML = todayString + " <a class='today-style' onmousemove='window.status=\"" + gotoString + "\"' onmouseout='window.status=\"\"' title='" + gotoString + "' href='javascript:monthSelected=monthNow;yearSelected=yearNow;constructCalendar();'>" + dayName[(today.getDay() - startAt == -1) ? 6 : (today.getDay() - startAt)] + ", " + dateNow + " " + monthName[monthNow].substring(0, 3) + "	" + yearNow + "</a>"
        }

        sHTML1 = "<span id='spanLeft'  class='title-control-normal-style' onmouseover='swapImage(\"changeLeft\",\"left2.gif\");this.className=\"title-control-select-style\";window.status=\"" + scrollLeftMessage + "\"' onclick='javascript:decMonth()' onmouseout='clearInterval(intervalID1);swapImage(\"changeLeft\",\"left1.gif\");this.className=\"title-control-normal-style\";window.status=\"\"' onmousedown='clearTimeout(timeoutID1);timeoutID1=setTimeout(\"StartDecMonth()\",500)'	onmouseup='clearTimeout(timeoutID1);clearInterval(intervalID1)'>&nbsp<IMG id='changeLeft' SRC='" + imgDir + "left1.gif' width=10 height=11 BORDER=0>&nbsp</span>&nbsp;"
        sHTML1 += "<span id='spanRight' class='title-control-normal-style' onmouseover='swapImage(\"changeRight\",\"right2.gif\");this.className=\"title-control-select-style\";window.status=\"" + scrollRightMessage + "\"' onmouseout='clearInterval(intervalID1);swapImage(\"changeRight\",\"right1.gif\");this.className=\"title-control-normal-style\";window.status=\"\"' onclick='incMonth()' onmousedown='clearTimeout(timeoutID1);timeoutID1=setTimeout(\"StartIncMonth()\",500)'	onmouseup='clearTimeout(timeoutID1);clearInterval(intervalID1)'>&nbsp<IMG id='changeRight' SRC='" + imgDir + "right1.gif'	width=10 height=11 BORDER=0>&nbsp</span>&nbsp"
        sHTML1 += "<span id='spanMonth' class='title-control-normal-style' onmouseover='swapImage(\"changeMonth\",\"drop2.gif\");this.className=\"title-control-select-style\";window.status=\"" + selectMonthMessage + "\"' onmouseout='swapImage(\"changeMonth\",\"drop1.gif\");this.className=\"title-control-normal-style\";window.status=\"\"' onclick='popUpMonth()'></span>&nbsp;"
        sHTML1 += "<span id='spanYear'  class='title-control-normal-style' onmouseover='swapImage(\"changeYear\",\"drop2.gif\");this.className=\"title-control-select-style\";window.status=\"" + selectYearMessage + "\"'	onmouseout='swapImage(\"changeYear\",\"drop1.gif\");this.className=\"title-control-normal-style\";window.status=\"\"'	onclick='popUpYear()'></span>&nbsp;"

        document.getElementById("caption").innerHTML = sHTML1

        bPageLoaded = true
    }
}

function hideCalendar() {
    crossobj.visibility = "hidden"
    if (crossMonthObj != null) { crossMonthObj.visibility = "hidden" }
    if (crossYearObj != null) { crossYearObj.visibility = "hidden" }

    if (bNeedShowElement) {
        showElement('SELECT');
        showElement('APPLET');
    }
}

function padZero(num) {
    return (num < 10) ? '0' + num : num;
}

function constructDate(d, m, y) {
    sTmp = dateFormat
    sTmp = sTmp.replace("dd", "<e>")
    sTmp = sTmp.replace("d", "<d>")
    sTmp = sTmp.replace("<e>", padZero(d))
    sTmp = sTmp.replace("<d>", d)
    sTmp = sTmp.replace("mmm", "<o>")
    sTmp = sTmp.replace("mm", "<n>")
    sTmp = sTmp.replace("m", "<m>")
    sTmp = sTmp.replace("<m>", m + 1)
    sTmp = sTmp.replace("<n>", padZero(m + 1))
    sTmp = sTmp.replace("<o>", monthName2[m])
    //sTmp = sTmp.replace("yyyy", y - 1911)
    sTmp = sTmp.replace("yyyy", y)
    return sTmp.replace("yy", padZero(y % 100))
}

function closeCalendar() {
    var sTmp

    hideCalendar();
    ctlToPlaceValue.value = constructDate(dateSelected, monthSelected, yearSelected)
}

/*** Month Pulldown	***/

function StartDecMonth() {
    intervalID1 = setInterval("decMonth()", 80)
}

function StartIncMonth() {
    intervalID1 = setInterval("incMonth()", 80)
}

function incMonth() {
    monthSelected++
    if (monthSelected > 11) {
        monthSelected = 0
        yearSelected++
    }
    constructCalendar()
}

function decMonth() {
    monthSelected--
    if (monthSelected < 0) {
        monthSelected = 11
        yearSelected--
    }
    constructCalendar()
}

function constructMonth() {
    popDownYear()
    if (!monthConstructed) {
        sHTML = ""
        for (i = 0; i < 12; i++) {
            sName = monthName[i];
            if (i == monthSelected) {
                sName = "<B>" + sName + "</B>"
            }
            sHTML += "<tr><td id='m" + i + "' onmouseover='this.className=\"dropdown-select-style\"' onmouseout='this.className=\"dropdown-normal-style\"' onclick='monthConstructed=false;monthSelected=" + i + ";constructCalendar();popDownMonth();event.cancelBubble=true'>&nbsp;" + sName + "&nbsp;</td></tr>"
        }

        document.getElementById("selectMonth").innerHTML = "<table width=70	class='dropdown-style' cellspacing=0 onmouseover='clearTimeout(timeoutID1)'	onmouseout='clearTimeout(timeoutID1);timeoutID1=setTimeout(\"popDownMonth()\",100);event.cancelBubble=true'>" + sHTML + "</table>"

        monthConstructed = true
    }
}

function popUpMonth() {
    constructMonth()
    crossMonthObj.visibility = (dom || ie) ? "visible" : "show"
    // Modify by Bohao
    //crossMonthObj.left = parseInt(crossobj.left) + 50
    //crossMonthObj.top =	parseInt(crossobj.top) + 26
    crossMonthObj.left = (parseInt(crossobj.left) + 50).toString() + "px";
    crossMonthObj.top = (parseInt(crossobj.top) + 26).toString() + "px";

    //hideElement('SELECT', document.getElementById("selectMonth"));
    hideElement('APPLET', document.getElementById("selectMonth"));
}

function popDownMonth() {
    crossMonthObj.visibility = "hidden"
}

/*** Year Pulldown ***/

function incYear() {
    for (i = 0; i < 7; i++) {
        newYear = (i + nStartingYear) + 1
        if (newYear == yearSelected)
        { txtYear = "&nbsp;<B>" + (newYear) + "</B>&nbsp;" }
        //        { txtYear = "&nbsp;<B>" + (newYear - 1911) + "</B>&nbsp;" }
        else
        { txtYear = "&nbsp;" + (newYear) + "&nbsp;" }
        //        { txtYear = "&nbsp;" + (newYear - 1911) + "&nbsp;" }
        document.getElementById("y" + i).innerHTML = txtYear
    }
    nStartingYear++;
    bShow = true
}

function decYear() {
    for (i = 0; i < 7; i++) {
        newYear = (i + nStartingYear) - 1
        if (newYear == yearSelected)
        { txtYear = "&nbsp;<B>" + (newYear) + "</B>&nbsp;" }
//        { txtYear = "&nbsp;<B>" + (newYear - 1911) + "</B>&nbsp;" }
        else
        { txtYear = "&nbsp;" + (newYear) + "&nbsp;" }
//        { txtYear = "&nbsp;" + (newYear - 1911) + "&nbsp;" }
        document.getElementById("y" + i).innerHTML = txtYear
    }
    nStartingYear--;
    bShow = true
}

function selectYear(nYear) {
    yearSelected = parseInt(nYear + nStartingYear);
    yearConstructed = false;
    constructCalendar();
    popDownYear();
}

function constructYear() {
    popDownMonth()
    sHTML = ""
    if (!yearConstructed) {

        sHTML = "<tr><td align='center'	onmouseover='this.className=\"dropdown-select-style\"' onmouseout='clearInterval(intervalID1);this.className=\"dropdown-normal-style\"' onmousedown='clearInterval(intervalID1);intervalID1=setInterval(\"decYear()\",30)' onmouseup='clearInterval(intervalID1)'>-</td></tr>"
        j = 0
        nStartingYear = yearSelected - 3
        for (i = (yearSelected - 3); i <= (yearSelected + 3); i++) {
            //sName = i - 1911;
            sName = i;
            if (i == yearSelected) {
                sName = "<B>" + sName + "</B>"
            }

            sHTML += "<tr><td id='y" + j + "' onmouseover='this.className=\"dropdown-select-style\"' onmouseout='this.className=\"dropdown-normal-style\"' onclick='selectYear(" + j + ");event.cancelBubble=true'>&nbsp;" + sName + "&nbsp;</td></tr>"
            j++;
        }

        sHTML += "<tr><td align='center' onmouseover='this.className=\"dropdown-select-style\"' onmouseout='clearInterval(intervalID2);this.className=\"dropdown-normal-style\"' onmousedown='clearInterval(intervalID2);intervalID2=setInterval(\"incYear()\",30)'	onmouseup='clearInterval(intervalID2)'>+</td></tr>"

        document.getElementById("selectYear").innerHTML = "<table width=44 class='dropdown-style' onmouseover='clearTimeout(timeoutID2)' onmouseout='clearTimeout(timeoutID2);timeoutID2=setTimeout(\"popDownYear()\",100)' cellspacing=0>" + sHTML + "</table>"

        yearConstructed = true
    }
}

function popDownYear() {
    clearInterval(intervalID1)
    clearTimeout(timeoutID1)
    clearInterval(intervalID2)
    clearTimeout(timeoutID2)
    crossYearObj.visibility = "hidden"
}

function popUpYear() {
    var leftOffset

    constructYear()
    crossYearObj.visibility = (dom || ie) ? "visible" : "show"
    leftOffset = parseInt(crossobj.left) + document.getElementById("spanYear").offsetLeft
    if (ie) {
        leftOffset += 6
    }
    // Modify by Bohao
    //crossYearObj.left = leftOffset
    //crossYearObj.top = parseInt(crossobj.top) +	26
    crossYearObj.left = leftOffset.toString() + "px";
    crossYearObj.top = (parseInt(crossobj.top) + 26).toString() + "px";
}

/*** calendar ***/

function WeekNbr(today) {
    Year = takeYear(today);
    Month = today.getMonth();
    Day = today.getDate();
    now = Date.UTC(Year, Month, Day + 1, 0, 0, 0);
    var Firstday = new Date();
    Firstday.setYear(Year);
    Firstday.setMonth(0);
    Firstday.setDate(1);
    then = Date.UTC(Year, 0, 1, 0, 0, 0);
    var Compensation = Firstday.getDay();
    if (Compensation > 3) Compensation -= 4;
    else Compensation += 3;
    NumberOfWeek = Math.round((((now - then) / 86400000) + Compensation) / 7);
    return NumberOfWeek;
}

function takeYear(theDate) {
    x = theDate.getFullYear();
    var y = x % 100;
    y += (y < 38) ? 2000 : 1900;
    return y;
}

function constructCalendar() {
    var dateMessage
    var startDate = new Date(yearSelected, monthSelected, 1)
    var endDate = new Date(yearSelected, monthSelected + 1, 1);
    endDate = new Date(endDate - (24 * 60 * 60 * 1000));
    numDaysInMonth = endDate.getDate()

    datePointer = 0
    dayPointer = startDate.getDay() - startAt

    if (dayPointer < 0) {
        dayPointer = 6
    }

    sHTML = "<table	border=0 class='body-style'><tr>"

    if (showWeekNumber == 1) {
        sHTML += "<td width=27><b>" + weekString + "</b></td><td width=1 rowspan=7 class='weeknumber-div-style'><img src='" + imgDir + "divider.gif' width=1></td>"
    }

    for (i = 0; i < 7; i++) {
        sHTML += "<td width='27' align='right'><B>" + dayName[i] + "</B></td>"
    }
    sHTML += "</tr><tr>"

    if (showWeekNumber == 1) {
        sHTML += "<td align=right>" + WeekNbr(startDate) + "&nbsp;</td>"
    }

    for (var i = 1; i <= dayPointer; i++) {
        sHTML += "<td>&nbsp;</td>"
    }

    for (datePointer = 1; datePointer <= numDaysInMonth; datePointer++) {
        dayPointer++;
        sHTML += "<td align=right>"

        var sStyle = " style= 'color: black;' "; //regular day

        if ((datePointer == dateNow) && (monthSelected == monthNow) && (yearSelected == yearNow)) //today
        { sStyle = " style='color: red;font-weight: bold;text-decoration: none;' "; }
        else if (dayPointer % 7 == (startAt * -1) + 1) //end-of-the-week day
        { sStyle = "  style= 'color: #909090;text-decoration: none;'  "; }

        //selected day
        if ((datePointer == odateSelected) && (monthSelected == omonthSelected) && (yearSelected == oyearSelected))
        { sStyle += "  style= 'border-style: solid;border-width: 1px; border-color: #a0a0a0;'  "; }

        sHint = ""
        for (k = 0; k < HolidaysCounter; k++) {
            if ((parseInt(Holidays[k].d) == datePointer) && (parseInt(Holidays[k].m) == (monthSelected + 1))) {
                if ((parseInt(Holidays[k].y) == 0) || ((parseInt(Holidays[k].y) == yearSelected) && (parseInt(Holidays[k].y) != 0))) {
                    sStyle += "  style= 'background-color: #FFDDDD;'  ";
                    sHint += sHint == "" ? Holidays[k].desc : "\n" + Holidays[k].desc
                }
            }
        }

        var regexp = /\"/g
        sHint = sHint.replace(regexp, "&quot;")

        dateMessage = "onmousemove='window.status=\"\"' onmouseout='window.status=\"\"' "

        sHTML += "<a " + sStyle + dateMessage + " title=\"" + sHint + "\" href='javascript:dateSelected=" + datePointer + ";closeCalendar();'>&nbsp;" + datePointer + "&nbsp;</a>"

        sHTML += ""
        if ((dayPointer + startAt) % 7 == startAt) {
            sHTML += "</tr><tr>"
            if ((showWeekNumber == 1) && (datePointer < numDaysInMonth)) {
                sHTML += "<td align=right >" + (WeekNbr(new Date(yearSelected, monthSelected, datePointer + 1))) + "&nbsp;</td>"
            }
        }
    }

    document.getElementById("content").innerHTML = sHTML
    document.getElementById("spanMonth").innerHTML = "&nbsp;" + monthName[monthSelected] + "&nbsp;月<IMG id='changeMonth' SRC='" + imgDir + "drop1.gif' WIDTH='12' HEIGHT='10' BORDER=0>"
    document.getElementById("spanYear").innerHTML = "&nbsp;" + (yearSelected) + "&nbsp;年<IMG id='changeYear' SRC='" + imgDir + "drop1.gif' WIDTH='12' HEIGHT='10' BORDER=0>"
    //document.getElementById("spanYear").innerHTML = "&nbsp;" + (yearSelected - 1911) + "&nbsp;年<IMG id='changeYear' SRC='" + imgDir + "drop1.gif' WIDTH='12' HEIGHT='10' BORDER=0>"
}

function trim(s) {
    var l = 0; var r = s.length - 1;
    while (l < s.length && s[l] == ' ')
    { l++; }
    while (r > l && s[r] == ' ')
    { r -= 1; }
    return s.substring(l, r + 1);
}

function popUpCalendar(ctl, ctl2, format) {
    var leftpos = 0
    var toppos = 0
    if (bPageLoaded) {
        if (crossobj.visibility == "hidden") {
            ctlToPlaceValue = ctl2
            dateFormat = format;

            formatChar = " "
            aFormat = dateFormat.split(formatChar)
            if (aFormat.length < 3) {
                formatChar = "/"
                aFormat = dateFormat.split(formatChar)
                if (aFormat.length < 3) {
                    formatChar = "."
                    aFormat = dateFormat.split(formatChar)
                    if (aFormat.length < 3) {
                        formatChar = "-"
                        aFormat = dateFormat.split(formatChar)
                        if (aFormat.length < 3) {
                            // invalid date	format
                            formatChar = ""
                        }
                    }
                }
            }

            tokensChanged = 0
            if (formatChar != "") {
                // use user's date
                aValue = trim(ctl2.value);
                len = aValue.length;

                if ((len != 0) && (aValue.indexOf("/") == -1)) {
                    aDay = aValue.substr(len - 2, 2)
                    aMonth = aValue.substr(len - 4, 2)
                    aYear = aValue.substr(0, len - 4)
                    aValue = aYear + "/" + aMonth + "/" + aDay
                }

                aData = aValue.split(formatChar)

                for (i = 0; i < 3; i++) {
                    if ((aFormat[i] == "d") || (aFormat[i] == "dd")) {
                        dateSelected = parseInt(aData[i], 10)
                        tokensChanged++
                    }
                    else if ((aFormat[i] == "m") || (aFormat[i] == "mm")) {
                        monthSelected = parseInt(aData[i], 10) - 1
                        tokensChanged++
                    }
                    else if (aFormat[i] == "yyyy") {
                    //yearSelected = parseInt(aData[i], 10) + 1911
                    yearSelected = parseInt(aData[i], 10)
                        tokensChanged++
                    }
                    else if (aFormat[i] == "mmm") {
                        for (j = 0; j < 12; j++) {
                            if (aData[i] == monthName[j]) {
                                monthSelected = j
                                tokensChanged++
                            }
                        }
                    }
                }
            }

            if ((tokensChanged != 3) || isNaN(dateSelected) || isNaN(monthSelected) || isNaN(yearSelected)) {
                dateSelected = dateNow
                monthSelected = monthNow
                yearSelected = yearNow
            }

            odateSelected = dateSelected
            omonthSelected = monthSelected
            oyearSelected = yearSelected

            aTag = ctl;
            do {
                if (null != aTag.offsetParent) {
                    aTag = aTag.offsetParent;
                    leftpos += aTag.offsetLeft;
                    toppos += aTag.offsetTop;
                }
                else {
                    break;
                }
            } while (aTag != document.body);

            // Modify by Bohao
            //crossobj.left = (fixedX == -1 ? ctl.offsetLeft + leftpos : fixedX);
            //crossobj.top = fixedY == -1 ? ctl.offsetTop + toppos + ctl.offsetHeight + 2 : fixedY
            crossobj.left = (fixedX == -1 ? ctl.offsetLeft + leftpos : fixedX).toString() + "px";
            crossobj.top = (fixedY == -1 ? ctl.offsetTop + toppos + ctl.offsetHeight + 2 : fixedY).toString() + "px";

            constructCalendar(1, monthSelected, yearSelected);
            crossobj.visibility = (dom || ie) ? "visible" : "show"

            //hideElement('SELECT', document.getElementById("calendar"));
            hideElement('APPLET', document.getElementById("calendar"));

            bShow = true;
        }
    }
    else {
        init()
        popUpCalendar(ctl, ctl2, format)
    }
}
document.onkeypress = function hidecal1() {
    if (event.keyCode == 27) {
        hideCalendar()
    }
}
document.onclick = function hidecal2() {
    if (!bShow) {
        hideCalendar()
    }
    bShow = false
}

if (ie) {
    init()
}
else {
    window.onload = init
}