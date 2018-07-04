<%@ Page Title="" Language="C#" MasterPageFile="~/Master/JuicERP.Master" AutoEventWireup="true" CodeBehind="Update.aspx.cs" Inherits="JuicERP.Pages.Update" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div style="font-family: 微軟正黑體">
    <asp:GridView ID="GridView1" runat="server" AllowPaging="True" AutoGenerateColumns="False" DataSourceID="SqlDataSource1" EnableModelValidation="True" PageSize="6" CssClass="table table-hover" GridLines="Horizontal">
                         <PagerSettings Position="TopAndBottom" />
                    <PagerStyle CssClass="pagination-ys" />
                <Columns>
            <asp:BoundField DataField="date" HeaderText="更新日期" SortExpression="date" ItemStyle-Width="20%" DataFormatString="{0:d}" >
<ItemStyle Width="20%"></ItemStyle>
                    </asp:BoundField>
            <asp:BoundField DataField="type" HeaderText="更新類型" SortExpression="type" ItemStyle-Width="10%">
<ItemStyle Width="10%"></ItemStyle>
                    </asp:BoundField>
            <asp:BoundField DataField="content" HeaderText="內容" SortExpression="content" ItemStyle-Width="70%">
<ItemStyle Width="70%"></ItemStyle>
                    </asp:BoundField>
        </Columns>
    </asp:GridView>
        </div>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:MENU %>" SelectCommand="SELECT [date], [type], [content] FROM [TB_Update] order by date desc"></asp:SqlDataSource>
</asp:Content>
