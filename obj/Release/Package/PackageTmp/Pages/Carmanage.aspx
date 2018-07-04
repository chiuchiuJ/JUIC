<%@ Page Title="" Language="C#" MasterPageFile="~/Master/JuicERP.Master" AutoEventWireup="true" CodeBehind="Carmanage.aspx.cs" Inherits="JuicERP.Pages.Carmanage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="col-md-2">
    </div>
    <div class="col-md-8" style="font-family: 微軟正黑體">

        <asp:DetailsView ID="DetailsView1" runat="server" Height="60px" Width="100%" AutoGenerateRows="False" DataKeyNames="id" DataSourceID="SqlDataSource1">
            <EditRowStyle Width="100%" />
            <Fields>
                <asp:BoundField DataField="id" HeaderText="編號" InsertVisible="False" ReadOnly="True" SortExpression="id" />
                <asp:TemplateField HeaderText="車輛編號">
                    <EditItemTemplate>
                        <asp:TextBox ID="TextBox6" runat="server" Text='<%# Bind("car_no") %>' ReadOnly="True"></asp:TextBox>
                    </EditItemTemplate>
                    <InsertItemTemplate>
                        <asp:TextBox ID="TextBox6" runat="server" Text='<%# Bind("car_no") %>'></asp:TextBox>
                    </InsertItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label6" runat="server" Text='<%# Bind("car_no") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="車牌號碼" SortExpression="car_name">
                    <EditItemTemplate>
                        <asp:TextBox ID="TextBox7" runat="server" Text='<%# Bind("car_name") %>' ReadOnly="True"></asp:TextBox>
                    </EditItemTemplate>
                    <InsertItemTemplate>
                        <asp:TextBox ID="TextBox7" runat="server" Text='<%# Bind("car_name") %>'></asp:TextBox>
                    </InsertItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label7" runat="server" Text='<%# Bind("car_name") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="emp_no" HeaderText="預約人ID" SortExpression="emp_no" />
                <asp:BoundField DataField="emp_cne" HeaderText="預約人姓名" SortExpression="emp_cne" />
                <asp:BoundField DataField="username" HeaderText="使用人" SortExpression="username" />
                <asp:TemplateField HeaderText="申請日期" SortExpression="applydate">
                    <EditItemTemplate>
                        <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("applydate") %>' Width="70%"></asp:TextBox>
                    </EditItemTemplate>
                    <InsertItemTemplate>
                        <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("applydate") %>'></asp:TextBox>
                    </InsertItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label2" runat="server" Text='<%# Bind("applydate") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="預約開始時間" SortExpression="startrent">
                    <EditItemTemplate>
                        <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("startrent") %>' Width="70%"></asp:TextBox>
                    </EditItemTemplate>
                    <InsertItemTemplate>
                        <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("startrent") %>'></asp:TextBox>
                    </InsertItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label1" runat="server" Text='<%# Bind("startrent") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="預約結束時間" SortExpression="endrent">
                    <EditItemTemplate>
                        <asp:TextBox ID="TextBox3" runat="server" Text='<%# Bind("endrent") %>' Width="70%"></asp:TextBox>
                    </EditItemTemplate>
                    <InsertItemTemplate>
                        <asp:TextBox ID="TextBox3" runat="server" Text='<%# Bind("endrent") %>'></asp:TextBox>
                    </InsertItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label3" runat="server" Text='<%# Bind("endrent") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="實際出發時間" SortExpression="startrent2">
                    <EditItemTemplate>
                        <asp:TextBox ID="TextBox4" runat="server" Text='<%# Bind("startrent2") %>' Width="70%"></asp:TextBox>
                    </EditItemTemplate>
                    <InsertItemTemplate>
                        <asp:TextBox ID="TextBox4" runat="server" Text='<%# Bind("startrent2") %>'></asp:TextBox>
                    </InsertItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label4" runat="server" Text='<%# Bind("startrent2") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="實際歸還時間" SortExpression="endrent2">
                    <EditItemTemplate>
                        <asp:TextBox ID="TextBox5" runat="server" Text='<%# Bind("endrent2") %>' Width="70%"></asp:TextBox>
                    </EditItemTemplate>
                    <InsertItemTemplate>
                        <asp:TextBox ID="TextBox5" runat="server" Text='<%# Bind("endrent2") %>'></asp:TextBox>
                    </InsertItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label5" runat="server" Text='<%# Bind("endrent2") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="destination" HeaderText="目的地" SortExpression="destination" />
                <asp:BoundField DataField="gotoYN" HeaderText="是否已出發" SortExpression="gotoYN" />
                <asp:BoundField DataField="backYN" HeaderText="是否已歸還" SortExpression="backYN" />
                <asp:BoundField DataField="gasoline1" HeaderText="出發前里程數" SortExpression="gasoline1" />
                <asp:BoundField DataField="gasoline2" HeaderText="歸還時里程數" SortExpression="gasoline2" />
                <asp:BoundField DataField="Fuelcosts" HeaderText="加油費" SortExpression="Fuelcosts" />
                <asp:BoundField DataField="PS" HeaderText="預約備註" SortExpression="PS" />
                <asp:BoundField DataField="PS2" HeaderText="歸還備註" SortExpression="PS2" />
                <asp:BoundField DataField="Check1" HeaderText="確認事項1" SortExpression="Check1" />
                <asp:BoundField DataField="Check2" HeaderText="確認事項2" SortExpression="Check2" />
                <asp:BoundField DataField="Check3" HeaderText="確認事項3" SortExpression="Check3" />
                <asp:BoundField DataField="Check4" HeaderText="確認事項4" SortExpression="Check4" />
                <asp:CommandField ShowEditButton="True" />
            </Fields>
        </asp:DetailsView>

        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:MENU %>" DeleteCommand="DELETE FROM [TB_Carrentdata] WHERE [id] = @id" InsertCommand="INSERT INTO [TB_Carrentdata] ([car_no], [car_name], [emp_no], [emp_cne], [username], [applydate], [startrent], [endrent], [startrent2], [endrent2], [destination], [gotoYN], [backYN], [gasoline1], [gasoline2], [Fuelcosts], [PS], [PS2], [Check1], [Check2], [Check3], [Check4], [Check5], [Check6]) VALUES (@car_no, @car_name, @emp_no, @emp_cne, @username, @applydate, @startrent, @endrent, @startrent2, @endrent2, @destination, @gotoYN, @backYN, @gasoline1, @gasoline2, @Fuelcosts, @PS, @PS2, @Check1, @Check2, @Check3, @Check4, @Check5, @Check6)" SelectCommand="SELECT * FROM [TB_Carrentdata] WHERE ([id] = @id)" UpdateCommand="UPDATE [TB_Carrentdata] SET [car_no] = @car_no, [car_name] = @car_name, [emp_no] = @emp_no, [emp_cne] = @emp_cne, [username] = @username, [applydate] = @applydate, [startrent] = @startrent, [endrent] = @endrent, [startrent2] = @startrent2, [endrent2] = @endrent2, [destination] = @destination, [gotoYN] = @gotoYN, [backYN] = @backYN, [gasoline1] = @gasoline1, [gasoline2] = @gasoline2, [Fuelcosts] = @Fuelcosts, [PS] = @PS, [PS2] = @PS2, [Check1] = @Check1, [Check2] = @Check2, [Check3] = @Check3, [Check4] = @Check4, [Check5] = @Check5, [Check6] = @Check6 WHERE [id] = @id">
            <DeleteParameters>
                <asp:Parameter Name="id" Type="Int32" />
            </DeleteParameters>
            <InsertParameters>
                <asp:Parameter Name="car_no" Type="Int32" />
                <asp:Parameter Name="car_name" Type="String" />
                <asp:Parameter Name="emp_no" Type="String" />
                <asp:Parameter Name="emp_cne" Type="String" />
                <asp:Parameter Name="username" Type="String" />
                <asp:Parameter Name="applydate" Type="DateTime" />
                <asp:Parameter Name="startrent" Type="DateTime" />
                <asp:Parameter Name="endrent" Type="DateTime" />
                <asp:Parameter Name="startrent2" Type="DateTime" />
                <asp:Parameter Name="endrent2" Type="DateTime" />
                <asp:Parameter Name="destination" Type="String" />
                <asp:Parameter Name="gotoYN" Type="String" />
                <asp:Parameter Name="backYN" Type="String" />
                <asp:Parameter Name="gasoline1" Type="String" />
                <asp:Parameter Name="gasoline2" Type="String" />
                <asp:Parameter Name="Fuelcosts" Type="String" />
                <asp:Parameter Name="PS" Type="String" />
                <asp:Parameter Name="PS2" Type="String" />
                <asp:Parameter Name="Check1" Type="String" />
                <asp:Parameter Name="Check2" Type="String" />
                <asp:Parameter Name="Check3" Type="String" />
                <asp:Parameter Name="Check4" Type="String" />
                <asp:Parameter Name="Check5" Type="String" />
                <asp:Parameter Name="Check6" Type="String" />
            </InsertParameters>
            <SelectParameters>
                <asp:QueryStringParameter Name="id" QueryStringField="pid" Type="Int32" />
            </SelectParameters>
            <UpdateParameters>
                <asp:Parameter Name="car_no" Type="Int32" />
                <asp:Parameter Name="car_name" Type="String" />
                <asp:Parameter Name="emp_no" Type="String" />
                <asp:Parameter Name="emp_cne" Type="String" />
                <asp:Parameter Name="username" Type="String" />
                <asp:Parameter Name="applydate" Type="DateTime" />
                <asp:Parameter Name="startrent" Type="DateTime" />
                <asp:Parameter Name="endrent" Type="DateTime" />
                <asp:Parameter Name="startrent2" Type="DateTime" />
                <asp:Parameter Name="endrent2" Type="DateTime" />
                <asp:Parameter Name="destination" Type="String" />
                <asp:Parameter Name="gotoYN" Type="String" />
                <asp:Parameter Name="backYN" Type="String" />
                <asp:Parameter Name="gasoline1" Type="String" />
                <asp:Parameter Name="gasoline2" Type="String" />
                <asp:Parameter Name="Fuelcosts" Type="String" />
                <asp:Parameter Name="PS" Type="String" />
                <asp:Parameter Name="PS2" Type="String" />
                <asp:Parameter Name="Check1" Type="String" />
                <asp:Parameter Name="Check2" Type="String" />
                <asp:Parameter Name="Check3" Type="String" />
                <asp:Parameter Name="Check4" Type="String" />
                <asp:Parameter Name="Check5" Type="String" />
                <asp:Parameter Name="Check6" Type="String" />
                <asp:Parameter Name="id" Type="Int32" />
            </UpdateParameters>
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:MENU %>" DeleteCommand="DELETE FROM [TB_Carrentdata] WHERE [id] = @id" InsertCommand="INSERT INTO [TB_Carrentdata] ([car_no], [car_name], [emp_no], [emp_cne], [username], [applydate], [startrent], [endrent], [startrent2], [endrent2], [destination], [gotoYN], [backYN], [gasoline1], [gasoline2], [Fuelcosts], [PS], [PS2], [Check1], [Check2], [Check3], [Check4]) VALUES (@car_no, @car_name, @emp_no, @emp_cne, @username, @applydate, @startrent, @endrent, @startrent2, @endrent2, @destination, @gotoYN, @backYN, @gasoline1, @gasoline2, @Fuelcosts, @PS, @PS2, @Check1, @Check2, @Check3, @Check4)" OldValuesParameterFormatString="original_{0}" SelectCommand="SELECT [id], [car_no], [car_name], [emp_no], [emp_cne], [username], [applydate], [startrent], [endrent], [startrent2], [endrent2], [destination], [gotoYN], [backYN], [gasoline1], [gasoline2], [Fuelcosts], [PS], [PS2], [Check1], [Check2], [Check3], [Check4] FROM [TB_Carrentdata] WHERE ([id] = @id)" UpdateCommand="UPDATE [TB_Carrentdata] SET [car_no] = @car_no, [car_name] = @car_name, [emp_no] = @emp_no, [emp_cne] = @emp_cne, [username] = @username, [applydate] = @applydate, [startrent] = @startrent, [endrent] = @endrent, [startrent2] = @startrent2, [endrent2] = @endrent2, [destination] = @destination, [gotoYN] = @gotoYN, [backYN] = @backYN, [gasoline1] = @gasoline1, [gasoline2] = @gasoline2, [Fuelcosts] = @Fuelcosts, [PS] = @PS, [PS2] = @PS2, [Check1] = @Check1, [Check2] = @Check2, [Check3] = @Check3, [Check4] = @Check4 WHERE [id] = @id">
            <DeleteParameters>
                <asp:Parameter Name="id" />
            </DeleteParameters>
            <InsertParameters>
                <asp:Parameter Name="car_no" Type="Int32" />
                <asp:Parameter Name="car_name" Type="String" />
                <asp:Parameter Name="emp_no" Type="String" />
                <asp:Parameter Name="emp_cne" Type="String" />
                <asp:Parameter Name="username" Type="String" />
                <asp:Parameter Name="applydate" Type="DateTime" />
                <asp:Parameter Name="startrent" Type="DateTime" />
                <asp:Parameter Name="endrent" Type="DateTime" />
                <asp:Parameter Name="startrent2" Type="DateTime" />
                <asp:Parameter Name="endrent2" Type="DateTime" />
                <asp:Parameter Name="destination" Type="String" />
                <asp:Parameter Name="gotoYN" Type="String" />
                <asp:Parameter Name="backYN" Type="String" />
                <asp:Parameter Name="gasoline1" Type="String" />
                <asp:Parameter Name="gasoline2" Type="String" />
                <asp:Parameter Name="Fuelcosts" Type="String" />
                <asp:Parameter Name="PS" Type="String" />
                <asp:Parameter Name="PS2" Type="String" />
                <asp:Parameter Name="Check1" Type="String" />
                <asp:Parameter Name="Check2" Type="String" />
                <asp:Parameter Name="Check3" Type="String" />
                <asp:Parameter Name="Check4" Type="String" />
            </InsertParameters>
            <SelectParameters>
                <asp:QueryStringParameter Name="id" QueryStringField="pid" Type="Int32" />
            </SelectParameters>
            <UpdateParameters>
                <asp:Parameter Name="car_no" Type="Int32" />
                <asp:Parameter Name="car_name" Type="String" />
                <asp:Parameter Name="emp_no" Type="String" />
                <asp:Parameter Name="emp_cne" Type="String" />
                <asp:Parameter Name="username" Type="String" />
                <asp:Parameter Name="applydate" Type="DateTime" />
                <asp:Parameter Name="startrent" Type="DateTime" />
                <asp:Parameter Name="endrent" Type="DateTime" />
                <asp:Parameter Name="startrent2" Type="DateTime" />
                <asp:Parameter Name="endrent2" Type="DateTime" />
                <asp:Parameter Name="destination" Type="String" />
                <asp:Parameter Name="gotoYN" Type="String" />
                <asp:Parameter Name="backYN" Type="String" />
                <asp:Parameter Name="gasoline1" Type="String" />
                <asp:Parameter Name="gasoline2" Type="String" />
                <asp:Parameter Name="Fuelcosts" Type="String" />
                <asp:Parameter Name="PS" Type="String" />
                <asp:Parameter Name="PS2" Type="String" />
                <asp:Parameter Name="Check1" Type="String" />
                <asp:Parameter Name="Check2" Type="String" />
                <asp:Parameter Name="Check3" Type="String" />
                <asp:Parameter Name="Check4" Type="String" />
                <asp:Parameter Name="id" />
            </UpdateParameters>
        </asp:SqlDataSource>

    </div>
    <div class="col-md-2">
    </div>
</asp:Content>
