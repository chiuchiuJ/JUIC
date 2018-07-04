<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="BudgetPrint.aspx.cs" Inherits="JuicERP.Pages.BudgetPrint" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div style="font-family: 微軟正黑體">
            <asp:Panel ID="Panel1" runat="server">
                <%--    <div align="center">--%>
                <asp:Label ID="Label5" runat="server" Text="久威國際股份有限公司" Width="25%" Font-Size="x-Large"></asp:Label><br />
                <asp:Label ID="Label6" runat="server" Text="2018年各月預算費用統計" Width="25%" Font-Size="x-Large"></asp:Label><br />
                <asp:Label ID="Label7" runat="server" Text="部門：" Width="25%" Font-Size="x-Large"></asp:Label><br />
                <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False"  Width="1900px" OnRowDataBound="GridView1_RowDataBound" ShowFooter="True">
                    <Columns>
                        <asp:BoundField DataField="AccNO" HeaderText="科目編號" SortExpression="AccNO">
                            <ItemStyle Width="70px" />
                        </asp:BoundField>
                        <asp:BoundField DataField="AccName" HeaderText="科目名稱" SortExpression="AccName">
                            <ItemStyle Width="200px" />
                        </asp:BoundField>
                        <asp:BoundField DataField="ps" HeaderText="編制說明" SortExpression="ps">
                            <ItemStyle Width="290px" />
                        </asp:BoundField>
                        <asp:BoundField DataField="mon01" HeaderText="1月" SortExpression="mon01" DataFormatString="{0:N0}">
                            <ItemStyle HorizontalAlign="Right" Width="80px" />
                        </asp:BoundField>
                        <asp:BoundField DataField="mon02" HeaderText="2月" SortExpression="mon02" DataFormatString="{0:N0}">
                            <ItemStyle HorizontalAlign="Right" Width="80px" />
                        </asp:BoundField>
                        <asp:BoundField DataField="mon03" HeaderText="3月" SortExpression="mon03" DataFormatString="{0:N0}">
                            <ItemStyle HorizontalAlign="Right" Width="80px" />
                        </asp:BoundField>
                        <asp:BoundField DataField="mon04" HeaderText="4月" SortExpression="mon04" DataFormatString="{0:N0}">
                            <ItemStyle HorizontalAlign="Right" Width="80px" />
                        </asp:BoundField>
                        <asp:BoundField DataField="mon05" HeaderText="5月" SortExpression="mon05" DataFormatString="{0:N0}">
                            <ItemStyle HorizontalAlign="Right" Width="80px" />
                        </asp:BoundField>
                        <asp:BoundField DataField="mon06" HeaderText="6月" SortExpression="mon06" DataFormatString="{0:N0}">
                            <ItemStyle HorizontalAlign="Right" Width="80px" />
                        </asp:BoundField>
                        <asp:BoundField DataField="mon07" HeaderText="7月" SortExpression="mon07" DataFormatString="{0:N0}">
                            <ItemStyle HorizontalAlign="Right" Width="80px" />
                        </asp:BoundField>
                        <asp:BoundField DataField="mon08" HeaderText="8月" SortExpression="mon08" DataFormatString="{0:N0}">
                            <ItemStyle HorizontalAlign="Right" Width="80px" />
                        </asp:BoundField>
                        <asp:BoundField DataField="mon09" HeaderText="9月" SortExpression="mon09" DataFormatString="{0:N0}">
                            <ItemStyle HorizontalAlign="Right" Width="80px" />
                        </asp:BoundField>
                        <asp:BoundField DataField="mon10" HeaderText="10月" SortExpression="mon10" DataFormatString="{0:N0}">
                            <ItemStyle HorizontalAlign="Right" Width="80px" />
                        </asp:BoundField>
                        <asp:BoundField DataField="mon11" HeaderText="11月" SortExpression="mon11" DataFormatString="{0:N0}">
                            <ItemStyle HorizontalAlign="Right" Width="80px" />
                        </asp:BoundField>
                        <asp:BoundField DataField="mon12" HeaderText="12月" SortExpression="mon12" DataFormatString="{0:N0}">
                            <ItemStyle HorizontalAlign="Right" Width="80px" />
                        </asp:BoundField>
                        <asp:BoundField DataField="2018年合計" HeaderText="2018年合計" SortExpression="2018年合計" DataFormatString="{0:N0}">
                            <ItemStyle HorizontalAlign="Right" Width="100px" />
                        </asp:BoundField>
                        <asp:BoundField DataField="2017年" HeaderText="2017年" SortExpression="2017年" DataFormatString="{0:N0}">
                            <ItemStyle HorizontalAlign="Right" Width="100px" />
                        </asp:BoundField>
                        <asp:BoundField DataField="增(減)" HeaderText="增(減)" SortExpression="增(減)" DataFormatString="{0:N0}">
                            <ItemStyle HorizontalAlign="Right" Width="100px" />
                        </asp:BoundField>
                        <asp:BoundField DataField="增(減)率" DataFormatString="{0:P0}" HeaderText="增(減)率" SortExpression="增(減)率">
                            <ItemStyle HorizontalAlign="Right" Width="80px" />
                        </asp:BoundField>
                    </Columns>
                    <FooterStyle HorizontalAlign="Right" />
                </asp:GridView>

                <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:MENU %>" SelectCommand="SELECT a.[year], a.[AccNO], a.[AccName], [mon01], [mon02], [mon03], [mon04], [mon05], [mon06], [mon07], [mon08], [mon09], [mon10], [mon11], [mon12],([mon01]+[mon02]+[mon03]+[mon04]+[mon05]+[mon06]+[mon07]+[mon08]+[mon09]+[mon10]+[mon11]+[mon12]) as '2018年合計',ISNULL(CONVERT(int,ROUND(([mon1b]+[mon2b]+[mon3b]+[mon4b]+[mon5b]+[mon6b]+[mon7b]+[mon8b]+[mon9b]+[mon10b]+[mon11b]+[mon12a]),0)),0)as '2017年',(([mon01]+[mon02]+[mon03]+[mon04]+[mon05]+[mon06]+[mon07]+[mon08]+[mon09]+[mon10]+[mon11]+[mon12])-ISNULL(CONVERT(int,ROUND(([mon1b]+[mon2b]+[mon3b]+[mon4b]+[mon5b]+[mon6b]+[mon7b]+[mon8b]+[mon9b]+[mon10b]+[mon11b]+[mon12a]),0)),0)) as '增(減)',case when ISNULL(CONVERT(int,ROUND(([mon1b]+[mon2b]+[mon3b]+[mon4b]+[mon5b]+[mon6b]+[mon7b]+[mon8b]+[mon9b]+[mon10b]+[mon11b]+[mon12a]),0)),0)=0 then 0 else ((([mon01]+[mon02]+[mon03]+[mon04]+[mon05]+[mon06]+[mon07]+[mon08]+[mon09]+[mon10]+[mon11]+[mon12])-ISNULL(CONVERT(int,ROUND(([mon1b]+[mon2b]+[mon3b]+[mon4b]+[mon5b]+[mon6b]+[mon7b]+[mon8b]+[mon9b]+[mon10b]+[mon11b]+[mon12a]),0)),0))/CONVERT(NUMERIC(15,2),ROUND(([mon1b]+[mon2b]+[mon3b]+[mon4b]+[mon5b]+[mon6b]+[mon7b]+[mon8b]+[mon9b]+[mon10b]+[mon11b]+[mon12a]),0))) end as '增(減)率',[ps] 
