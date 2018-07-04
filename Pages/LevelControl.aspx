<%@ Page Title="" Language="C#" MasterPageFile="~/Master/JuicERP.Master" AutoEventWireup="true" CodeBehind="LevelControl.aspx.cs" Inherits="JuicERP.Pages.LevelControl" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:MENU %>" SelectCommand="  SELECT [MenuId]
      ,[ParentMenuId]
      ,[Title]
      ,[Description]
      ,[Url]
  FROM [TB_Menus]
  where ParentMenuId=0
  order by ParentMenuId"></asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:MENU %>" SelectCommand="  SELECT [MenuId]
      ,[ParentMenuId]
      ,[Title]
      ,[Description]
      ,[Url]
  FROM [TB_Menus]
  where ParentMenuId!=0
  order by ParentMenuId"></asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:MENU %>" SelectCommand="SELECT [userid], (RTRIM([username])+'('+RTRIM([userid])+')') as username FROM [bas03]"></asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSource4" runat="server" ConnectionString="<%$ ConnectionStrings:MENU %>" SelectCommand="SELECT [ActID], [Actname], [ActNO], [PS] FROM [TB_UserActList]"></asp:SqlDataSource>
    <div class="col-md-2"></div>
  <div class="col-md-8">
    <asp:DropDownList ID="DropDownList1" runat="server" AutoPostBack="True" DataSourceID="SqlDataSource3" DataTextField="username" DataValueField="userid" OnSelectedIndexChanged="DropDownList1_SelectedIndexChanged" AppendDataBoundItems="True">
        <asp:ListItem Value="0">請選擇修改權限對象</asp:ListItem>
    </asp:DropDownList>

      <asp:Button ID="Button2" runat="server" Text="查詢自己權限狀態" OnClick="Button2_Click" CssClass="btn btn-primary" />
      <br />      <br />
     <div class="panel panel-primary" style="font-family: 微軟正黑體">
      <div class="panel-heading">網站選單(母項目)</div>
      <div class="panel-body">
    <asp:CheckBoxList ID="CheckBoxList1" runat="server" DataSourceID="SqlDataSource1" DataTextField="Title" DataValueField="MenuId" Font-Names="微軟正黑體" Font-Size="Medium" RepeatColumns="5" RepeatDirection="Horizontal" Width="100%"></asp:CheckBoxList>
          <br />
      </div>
    </div>
           <div class="panel panel-primary" style="font-family: 微軟正黑體">
      <div class="panel-heading">網站選單(子項目)</div>
      <div class="panel-body">
     <asp:CheckBoxList ID="CheckBoxList2" runat="server" DataSourceID="SqlDataSource2" DataTextField="Title" DataValueField="MenuId" Font-Names="微軟正黑體" Font-Size="Medium" RepeatColumns="5" RepeatDirection="Horizontal" Width="100%"></asp:CheckBoxList>
    <br />
      </div>
    </div>
                 <div class="panel panel-primary" style="font-family: 微軟正黑體">
      <div class="panel-heading">其他功能權限</div>
      <div class="panel-body">
            <asp:CheckBoxList ID="CheckBoxList3" runat="server" DataSourceID="SqlDataSource4" DataTextField="Actname" DataValueField="ActNO" Font-Names="微軟正黑體" Font-Size="Medium" RepeatColumns="5" RepeatDirection="Horizontal" Width="100%"></asp:CheckBoxList>
    <br />
      </div>
    </div>

 

      <asp:Button ID="Button1" runat="server" Text="修改" OnClick="Button1_Click" CssClass="btn btn-success btn-block" />
  <br />    
  </div>
    <div class="col-md-2">
    </div>
</asp:Content>
