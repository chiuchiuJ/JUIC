<%@ Page Title="" Language="C#" MasterPageFile="~/Master/JuicERP.Master" AutoEventWireup="true" CodeBehind="BudgetReference2.aspx.cs" Inherits="JuicERP.Pages.BudgetReference2" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div style="font-family: 微軟正黑體">
        <asp:Panel ID="Panel1" runat="server" ScrollBars="Horizontal">
            <div align="center">
                選擇查看明細帳的部門(T久國J久威)
    <asp:DropDownList ID="DropDownList1" runat="server" AppendDataBoundItems="True" AutoPostBack="True" DataSourceID="SqlDataSource1" DataTextField="emp_deptCh" DataValueField="emp_dept" OnSelectedIndexChanged="DropDownList1_SelectedIndexChanged" Width="250">
        <asp:ListItem>請選擇</asp:ListItem>
    </asp:DropDownList>
                <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:MENU %>" SelectCommand="select [emp_no],[emp_dept],([emp_dept]+[emp_deptCh])as'emp_deptCh'
from [TB_BudgetLevel]
where [emp_no]=@emp_no and [TypeWrt]=@TypeWrt ">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="Label1" Name="emp_no" PropertyName="Text" />
                        <asp:Parameter DefaultValue="n0" Name="TypeWrt" />
                    </SelectParameters>
                </asp:SqlDataSource>
                <asp:Label ID="Label1" runat="server" Text="Label" Visible="false"></asp:Label>
                <asp:Label ID="Label2" runat="server" Text="Label" Visible="false"></asp:Label>
                <br /><br />
                <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource2" PageSize="50" AllowPaging="True" AllowSorting="True" BackColor="#CCCCCC" BorderColor="#999999" BorderStyle="Solid" BorderWidth="3px" CellPadding="4" CellSpacing="2" ForeColor="Black">
                    <Columns>
                        <asp:BoundField DataField="日期" HeaderText="日期" SortExpression="日期" ItemStyle-Width="100" >
                        <ItemStyle Width="100px" />
                        </asp:BoundField>
                        <asp:BoundField DataField="會計科目編號" HeaderText="會計科目編號" SortExpression="會計科目編號" ItemStyle-Width="100" >
                        <ItemStyle Width="100px" />
                        </asp:BoundField>
                        <asp:BoundField DataField="摘要" HeaderText="摘要" SortExpression="摘要" ItemStyle-Width="400" >
                        <ItemStyle Width="400px" />
                        </asp:BoundField>
                        <asp:BoundField DataField="幣別" HeaderText="幣別" SortExpression="幣別" ItemStyle-Width="30" >
                        <ItemStyle HorizontalAlign="Center" Width="50px" />
                        </asp:BoundField>
                        <asp:BoundField DataField="匯率" HeaderText="匯率" SortExpression="匯率" ItemStyle-Width="30">
                        <ItemStyle HorizontalAlign="Center" Width="50px" />
                        </asp:BoundField>
                        <asp:BoundField DataField="金額" HeaderText="金額" SortExpression="金額" ItemStyle-Width="30" DataFormatString="{0:N0}">
                        <ItemStyle HorizontalAlign="Right" Width="100px" />
                        </asp:BoundField>
                        <asp:BoundField DataField="會計科目名稱" HeaderText="會計科目名稱" SortExpression="會計科目名稱" >
                        <ItemStyle Width="170px" />
                        </asp:BoundField>
                    </Columns>
                    <FooterStyle BackColor="#CCCCCC" />
                    <HeaderStyle BackColor="Black" Font-Bold="True" ForeColor="White" />
                    <PagerStyle BackColor="#CCCCCC" ForeColor="Black" HorizontalAlign="Left" />
                    <RowStyle BackColor="White" />
                    <SelectedRowStyle BackColor="#000099" Font-Bold="True" ForeColor="White" />
                    <SortedAscendingCellStyle BackColor="#F1F1F1" />
                    <SortedAscendingHeaderStyle BackColor="#808080" />
                    <SortedDescendingCellStyle BackColor="#CAC9C9" />
                    <SortedDescendingHeaderStyle BackColor="#383838" />
                </asp:GridView>
                <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:MENU %>" SelectCommand="SELECT  [日期]
      ,[傳票編號]
      ,[序號]
      ,[部門代號]
      ,[新部門代號]
      ,[會計科目編號]
      ,[摘要]
      ,[借方1貸方0]
      ,[幣別]
      ,[匯率]
      ,[金額]
      ,[會計科目名稱]
  FROM [juic].[dbo].[chuck13AccDetailForBudget]
where [新部門代號]=@dept and [會計科目編號]&lt;&gt;'6251000'and [會計科目編號]&lt;&gt;'6251001'and [會計科目編號]&lt;&gt;'6151000'and [會計科目編號]&lt;&gt;'6262002'and [會計科目編號]&lt;&gt;'6262001'and [會計科目編號]&lt;&gt;'6283000'and [會計科目編號]&lt;&gt;'6281000'
   Order By [會計科目編號],[傳票編號],[序號]">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="Label2" Name="dept" PropertyName="Text" />
                    </SelectParameters>
                </asp:SqlDataSource>
                <br />
                <br />
                <br />
                <br />
                <br />
            </div>
        </asp:Panel>
    </div>
</asp:Content>
