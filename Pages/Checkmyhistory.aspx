<%@ Page Title="" Language="C#" MasterPageFile="~/Master/JuicERP.Master" AutoEventWireup="true" CodeBehind="Checkmyhistory.aspx.cs" Inherits="JuicERP.Pages.Checkmyhistory" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">
        .auto-style2 {
            color: #000080;
            font-weight: normal;
        }
    </style>
    <style type="text/css">
                table.table_class tbody  tr th  
                {
                 text-align:center !important;
                }

    </style>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="col-md-1">
    </div>
    <div class="col-md-10" style="font-family: 微軟正黑體">
        <asp:Label ID="Label1" runat="server" Text="Label" Visible="False"></asp:Label>
        <asp:Label ID="Label2" runat="server" Text="Label" Visible="False"></asp:Label>

        <%-- <asp:Panel ID="Panel4" runat="server">
            <h3 style="font-weight: normal; color: #000080;">個人請假狀況一覽</h3>
            <asp:GridView ID="GridView3" runat="server" EmptyDataText="您本月無請假資料。" CellPadding="4" ForeColor="#333333" GridLines="Both" Width="100%">
                <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                <EditRowStyle BackColor="#999999" />
                <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White"  />
                <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
                <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
                <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
                <SortedAscendingCellStyle BackColor="#E9E7E2" />
                <SortedAscendingHeaderStyle BackColor="#506C8C" />
                <SortedDescendingCellStyle BackColor="#FFFDF8" />
                <SortedDescendingHeaderStyle BackColor="#6F8DAE" />
            </asp:GridView>
            <asp:SqlDataSource ID="SqlDataSource8" runat="server"></asp:SqlDataSource>
        </asp:Panel>--%>

        <asp:Panel ID="Panel1" runat="server">
            <h4 style="font-weight: normal; color: #800080;">您可查詢
 <asp:DropDownList ID="DropDownList1" runat="server" DataSourceID="SqlDataSource4" OnSelectedIndexChanged="DropDownList1_SelectedIndexChanged" AutoPostBack="True" DataTextField="emp_cne" DataValueField="emp_no" Width="100px"></asp:DropDownList>
                的出勤紀錄與狀況
            </h4>

            <asp:SqlDataSource ID="SqlDataSource4" runat="server" ConnectionString="<%$ ConnectionStrings:MENU %>" SelectCommand="WITH DirectReports ([KEY5], [DEPA_NO], [emp_cne],[emp_no], [DEPA_NE1], Level)
AS
(
  SELECT e.[KEY5], e.[DEPA_NO], e.[emp_cne],e.[emp_no], e.[DEPA_NE1], 
        0 AS Level
    FROM [chuck15companytree] AS e
    WHERE e.[emp_no] =@emp_no
	UNION ALL
	SELECT e.[KEY5], e.[DEPA_NO], e.[emp_cne],e.[emp_no], e.[DEPA_NE1],
        Level + 1
    FROM [chuck15companytree] AS e

    INNER JOIN DirectReports AS d
        ON e.[KEY5] = d.[DEPA_NO]
		)
		select * from DirectReports
		union
		   select [KEY3], [emp_no], [emp_cne],[emp_no], [DEPA_NE1],''  FROM [juic].[dbo].[chuck15companytree] where @emp_no=KEY3 and @emp_no&lt;&gt;emp_no">
                <SelectParameters>
                    <asp:ControlParameter ControlID="Label2" Name="emp_no" PropertyName="Text" />
                </SelectParameters>
            </asp:SqlDataSource>
            <asp:SqlDataSource ID="SqlDataSource5" runat="server" ConnectionString="<%$ ConnectionStrings:MENU %>" SelectCommand="SELECT [emp_cne], [emp_no] FROM [juic].[dbo].[pay11] WHERE ([c01] = @c01)
