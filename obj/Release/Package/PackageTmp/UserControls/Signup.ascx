<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Signup.ascx.cs" Inherits="JuicERP.UserControls.Signup" %>

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


<div class="panel panel-primary">
    <div class="panel-heading">
        <h2 class="panel-title" style="text-align: center;">
            <asp:Label ID="Label1" runat="server" Text="Title" Font-Size="X-Large" Font-Names="微軟正黑體"></asp:Label></h2>
    </div>
    <div class="panel-body">
        <h4 style="text-align: center">
            <asp:Label ID="Label9" runat="server" Text="date" Font-Names="微軟正黑體"></asp:Label><br />
            <asp:Label ID="Label5" runat="server" Text="type" Font-Names="微軟正黑體" ForeColor="Blue"></asp:Label>
        </h4>
        <asp:TextBox ID="TextBox1" runat="server" BorderStyle="None" TextMode="MultiLine" Width="100%" ReadOnly="True" AutoPostBack="False" Height="100%" Rows="10" Font-Names="微軟正黑體"></asp:TextBox>
        <br />
        <div style="text-align: center">
            查看附件：<asp:HyperLink ID="HyperLink1" runat="server" CssClass="btn btn-warning" Visible="False" Target="_blank">[HyperLink1]</asp:HyperLink>
        </div>
    </div>
    <asp:Panel ID="Panel1" runat="server">
        <div class="panel panel-info">
            <div class="panel-heading" style="text-align: center;">
                <asp:Label ID="Label2" runat="server" Text="Label" Font-Names="微軟正黑體" Font-Size="XX-Large"></asp:Label>
                <br />
                <asp:Label ID="Label3" runat="server" Text="" Font-Names="微軟正黑體" ForeColor="Red"></asp:Label>
            </div>
        </div>
    </asp:Panel>
    <asp:Panel ID="Panel2" runat="server">
        <div class="panel panel-danger">
            <div class="panel-heading" style="text-align: center;">
                <div class="panel-body">
                    <asp:Label ID="Label4" runat="server" Text=""></asp:Label><br />
                    <asp:Label ID="Label6" runat="server" Text="參加人數為：" Font-Names="微軟正黑體" ForeColor="#3366FF"></asp:Label>
                    <asp:TextBox ID="TextBox3" runat="server" Font-Names="微軟正黑體">1</asp:TextBox>
                    <asp:Label ID="Label7" runat="server" Font-Names="微軟正黑體" Text="人" ForeColor="#3366FF"></asp:Label>
                                        <br />
                    <asp:Label ID="Label8" runat="server" Text="備註事項及意見反應"></asp:Label>
                    <br />
                    <asp:TextBox ID="TextBox2" runat="server" TextMode="MultiLine" Width="500px" Rows="6"></asp:TextBox>
                </div>
            </div>
        </div>
    </asp:Panel>
    <div style="text-align: center;">
        <asp:Button ID="Button1" CssClass="btn btn-success btn-block" runat="server" Text="確認報名" Font-Names="微軟正黑體" OnClick="Button1_Click" />
        <asp:Button ID="Button2" CssClass="btn btn-success btn-block" runat="server" Text="報名並填寫詳細報名資料" Font-Names="微軟正黑體" OnClick="Button2_Click" />
        <asp:Button ID="btnExit" CssClass="btn btn-danger btn-block" runat="server" Text="關閉" Font-Names="微軟正黑體" />
    </div>
</div>



<%--隱藏label儲存user編號--%>
<asp:Label ID="LabelID" runat="server" Text="" Visible="False"></asp:Label>
<asp:Label ID="LabeluserID" runat="server" Text="" Visible="False"></asp:Label>
<asp:Label ID="LabeluserName" runat="server" Visible="False"></asp:Label>
<asp:Label ID="LabelChoice" runat="server" Text="" Visible="False"></asp:Label>
<asp:Label ID="Labeleat" runat="server" Text="" Visible="False"></asp:Label>
<asp:Label ID="Labelvalid" runat="server" Text="" Visible="False"></asp:Label>
<asp:HiddenField ID="Annname" runat="server" />
