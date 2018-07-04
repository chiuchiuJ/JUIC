<%@ Page Title="" Language="C#" MasterPageFile="~/Master/JuicERP.Master" AutoEventWireup="true" CodeBehind="Exceltogrid.aspx.cs" Inherits="JuicERP.Pages.Exceltogrid" %>

<%@ Register Assembly="System.Web.DataVisualization, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" Namespace="System.Web.UI.DataVisualization.Charting" TagPrefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <%--    <asp:FileUpload ID="FileUpload1" runat="server" />
    <asp:Button ID="Button1" runat="server" Text="Button" OnClick="Button1_Click" />
    <br />
<asp:Label ID="Label1" runat="server" Text="Has Header ?" />
<asp:RadioButtonList ID="rbHDR" runat="server">
    <asp:ListItem Text = "Yes" Value = "Yes" Selected = "True" >
    </asp:ListItem>
    <asp:ListItem Text = "No" Value = "No"></asp:ListItem>
</asp:RadioButtonList>

    <asp:GridView ID="GridView1" runat="server" OnPageIndexChanging = "PageIndexChanging" AllowPaging = "true">
</asp:GridView>--%>

    <asp:FileUpload ID="FileUpload1" runat="server" />
<asp:Button ID="btnUpload" runat="server" Text="Upload"
            OnClick="btnUpload_Click" />
<br />
<asp:Label ID="Label1" runat="server" Text="Has Header ?" />
<asp:RadioButtonList ID="rbHDR" runat="server">
    <asp:ListItem Text = "Yes" Value = "Yes" Selected = "True" >
    </asp:ListItem>
    <asp:ListItem Text = "No" Value = "No"></asp:ListItem>
</asp:RadioButtonList>
<asp:GridView ID="GridView1" runat="server"
OnPageIndexChanging = "PageIndexChanging" AllowPaging = "true">
</asp:GridView>
    <hr />
    
    <asp:Chart ID="Chart1" runat="server" DataSourceID="SqlDataSource2">
        <Series>
            <asp:Series Name="Series1" ChartType="RangeBar" XValueMember="room" YValuesPerPoint="2"></asp:Series>
        </Series>
        <ChartAreas>
            <asp:ChartArea Name="ChartArea1"></asp:ChartArea>
        </ChartAreas>
    </asp:Chart>


    <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:MENU %>" SelectCommand="SELECT * FROM [TB_Conference]"></asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:MENU %>" SelectCommand="SELECT * FROM [TB_Carrent]"></asp:SqlDataSource>


    </asp:Content>
