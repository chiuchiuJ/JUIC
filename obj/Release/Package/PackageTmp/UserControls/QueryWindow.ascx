<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="QueryWindow.ascx.cs"
    Inherits="JuicERP.UserControls.QueryWindow" %>
<%@ Register Src="StartEndDatePicker.ascx" TagName="StartEndDatePicker" TagPrefix="uc1" %>
<%@ Register Src="~/UserControls/ListPicker.ascx" TagPrefix="uc1" TagName="ListPicker" %>

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
    <ContentTemplate>
        <table class="table table-striped table-bordered table-condensed">
            <tr>
                <td colspan="2">
                    &nbsp;</td>
            </tr>
            <tr>
                <td>廠商別 ：
                </td>
                <td>
                    <asp:TextBox ID="txtJVendor" runat="server" Width="300px"></asp:TextBox>&nbsp;
            <asp:Button ID="btnMultiVendor" runat="server" Text="..." OnClick="btnMultiVendor_Click" />
                </td>
            </tr>
            <tr>
                <td>倉庫別 ：
                </td>
                <td>
                    <asp:TextBox ID="txtJWareHouse" runat="server" Width="300px"></asp:TextBox>&nbsp;
            <asp:Button ID="btnMultiWareHouse" runat="server" Text="..." OnClick="btnMultiWareHouse_Click" />
                </td>
            </tr>
            <tr>
                <td>最近銷貨日：
                </td>
                <td>
                    <uc1:StartEndDatePicker ID="sdpJOutDate" runat="server" />
                </td>
            </tr>
            <tr>
                <td>呆滯日 ：
                </td>
                <td>
                    <asp:TextBox ID="txtJDelayDateStart" runat="server" Width="100px" />
                    -
            <asp:TextBox ID="txtJDelayDateEnd" runat="server" Width="100px" />
                </td>
            </tr>
            <tr>
                <td>品號 ：
                </td>
                <td>
                    <asp:TextBox ID="txtJProdID" runat="server" />
                </td>
            </tr>
            <tr>
                <td>廠商品號 ：
                </td>
                <td>
                    <asp:TextBox ID="txtJVProdID" runat="server" />
                </td>
            </tr>
            <tr>
                <td>品名規格 ：
                </td>
                <td>
                    <asp:TextBox ID="txtJSPEC" runat="server" />
                </td>
            </tr>
            <tr>
                <td>
                    <asp:HiddenField ID="hfDbName" runat="server" />
                </td>
                <td>
                    <asp:Button ID="btnQuery" CssClass="btn btn-primary" runat="server" Text="查詢" OnClick="btnQuery_Click" />
                    <asp:Button ID="btnExit" CssClass="btn btn-success" runat="server" Text="離開" />
                </td>
            </tr>
        </table>
    </ContentTemplate>
    <Triggers>
        <asp:PostBackTrigger ControlID="btnQuery" />
        <asp:PostBackTrigger ControlID="btnExit" />
    </Triggers>
</asp:UpdatePanel>
<script>
    $(function () {
        ////$(document).mousemove(function (event) {
        ////    $("#ctl00_ContentPlaceHolder1_QueryWindow_Child").position({
        ////        my: "left+3 bottom-3",
        ////        of: event,
        ////        collision: "fit"
        ////    });
        ////});

        <%--        $('#<%= btnMultiVendor.ClientID %>').on("click", function (event) {
            var item = $('#<%= ModalPanelChild.ClientID %>');
            //item.detach();
            //var target = $('#FloatWindow');
            //if (target.length > 0) {
            //    target.remove();
            //}
            //$(document.body).append("<div id='FloatWindow' />");
            //target = $('#FloatWindow');
            //item.appendTo(target);

            var offset = $(this).position();
            var top = offset.top;
            var left = offset.left;
            var bottom = top + $(this).outerHeight();
            var right = left + $(this).outerWidth();

            item.css("position", "absolute");
            item.css("top", top + 28 + "px");
            item.css("left", left - 310 + "px");
            item.css("z-index", "9");
            item.removeClass("hide");
        });--%>
    });
</script>
