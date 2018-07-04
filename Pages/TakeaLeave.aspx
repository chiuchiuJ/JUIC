<%@ Page Title="" Language="C#" MasterPageFile="~/Master/JuicERP.Master" AutoEventWireup="true" CodeBehind="TakeaLeave.aspx.cs" Inherits="JuicERP.Pages.TakeaLeave" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
              <div class="col-md-1">
  </div>
                <div class="col-md-10" style="font-family: 微軟正黑體">
                             <h3 style=" font-weight: normal; color: #000080;">請/休假紀錄查詢</h3>
    <asp:Label ID="Label2" runat="server"></asp:Label>
    <asp:Button ID="Button1" runat="server" Text="查詢自己" />
    <asp:sqldatasource runat="server" ID="SqlDataSource1" ConnectionString="<%$ ConnectionStrings:MENU %>" SelectCommand="SELECT emp_cne, pay0602, ind_d, ymd_s, ymd_e, hs, rmk1 FROM chuck04 WHERE (emp_cne = @emp_cne) ORDER BY ymd_s DESC">
        <SelectParameters>
            <asp:ControlParameter ControlID="Label2" Name="emp_cne" PropertyName="Text" Type="String" />
        </SelectParameters>
    </asp:sqldatasource>
    <asp:TextBox ID="TextBox1" runat="server"></asp:TextBox>
    <asp:Button ID="Button2" runat="server" OnClick="Button2_Click" Text="查詢其他員工(中文全名)" />
    <asp:gridview runat="server" AllowPaging="True" CssClass="table table-hover" DataSourceID="SqlDataSource1" PageSize="15" AllowSorting="True" AutoGenerateColumns="False" BackColor="White" BorderColor="#999999" BorderStyle="None" BorderWidth="1px" CellPadding="3" GridLines="Vertical">
                                        <AlternatingRowStyle BackColor="#DCDCDC" />
                                        <Columns>
                                            <asp:BoundField DataField="emp_cne" HeaderText="員工姓名" SortExpression="emp_cne" />
                                            <asp:BoundField DataField="pay0602" HeaderText="假別" SortExpression="pay0602" />
                                            <asp:BoundField DataField="ind_d" HeaderText="申請日期" SortExpression="ind_d" />
                                            <asp:BoundField DataField="ymd_s" HeaderText="請假開始日" SortExpression="ymd_s" />
                                            <asp:BoundField DataField="ymd_e" HeaderText="請假結束日" SortExpression="ymd_e" />
                                            <asp:BoundField DataField="hs" HeaderText="時數" SortExpression="hs" />
                                            <asp:BoundField DataField="rmk1" HeaderText="備註" SortExpression="rmk1" />
                                        </Columns>
                                        <FooterStyle BackColor="#CCCCCC" ForeColor="Black" />
                                        <HeaderStyle BackColor="#000084" Font-Bold="True" ForeColor="White" />
                                        <PagerSettings Position="TopAndBottom" />
                    <PagerStyle CssClass="pagination-ys" BackColor="#999999" ForeColor="Black" HorizontalAlign="Center" />        
                                        <RowStyle BackColor="#EEEEEE" ForeColor="Black" />
                                        <SelectedRowStyle BackColor="#008A8C" Font-Bold="True" ForeColor="White" />
                                        <SortedAscendingCellStyle BackColor="#F1F1F1" />
                                        <SortedAscendingHeaderStyle BackColor="#0000A9" />
                                        <SortedDescendingCellStyle BackColor="#CAC9C9" />
                                        <SortedDescendingHeaderStyle BackColor="#000065" />
    </asp:gridview>
                                                                                  </div>
        <br />
                <div class="col-md-1">
  </div>
</asp:Content>
