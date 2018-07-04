<%@ Page Title="" Language="C#" MasterPageFile="~/Master/JuicERP.Master" AutoEventWireup="true" CodeBehind="MISservicedetail.aspx.cs" Inherits="JuicERP.Pages.MISservicedetail" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

        <div class="col-md-2">
    </div>
    <div class="col-md-8" style="font-family: 微軟正黑體">
        <asp:DetailsView ID="DetailsView1" runat="server" Height="60px" Width="100%" AutoGenerateRows="False" BackColor="#CCCCCC" BorderColor="#999999" BorderStyle="Solid" BorderWidth="3px" CellPadding="10" CellSpacing="2" DataSourceID="SqlDataSource1" ForeColor="Black">
            <EditRowStyle BackColor="#000099" Font-Bold="True" ForeColor="White" />
            <Fields>
                <asp:BoundField DataField="NO" HeaderText="編號" SortExpression="NO" HeaderStyle-Width="20%" ItemStyle-Width="80%" >
<HeaderStyle Width="20%"></HeaderStyle>

<ItemStyle Width="80%"></ItemStyle>
                </asp:BoundField>
                <asp:BoundField DataField="category" HeaderText="問題類型" SortExpression="category" />
                <asp:BoundField DataField="problem" HeaderText="問題內容" SortExpression="problem" />
                <asp:BoundField DataField="emp_cne" HeaderText="申請人" SortExpression="emp_cne" />
                <asp:BoundField DataField="situation" HeaderText="處理狀態" SortExpression="situation" />
                <asp:BoundField DataField="testsituation" HeaderText="測試狀態" SortExpression="testsituation" />
                <asp:BoundField DataField="testfeedback" HeaderText="測試回饋" SortExpression="testfeedback" />
                <asp:BoundField DataField="priority" HeaderText="優先度" SortExpression="priority" />
                <asp:BoundField DataField="date" HeaderText="申請日期" SortExpression="date" DataFormatString="{0:d}" />
                <asp:BoundField DataField="enddate1" HeaderText="處理日期" SortExpression="enddate1" DataFormatString="{0:d}" />
                <asp:BoundField DataField="enddate2" HeaderText="測試日期" SortExpression="enddate2" DataFormatString="{0:d}" />
                <asp:BoundField DataField="finishdate" HeaderText="完成日期" SortExpression="finishdate" DataFormatString="{0:d}" />
                <asp:BoundField DataField="mis_cne" HeaderText="負責人" SortExpression="mis_cne" />
                <asp:BoundField DataField="PS" HeaderText="處理狀況/備註" SortExpression="PS" />
                <asp:BoundField DataField="feedback" HeaderText="回饋資料" SortExpression="feedback" />
            </Fields>
            <FooterStyle BackColor="#CCCCCC" />
            <HeaderStyle BackColor="Black" Font-Bold="True" ForeColor="White" />
            <PagerStyle BackColor="#CCCCCC" ForeColor="Black" HorizontalAlign="Left" />
            <RowStyle BackColor="White" />
        </asp:DetailsView>
        </div>
            <div class="col-md-2">
    </div>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:MENU %>" SelectCommand="SELECT * FROM [TB_MISservice] WHERE ([NO] = @NO)">
        <SelectParameters>
            <asp:QueryStringParameter DefaultValue="20160001" Name="NO" QueryStringField="pid" Type="String" />
        </SelectParameters>
        </asp:SqlDataSource>
</asp:Content>
