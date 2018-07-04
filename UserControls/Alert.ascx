<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Alert.ascx.cs" Inherits="JuicERP.UserControls.Alert" %>

<script>
    function MoveToItem(src, item) {
        var eventItem = $('#' + item);
        var offset = eventItem.position();
        var top = offset.top;
        var left = offset.left;
        var bottom = top + eventItem.outerHeight();
        var right = left + eventItem.outerWidth();

        var target = $('#' + src);
        target.css("position", "absolute");
        target.css("top", top + 28 + "px");
        target.css("left", left + "px");
        target.css("z-index", "9");
        target.removeClass("hide");
    }
</script>

<asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional">

</asp:UpdatePanel>

<asp:HiddenField ID="hfDbName" runat="server" />