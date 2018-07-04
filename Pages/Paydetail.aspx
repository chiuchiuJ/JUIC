<%@ Page Title="" Language="C#" MasterPageFile="~/Master/JuicERP.Master" AutoEventWireup="true" CodeBehind="Paydetail.aspx.cs" Inherits="JuicERP.Pages.Paydetail" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
        <div class="col-md-2">
    </div>
    <div class="col-md-8" style="font-family: 微軟正黑體; font-size: large;">
        <br />
        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource1" Width="100%" BackColor="White" BorderColor="#DEDFDE" BorderStyle="None" BorderWidth="1px" CellPadding="4" ForeColor="Black" GridLines="Vertical">
            <AlternatingRowStyle BackColor="White" />
            <Columns>
                <asp:BoundField DataField="id" HeaderText="款項編號" InsertVisible="False" ReadOnly="True" SortExpression="id" />
                <asp:BoundField DataField="paymentid" HeaderText="所屬請款單ID" SortExpression="paymentid" />
                <asp:BoundField DataField="dept_no" HeaderText="dept_no" SortExpression="dept_no" Visible="False" />
                <asp:BoundField DataField="dept_cne" HeaderText="款項歸屬部門" SortExpression="dept_cne" />
                <asp:BoundField DataField="comment" HeaderText="請款內容" SortExpression="comment" />
                <asp:BoundField DataField="payment" HeaderText="款項金額" SortExpression="payment" DataFormatString="{0:N0}" />
            </Columns>
            <FooterStyle BackColor="#CCCC99" />
            <HeaderStyle BackColor="#6B696B" Font-Bold="True" ForeColor="White" />
            <PagerStyle BackColor="#F7F7DE" ForeColor="Black" HorizontalAlign="Right" />
            <RowStyle BackColor="#F7F7DE" />
            <SelectedRowStyle BackColor="#CE5D5A" Font-Bold="True" ForeColor="White" />
            <SortedAscendingCellStyle BackColor="#FBFBF2" />
            <SortedAscendingHeaderStyle BackColor="#848384" />
            <SortedDescendingCellStyle BackColor="#EAEAD3" />
            <SortedDescendingHeaderStyle BackColor="#575357" />
        </asp:GridView>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:MENU %>" SelectCommand="SELECT * FROM [TB_Paymentdetail] WHERE ([paymentid] = @id)">
            <SelectParameters>
                <asp:QueryStringParameter Name="id" QueryStringField="pid" Type="Int32" />
            </SelectParameters>
        </asp:SqlDataSource>
        <br />
        <br />
        <br />
        </div>
            <div class="col-md-2">
    </div>

</asp:Content>