union
SELECT [emp_cne], [emp_no] FROM [jutw].[dbo].[pay11] WHERE ([c01] = @c01)
order by [emp_no] ">
                <SelectParameters>
                    <asp:Parameter DefaultValue="1" Name="c01" />
                </SelectParameters>
            </asp:SqlDataSource>
        </asp:Panel>

        <h3 style="font-weight: normal; color: #000080;">假別狀況一覽(已請完之時數不做列表)</h3>
        <%--        <asp:UpdatePanel ID="UpdatePanel1" runat="server">--%>
        <%--        <ContentTemplate>--%>
        <%--   <asp:DropDownList ID="DropDownList1" runat="server" AutoPostBack="True" DataSourceID="SqlDataSource2" DataTextField="date" DataValueField="date">
                        <asp:ListItem>201703</asp:ListItem>
                    </asp:DropDownList>
                    <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:MENU %>" SelectCommand="SELECT * FROM [TB_Date]"></asp:SqlDataSource>--%>
        <asp:Label ID="Label3" runat="server" Text="Label" Font-Italic="False" Font-Size="Larger"></asp:Label>
        <br />

        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource2" Width="100%" OnRowDataBound="GridView1_RowDataBound">
            <Columns>
                <asp:BoundField DataField="pay0602" HeaderText="假別" SortExpression="pay0602" />
                <asp:BoundField DataField="s_d" HeaderText="開始時間" SortExpression="s_d" />
                <asp:BoundField DataField="e_d" HeaderText="到期時間" SortExpression="e_d" />
                <asp:BoundField DataField="n01" HeaderText="可請假天數" SortExpression="n01" />
                <asp:BoundField DataField="n03" HeaderText="剩餘可請假天數" ReadOnly="True" SortExpression="n03" />
            </Columns>
            <HeaderStyle Font-Size="Larger" />
            <RowStyle Font-Size="Large" />
        </asp:GridView>
        <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:MENU %>" SelectCommand="SELECT [emp_no], [pay0602], [s_d], [e_d], [n01], [n02], [n03] FROM [chuck10] WHERE ([emp_no] = @emp_no)">
            <SelectParameters>
                <asp:ControlParameter ControlID="Label1" Name="emp_no" PropertyName="Text" Type="String" />
            </SelectParameters>
        </asp:SqlDataSource>
        <asp:Panel ID="Panel3" runat="server" Visible="false">
            <h3 class="auto-style2">即時刷卡紀錄查詢(10筆)<asp:CheckBox ID="CheckBox1" runat="server" Text="點我展開" AutoPostBack="True" ForeColor="Red" OnCheckedChanged="CheckBox1_CheckedChanged" />
            </h3>
            <asp:Panel ID="Panel2" runat="server" Visible="false">
                <asp:GridView ID="GridView2" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource6" CssClass="table table-hover" PageSize="30" BackColor="White" BorderColor="#DEDFDE" BorderStyle="None" BorderWidth="1px" CellPadding="4" ForeColor="Black" GridLines="Vertical" OnRowDataBound="GridView2_RowDataBound" Visible="False">
                    <FooterStyle BackColor="#CCCC99" />
                    <HeaderStyle BackColor="#6B696B" Font-Bold="True" ForeColor="White" />
                    <PagerSettings Position="TopAndBottom" />
                    <PagerStyle CssClass="pagination-ys" BackColor="#F7F7DE" ForeColor="Black" HorizontalAlign="Right" />
                    <AlternatingRowStyle BackColor="White" />
                    <Columns>
                        <asp:BoundField DataField="emp_cne" HeaderText="員工姓名" SortExpression="emp_cne" />
                        <asp:BoundField DataField="card_no" HeaderText="卡片號碼" SortExpression="card_no" />
                        <asp:BoundField DataField="ymd1" HeaderText="刷卡日期" SortExpression="ymd1" />
                        <asp:BoundField DataField="tc" HeaderText="刷卡時間" SortExpression="tc" />
                        <asp:BoundField DataField="rc" HeaderText="補刷紀錄" SortExpression="rc" />
                    </Columns>
                    <RowStyle BackColor="#F7F7DE" />
                    <SelectedRowStyle BackColor="#CE5D5A" Font-Bold="True" ForeColor="White" />
                    <SortedAscendingCellStyle BackColor="#FBFBF2" />
                    <SortedAscendingHeaderStyle BackColor="#848384" />
                    <SortedDescendingCellStyle BackColor="#EAEAD3" />
                    <SortedDescendingHeaderStyle BackColor="#575357" />
                </asp:GridView>
            </asp:Panel>
            <asp:SqlDataSource ID="SqlDataSource6" runat="server" ConnectionString="<%$ ConnectionStrings:MENU %>" SelectCommand="SELECT TOP(10) emp_cne, card_no, ymd1, tc, rc FROM chuck03 WHERE (emp_no = @emp_no) ORDER BY ymd1 DESC, tc DESC">
                <SelectParameters>
                    <asp:ControlParameter ControlID="Label1" Name="emp_no" PropertyName="Text" />
                </SelectParameters>
            </asp:SqlDataSource>
        </asp:Panel>

        <h3 class="auto-style2">近二月考勤紀錄查詢</h3>

        <asp:DropDownList ID="DropDownList2" runat="server" AutoPostBack="True">
        </asp:DropDownList>
        <br />
        <asp:DetailsView ID="DetailsView1" runat="server" AutoGenerateRows="False" DataKeyNames="emp_no" DataSourceID="SqlDataSource3" Height="50px" Visible="False" Width="125px">
            <Fields>
                <asp:BoundField DataField="a_d" HeaderText="a_d" SortExpression="a_d" />
                <asp:BoundField DataField="emp_no" HeaderText="emp_no" ReadOnly="True" SortExpression="emp_no" />
                <asp:BoundField DataField="emp_cne" HeaderText="emp_cne" SortExpression="emp_cne" />
                <asp:BoundField DataField="attn" HeaderText="attn" SortExpression="attn" />
                <asp:BoundField DataField="birthday" HeaderText="birthday" SortExpression="birthday" />
            </Fields>
        </asp:DetailsView>
        <asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:MENU %>" SelectCommand="SELECT [a_d], [emp_no],[emp_cne], [attn], [birthday] FROM [pay11] WHERE ([emp_no] = @emp_no)">
            <SelectParameters>
                <asp:ControlParameter ControlID="Label1" Name="emp_no" PropertyName="Text" Type="String" />
            </SelectParameters>
        </asp:SqlDataSource>
        <br />
        <%--<asp:Panel ID="Panel4" runat="server">--%>
        <h3 style="font-weight: normal; color: #000080;">個人出勤狀況一覽</h3>
        <asp:GridView ID="GridView3" runat="server" EmptyDataText="您本月無請假資料。"  CssClass="table_class " HorizontalAlign="Center" OnRowDataBound="GridView3_DataBound" BackColor="White" BorderColor="#3366CC" BorderStyle="None" BorderWidth="1px" CellPadding="4" Width="100%">
            <FooterStyle BackColor="#99CCCC" ForeColor="#003399" />
            <HeaderStyle BackColor="#003399" Font-Bold="True" ForeColor="#CCCCFF" HorizontalAlign="Center" />
            <PagerStyle BackColor="#99CCCC" ForeColor="#003399" HorizontalAlign="right" />
            <RowStyle BackColor="White" ForeColor="#003399" HorizontalAlign="Center" />
            <SelectedRowStyle BackColor="#009999" Font-Bold="True" ForeColor="#CCFF99" />
            <SortedAscendingCellStyle BackColor="#EDF6F6" />
            <SortedAscendingHeaderStyle BackColor="#0D4AC4" />
            <SortedDescendingCellStyle BackColor="#D6DFDF" />
            <SortedDescendingHeaderStyle BackColor="#002876" />
        </asp:GridView>
        <%-- </asp:Panel>--%>

        <br />
        <asp:UpdatePanel ID="UpdatePanel2" runat="server">
            <ContentTemplate>
                <asp:GridView ID="check" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource7" AllowPaging="True" AllowSorting="True" CssClass="table table-hover" PageSize="32" BackColor="White" BorderColor="#DEDFDE" BorderStyle="None" BorderWidth="1px" CellPadding="4" ForeColor="Black" GridLines="Vertical" OnRowDataBound="check_RowDataBound">
                    <FooterStyle BackColor="#CCCC99" />
                    <HeaderStyle BackColor="#6B696B" Font-Bold="True" ForeColor="White" />
                    <PagerSettings Position="TopAndBottom" />
                    <PagerStyle CssClass="pagination-ys" BackColor="#F7F7DE" ForeColor="Black" HorizontalAlign="Right" />
                    <AlternatingRowStyle BackColor="White" />
                    <Columns>
                        <asp:BoundField DataField="ymd" HeaderText="日期" SortExpression="ymd" />
                        <asp:BoundField DataField="ymd" HeaderText="星期" />
                        <asp:BoundField DataField="t01" HeaderText="刷卡時間" SortExpression="t01" />
                        <asp:BoundField DataField="t02" HeaderText="刷退時間" SortExpression="t02" />
                        <asp:BoundField DataField="rllu_name" HeaderText="狀況" SortExpression="rllu_name" />
                        <asp:BoundField DataField="chs" HeaderText="時數" SortExpression="chs" />
                    </Columns>
                    <RowStyle BackColor="#F7F7DE" />
                    <SelectedRowStyle BackColor="#CE5D5A" Font-Bold="True" ForeColor="White" />
                    <SortedAscendingCellStyle BackColor="#FBFBF2" />
                    <SortedAscendingHeaderStyle BackColor="#848384" />
                    <SortedDescendingCellStyle BackColor="#EAEAD3" />
                    <SortedDescendingHeaderStyle BackColor="#575357" />
                </asp:GridView>
                <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:MENU %>" SelectCommand="SELECT * FROM [chuck09] WHERE ([emp_no] = @emp_no) and  (ymd  LIKE '%' + @ymd+ '%')">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="Label1" Name="emp_no" PropertyName="Text" Type="String" />
                        <asp:ControlParameter ControlID="DropDownList2" Name="ymd" PropertyName="SelectedValue" />
                    </SelectParameters>
                </asp:SqlDataSource>
                <%--<asp:SqlDataSource ID="SqlDataSource7" runat="server" ConnectionString="<%$ ConnectionStrings:MENU %>" SelectCommand="SELECT * FROM [chuck09new2] WHERE ([emp_no] = @emp_no) and  (ymd  LIKE '%' + @ymd+ '%')
order by ymd desc">--%>
                <asp:SqlDataSource ID="SqlDataSource7" runat="server" ConnectionString="<%$ ConnectionStrings:MENU %>" SelectCommand="SELECT * FROM [chuck09new2] WHERE ([emp_no] = @emp_no) and  (ymd  LIKE '%' + @ymd+ '%') and kind is not null order by ymd desc">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="Label1" Name="emp_no" PropertyName="Text" Type="String" />
                        <asp:ControlParameter ControlID="DropDownList2" Name="ymd" PropertyName="SelectedValue" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>
    <br />
    <div class="col-md-1">
    </div>

</asp:Content>
