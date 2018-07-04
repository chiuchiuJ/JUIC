<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PayPrint1.aspx.cs" Inherits="JuicERP.Pages.PayPrint1" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style type="text/css">
        .auto-style1 {
            height: 151px;
        }

        .auto-style2 {
            height: 30px;
        }

        .auto-style3 {
            height: 25px;
            width: 347px;
        }

        .auto-style4 {
            height: 30px;
            width: 118px;
        }

        .auto-style5 {
            width: 118px;
            height: 40px;
        }

        .auto-style6 {
            height: 151px;
            width: 118px;
        }

        .auto-style7 {
            width: 256px;
            height: 40px;
        }

        .auto-style8 {
            width: 164px;
            height: 40px;
        }
        .auto-style9 {
            height: 40px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server" style="width: 800px">
        <asp:Panel ID="Panel2" runat="server">
            <div style="font-family: 標楷體">

                <img class="auto-style2" src="../img/logo.png" /><br />
                <div style="font-size: x-large; text-align: left; font-weight: bold;" class="auto-style3">
                    零用金支出單<br />
                </div>
                <hr />
                <div>申請日：<asp:Label ID="Label1" runat="server" Text="Label"></asp:Label></div>
                <br />
                <table style="width: 100%;" border="1">
                    <tr>
                        <td class="auto-style6" style="font-family: 標楷體; font-size: x-large; font-weight: bold; text-align: center;">請款事由</td>
                        <td class="auto-style1" colspan="3">
                            &nbsp;<asp:Label ID="Label4" runat="server" Text="Label" Font-Size="Large" ></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td class="auto-style4" style="font-family: 標楷體; font-size: x-large; font-weight: bold; text-align: center;">使用單位</td>
                        <td class="auto-style2" colspan="3" style="text-align: center">
                            <asp:Label ID="Label5" runat="server" Text="Label" Font-Size="Large"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td class="auto-style5" style="font-family: 標楷體; font-size: x-large; font-weight: bold; text-align: center;">申請金額</td>
                        <td class="auto-style7" style="text-align: center">
                            <asp:Label ID="Label6" runat="server" Text="Label" Font-Size="X-Large" ForeColor="#0000CC"></asp:Label>
                        </td>
                        <td class="auto-style8" style="font-family: 標楷體; font-size: x-large; font-weight: bold; text-align: center;">簽收人</td>
                        <td class="auto-style9"></td>
                    </tr>
                </table>
                <br />
                <div style="font-size: large; font-weight: bold">
                    <asp:Label ID="Label2" runat="server" Text="Label"></asp:Label>
                </div>
                <br />
                <hr />
                <table style="width: 100%;">
                    <tr>
                        <td>Form No: TGS-0002-04(20180515)</td>
                        <td class="auto-style11">&nbsp;</td>
                        <td>保存期間：七年</td>
                    </tr>
                </table>
            </div>
        </asp:Panel>
        <asp:DetailsView ID="DetailsView1" runat="server" AutoGenerateRows="False" DataSourceID="SqlDataSource1" Height="50px" Visible="False" Width="125px">
            <Fields>
                <asp:BoundField DataField="id" HeaderText="id" SortExpression="id" />
                <asp:BoundField DataField="date" HeaderText="date" SortExpression="date" />
                <asp:BoundField DataField="formtype" HeaderText="formtype" SortExpression="formtype" />
                <asp:BoundField DataField="payment" HeaderText="payment" SortExpression="payment" DataFormatString="{0:N0}" />
                <asp:BoundField DataField="paymentdetail" HeaderText="paymentdetail" SortExpression="paymentdetail" />
                <asp:BoundField DataField="signtype" HeaderText="signtype" SortExpression="signtype" />
                <asp:BoundField DataField="emp_no" HeaderText="emp_no" SortExpression="emp_no" />
                <asp:BoundField DataField="emp_cne" HeaderText="emp_cne" SortExpression="emp_cne" />
                <asp:BoundField DataField="department" HeaderText="department" SortExpression="department" />
            </Fields>
        </asp:DetailsView>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:MENU %>" SelectCommand="SELECT [id], [date], [formtype], [payment], [paymentdetail], [signtype], [emp_no], [emp_cne], [department] FROM [TB_Payment] WHERE ([id] = @id)">
            <SelectParameters>
                <asp:QueryStringParameter Name="id" QueryStringField="pid" Type="Int32" />
            </SelectParameters>
        </asp:SqlDataSource>
    </form>
</body>
</html>
