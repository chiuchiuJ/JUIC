<%@ Page Language="C#"  MasterPageFile="~/Master/JuicERP.Master"  AutoEventWireup="true" CodeBehind="Sales2week.aspx.cs" Inherits="JuicERP.Pages.Sales1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <script>var imgDir = '<%=ResolveUrl("~/img") %>' + "/";	</script>
    <script src="<%=ResolveUrl("~/js/popcalendar.js") %>" charset="UTF-8"></script>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div>
        <iframe id="reportFrame" src="<%= System.Configuration.ConfigurationManager.AppSettings["reporturl"] %>WebReport/ReportServer?reportlet=sales2week.cpt&op=view" width = "100%" height = "600px"></iframe>
    </div>
</asp:Content>



