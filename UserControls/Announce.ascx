<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Announce.ascx.cs" Inherits="JuicERP.UserControls.Announce" %>

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
<asp:UpdatePanel ID="UpdatePanel1" runat="server">
    <ContentTemplate>
        <div class="panel panel-primary">
  <div class="panel-heading">
    <h3 class="panel-title" style="text-align: center;">
        <asp:Label ID="Label1" runat="server" Text="Title"></asp:Label></h3>
  </div>
              
    <div class="panel-body panel panel-success ">
        <asp:Label ID="Label2" runat="server" Text="" Font-Names="微軟正黑體"></asp:Label>
        <br />
             <asp:Label ID="Label3" runat="server" Text="" Font-Names="微軟正黑體"></asp:Label>
            <br />
             <asp:Label ID="Label4" runat="server" Text="" Font-Names="微軟正黑體"></asp:Label>
    </div>

  <div class="panel-body">
      <asp:TextBox ID="TextBox1" runat="server" BorderStyle="None" TextMode="MultiLine" Width="100%" ReadOnly="True" AutoPostBack="False" Height="100%" Rows="10" Font-Names="微軟正黑體"></asp:TextBox>
<%--      <asp:Table ID="Table1" runat="server">
          <asp:TableRow ID="tab">

          </asp:TableRow>
      </asp:Table>--%>
  </div>
            <div  style="text-align: center;">
                <asp:HyperLink ID="HyperLink1" runat="server" Target="_blank">點我查看附件</asp:HyperLink>
                <br />
                <asp:Button ID="btnExit" CssClass="btn btn-success btn-block" runat="server" Text="關閉" />
                            </div>
</div>
    </ContentTemplate>
</asp:UpdatePanel>

<label ID="ID"></label>
<asp:HiddenField ID="Annname" runat="server" />