FROM [TB_BudgetTable] a
left join [TB_BudgetCompare] b
on (a.[year]=b.[year]) and (a.[AccNO]=b.[AccNO]) and (a.[dept_no]=b.[dept_no])
where (a.[year] = @year) AND ([TypeWrt] = @TypeWrt) AND (a.[dept_no] = @dept_no) 
">
                    <SelectParameters>
                        <asp:QueryStringParameter DefaultValue="2018" Name="year" QueryStringField="year" Type="Int32" />
                        <asp:Parameter DefaultValue="n0" Name="TypeWrt" />
                        <asp:QueryStringParameter DefaultValue="" Name="dept_no" QueryStringField="dept" Type="String" />
                    </SelectParameters>
                </asp:SqlDataSource>
                <br />
                <table style="width: 1700px;">
                    <tr>
                        <td style="width: 380px; font-size: x-large;">董事長：</td>
                        <td style="width: 380px; font-size: x-large;">總經理：</td>
                        <td style="width: 380px; font-size: x-large;">處級主管：</td>
                        <td style="width: 380px; font-size: x-large;">部級主管：</td>
                        <td style="width: 300px; font-size: x-large;">製表人：</td>
                    </tr>
                </table>
                <br />
                <%--<asp:Label ID="Label0" runat="server" Text="董事長：" Width="20%" Font-Size="Large"></asp:Label>
                <asp:Label ID="Label1" runat="server" Text="總經理：" Width="20%" Font-Size="Large"></asp:Label>
                <asp:Label ID="Label2" runat="server" Text="處級主管：" Width="20%" Font-Size="Large"></asp:Label>
                <asp:Label ID="Label3" runat="server" Text="部級主管：" Width="20%" Font-Size="Large"></asp:Label>
                <asp:Label ID="Label4" runat="server" Text="製表人：" Width="18%" Font-Size="Large"></asp:Label>--%>
                <%--         </div>--%>
            </asp:Panel>
            <br />
            <br />
            <br />
            <br />
            <br />
        </div>
    </form>
</body>
</html>
