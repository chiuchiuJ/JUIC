<%@ Page Title="" Language="C#" MasterPageFile="~/Master/JuicERP.Master" AutoEventWireup="true" CodeBehind="Suppliersearch.aspx.cs" Inherits="JuicERP.Pages.Suppliersearch" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div  style="font-family: 微軟正黑體">
        <h3 style="font-weight: normal; color: #000080;">公司供應商查詢(限JUIC資料庫已建檔)</h3>
        <asp:TextBox ID="TextBox1" runat="server"></asp:TextBox>
        <asp:Button ID="Button1" runat="server" Text="供應商名稱查詢(空白為全部查詢)" />
        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource1" AllowPaging="True" AllowSorting="True" CssClass="table table-hover" PageSize="30" BackColor="White" BorderColor="#CCCCCC" BorderStyle="None" BorderWidth="1px" CellPadding="3">
            <Columns>
                <asp:BoundField DataField="SUP_NE2" HeaderText="供應商名稱" SortExpression="SUP_NE2" ItemStyle-Width="25%">
                    <ItemStyle Width="20%"></ItemStyle>
                </asp:BoundField>
                <asp:BoundField DataField="ADDR1" HeaderText="地址" SortExpression="ADDR1" ItemStyle-Width="20%">
                    <ItemStyle Width="15%"></ItemStyle>
                </asp:BoundField>
                <asp:BoundField DataField="TEL1" HeaderText="電話" SortExpression="TEL1" ItemStyle-Width="15%">
                    <ItemStyle Width="12%"></ItemStyle>
                </asp:BoundField>
                <asp:BoundField DataField="COMP_ID" HeaderText="公司統編" SortExpression="COMP_ID" ItemStyle-Width="10%">
                    <ItemStyle Width="8%"></ItemStyle>
                </asp:BoundField>
                <asp:BoundField DataField="emp_cne" HeaderText="採購人員" SortExpression="emp_cne" ItemStyle-Width="10%">
                    <ItemStyle Width="5%"></ItemStyle>
                </asp:BoundField>
                <asp:BoundField DataField="RMK1" HeaderText="備註" SortExpression="RMK1" ItemStyle-Width="20%">
                    <ItemStyle Width="15%"></ItemStyle>
                </asp:BoundField>
                <asp:BoundField DataField="pay_ne2" HeaderText="月結條件">
                    <ItemStyle Width="25%" />
                </asp:BoundField>
            </Columns>
            <FooterStyle BackColor="White" ForeColor="#000066" />
            <HeaderStyle BackColor="#006699" Font-Bold="True" ForeColor="White" />
            <PagerSettings Position="TopAndBottom" />
            <PagerStyle CssClass="pagination-ys" BackColor="White" ForeColor="#000066" HorizontalAlign="Left" />
            <RowStyle ForeColor="#000066" />
            <SelectedRowStyle BackColor="#669999" Font-Bold="True" ForeColor="White" />
            <SortedAscendingCellStyle BackColor="#F1F1F1" />
            <SortedAscendingHeaderStyle BackColor="#007DBB" />
            <SortedDescendingCellStyle BackColor="#CAC9C9" />
            <SortedDescendingHeaderStyle BackColor="#00547E" />
        </asp:GridView>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:MENU %>" SelectCommand="SELECT * FROM [chuck02] WHERE ([SUP_NE2] LIKE '%' + @SUP_NE2 + '%')">
            <SelectParameters>
                <asp:ControlParameter ControlID="TextBox1" DefaultValue="_" Name="SUP_NE2" PropertyName="Text" Type="String" />
            </SelectParameters>
        </asp:SqlDataSource>
    </div>

</asp:Content>
