jQuery.fn.center = function () {
    this.css("position", "absolute");
    this.css("top", Math.max(0, (($(window).height() - $(this).outerHeight()) / 2) + $(window).scrollTop()) + "px");
    this.css("left", Math.max(0, (($(window).width() - $(this).outerWidth()) / 2) + $(window).scrollLeft()) + "px");
    return this;
}
jQuery.fn.fullscreen = function () {
    this.css("position", "absolute");
    this.css("top", "0px");
    this.css("left", "0px");
    $(this).height($(window).innerHeight() > $(window).height() ? $(window).innerHeight() : $(window).height());
    $(this).width($(window).innerWidth() > $(window).width() ? $(window).innerWidth() : $(window).width());
    return this;
}

var controls = [];
var masks = [];
$(window).resize(function () {
    controls.forEach(function (ctl) {
        $(ctl).center();
    });
    masks.forEach(function (ctl) {
        $(ctl).fullscreen();
    });
});

function GetMaxZindex() {
    var maxZindex = 99;
    controls.forEach(function (ctl) {
        var zidx = ctl.style.zIndex;
        if (zidx > maxZindex) {
            maxZindex = zidx;
        }
    });
    masks.forEach(function (ctl) {
        var zidx = ctl.style.zIndex;
        if (zidx > maxZindex) {
            maxZindex = zidx;
        }
    });
    return maxZindex;
}

function LoadControl(dialogID, titleName, buttonUrl) {
    objDialog = document.getElementById(dialogID);
    objDialog.setAttribute("class", "box");

    objTitle = document.createElement('h2');
    objTitle.id = dialogID + "Title";
    objTitle.innerText = titleName;
    $(objDialog).prepend(objTitle);

    objButton = document.createElement("input");
    objButton.id = dialogID + "CloseButton";
    objButton.setAttribute("type", "image");
    objButton.setAttribute("class", "boxClose");
    objButton.setAttribute("src", buttonUrl);
    objButton.setAttribute("alt", "關閉");
    objButton.setAttribute("onclick", "CloseControl('" + dialogID + "'); return false;");
    $(objDialog).append(objButton);

    ShowControl(dialogID);
}

function ShowControl(dialogID) {
    var objControl = document.getElementById(dialogID);
    if (dialogID != null) {
        objControl.style.display = 'inline';
        objControl.style.visibility = 'visible';
        $(objControl).center();

        var innerWidth = $(window).innerWidth();
        var innerHeight = $(window).innerHeight();
        if ($(objControl).height() > innerHeight) {
            objControl.style.height = innerHeight - 10 + "px";
            objControl.style.maxHeight = innerHeight - 10 + "px";
        }
        else {
            objControl.style.height = $(objControl).height() + 2 + "px";
            objControl.style.maxHeight = $(objControl).height() + 2 + "px";
        }
        objControl.style.maxWidth = innerWidth - 10 + "px";
        objControl.style.overflow = "auto";

        objControl.style.zIndex = parseInt(GetMaxZindex()) + 2;
        controls.push(objControl);
    }
    ShowMask(dialogID);
}

function ShowMask(controlID) {
    var maskedID = controlID + 'MaskedDiv';
    var objMasked = document.getElementById(maskedID);
    if (objMasked == null) {
        objMasked = document.createElement('div');
        objMasked.setAttribute("id", maskedID);
        objMasked.setAttribute("class", "boxBG");
        $(document.forms[0]).append(objMasked);
    }
    objMasked.style.display = 'block';
    objMasked.style.visibility = 'visible';
    objMasked.style.overflow = "hidden";

    $(objMasked).fullscreen();
    objMasked.style.zIndex = parseInt(GetMaxZindex()) - 1; // 先進 control，且control 要比 mask 高，所以前面的control+2，這裡的mask就要-1
    masks.push(objMasked);
}

function CloseMask(controlID) {
    var maskedID = controlID + 'MaskedDiv';
    var objMasked = document.getElementById(maskedID);
    if (objMasked != null) {
        document.getElementById(maskedID).style.display = 'none';
        var idx = masks.indexOf(objMasked);
        if (idx >= 0) masks.splice(idx, 1);
        objMasked = null;
    }
}

function CloseControl(controlID) {
    CloseMask(controlID);
    var objControl = document.getElementById(controlID);
    if (objControl != null) {
        $(objControl).removeClass("box");
        $(objControl).find("#" + controlID + "Title").remove();
        $(objControl).find("#" + controlID + "CloseButton").remove();
        var idx = controls.indexOf(objControl);
        if (idx >= 0) controls.splice(idx, 1);
        objControl.style.display = 'none';
    }
}

//function ControlWaiting() {
//    var objMasked = document.createElement('div');
//    objMasked.setAttribute("id", "ControlWaiting");
//    objMasked.setAttribute("class", "boxBG");
//    objMasked.setAttribute("style", "display: inline-block;");
//    objMasked.style.zIndex = "999";
//    $(document.forms[0]).append(objMasked);
//    objMasked.innerHTML = "資料載入中，請耐心等候<br /><img id='AjaxWaitingImg' style='display: inline-block;vertical-align: middle;margin: 0 auto;' src='/LMS/Resource/image/ajax-loader.gif' alt='資料載入中，請耐心等候' />";
//    objMasked.style.display = 'block';
//    objMasked.style.visibility = 'visible';
//    objMasked.style.overflow = "hidden";
//    $(objMasked).fullscreen();
//}

//function ControlWaitingClose() {
//    if ($("#ControlWaiting") != null) $("#ControlWaiting").remove();
//}
