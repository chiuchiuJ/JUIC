<%@ Page Title="" Language="C#" MasterPageFile="~/Master/JuicERP.Master" AutoEventWireup="true" CodeBehind="Misserviceusertest.aspx.cs" Inherits="JuicERP.Pages.Misserviceusertest" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">


    <div class="col-md-2">
    </div>
    <div class="col-md-8" style="font-family: 微軟正黑體">

        <asp:DetailsView ID="DetailsView1" runat="server" Height="60px" Width="100%" AutoGenerateRows="False" BackColor="#CCCCCC" BorderColor="#999999" BorderStyle="Solid" BorderWidth="3px" CellPadding="10" CellSpacing="2" DataSourceID="SqlDataSource1" ForeColor="Black" DataKeyNames="NO" OnItemUpdated="DetailsView1_ItemUpdated" OnItemCommand="DetailsView1_ItemCommand" DefaultMode="Edit" OnModeChanged="DetailsView1_ModeChanged">
            <%--<EditRowStyle BackColor="#000099" Font-Bold="True" ForeColor="White" />--%>
            <Fields>
        

               <%-- <asp:BoundField DataField="testsituation" HeaderText="testsituation" SortExpression="testsituation" />
                <asp:BoundField DataField="testfeedback" HeaderText="testfeedback" SortExpression="testfeedback" />--%>
                <asp:BoundField DataField="NO" HeaderText="編號" ReadOnly="True" SortExpression="NO" />
                <asp:BoundField DataField="emp_no" HeaderText="申請人ID" ReadOnly="True" SortExpression="emp_no" />
        
           <asp:TemplateField  HeaderStyle-Width="20%" ItemStyle-Width="80%" HeaderText="測試狀態">
                    <ItemTemplate>
                        <%# Eval("testsituation") %>
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:Label ID="Label1" runat="server" Text='<%# Eval("testsituation") %>' Visible="false"></asp:Label>
                        <asp:DropDownList ID="drp_testsituation" runat="server">
                            <asp:ListItem Value="">請重新選擇</asp:ListItem>
                            <asp:ListItem Value="未測試" Text="未測試"></asp:ListItem>
                            <asp:ListItem Value="測試問題" Text="測試問題"></asp:ListItem>
                            <asp:ListItem Value="測試完成" Text="測試完成"></asp:ListItem>
                        </asp:DropDownList>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="請選擇" Display="Dynamic" ControlToValidate="drp_testsituation"></asp:RequiredFieldValidator>
                    </EditItemTemplate>
                    <HeaderStyle Width="20%" />
                    <ItemStyle Width="80%" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="測試結果敘述">
                    <ItemTemplate>
                        <%# Eval("testfeedback") %>
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:TextBox ID="text_testfeedback" runat="server" text=  '<%# Eval("testfeedback") %>' TextMode="MultiLine" Rows="4" Width="100%"></asp:TextBox>
                    </EditItemTemplate>
                </asp:TemplateField>
                                <asp:TemplateField HeaderText="測試日期" Visible="False">
                    <ItemTemplate>
                        <%# Eval("enddate2") %>
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:TextBox ID="nouse" runat="server" text=  '<%# Eval("enddate2") %>' TextMode="MultiLine" Rows="4" Width="100%"></asp:TextBox>
                    </EditItemTemplate>
                </asp:TemplateField>

                <asp:CommandField ShowEditButton="True" />
     
            </Fields>
            <FooterStyle BackColor="#CCCCCC" />
            <HeaderStyle BackColor="Black" Font-Bold="True" ForeColor="White" />
            <PagerStyle BackColor="#CCCCCC" ForeColor="Black" HorizontalAlign="Left" />
            <RowStyle BackColor="White" />
            <EditRowStyle BackColor="White" Width="100%" />
        </asp:DetailsView>

        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:MENU %>" SelectCommand="SELECT [emp_no], [NO], [testsituation], [testfeedback], [enddate2] FROM [TB_MISservice] WHERE ([NO] = @NO)" DeleteCommand="DELETE FROM [TB_MISservice] WHERE [NO] = @NO" InsertCommand="INSERT INTO [TB_MISservice] ( [NO], [testsituation], [testfeedback], [enddate2]) VALUES (@NO, @testsituation, @testfeedback, @enddate2)" UpdateCommand="UPDATE [TB_MISservice] SET [testsituation] = @testsituation, [testfeedback] = @testfeedback, [enddate2] = @enddate2 WHERE [NO] = @NO">
            <DeleteParameters>
                <asp:Parameter Name="NO" Type="String" />
            </DeleteParameters>
            <InsertParameters>
                <asp:Parameter Name="NO" Type="String" />
                <asp:Parameter Name="testsituation" Type="String" />
                <asp:Parameter Name="testfeedback" Type="String" />
                <asp:Parameter Name="enddate2" Type="DateTime" />
            </InsertParameters>
            <SelectParameters>
                <asp:QueryStringParameter Name="NO" QueryStringField="pid" Type="String" />
            </SelectParameters>
            <UpdateParameters>
                <asp:Parameter Name="testsituation" Type="String" />
                <asp:Parameter Name="testfeedback" Type="String" />
                <asp:Parameter Name="enddate2" Type="DateTime" />
                <asp:Parameter Name="NO" Type="String" />
            </UpdateParameters>
        </asp:SqlDataSource>

        <br />

    </div>
    <div class="col-md-2">
    </div>


</asp:Content>
