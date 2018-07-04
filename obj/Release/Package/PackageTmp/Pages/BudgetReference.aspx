<%@ Page Title="" Language="C#" MasterPageFile="~/Master/JuicERP.Master" AutoEventWireup="true" CodeBehind="BudgetReference.aspx.cs" Inherits="JuicERP.Pages.BudgetReference" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.8.2/jquery.min.js"></script>
    <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.9.1/jquery-ui.min.js"></script>
    <script type="text/javascript" src="../js/gridviewScroll.min.js"></script>
    <script type="text/javascript">
        $(document).ready(function () {
            gridviewScroll();

        });
        function gridviewScroll() {
            $('#<%=GridView1.ClientID%>').gridviewScroll({
                width: 1080,
                height: 500,
                freezesize: 2

            });
        }
    </script>
    <%--    凍結窗格指令--%>
    <style type="text/css">
        .GridviewScrollHeader TH, .GridviewScrollHeader TD {
            padding: 1px;
            font-weight: bold;
            white-space: nowrap;
            border-right: 1px solid #AAAAAA;
            border-bottom: 1px solid #AAAAAA;
            background-color: #EFEFEF;
            text-align: left;
            vertical-align: bottom;
        }

        .GridviewScrollItem TD {
            padding: 1px;
            white-space: nowrap;
            border-right: 1px solid #AAAAAA;
            border-bottom: 1px solid #AAAAAA;
            background-color: #FFFFFF;
            height: 40px;
        }

        .GridviewScrollPager {
            border-top: 1px solid #AAAAAA;
            background-color: #FFFFFF;
        }

            .GridviewScrollPager TD {
                padding-top: 3px;
                font-size: 14px;
                padding-left: 5px;
                padding-right: 5px;
            }

            .GridviewScrollPager A {
                color: #666666;
            }

            .GridviewScrollPager SPAN {
                font-size: 16px;
                font-weight: bold;
            }
    </style>
    <%--    凍結窗格指令--%>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div style="font-family: 微軟正黑體">
        <asp:Panel ID="Panel1" runat="server" ScrollBars="Horizontal">
            <div align="center">
                 <asp:Label ID="Label1" runat="server" Text="2017各部門預算實支比" Font-Size="Large" Font-Bold="True"></asp:Label>
                 <br />
                 <br />
                 選擇查看的預算部門(T久國J久威)<br /> <asp:DropDownList ID="DropDownList1" runat="server" Width="200px" AutoPostBack="True" DataSourceID="SqlDataSource1" DataTextField="emp_deptCh" DataValueField="emp_dept" OnSelectedIndexChanged="DropDownList1_SelectedIndexChanged" AppendDataBoundItems="True">
                     <asp:ListItem>請選擇</asp:ListItem>
                 </asp:DropDownList>
                 <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:MENU %>" SelectCommand="SELECT ([emp_dept]+[emp_deptCh]) as [emp_deptCh], [emp_dept] FROM [TB_BudgetLevel] WHERE (([emp_no] = @emp_no) AND ([emp_dept] &lt;&gt; @emp_dept)) AND ([TypeWrt]&lt;&gt;@TypeWrt)">
                     <SelectParameters>
                         <asp:ControlParameter ControlID="Label4" DefaultValue="" Name="emp_no" PropertyName="Text" />
                         <asp:Parameter DefaultValue="ALL" Name="emp_dept" />
                         <asp:Parameter DefaultValue="sa" Name="TypeWrt" />
                     </SelectParameters>
                 </asp:SqlDataSource>
                 <br />
                 <asp:Label ID="Label4" runat="server" Text="Label" Visible="False"></asp:Label>
                 <asp:Label ID="label3" runat="server" Text="" Font-Size="Larger"></asp:Label><br />
                <asp:Label ID="Label2" runat="server" Text="" Visible="False"></asp:Label>
                <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" BackColor="White" BorderColor="#999999" BorderStyle="None" BorderWidth="1px" CellPadding="3" DataKeyNames="id" DataSourceID="SqlDataSource3" GridLines="Vertical">
                    <AlternatingRowStyle BackColor="#DCDCDC" />
                    <Columns>
                        <asp:BoundField DataField="AccNO" HeaderText="編號" SortExpression="AccNO" >
                        <ItemStyle Width="80px" />
                        </asp:BoundField>
                        <asp:BoundField DataField="AccName" HeaderText="科目名稱" SortExpression="AccName" >
                        <ItemStyle Width="160px" />
                        </asp:BoundField>
                        <asp:BoundField DataField="mon1a" DataFormatString="{0:N0}" HeaderText="1月預算數" SortExpression="mon1a" >
                        <ItemStyle HorizontalAlign="Right" Width="100px" />
                        </asp:BoundField>
                        <asp:BoundField DataField="mon1b" DataFormatString="{0:N0}" HeaderText="1月實際數" SortExpression="mon1b" >
                        <ItemStyle HorizontalAlign="Right" Width="100px" />
                        </asp:BoundField>
                        <asp:BoundField DataField="mon1p" DataFormatString="{0:P}" HeaderText="1月實支比" ReadOnly="True" SortExpression="mon1p" >
                        <ItemStyle HorizontalAlign="Right" Width="100px" />
                        </asp:BoundField>
                        <asp:BoundField DataField="mon2a" DataFormatString="{0:N0}" HeaderText="2月預算數" SortExpression="mon2a" >
                        <ItemStyle HorizontalAlign="Right" Width="100px" />
                        </asp:BoundField>
                        <asp:BoundField DataField="mon2b" DataFormatString="{0:N0}" HeaderText="2月實際數" SortExpression="mon2b" >
                        <ItemStyle HorizontalAlign="Right" Width="100px" />
                        </asp:BoundField>
                        <asp:BoundField DataField="mon2p" DataFormatString="{0:P}" HeaderText="2月實支比" ReadOnly="True" SortExpression="mon2p" >
                        <ItemStyle HorizontalAlign="Right" Width="100px" />
                        </asp:BoundField>
                        <asp:BoundField DataField="mon3a" DataFormatString="{0:N0}" HeaderText="3月預算數" SortExpression="mon3a" >
                        <ItemStyle HorizontalAlign="Right" Width="100px" />
                        </asp:BoundField>
                        <asp:BoundField DataField="mon3b" DataFormatString="{0:N0}" HeaderText="3月實際數" SortExpression="mon3b" >
                        <ItemStyle HorizontalAlign="Right" Width="100px" />
                        </asp:BoundField>
                        <asp:BoundField DataField="mon3p" DataFormatString="{0:P}" HeaderText="3月實支比" ReadOnly="True" SortExpression="mon3p" >
                        <ItemStyle HorizontalAlign="Right" Width="100px" />
                        </asp:BoundField>
                        <asp:BoundField DataField="mon4a" DataFormatString="{0:N0}" HeaderText="4月預算數" SortExpression="mon4a" >
                        <ItemStyle HorizontalAlign="Right" Width="100px" />
                        </asp:BoundField>
                        <asp:BoundField DataField="mon4b" DataFormatString="{0:N0}" HeaderText="4月實際數" SortExpression="mon4b" >
                        <ItemStyle HorizontalAlign="Right" Width="100px" />
                        </asp:BoundField>
                        <asp:BoundField DataField="mon4p" DataFormatString="{0:P}" HeaderText="4月實支比" ReadOnly="True" SortExpression="mon4p" >
                        <ItemStyle HorizontalAlign="Right" Width="100px" />
                        </asp:BoundField>
                        <asp:BoundField DataField="mon5a" DataFormatString="{0:N0}" HeaderText="5月預算數" SortExpression="mon5a" >
                        <ItemStyle HorizontalAlign="Right" Width="100px" />
                        </asp:BoundField>
                        <asp:BoundField DataField="mon5b" DataFormatString="{0:N0}" HeaderText="5月實際數" SortExpression="mon5b" >
                        <ItemStyle HorizontalAlign="Right" Width="100px" />
                        </asp:BoundField>
                        <asp:BoundField DataField="mon5p" DataFormatString="{0:P}" HeaderText="5月實支比" ReadOnly="True" SortExpression="mon5p" >
                        <ItemStyle HorizontalAlign="Right" Width="100px" />
                        </asp:BoundField>
                        <asp:BoundField DataField="mon6a" DataFormatString="{0:N0}" HeaderText="6月預算數" SortExpression="mon6a" >
                        <ItemStyle HorizontalAlign="Right" Width="100px" />
                        </asp:BoundField>
                        <asp:BoundField DataField="mon6b" DataFormatString="{0:N0}" HeaderText="6月實際數" SortExpression="mon6b" >
                        <ItemStyle HorizontalAlign="Right" Width="100px" />
                        </asp:BoundField>
                        <asp:BoundField DataField="mon6p" DataFormatString="{0:P}" HeaderText="6月實支比" ReadOnly="True" SortExpression="mon6p" >
                        <ItemStyle HorizontalAlign="Right" Width="100px" />
                        </asp:BoundField>
                        <asp:BoundField DataField="mon7a" DataFormatString="{0:N0}" HeaderText="7月預算數" SortExpression="mon7a" >
                        <ItemStyle HorizontalAlign="Right" Width="100px" />
                        </asp:BoundField>
                        <asp:BoundField DataField="mon7b" DataFormatString="{0:N0}" HeaderText="7月實際數" SortExpression="mon7b" >
                        <ItemStyle HorizontalAlign="Right" Width="100px" />
                        </asp:BoundField>
                        <asp:BoundField DataField="mon7p" DataFormatString="{0:P}" HeaderText="7月實支比" ReadOnly="True" SortExpression="mon7p" >
                        <ItemStyle HorizontalAlign="Right" Width="100px" />
                        </asp:BoundField>
                        <asp:BoundField DataField="mon8a" DataFormatString="{0:N0}" HeaderText="8月預算數" SortExpression="mon8a" >
                        <ItemStyle HorizontalAlign="Right" Width="100px" />
                        </asp:BoundField>
                        <asp:BoundField DataField="mon8b" DataFormatString="{0:N0}" HeaderText="8月實際數" SortExpression="mon8b" >
                        <ItemStyle HorizontalAlign="Right" Width="100px" />
                        </asp:BoundField>
                        <asp:BoundField DataField="mon8p" DataFormatString="{0:P}" HeaderText="8月實支比" ReadOnly="True" SortExpression="mon8p" >
                        <ItemStyle HorizontalAlign="Right" Width="100px" />
                        </asp:BoundField>
                        <asp:BoundField DataField="mon9a" DataFormatString="{0:N0}" HeaderText="9月預算數" SortExpression="mon9a" >
                        <ItemStyle HorizontalAlign="Right" Width="100px" />
                        </asp:BoundField>
                        <asp:BoundField DataField="mon9b" DataFormatString="{0:N0}" HeaderText="9月實際數" SortExpression="mon9b" >
                        <ItemStyle HorizontalAlign="Right" Width="100px" />
                        </asp:BoundField>
                        <asp:BoundField DataField="mon9p" DataFormatString="{0:P}" HeaderText="9月實支比" ReadOnly="True" SortExpression="mon9p" >
                        <ItemStyle HorizontalAlign="Right" Width="100px" />
                        </asp:BoundField>
                        <asp:BoundField DataField="mon10a" DataFormatString="{0:N0}" HeaderText="10月預算數" SortExpression="mon10a" >
                        <ItemStyle HorizontalAlign="Right" Width="100px" />
                        </asp:BoundField>
                        <asp:BoundField DataField="mon10b" DataFormatString="{0:N0}" HeaderText="10月實際數" SortExpression="mon10b" >
                        <ItemStyle HorizontalAlign="Right" Width="100px" />
                        </asp:BoundField>
                        <asp:BoundField DataField="mon10p" DataFormatString="{0:P}" HeaderText="10月實支比" ReadOnly="True" SortExpression="mon10p" >
                        <ItemStyle HorizontalAlign="Right" Width="100px" />
                        </asp:BoundField>
                        <asp:BoundField DataField="mon11a" DataFormatString="{0:N0}" HeaderText="11月預算數" SortExpression="mon11a" >
                        <ItemStyle HorizontalAlign="Right" Width="100px" />
                        </asp:BoundField>
                        <asp:BoundField DataField="mon11b" DataFormatString="{0:N0}" HeaderText="11月實際數" SortExpression="mon11b" >
                        <ItemStyle HorizontalAlign="Right" Width="100px" />
                        </asp:BoundField>
                        <asp:BoundField DataField="mon11p" DataFormatString="{0:P}" HeaderText="11月實支比" ReadOnly="True" SortExpression="mon11p" >
                        <ItemStyle HorizontalAlign="Right" Width="100px" />
                        </asp:BoundField>
                        <asp:BoundField DataField="mon12a" DataFormatString="{0:N0}" HeaderText="12月預算數" SortExpression="mon12a" >
                        <ItemStyle HorizontalAlign="Right" Width="100px" />
                        </asp:BoundField>
                        <asp:BoundField DataField="mon12b" DataFormatString="{0:N0}" HeaderText="12月實際數" SortExpression="mon12b" >
                        <ItemStyle HorizontalAlign="Right" Width="100px" />
                        </asp:BoundField>
                        <asp:BoundField DataField="mon12p" DataFormatString="{0:P}" HeaderText="12月實支比" ReadOnly="True" SortExpression="mon12p" >
                        <ItemStyle HorizontalAlign="Right" Width="100px" />
                        </asp:BoundField>
                    </Columns>
                    <FooterStyle BackColor="#CCCCCC" ForeColor="Black" />
                    <HeaderStyle BackColor="#000084" Font-Bold="True" ForeColor="White" />
                    <PagerStyle BackColor="#999999" ForeColor="Black" HorizontalAlign="Center" />
                    <RowStyle BackColor="#EEEEEE" ForeColor="Black" />
                    <SelectedRowStyle BackColor="#008A8C" Font-Bold="True" ForeColor="White" />
                    <SortedAscendingCellStyle BackColor="#F1F1F1" />
                    <SortedAscendingHeaderStyle BackColor="#0000A9" />
                    <SortedDescendingCellStyle BackColor="#CAC9C9" />
                    <SortedDescendingHeaderStyle BackColor="#000065" />
                 </asp:GridView>
                 <asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:MENU %>" SelectCommand="select  id
      ,year
      ,AccNO
      ,AccName
      ,dept_no,
