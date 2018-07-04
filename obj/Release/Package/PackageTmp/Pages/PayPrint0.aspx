<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PayPrint0.aspx.cs" Inherits="JuicERP.Pages.PayPrint0" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>

    <style type="text/css">
        .auto-style2 {
            width: 280px;
            height: 35px;
        }

        .auto-style31 {
            height: 40px;
        }

        .auto-style3 {
            height: 40px;
            width: 200px;
        }

        .auto-style4 {
            height: 150px;
            width: 200px;
        }

        .auto-style5 {
            height: 120px;
            width: 160px;
        }

        .auto-style6 {
            width: 800px;
        }
        .auto-style32 {
            height: 120px;
            width: 125px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <img class="auto-style2" src="../img/logo.png" /><br />

        <asp:Panel ID="Panel1" runat="server" HorizontalAlign="Center" Font-Names="微軟正黑體" Width="800px">
            <div>
                <table border="1" cellpadding="0" cellspacing="0" border-collapse:collaps class="auto-style6">
                    <tr>
                        <td class="auto-style31" colspan="8">
                            <asp:Label ID="Label1" runat="server" Text="零用金預支單" Font-Size="X-Large" Font-Names="標楷體"></asp:Label>

                        </td>
                    </tr>
                    <tr>
                        <td class="auto-style31" colspan="8" style="text-align: left">
                            <asp:Label ID="Label2" runat="server" Text="年月日" Font-Size="Large"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td class="auto-style3" colspan="2" style="border-style: solid">
                            <asp:Label ID="Label3" runat="server" Text="申請單位" Font-Size="Large"></asp:Label>
                        </td>
                        <td class="auto-style3" colspan="2" style="border-style: solid">
                            <asp:Label ID="Label4" runat="server" Text="預支原因" Font-Size="Large"></asp:Label>
                        </td>
                        <td class="auto-style3" colspan="2" style="border-style: solid">
                            <asp:Label ID="Label5" runat="server" Text="金額" Font-Size="Large"></asp:Label>
                        </td>
                        <td class="auto-style3" colspan="2" style="border-style: solid">
                            <asp:Label ID="Label6" runat="server" Text="領款人" Font-Size="Large"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td class="auto-style4" colspan="2" style="border-style: solid">
                            <asp:Label ID="Label7" runat="server" Text="" Font-Size="Large"></asp:Label>
                        </td>
                        <td class="auto-style4" colspan="2" style="border-style: solid">
                            <asp:Label ID="Label8" style="word-break:break-all" runat="server"></asp:Label>
                        </td>
                        <td class="auto-style4" colspan="2" style="border-style: solid">
                            <asp:Label ID="Label9" runat="server" Text=""></asp:Label>
                        </td>
                        <td class="auto-style4" colspan="2" style="border-style: solid">
                            <asp:Label ID="Label10" runat="server" Text="" Font-Size="Large"></asp:Label>
                        </td>
                    </tr>
                

                </table>
                <table border="1" cellpadding="0" cellspacing="0" border-collapse:collaps class="auto-style6">
    <tr>
                        <td class="auto-style32" style="border-style: solid; text-align: left; vertical-align: top;">董事長：
                        </td>
                        <td class="auto-style5" colspan="2" style="border-style: solid; text-align: left; vertical-align: top;">總經理：
                        </td>
                        <td class="auto-style5" colspan="2" style="border-style: solid; text-align: left; vertical-align: top;">副總經理：
                        </td>
                        <td class="auto-style5" colspan="2" style="border-style: solid; text-align: left; vertical-align: top;">處級主管：
                        </td>
                        <td class="auto-style5" colspan="2" style="border-style: solid; text-align: left; vertical-align: top;">部級主管：
                        </td>
                        <td class="auto-style5" style="border-style: solid; text-align: left; vertical-align: top;">申請人：
                        </td>
                    </tr>
                    </table>
                <div style="text-align: left;">Form No: TGS-0014-02(20180515)</div>
            </div>
        </asp:Panel>



    </form>



</body>
</html>
