<%@ Page Title="" Language="C#" MasterPageFile="~/Master/JuicERP.Master" AutoEventWireup="true" CodeBehind="MISserviceedit.aspx.cs" Inherits="JuicERP.Pages.MISserviceedit" %>

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
        
           <asp:TemplateField  HeaderStyle-Width="20%" ItemStyle-Width="80%" HeaderText="問題類型">
                    <ItemTemplate>
                        <%# Eval("category") %>
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:Label ID="Label1" runat="server" Text='<%# Eval("category") %>' Visible="false"></asp:Label>
                        <asp:DropDownList ID="drp_cate" runat="server">
                            <asp:ListItem Value="">請重新選擇</asp:ListItem>
                            <asp:ListItem Value="ERP系統" Text="ERP系統"></asp:ListItem>
                            <asp:ListItem Value="知識平台" Text="知識平台"></asp:ListItem>
                            <asp:ListItem Value="電腦狀況" Text="電腦狀況"></asp:ListItem>
                        </asp:DropDownList>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="請選擇" Display="Dynamic" ControlToValidate="drp_cate"></asp:RequiredFieldValidator>
                    </EditItemTemplate>
                    <HeaderStyle Width="20%" />
                    <ItemStyle Width="80%" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="問題內容">
                    <ItemTemplate>
                        <%# Eval("problem") %>
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:TextBox ID="text_pro" runat="server" text=  '<%# Eval("problem") %>' TextMode="MultiLine" Rows="4" Width="100%"></asp:TextBox>
                    </EditItemTemplate>
                </asp:TemplateField>


                <asp:CommandField ShowEditButton="True" ButtonType="Button"/>
     
<%--                取代CommandField
                <asp:TemplateField HeaderText="Edit User">
                <ItemTemplate>
                    <asp:LinkButton ID="EditButton"
                            runat="server"
                            CssClass="UsersGridViewButton"
                            CommandName="Edit"
                            Text="Edit" />
                </ItemTemplate>
            </asp:TemplateField>--%>

            </Fields>
            <FooterStyle BackColor="#CCCCCC" />
            <HeaderStyle BackColor="Black" Font-Bold="True" ForeColor="White" />
            <PagerStyle BackColor="#CCCCCC" ForeColor="Black" HorizontalAlign="Left" />
            <RowStyle BackColor="White" />
            <EditRowStyle BackColor="White" Width="100%" />
        </asp:DetailsView>

        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:MENU %>" DeleteCommand="DELETE FROM [TB_MISservice] WHERE [NO] = @NO" InsertCommand="INSERT INTO [TB_MISservice] ([problem], [category], [testsituation], [testfeedback], [NO]) VALUES (@problem, @category, @testsituation, @testfeedback, @NO)" SelectCommand="SELECT [emp_no],[problem], [category], [testsituation], [testfeedback], [NO] FROM [TB_MISservice] WHERE ([NO] = @NO)" UpdateCommand="UPDATE [TB_MISservice] SET [problem] = @problem, [category] = @category WHERE [NO] = @NO">
            <DeleteParameters>
                <asp:Parameter Name="NO" Type="String" />
            </DeleteParameters>
            <InsertParameters>
                <asp:Parameter Name="problem" Type="String" />
                <asp:Parameter Name="category" Type="String" />
                <asp:Parameter Name="testsituation" Type="String" />
                <asp:Parameter Name="testfeedback" Type="String" />
                <asp:Parameter Name="NO" Type="String" />
            </InsertParameters>
            <SelectParameters>
                <asp:QueryStringParameter DefaultValue="" Name="NO" QueryStringField="pid" Type="String" />
            </SelectParameters>
            <UpdateParameters>
                <asp:Parameter Name="problem" Type="String" />
                <asp:Parameter Name="category" Type="String" />
                <asp:Parameter Name="NO" Type="String" />
            </UpdateParameters>
        </asp:SqlDataSource>

        <br />

    </div>
    <div class="col-md-2">
    </div>


</asp:Content>
