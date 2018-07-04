<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Votego.ascx.cs" Inherits="JuicERP.UserControls.Vote" %>

    <div class="panel panel-primary">
  <div class="panel-heading">
    <h2 class="panel-title" style="text-align: center;">
        <asp:Label ID="Labeltitle" runat="server" Text="Title" Font-Size="X-Large" Font-Names="微軟正黑體"></asp:Label></h2>
  </div>
  <div class="panel-body">
            <h4 style="text-align: center"  >
 <%--         <asp:Label ID="Label9" runat="server" Text="date" Font-Names="微軟正黑體"></asp:Label>--%>
      </h4>
      <asp:TextBox ID="TextBoxContent" runat="server" BorderStyle="None" TextMode="MultiLine" Width="100%" ReadOnly="True" AutoPostBack="False" Height="100%" Rows="10" Font-Names="微軟正黑體"></asp:TextBox>
  </div>
   <asp:Panel ID="Panel1" runat="server">
       <div class="panel panel-info">
              <div class="panel-heading"   style="text-align: center;">
                   <asp:Label ID="Label2" runat="server" Text="Label" Font-Names="微軟正黑體" Font-Size="XX-Large" ></asp:Label>
                   <br />
                   <asp:Label ID="Label3" runat="server" Text="" Font-Names="微軟正黑體" ForeColor="Red"></asp:Label>
             </div>
        </div>
   </asp:Panel>

    <asp:Panel ID="Panel2" runat="server">
       <div class="panel panel-danger">
              <div class="panel-heading" style="text-align: center;">
                   <asp:Label ID="Label4" runat="server" Text="投票項目" Font-Names="微軟正黑體" Font-Size="Large" ForeColor="#FF3300"></asp:Label>
                  </div></div>
<div class="panel-body">
        <ul class="list-group">
  <li class="list-group-item list-group-item-success" style="vertical-align: middle; text-align: center">
<asp:Label ID="Labelvote1" runat="server" Text="" Visible="false" Font-Size="Larger" Font-Names="微軟正黑體"></asp:Label>
    <asp:CheckBoxList ID="CheckBoxList1" runat="server" Visible="false" RepeatDirection="Vertical" Width="100%" Font-Size="Medium" Font-Names="微軟正黑體"></asp:CheckBoxList>
      <asp:RadioButtonList ID="RadioButtonList1" runat="server" RepeatDirection="Vertical" Width="100%" Font-Size="Medium" Font-Names="微軟正黑體"></asp:RadioButtonList>
  </li>
  <li class="list-group-item list-group-item-info" style="vertical-align: middle; text-align: center">
            <asp:Label ID="Labelvote2" runat="server" Text="" Visible="false" Font-Size="Larger" Font-Names="微軟正黑體"></asp:Label>
    <asp:CheckBoxList ID="CheckBoxList2" runat="server" Visible="false"  RepeatDirection="Vertical" Width="100%" Font-Size="Medium" Font-Names="微軟正黑體"></asp:CheckBoxList>
        <asp:RadioButtonList ID="RadioButtonList2" runat="server" RepeatDirection="Vertical" Width="100%" Font-Size="Medium" Font-Names="微軟正黑體"></asp:RadioButtonList>
  </li>
  <li class="list-group-item list-group-item-warning" style="vertical-align: middle; text-align: center">
                <asp:Label ID="Labelvote3" runat="server" Text="" Visible="false" Font-Size="Larger" Font-Names="微軟正黑體"></asp:Label>
    <asp:CheckBoxList ID="CheckBoxList3" runat="server" Visible="false"  RepeatDirection="Vertical" Width="100%" Font-Size="Medium" Font-Names="微軟正黑體"></asp:CheckBoxList>
        <asp:RadioButtonList ID="RadioButtonList3" runat="server" RepeatDirection="Vertical" Width="100%" Font-Size="Medium" Font-Names="微軟正黑體"></asp:RadioButtonList>
  </li>

</ul>
    </div>
    

        </asp:Panel>
            <div  style="text-align: center;">
                <asp:Button ID="Button1" CssClass="btn btn-success btn-block" runat="server" Text="送出" Font-Names="微軟正黑體" OnClick="Button1_Click"/>
                <asp:Button ID="btnExit" CssClass="btn btn-danger btn-block" runat="server" Text="關閉" Font-Names="微軟正黑體"/>
                       </div>
</div>



<%--隱藏label儲存user編號--%>
<asp:Label ID="Labeluserid" runat="server" Text="" Visible="False"></asp:Label>
<asp:Label ID="Labelusername" runat="server" Text="" Visible="False"></asp:Label>
<asp:Label ID="Labelvoteid" runat="server" Text="" Visible="False"></asp:Label>
<asp:Label ID="Labelvalid" runat="server" Text="" Visible="False"></asp:Label>
<asp:HiddenField ID="Annname" runat="server" />

<asp:Label ID="Labeltest" runat="server" Text="" Visible="False"></asp:Label>