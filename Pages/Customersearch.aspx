<%@ Page Title="" Language="C#" MasterPageFile="~/Master/JuicERP.Master" AutoEventWireup="true" CodeBehind="Customersearch.aspx.cs" Inherits="JuicERP.Pages.Search.Customer" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

                <div style="font-family: 微軟正黑體">
                                        <h3 style=" font-weight: normal; color: #000080;">公司客戶查詢(限JUIC資料庫已建檔)</h3>
    <asp:TextBox ID="TextBox1" runat="server"></asp:TextBox>
    <asp:Button ID="Button1" runat="server" Text="客戶名稱查詢(空白為全部查詢)" />
    <asp:GridView ID="Customergiv" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource1" AllowPaging="True" AllowSorting="True" CssClass="table table-hover" PageSize="30" BackColor="White" BorderColor="#CCCCCC" BorderStyle="None" BorderWidth="1px" CellPadding="3">
                            <FooterStyle BackColor="White" ForeColor="#000066" />
                            <HeaderStyle BackColor="#006699" Font-Bold="True" ForeColor="White" />
                            <PagerSettings Position="TopAndBottom" />
                    <PagerStyle CssClass="pagination-ys" BackColor="White" ForeColor="#000066" HorizontalAlign="Left" />
        <Columns>
            <asp:BoundField DataField="CUS_NE2" HeaderText="客戶名稱" SortExpression="CUS_NE2" ItemStyle-Width="15%" >
<ItemStyle Width="15%"></ItemStyle>
            </asp:BoundField>
            <asp:BoundField DataField="ADDR1" HeaderText="公司住址" SortExpression="ADDR1" ItemStyle-Width="15%">
<ItemStyle Width="15%"></ItemStyle>
            </asp:BoundField>
            <asp:BoundField DataField="TEL1" HeaderText="電話" SortExpression="TEL1" ItemStyle-Width="5%">
<ItemStyle Width="10%"></ItemStyle>
            </asp:BoundField>
            <asp:BoundField DataField="COMP_ID" HeaderText="統編" SortExpression="COMP_ID" ItemStyle-Width="5%">
<ItemStyle Width="6%"></ItemStyle>
            </asp:BoundField>
            <asp:BoundField DataField="LIAISE" HeaderText="聯絡人" SortExpression="LIAISE" ItemStyle-Width="7%">
<ItemStyle Width="7%"></ItemStyle>
            </asp:BoundField>
            <asp:BoundField DataField="SAL0601" HeaderText="職稱" SortExpression="SAL0601" ItemStyle-Width="13%">
<ItemStyle Width="7%"></ItemStyle>
            </asp:BoundField>
            <asp:BoundField DataField="CRET_L" DataFormatString="{0:N}" HeaderText="授信額度" SortExpression="CRET_L">
            <ItemStyle Width="6%" />
            </asp:BoundField>
            <asp:BoundField DataField="pay_ne2" HeaderText="帳款條件" SortExpression="pay_ne2">
            <ItemStyle Width="20%" />
            </asp:BoundField>
        </Columns>
                            <RowStyle ForeColor="#000066" />
                            <SelectedRowStyle BackColor="#669999" Font-Bold="True" ForeColor="White" />
                            <SortedAscendingCellStyle BackColor="#F1F1F1" />
                            <SortedAscendingHeaderStyle BackColor="#007DBB" />
                            <SortedDescendingCellStyle BackColor="#CAC9C9" />
                            <SortedDescendingHeaderStyle BackColor="#00547E" />
    </asp:GridView>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:MENU %>" SelectCommand="SELECT * FROM [chuck01] WHERE ([CUS_NE2] LIKE '%' + @CUS_NE2 + '%')">
        <SelectParameters>
            <asp:ControlParameter ControlID="TextBox1" DefaultValue="_" Name="CUS_NE2" PropertyName="Text" Type="String" />
        </SelectParameters>
    </asp:SqlDataSource>
                      </div>

</asp:Content>
