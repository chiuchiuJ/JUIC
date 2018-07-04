<%@ Page Title="" Language="C#" MasterPageFile="~/Master/JuicERP.Master" AutoEventWireup="true" CodeBehind="Checkhistory.aspx.cs" Inherits="JuicERP.Pages.Checkhistory" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
          <div class="col-md-1">
  </div>
                <div class="col-md-10" style="font-family: 微軟正黑體">
                    <h3 style=" font-weight: normal; color: #000080;">刷卡紀錄查詢</h3>
<%--        <asp:UpdatePanel ID="UpdatePanel1" runat="server">--%>
<%--        <ContentTemplate>--%>
        <asp:Label ID="Label1" runat="server"></asp:Label>
    <asp:Button ID="Button1" runat="server" Text="查詢自己" OnClick="Button1_Click" />


    <asp:TextBox ID="TextBox1" runat="server"></asp:TextBox>
    <asp:Button ID="Button2" runat="server" Text="查詢其他員工(中文全名)" OnClick="Button2_Click" />
                    <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                                <ContentTemplate>
    <asp:GridView ID="check" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource1" AllowPaging="True" AllowSorting="True" CssClass="table table-hover" PageSize="30" OnRowDataBound="check_RowDataBound" BackColor="White" BorderColor="#DEDFDE" BorderStyle="None" BorderWidth="1px" CellPadding="4" ForeColor="Black" GridLines="Vertical">
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
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:MENU %>" SelectCommand="SELECT emp_cne, card_no, ymd1, tc, rc FROM chuck03 WHERE (emp_cne = @emp_cne) ORDER BY ymd1 DESC, tc DESC">
        <SelectParameters>
            <asp:ControlParameter ControlID="Label1" Name="emp_cne" PropertyName="Text" Type="String" />
        </SelectParameters>
        </asp:SqlDataSource>
            </ContentTemplate>
            </asp:UpdatePanel>
                                                              </div>
    <br />
                <div class="col-md-1">
  </div>
</asp:Content>
