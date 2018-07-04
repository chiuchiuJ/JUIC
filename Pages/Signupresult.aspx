<%@ Page Title="" Language="C#" MasterPageFile="~/Master/JuicERP.Master" AutoEventWireup="true" CodeBehind="Signupresult.aspx.cs" Inherits="JuicERP.Pages.Signupresult" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="../css/bootstrap-select.css" rel="stylesheet" />
    <link href="../css/bootstrap-select.min.css" rel="stylesheet" />
    <script src="../js/bootstrap-select.js" type="text/javascript"></script>
    <script src="//ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="row">
        <div class="col-md-1"></div>
        <div class="col-md-10" style="font-family: 微軟正黑體">
            <asp:Label ID="Label1" runat="server" Text="Label" Visible="False"></asp:Label>

            <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:MENU %>" SelectCommand="SELECT [Title], [ID] FROM [TB_SignupList]"></asp:SqlDataSource>
            <asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:MENU %>" SelectCommand="SELECT a.[title], a.[eventID], a.[emp_no], a.[emp_cne], a.[People],convert(varchar(12),b.[activedate],111) as[activedate] FROM [TB_SignupList] b,[TB_SignupTotal] a WHERE (a.title =@title)and a.eventID=b.ID">
                <SelectParameters>
                    <asp:ControlParameter ControlID="DropDownList1" Name="title" PropertyName="SelectedValue" Type="String" />
                </SelectParameters>
            </asp:SqlDataSource>


            <asp:SqlDataSource ID="SqlDataSource5" runat="server" ConnectionString="<%$ ConnectionStrings:MENU %>" SelectCommand="SELECT a.[ID], [eventID], ('活動:'+a.[title]+'  共有 '+cast([People] as varchar) +' 人資訊需填寫'+b.[Addons3]) as 'title', a.[emp_no], a.[emp_cne], [People], [PS], [DetailTable] FROM [TB_SignupTotal] a,[TB_SignupList] b WHERE (a.[eventID]=b.[ID]) AND ((a.[emp_no] = @emp_no) AND (a.[DetailTable] = @DetailTable))">
                <SelectParameters>
                    <asp:ControlParameter ControlID="Label1" Name="emp_no" PropertyName="Text" Type="String" />
                    <asp:Parameter DefaultValue="1" Name="DetailTable" Type="Int32" />
                </SelectParameters>
            </asp:SqlDataSource>
            <asp:SqlDataSource ID="SqlDataSource4" runat="server" ConnectionString="<%$ ConnectionStrings:MENU %>" SelectCommand="SELECT [ID],  [Name], [IDnumber], [Birthday], [Old], [Who], [Bigbus], [Eat], [PS] FROM [TB_SignupTotalDetail] WHERE ([SignupTotalid] = @SignupTotalid)" DeleteCommand="DELETE FROM [TB_SignupTotalDetail] WHERE [ID] = @ID" InsertCommand="INSERT INTO [TB_SignupTotalDetail] ([SignupTotalid], [Name], [IDnumber], [Birthday], [Old], [Who], [Bigbus], [Eat], [PS]) VALUES (@SignupTotalid, @Name, @IDnumber, @Birthday, @Old, @Who, @Bigbus, @Eat, @PS)" UpdateCommand="UPDATE [TB_SignupTotalDetail] SET [Name] = @Name, [IDnumber] = @IDnumber, [Birthday] = @Birthday, [Old] = @Old, [Who] = @Who, [Bigbus] = @Bigbus, [Eat] = @Eat, [PS] = @PS WHERE [ID] = @ID">
                <DeleteParameters>
                    <asp:Parameter Name="ID" Type="Int32" />
                </DeleteParameters>
                <InsertParameters>
                    <asp:Parameter Name="SignupTotalid" Type="Int32" />
                    <asp:Parameter Name="Name" Type="String" />
                    <asp:Parameter Name="IDnumber" Type="String" />
                    <asp:Parameter Name="Birthday" Type="String" />
                    <asp:Parameter Name="Old" Type="String" />
                    <asp:Parameter Name="Who" Type="String" />
                    <asp:Parameter Name="Bigbus" Type="String" />
                    <asp:Parameter Name="Eat" Type="String" />
                    <asp:Parameter Name="PS" Type="String" />
                </InsertParameters>
                <SelectParameters>
                    <asp:ControlParameter ControlID="DropDownList2" Name="SignupTotalid" PropertyName="SelectedValue" Type="Int32" />
                </SelectParameters>
                <UpdateParameters>
                    <asp:Parameter Name="Name" Type="String" />
                    <asp:Parameter Name="IDnumber" Type="String" />
                    <asp:Parameter Name="Birthday" Type="String" />
                    <asp:Parameter Name="Old" Type="String" />
                    <asp:Parameter Name="Who" Type="String" />
                    <asp:Parameter Name="Bigbus" Type="String" />
                    <asp:Parameter Name="Eat" Type="String" />
                    <asp:Parameter Name="PS" Type="String" />
                    <asp:Parameter Name="ID" Type="Int32" />
                </UpdateParameters>
            </asp:SqlDataSource>

            <div class="panel-group" id="accordion">
                <div class="panel panel-success">
                    <div class="panel-heading" style="height: 50px">
                        <h4 class="panel-title" style="font-size: x-large" align="center">
                            <a data-toggle="collapse" data-parent="#accordion" href="#collapse0">詳細活動資料填寫(同行者資訊等)</a>
                        </h4>
                    </div>
                    <div id="collapse0" class="panel-collapse collapse">
                        <div class="panel-body">
                            <asp:UpdatePanel ID="UpdatePanel3" runat="server">
                                <ContentTemplate>
                                    <asp:DropDownList ID="DropDownList2" runat="server" AppendDataBoundItems="True" AutoPostBack="True" DataSourceID="SqlDataSource5" DataTextField="title" DataValueField="ID" Height="40px" Width="100%" OnSelectedIndexChanged="DropDownList2_SelectedIndexChanged" Font-Size="Medium">
                                        <asp:ListItem Value="0">請選擇活動</asp:ListItem>
                                    </asp:DropDownList><br />
                                    <asp:Panel ID="Panel1" runat="server" HorizontalAlign="Center">
                                        <asp:GridView ID="GridView3" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource4" DataKeyNames="ID" Width="100%" OnRowDataBound="GridView3_RowDataBound" BackColor="White" BorderColor="#3366CC" BorderStyle="None" BorderWidth="1px" CellPadding="4">
                                            <Columns>
                                                <asp:BoundField DataField="ID" HeaderText="ID" InsertVisible="False" ReadOnly="True" SortExpression="ID" Visible="False" />
                                                <asp:TemplateField HeaderText="參加者姓名" SortExpression="Name">
                                                    <EditItemTemplate>
                                                        <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("Name") %>'></asp:TextBox>
                                                    </EditItemTemplate>
                                                    <ItemTemplate>
                                                        <asp:TextBox ID="Name" runat="server" Text='<%# Bind("Name") %>' Width="100"></asp:TextBox>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="身份證字號" SortExpression="IDnumber">
                                                    <EditItemTemplate>
                                                        <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("IDnumber") %>'></asp:TextBox>
                                                    </EditItemTemplate>
                                                    <ItemTemplate>
                                                        <asp:TextBox ID="IDnumber" runat="server" Text='<%# Bind("IDnumber") %>' Width="130"></asp:TextBox>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="出生年月日" SortExpression="Birthday">
                                                    <EditItemTemplate>
                                                        <asp:TextBox ID="TextBox3" runat="server" Text='<%# Bind("Birthday") %>'></asp:TextBox>
                                                    </EditItemTemplate>
                                                    <ItemTemplate>
                                                        <asp:TextBox ID="Birthday" runat="server" Text='<%# Bind("Birthday") %>' Width="120"></asp:TextBox>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="年齡" SortExpression="Old">
                                                    <EditItemTemplate>
                                                        <asp:TextBox ID="TextBox4" runat="server" Text='<%# Bind("Old") %>'></asp:TextBox>
                                                    </EditItemTemplate>
                                                    <ItemTemplate>
                                                        <asp:TextBox ID="Old" runat="server" Text='<%# Bind("Old") %>' Width="50"></asp:TextBox>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="關係" SortExpression="Who">
                                                    <EditItemTemplate>
                                                        <asp:TextBox ID="TextBox5" runat="server" Text='<%# Bind("Who") %>'></asp:TextBox>
                                                    </EditItemTemplate>
                                                    <ItemTemplate>
                                                        <asp:TextBox ID="Who" runat="server" Text='<%# Bind("Who") %>' Width="50"></asp:TextBox>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="是否搭遊覽車" SortExpression="Bigbus">
                                                    <EditItemTemplate>
                                                        <asp:TextBox ID="TextBox6" runat="server" Text='<%# Bind("Bigbus") %>'></asp:TextBox>
                                                    </EditItemTemplate>
                                                    <ItemTemplate>
                                                        <asp:TextBox ID="Bigbus" runat="server" Text='<%# Bind("Bigbus") %>' Width="110"></asp:TextBox>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="飲食(葷/素)" SortExpression="Eat">
                                                    <EditItemTemplate>
                                                        <asp:TextBox ID="TextBox7" runat="server" Text='<%# Bind("Eat") %>'></asp:TextBox>
                                                    </EditItemTemplate>
                                                    <ItemTemplate>
                                                        <asp:TextBox ID="Eat" runat="server" Text='<%# Bind("Eat") %>' Width="110"></asp:TextBox>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="備註" SortExpression="PS">
                                                    <EditItemTemplate>
                                                        <asp:TextBox ID="TextBox8" runat="server" Text='<%# Bind("PS") %>'></asp:TextBox>
                                                    </EditItemTemplate>
                                                    <ItemTemplate>
                                                        <asp:TextBox ID="PS" runat="server" Text='<%# Bind("PS") %>' Width="300"></asp:TextBox>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                            </Columns>
                                            <FooterStyle BackColor="#99CCCC" ForeColor="#003399" />
                                            <HeaderStyle BackColor="#003399" Font-Bold="True" ForeColor="#CCCCFF" />
                                            <PagerStyle BackColor="#99CCCC" ForeColor="#003399" HorizontalAlign="Left" />
                                            <RowStyle BackColor="White" ForeColor="#003399" />
                                            <SelectedRowStyle BackColor="#009999" Font-Bold="True" ForeColor="#CCFF99" />
                                            <SortedAscendingCellStyle BackColor="#EDF6F6" />
                                            <SortedAscendingHeaderStyle BackColor="#0D4AC4" />
                                            <SortedDescendingCellStyle BackColor="#D6DFDF" />
                                            <SortedDescendingHeaderStyle BackColor="#002876" />
                                        </asp:GridView>
                                        <hr />
                                        <asp:Button ID="Button1" runat="server" Text="更新資料" CssClass="btn btn-success" OnClick="Button1_Click" Visible="False" />
                                        <asp:Label ID="Label2" runat="server" Text="" ForeColor="Red"></asp:Label>
                                        <br />
                                    </asp:Panel>
                                </ContentTemplate>
                            </asp:UpdatePanel>
                        </div>
                    </div>
                </div>
                <br />
                <div class="panel panel-danger">
                    <div class="panel-heading" style="height: 50px">
                        <h4 class="panel-title" style="font-size: x-large" align="center">
                            <a data-toggle="collapse" data-parent="#accordion" href="#collapse1">你的報名紀錄</a>
                        </h4>
                    </div>
                    <div id="collapse1" class="panel-collapse collapse">
                        <div class="panel-body">
                                <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:MENU %>" SelectCommand="SELECT a.[title], a.[eventID], a.[emp_no], a.[emp_cne], a.[People],convert(varchar(12),b.[activedate],111) as[activedate] FROM [TB_SignupList] b,[TB_SignupTotal] a WHERE (a.[emp_no] =@emp_no) and  a.[eventID]=b.[ID]  ORDER BY a.[eventID] DESC">
            <SelectParameters>
                <asp:ControlParameter ControlID="Label1" Name="emp_no" PropertyName="Text" Type="String" />
            </SelectParameters>
        </asp:SqlDataSource>
        <asp:UpdatePanel ID="UpdatePanel2" runat="server">
            <ContentTemplate>
                <asp:GridView ID="GridView1" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" DataSourceID="SqlDataSource1" CssClass="table table-hover table-striped" Font-Names="微軟正黑體">
                    <PagerSettings Position="TopAndBottom" />
                    <PagerStyle CssClass="pagination-ys" />
                    <Columns>
                        <asp:BoundField DataField="title" HeaderText="活動事件" SortExpression="title" />
                        <asp:BoundField DataField="emp_cne" HeaderText="員工姓名" SortExpression="emp_cne" />
                        <asp:BoundField DataField="People" HeaderText="參加人數" SortExpression="People" />
                        <asp:BoundField DataField="activedate" HeaderText="活動日期" ReadOnly="True" SortExpression="activedate" />
                    </Columns>
                </asp:GridView>
            </ContentTemplate>
        </asp:UpdatePanel>

                        </div>
                    </div>
                </div>
                <br />
                <div class="panel panel-info">
                    <div class="panel-heading" style="height: 50px">
                        <h4 class="panel-title" style="font-size: x-large" align="center">
                            <a data-toggle="collapse" data-parent="#accordion" href="#collapse2">全公司活動報名狀況</a>
                        </h4>
                    </div>
                    <div id="collapse2" class="panel-collapse collapse">
                        <div class="panel-body">
                            <div style="font-family: 微軟正黑體">
                                <div align="center" style="font-size: medium">請選擇要查詢的活動</div>
                                <asp:DropDownList ID="DropDownList1" runat="server" AutoPostBack="True" DataSourceID="SqlDataSource2" DataTextField="Title" DataValueField="Title" CssClass="selectpicker" data-width="100%" data-style="btn-info" AppendDataBoundItems="True">
                                    <asp:ListItem>請選擇</asp:ListItem>
                                </asp:DropDownList>
                            </div>

                            <br />
                            <%--         不刷新連動設定--%>
                            <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional">
                                <ContentTemplate>

                                    <asp:GridView ID="GridView2" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" DataSourceID="SqlDataSource3" CssClass="table table-hover table-striped" Font-Names="微軟正黑體" OnRowDataBound="GridView2_RowDataBound" ShowFooter="True">
                                        <PagerSettings Position="TopAndBottom" />
                                        <PagerStyle CssClass="pagination-ys" />
                                        <Columns>
                                            <asp:BoundField DataField="title" HeaderText="活動事件" SortExpression="title" />
                                            <asp:BoundField DataField="emp_no" HeaderText="員工ID" SortExpression="emp_no" />
                                            <asp:BoundField DataField="emp_cne" HeaderText="員工姓名" SortExpression="emp_cne" />
                                            <asp:BoundField DataField="People" HeaderText="參加人數" SortExpression="People" />
                                            <asp:BoundField DataField="activedate" HeaderText="活動日期" SortExpression="activedate" />
                                        </Columns>
                                    </asp:GridView>

                                </ContentTemplate>
                                <Triggers>
                                    <asp:AsyncPostBackTrigger ControlID="DropDownList1" EventName="SelectedIndexChanged" />
                                </Triggers>
                            </asp:UpdatePanel>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div style="font-family: 微軟正黑體">
        </div>

        <div class="col-md-1"></div>
    </div>

</asp:Content>
