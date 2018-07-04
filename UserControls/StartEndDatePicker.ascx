<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="StartEndDatePicker.ascx.cs" Inherits="JuicERP.UserControls.StartEndDatePicker" %>
<script>var imgDir = '<%=ResolveUrl("~/img") %>' + "/";	</script>
<script src="<%=ResolveUrl("~/js/popcalendar.js") %>" charset="UTF-8"></script>
<asp:TextBox ID="txtStartDate" runat="server" Width="90px"></asp:TextBox>
<img align="middle" alt="" style="margin: 0 auto;" onclick="popUpCalendar(this, document.getElementById('<%= txtStartDate.ClientID %>'), 'yyyy/mm/dd')" src="<%=ResolveUrl("~/img/calendar.gif") %>" />&nbsp;~
<asp:TextBox ID="txtEndDate" runat="server" Width="90px"></asp:TextBox>
<img align="middle" alt="" style="margin: 0 auto;" onclick="popUpCalendar(this, document.getElementById('<%= txtEndDate.ClientID %>'), 'yyyy/mm/dd')" src="<%=ResolveUrl("~/img/calendar.gif") %>" />
<asp:Label ID="lblDateMsg" runat="server" EnableViewState="False" ForeColor="Red"></asp:Label>

