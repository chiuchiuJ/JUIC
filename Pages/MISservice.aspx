<%@ Page Title="" Language="C#" MasterPageFile="~/Master/JuicERP.Master" AutoEventWireup="true" CodeBehind="MISservice.aspx.cs" Inherits="JuicERP.Pages.MISservice" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="col-md-1">
    </div>
    <div class="col-md-10" style="font-family: 微軟正黑體">
        <asp:Label ID="checkma" runat="server" Text="Label" Visible="False"></asp:Label>
        
                <asp:Button ID="Button1" runat="server" Text="新增需求單" CssClass="btn btn-success" OnClick="Button1_Click" />
            <asp:Button ID="btnexcel" runat="server" Text="Excel下載" OnClick="btnexcel_Click" CssClass="btn btn-primary" />

    <asp:GridView ID="gridexcel" runat="server" AutoGenerateColumns="False" DataKeyNames="NO" DataSourceID="Sqlexcel" Visible="False" Font-Names="標楷體" OnRowDataBound="gridexcel_RowDataBound">
        <Columns>
<%--            <asp:BoundField DataField="emp_no" HeaderText="emp_no" SortExpression="emp_no" />--%>
           <%-- <asp:BoundField DataField="testfinishdate" HeaderText="testfinishdate" SortExpression="testfinishdate" />--%>
           <%-- <asp:BoundField DataField="mis_no" HeaderText="mis_no" SortExpression="mis_no" />--%>
    <%--        <asp:BoundField DataField="feedback" HeaderText="feedback" SortExpression="feedback" />--%>
            <asp:BoundField DataField="NO" HeaderText="編號" ReadOnly="True" SortExpression="NO" />
            <asp:BoundField DataField="category" HeaderText="問題類型" SortExpression="category" />
            <asp:BoundField DataField="type" HeaderText="問題分類" />
            <asp:BoundField DataField="problem" HeaderText="問題內容" SortExpression="problem" />
            <asp:BoundField DataField="emp_cne" HeaderText="申請人" SortExpression="emp_cne" />
            <asp:BoundField DataField="situation" HeaderText="處理狀態" SortExpression="situation" />
            <asp:BoundField DataField="testsituation" HeaderText="測試狀態" SortExpression="testsituation" />
            <asp:BoundField DataField="priority" HeaderText="優先度" SortExpression="priority" />
            <asp:BoundField DataField="date" HeaderText="申請日期" SortExpression="date" DataFormatString="{0:d}" >
            <ItemStyle HorizontalAlign="Center" />
            </asp:BoundField>
            <asp:BoundField DataField="enddate1" HeaderText="處理日期" SortExpression="enddate1" DataFormatString="{0:d}" >
            <ItemStyle HorizontalAlign="Center" />
            </asp:BoundField>
            <asp:BoundField DataField="enddate2" HeaderText="測試日期" SortExpression="enddate2" DataFormatString="{0:d}" >
            <ItemStyle HorizontalAlign="Center" />
            </asp:BoundField>
            <asp:BoundField DataField="finishdate" HeaderText="完成日期" SortExpression="finishdate" DataFormatString="{0:d}" >
            <ItemStyle HorizontalAlign="Center" />
            </asp:BoundField>
            <asp:BoundField DataField="mis_cne" HeaderText="MIS負責人" SortExpression="mis_cne" />
            <asp:BoundField DataField="testfeedback" HeaderText="測試回饋" SortExpression="testfeedback" />
            <asp:BoundField DataField="PS" HeaderText="處理狀況/備註" SortExpression="PS" />
        </Columns>
    </asp:GridView>

    <asp:SqlDataSource ID="Sqlexcel" runat="server" ConnectionString="<%$ ConnectionStrings:MENU %>" SelectCommand="SELECT * FROM [TB_MISservice]"></asp:SqlDataSource>

        <br />
        <asp:Panel ID="Panel1" runat="server" Visible="False" Font-Names="微軟正黑體">
            問題分類：<br />
            <asp:DropDownList ID="DropDownList1" runat="server" Width="15%">
                            <asp:ListItem Value="ERP系統" Text="ERP系統"></asp:ListItem>
                            <asp:ListItem Value="知識平台" Text="知識平台"></asp:ListItem>
                            <asp:ListItem Value="電腦狀況" Text="電腦狀況"></asp:ListItem>
            </asp:DropDownList>


            <br />
            需求說明：<br />
            <asp:TextBox ID="TextBox1" runat="server" Height="58px" TextMode="MultiLine" Width="572px"></asp:TextBox>

            <br />

            <asp:Button ID="Button2" runat="server" Text="送出" CssClass="btn btn-primary" OnClick="Button2_Click" />

            <br />
            <asp:Label ID="usname" runat="server" Text="Label" Visible="False"></asp:Label>
            <br />

        </asp:Panel>
        <asp:GridView ID="service" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource1" AllowPaging="True" AllowSorting="True" CssClass="table table-hover" PageSize="30" BackColor="White" BorderColor="#DEDFDE" BorderStyle="None" BorderWidth="1px" CellPadding="4" ForeColor="Black" GridLines="Vertical" OnRowDataBound="service_RowDataBound" OnRowCommand="service_RowCommand">
            <FooterStyle BackColor="#CCCC99" />
            <HeaderStyle BackColor="#6B696B" Font-Bold="True" ForeColor="White" />
            <PagerSettings Position="TopAndBottom" />
            <PagerStyle CssClass="pagination-ys" BackColor="White" ForeColor="Black" HorizontalAlign="Right" />
            <AlternatingRowStyle BackColor="White" />
            <Columns>
                <asp:BoundField DataField="NO" HeaderText="編號" SortExpression="NO" />
                <asp:BoundField DataField="category" HeaderText="問題類型" SortExpression="category" />
                <asp:BoundField DataField="type" HeaderText="問題分類" SortExpression="type" />
                <asp:HyperLinkField DataNavigateUrlFields="NO" DataNavigateUrlFormatString="MISservicedetail.aspx?pid={0}" DataTextField="problem" HeaderText="問題內容" Target="_blank" />
                <asp:BoundField DataField="emp_cne" HeaderText="申請人" SortExpression="emp_cne" />
                <asp:BoundField DataField="situation" HeaderText="處理狀態" SortExpression="situation" />
                <asp:BoundField DataField="testsituation" HeaderText="測試狀態" SortExpression="testsituation" />
                <asp:BoundField DataField="date" HeaderText="申請日期" SortExpression="date" DataFormatString="{0:d}" />
                <asp:BoundField DataField="enddate1" DataFormatString="{0:d}" HeaderText="程式完成日期" SortExpression="enddate1" Visible="False" />
                <asp:BoundField DataField="finishdate" HeaderText="完成日期" SortExpression="finishdate" DataFormatString="{0:d}" />
                <asp:BoundField DataField="mis_cne" HeaderText="負責人員" SortExpression="mis_cne" />
                <asp:TemplateField HeaderText="管理選項">
                    <ItemTemplate>
                        <asp:Button ID="manage" runat="server" Text="管理" CommandName="manage" CssClass="btn btn-success btn-xs" Visible="False" CommandArgument='<%# Eval("NO") %>' />
                        <asp:Button ID="edit" runat="server" Text="編輯" CommandName="edit" CssClass="btn btn-waring btn-xs" Visible="False" CommandArgument='<%# Eval("NO") %>' />
                        <asp:Button ID="remove" runat="server" Text="刪除" CommandName="remove" CssClass="btn btn-danger btn-xs" Visible="False" CommandArgument='<%# Eval("NO") %>' />
                        <asp:Button ID="print" runat="server" Text="列印" CommandName="print" CssClass="btn btn-primary btn-xs" Visible="False" CommandArgument='<%# Eval("NO")+",,"+Eval("emp_cne") %>' />
                          <asp:Button ID="usertest" runat="server" Text="測試回報" CommandName="usertest" CssClass="btn btn-primary btn-xs" Visible="False" CommandArgument='<%# Eval("NO") %>' />
                        <asp:Button ID="upload" runat="server" Text="附件" CommandName="upload" CssClass="btn btn-success btn-xs" Visible="true" CommandArgument='<%# Eval("NO") %>' />
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
            <RowStyle BackColor="#F7F7DE" />
            <SelectedRowStyle BackColor="#CE5D5A" Font-Bold="True" ForeColor="White" />
            <SortedAscendingCellStyle BackColor="#FBFBF2" />
            <SortedAscendingHeaderStyle BackColor="#848384" />
            <SortedDescendingCellStyle BackColor="#EAEAD3" />
            <SortedDescendingHeaderStyle BackColor="#575357" />
        </asp:GridView>

        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:MENU %>" SelectCommand="SELECT [NO], [category], [type], SUBSTRING(problem,0,12)+'....(詳細)' as 'problem', [emp_no],[emp_cne], [situation], [testsituation], [date], [finishdate], [enddate1], [mis_cne] FROM [TB_MISservice] order by NO desc" DeleteCommand="DELETE FROM [TB_MISservice] WHERE [NO] = @NO" InsertCommand="INSERT INTO [TB_MISservice] ([NO], [category], [problem], [emp_no], [emp_cne], [situation], [testsituation], [testfeedback], [priority], [date], [enddate1], [enddate2], [finishdate], [testfinishdate], [mis_no], [mis_cne], [PS], [feedback]) VALUES (@NO, @category, @problem, @emp_no, @emp_cne, @situation, @testsituation, @testfeedback, @priority, @date, @enddate1, @enddate2, @finishdate, @testfinishdate, @mis_no, @mis_cne, @PS, @feedback)" UpdateCommand="UPDATE [TB_MISservice] SET [category] = @category, [problem] = @problem, [emp_no] = @emp_no, [emp_cne] = @emp_cne, [situation] = @situation, [testsituation] = @testsituation, [testfeedback] = @testfeedback, [priority] = @priority, [date] = @date, [enddate1] = @enddate1, [enddate2] = @enddate2, [finishdate] = @finishdate, [testfinishdate] = @testfinishdate, [mis_no] = @mis_no, [mis_cne] = @mis_cne, [PS] = @PS, [feedback] = @feedback WHERE [NO] = @NO">
            <DeleteParameters>
                <asp:Parameter Name="NO" Type="String" />
            </DeleteParameters>
            <InsertParameters>
                <asp:Parameter Name="NO" Type="String" />
                <asp:Parameter Name="category" Type="String" />
                <asp:Parameter Name="problem" Type="String" />
                <asp:Parameter Name="emp_no" Type="String" />
                <asp:Parameter Name="emp_cne" Type="String" />
                <asp:Parameter Name="situation" Type="String" />
                <asp:Parameter Name="testsituation" Type="String" />
                <asp:Parameter Name="testfeedback" Type="String" />
                <asp:Parameter Name="priority" Type="String" />
                <asp:Parameter Name="date" Type="DateTime" />
                <asp:Parameter Name="enddate1" Type="DateTime" />
                <asp:Parameter Name="enddate2" Type="DateTime" />
                <asp:Parameter Name="finishdate" Type="DateTime" />
                <asp:Parameter Name="testfinishdate" Type="DateTime" />
                <asp:Parameter Name="mis_no" Type="String" />
                <asp:Parameter Name="mis_cne" Type="String" />
                <asp:Parameter Name="PS" Type="String" />
                <asp:Parameter Name="feedback" Type="String" />
            </InsertParameters>
            <UpdateParameters>
                <asp:Parameter Name="category" Type="String" />
                <asp:Parameter Name="problem" Type="String" />
                <asp:Parameter Name="emp_no" Type="String" />
                <asp:Parameter Name="emp_cne" Type="String" />
                <asp:Parameter Name="situation" Type="String" />
                <asp:Parameter Name="testsituation" Type="String" />
                <asp:Parameter Name="testfeedback" Type="String" />
                <asp:Parameter Name="priority" Type="String" />
                <asp:Parameter Name="date" Type="DateTime" />
                <asp:Parameter Name="enddate1" Type="DateTime" />
                <asp:Parameter Name="enddate2" Type="DateTime" />
                <asp:Parameter Name="finishdate" Type="DateTime" />
                <asp:Parameter Name="testfinishdate" Type="DateTime" />
                <asp:Parameter Name="mis_no" Type="String" />
                <asp:Parameter Name="mis_cne" Type="String" />
                <asp:Parameter Name="PS" Type="String" />
                <asp:Parameter Name="feedback" Type="String" />
                <asp:Parameter Name="NO" Type="String" />
            </UpdateParameters>
        </asp:SqlDataSource>



        <br />



    </div>
    <div class="col-md-1">
    </div>
</asp:Content>
