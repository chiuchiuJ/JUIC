<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="MisservicePrint.aspx.cs" Inherits="JuicERP.Pages.MisservicePrint" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style type="text/css">
        .auto-style1 {
            width: 267px;
            height: 37px;
        }

        .auto-style5 {
            width: 819px;
        }

        .auto-style11 {
            height: 33px;
            width: 205px;
        }

        .auto-style12 {
            width: 204px;
        }

        .auto-style13 {
            width: 205px;
        }

        .auto-style14 {
            height: 33px;
        }

        .auto-style16 {
            height: 180px;
        }

        .auto-style17 {
            width: 204px;
            height: 37px;
        }

        .auto-style18 {
            width: 205px;
            height: 37px;
        }

        .auto-style19 {
            width: 204px;
            height: 60px;
        }

        .auto-style20 {
            width: 205px;
            height: 60px;
        }

        .auto-style21 {
            width: 204px;
            height: 33px;
        }

        @media print {
            .NoPrint {
                display: none;
            }
        }

        .button {
            background-color: #4CAF50; /* Green */
            border: none;
            color: white;
            padding: 15px 32px;
            text-align: center;
            text-decoration: none;
            display: inline-block;
            font-size: 16px;
        }

        .auto-style23 {
            height: 220px;
        }
    </style>
</head>
<body>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:MENU %>" SelectCommand="SELECT [NO], [problem],[PS],[testfeedback], [date] FROM [TB_MISservice] WHERE ([NO] = @NO)">
        <SelectParameters>
            <asp:QueryStringParameter Name="NO" QueryStringField="pid" Type="String" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:DetailsView ID="DetailsView1" runat="server" AutoGenerateRows="False" DataKeyNames="NO" DataSourceID="SqlDataSource1" Height="50px" Width="125px" Visible="False">
        <Fields>
            <asp:BoundField DataField="NO" HeaderText="NO" ReadOnly="True" SortExpression="NO" />
            <asp:BoundField DataField="problem" HeaderText="problem" SortExpression="problem" />
            <asp:BoundField DataField="date" DataFormatString="{0:d}" HeaderText="date" SortExpression="date" />
            <asp:BoundField DataField="PS" HeaderText="PS" SortExpression="PS" />
            <asp:BoundField DataField="testfeedback" HeaderText="testfeedback" SortExpression="testfeedback" />
        </Fields>
    </asp:DetailsView>
    <asp:Label ID="Labelname" runat="server" Text="Label" Visible="False"></asp:Label>

    <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:MENU %>" SelectCommand="SELECT * FROM [chuck06] WHERE ([emp_cne] = @emp_cne)">
        <SelectParameters>
            <asp:QueryStringParameter Name="emp_cne" QueryStringField="user" Type="String" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:DetailsView ID="DetailsView2" runat="server" AutoGenerateRows="False" DataKeyNames="emp_no" DataSourceID="SqlDataSource2" Height="50px" Visible="False" Width="125px">
        <Fields>
            <asp:BoundField DataField="emp_no" HeaderText="emp_no" ReadOnly="True" SortExpression="emp_no" />
            <asp:BoundField DataField="emp_cne" HeaderText="emp_cne" SortExpression="emp_cne" />
            <asp:BoundField DataField="DEPA_NE1" HeaderText="DEPA_NE1" SortExpression="DEPA_NE1" />
        </Fields>
    </asp:DetailsView>

    <input type="button" value="列印" onclick="window.print()" class="NoPrint" style="font-size: xx-large; background-color: #00FFFF; font-family: 微軟正黑體" />
    <form id="form1" runat="server" style="width: 800px">
        <asp:Panel ID="Panel1" runat="server">
            <div style="font-family: 標楷體">

                <img class="auto-style1" src="../img/logo.png" /><br />
                <br />
                <div style="font-size: xx-large; text-align: center">系統作業反應單</div>
                <br />
                <table class="auto-style5">
                    <tr>
                        <td class="auto-style12">&nbsp;</td>
                        <td class="auto-style12">&nbsp;</td>
                        <td class="auto-style12">&nbsp;</td>
                        <td class="auto-style13" style="font-size: 20px">NO:<asp:Label ID="Label2" runat="server" Text="Label"></asp:Label>
                        </td>
                    </tr>
                </table>
                <br />
                <table class="auto-style5" border="1" style="font-size: 20px">
                    <tr>
                        <td class="auto-style21">申請單位</td>
                        <td class="auto-style21">
                            <asp:Label ID="Label4" runat="server"></asp:Label>
                        </td>
                        <td class="auto-style21">申請日期</td>
                        <td class="auto-style11">
                            <asp:Label ID="Label1" runat="server"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td class="auto-style14" colspan="4">申請項目：□修改　□異常　□刪除&nbsp; □新增</td>
                    </tr>
                    <tr>
                        <td colspan="4" class="auto-style23" style="vertical-align: top">一、需求說明：<br />
                            <br />
                            <asp:Label ID="Label3" runat="server" Width="794px"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="4" class="auto-style23" style="vertical-align: top">二、修改記錄／處理結果：□資訊單位 □軟體廠商<br />
                            <br />
                            <asp:Label ID="LabelPS" runat="server"></asp:Label>
                            <br />
                        </td>
                    </tr>
                    <tr>
                        <td colspan="4" class="auto-style16" style="vertical-align: top">三、申請單位測試結果：<br />
                            <br />
                            <asp:Label ID="Labeltestfeedback" runat="server" Text="Label"></asp:Label>
                            <br />

                            <br />
                            <br />
                            <br />
                            <br />
                            <br />
                            <br />
                            <br />
                            <div style="text-align: right">申請單位測試人員：&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div>
                            <br />
                        </td>
                    </tr>
                    <tr>
                        <td class="auto-style17" style="text-align: center; clip: rect(5px, auto, 5px, auto)">資訊單位主管</td>
                        <td class="auto-style17" style="text-align: center; clip: rect(5px, auto, 5px, auto)">資訊單位處理人員</td>
                        <td class="auto-style17" style="text-align: center; clip: rect(5px, auto, 5px, auto)">申請單位主管</td>
                        <td class="auto-style18" style="text-align: center; clip: rect(5px, auto, 5px, auto)">申請人</td>
                    </tr>
                    <tr>
                        <td class="auto-style19"></td>
                        <td class="auto-style19"></td>
                        <td class="auto-style19"></td>
                        <td class="auto-style20">&nbsp;</td>
                    </tr>
                </table>
                <br />
                <hr />
                <div>Form No: THS-0003-01(20160316)</div>
                <div style="text-align: right">保存期間：五年</div>




            </div>
        </asp:Panel>
    </form>
</body>
</html>
