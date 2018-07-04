<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="MessageBox.ascx.cs" Inherits="JuicERP.UserControls.MessageBox" %>
<table border="0" cellpadding="0" cellspacing="0" class="Message" frame="void" style="height: 14px" width="100%">
    <tr>
        <td align="left" style="width: 75%">
            <asp:Label ID="lblHint" runat="server" EnableViewState="False" Visible="false" >訊息：</asp:Label>
            <asp:Label ID="lblMessage" runat="server" EnableViewState="False" Font-Bold="True" Visible="False"></asp:Label>
            <asp:Label ID="lblErrorMessage" runat="server" EnableViewState="False" Font-Bold="True" ForeColor="Red" Visible="False"></asp:Label>
        </td>
        <td align="right" style="width: 25%">
            <asp:Label ID="lblCount" runat="server" EnableViewState="False" Visible="False">共0筆</asp:Label>
            <asp:Label ID="lblPage" runat="server" EnableViewState="False" Visible="False">(第0頁/共0頁)</asp:Label>
        </td>
    </tr>
</table>