mon1a,mon1b,(case when mon1a=0 then 0 else mon1b/mon1a end)as mon1p, 
mon2a,mon2b,(case when mon2a=0 then 0 else mon2b/mon2a end)as mon2p,
mon3a,mon3b,(case when mon3a=0 then 0 else mon3b/mon3a end)as mon3p,
mon4a,mon4b,(case when mon4a=0 then 0 else mon4b/mon4a end)as mon4p,
mon5a,mon5b,(case when mon5a=0 then 0 else mon5b/mon5a end)as mon5p,
mon6a,mon6b,(case when mon6a=0 then 0 else mon6b/mon6a end)as mon6p,
mon7a,mon7b,(case when mon7a=0 then 0 else mon7b/mon7a end)as mon7p,
mon8a,mon8b,(case when mon8a=0 then 0 else mon8b/mon8a end)as mon8p,
mon9a,mon9b,(case when mon9a=0 then 0 else mon9b/mon9a end)as mon9p,
mon10a,mon10b,(case when mon10a=0 then 0 else mon10b/mon10a end)as mon10p,
mon11a,mon11b,(case when mon11a=0 then 0 else mon11b/mon11a end)as mon11p,
mon12a,mon12b,(case when mon12a=0 then 0 else mon12b/mon12a end)as mon12p
from TB_BudgetCompare
where [dept_no]=@dept_no  and [AccNO]&lt;&gt;'6251000'and [AccNO]&lt;&gt;'6251001'and [AccNO]&lt;&gt;'6151000'and [AccNO]&lt;&gt;'6262002'and [AccNO]&lt;&gt;'6262001'and [AccNO]&lt;&gt;'6283000'and [AccNO]&lt;&gt;'6281000'">
                     <SelectParameters>
                         <asp:ControlParameter ControlID="Label2" Name="dept_no" PropertyName="Text" />
                     </SelectParameters>
                 </asp:SqlDataSource>
            </div>
        </asp:Panel>
    </div>
</asp:Content>
