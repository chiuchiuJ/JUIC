<%@ Page Title="" Language="C#" MasterPageFile="~/Master/JuicERP.Master" AutoEventWireup="true" CodeBehind="MISservicemanage.aspx.cs" Inherits="JuicERP.Pages.MISservicemanage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script>var imgDir = '<%=ResolveUrl("~/img") %>' + "/";	</script>
    <script src="<%=ResolveUrl("~/js/popcalendar.js") %>" charset="UTF-8"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">



    <div class="col-md-2">
    </div>
    <div class="col-md-8" style="font-family: 微軟正黑體">

        <asp:DetailsView ID="DetailsView2" runat="server" AutoGenerateRows="False" DataSourceID="SqlDataSource2" Height="50px" Width="282px" Visible="False">
            <Fields>
                <asp:BoundField DataField="category" HeaderText="category" SortExpression="category" />
                <asp:BoundField DataField="situation" HeaderText="situation" SortExpression="situation" />
                <asp:BoundField DataField="testsituation" HeaderText="testsituation" SortExpression="testsituation" />
                <asp:BoundField DataField="priority" HeaderText="priority" SortExpression="priority" />
                <asp:BoundField DataField="type" HeaderText="type" SortExpression="type" />
            </Fields>
        </asp:DetailsView>
        <br />
        <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:MENU %>" SelectCommand="SELECT [category], [situation], [testsituation], [priority],[type] FROM [TB_MISservice] WHERE ([NO] = @NO)">
            <SelectParameters>
                <asp:QueryStringParameter Name="NO" QueryStringField="pid" Type="String" />
            </SelectParameters>
        </asp:SqlDataSource>

        <asp:DetailsView ID="DetailsView1" runat="server" Height="60px" Width="100%" AutoGenerateRows="False" CellPadding="4" DataSourceID="SqlDataSource1" ForeColor="#333333" DataKeyNames="NO" OnItemUpdated="DetailsView1_ItemUpdated" OnItemCommand="DetailsView1_ItemCommand" DefaultMode="Edit" OnModeChanged="DetailsView1_ModeChanged" GridLines="None">
            <%--<EditRowStyle BackColor="#000099" Font-Bold="True" ForeColor="White" />--%>
            <FieldHeaderStyle BackColor="#FFFF99" Font-Bold="True" />
            <Fields>


                <%-- <asp:BoundField DataField="testsituation" HeaderText="testsituation" SortExpression="testsituation" />
                <asp:BoundField DataField="testfeedback" HeaderText="testfeedback" SortExpression="testfeedback" />--%>
                <asp:BoundField DataField="NO" HeaderText="編號" ReadOnly="True" SortExpression="NO" />
                <asp:TemplateField HeaderStyle-Width="20%" ItemStyle-Width="80%" HeaderText="問題類型">
                    <ItemTemplate>
                        <%# Eval("category") %>
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:Label ID="Label1" runat="server" Text='<%# Eval("category") %>' Visible="false"></asp:Label>
                        <asp:DropDownList ID="drp_cate" runat="server">
                            <asp:ListItem Value="">不變更</asp:ListItem>
                            <asp:ListItem Value="ERP系統" Text="ERP系統"></asp:ListItem>
                            <asp:ListItem Value="知識平台" Text="知識平台"></asp:ListItem>
                            <asp:ListItem Value="電腦狀況" Text="電腦狀況"></asp:ListItem>
                        </asp:DropDownList>
                        <%--  <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="請選擇" Display="Dynamic" ControlToValidate="drp_cate"></asp:RequiredFieldValidator>--%>
                    </EditItemTemplate>

                    <HeaderStyle Width="20%"></HeaderStyle>

                    <ItemStyle Width="80%"></ItemStyle>
                </asp:TemplateField>
                <asp:TemplateField HeaderStyle-Width="20%" ItemStyle-Width="80%" HeaderText="問題分類">
                    <ItemTemplate>
                        <%# Eval("type") %>
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:Label ID="Labeltype" runat="server" Text='<%# Eval("type") %>' Visible="false"></asp:Label>
                        <asp:DropDownList ID="drp_type" runat="server">
                            <asp:ListItem Value="">不變更</asp:ListItem>
                            <asp:ListItem Value="新建需求" Text="新建需求"></asp:ListItem>
                            <asp:ListItem Value="資料問題" Text="資料問題"></asp:ListItem>
                            <asp:ListItem Value="操作問題" Text="操作問題"></asp:ListItem>
                            <asp:ListItem Value="BUG錯誤" Text="BUG錯誤"></asp:ListItem>
                            <asp:ListItem Value="優化改良" Text="優化改良"></asp:ListItem>
                        </asp:DropDownList>
                        <%--  <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="請選擇" Display="Dynamic" ControlToValidate="drp_cate"></asp:RequiredFieldValidator>--%>
                    </EditItemTemplate>

                    <HeaderStyle Width="20%"></HeaderStyle>

                    <ItemStyle Width="80%"></ItemStyle>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="問題內容">
                    <ItemTemplate>
                        <%# Eval("problem") %>
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:TextBox ID="text_pro" runat="server" Text='<%# Eval("problem") %>' TextMode="MultiLine" Rows="4" Width="100%"></asp:TextBox>
                    </EditItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="emp_no" HeaderText="申請人ID" SortExpression="emp_no" />
                <asp:BoundField DataField="emp_cne" HeaderText="申請人" SortExpression="emp_cne" />
                <asp:TemplateField HeaderStyle-Width="20%" ItemStyle-Width="80%" HeaderText="處理狀態">
                    <ItemTemplate>
                        <%# Eval("situation") %>
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:Label ID="lab_sit" runat="server" Text='<%# Eval("situation") %>' Visible="false"></asp:Label>
                        <asp:DropDownList ID="drp_sit" runat="server">
                            <asp:ListItem Value="">不變更</asp:ListItem>
                            <asp:ListItem Value="未開始" Text="未開始"></asp:ListItem>
                            <asp:ListItem Value="討論中" Text="討論中"></asp:ListItem>
                            <asp:ListItem Value="待修改" Text="待修改"></asp:ListItem>
                            <asp:ListItem Value="處理中" Text="處理中"></asp:ListItem>
                            <asp:ListItem Value="待測試" Text="待測試"></asp:ListItem>
                            <asp:ListItem Value="已完成" Text="已完成"></asp:ListItem>
                            <asp:ListItem Value="展延" Text="展延"></asp:ListItem>
                            <asp:ListItem Value="結案" Text="結案"></asp:ListItem>
                        </asp:DropDownList>
                        <%--  <asp:RequiredFieldValidator ID="RequiredFieldValidator_sit" runat="server" ErrorMessage="請選擇" Display="Dynamic" ControlToValidate="drp_sit"></asp:RequiredFieldValidator>--%>
                    </EditItemTemplate>

                    <HeaderStyle Width="20%"></HeaderStyle>

                    <ItemStyle Width="80%"></ItemStyle>
                </asp:TemplateField>
                <asp:TemplateField HeaderStyle-Width="20%" ItemStyle-Width="80%" HeaderText="測試狀態">
                    <ItemTemplate>
                        <%# Eval("testsituation") %>
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:Label ID="lab_tsit" runat="server" Text='<%# Eval("testsituation") %>' Visible="false"></asp:Label>
                        <asp:DropDownList ID="drp_tsit" runat="server">
                            <asp:ListItem Value="">不變更</asp:ListItem>
                            <asp:ListItem Value="不需測試" Text="不需測試"></asp:ListItem>
                            <asp:ListItem Value="未測試" Text="未測試"></asp:ListItem>
                            <asp:ListItem Value="測試完成" Text="測試完成"></asp:ListItem>
                        </asp:DropDownList>
                        <%--       <asp:RequiredFieldValidator ID="RequiredFieldValidator_tsit" runat="server" ErrorMessage="請選擇" Display="Dynamic" ControlToValidate="drp_tsit"></asp:RequiredFieldValidator>--%>
                    </EditItemTemplate>

                    <HeaderStyle Width="20%"></HeaderStyle>

                    <ItemStyle Width="80%"></ItemStyle>
                </asp:TemplateField>
                <%--  <asp:BoundField DataField="testfeedback" HeaderText="測試狀況" SortExpression="testfeedback" />--%>
                <asp:TemplateField HeaderText="測試狀況">
                    <ItemTemplate>
                        <%# Eval("testfeedback") %>
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:TextBox ID="text_testfeedback" runat="server" Text='<%# Eval("testfeedback") %>' TextMode="MultiLine" Rows="4" Width="100%"></asp:TextBox>
                    </EditItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="priority" HeaderText="priority" SortExpression="priority" />
                <asp:TemplateField HeaderText="申請日期">
                    <ItemTemplate>
                        <%# Eval("date") %>
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:TextBox ID="text_date" runat="server" Text='<%# Eval("date") %>' TextMode="date"></asp:TextBox>
                        <%--   <img align="middle" alt="" style="margin: 0 auto;" onclick="popUpCalendar(this, document.getElementById('<%= text_date.ClientID %>'), 'yyyy/mm/dd')" src="<%=ResolveUrl("~/img/calendar.gif") %>" />--%>
                    </EditItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="處理日期">
                    <ItemTemplate>
                        <%# Eval("enddate1") %>
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:TextBox ID="text_enddate1" runat="server" Text='<%# Eval("enddate1") %>' TextMode="date"></asp:TextBox>
                        <%--   <img align="middle" alt="" style="margin: 0 auto;" onclick="popUpCalendar(this, document.getElementById('<%= text_date.ClientID %>'), 'yyyy/mm/dd')" src="<%=ResolveUrl("~/img/calendar.gif") %>" />--%>
                    </EditItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="測試日期">
                    <ItemTemplate>
                        <%# Eval("enddate2") %>
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:TextBox ID="text_enddate2" runat="server" Text='<%# Eval("enddate2") %>' TextMode="date"></asp:TextBox>
                        <%--   <img align="middle" alt="" style="margin: 0 auto;" onclick="popUpCalendar(this, document.getElementById('<%= text_date.ClientID %>'), 'yyyy/mm/dd')" src="<%=ResolveUrl("~/img/calendar.gif") %>" />--%>
                    </EditItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="完成日期">
                    <ItemTemplate>
                        <%# Eval("finishdate") %>
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:TextBox ID="text_finishdate" runat="server" Text='<%# Eval("finishdate") %>' TextMode="date"></asp:TextBox>
                        <%--   <img align="middle" alt="" style="margin: 0 auto;" onclick="popUpCalendar(this, document.getElementById('<%= text_date.ClientID %>'), 'yyyy/mm/dd')" src="<%=ResolveUrl("~/img/calendar.gif") %>" />--%>
                    </EditItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="mis_no" HeaderText="MIS負責人ID" SortExpression="mis_no" />
                <asp:BoundField DataField="mis_cne" HeaderText="MIS負責人名字" SortExpression="mis_cne" />
                <asp:TemplateField HeaderText="處理狀況/備註">
                    <ItemTemplate>
                        <%# Eval("PS") %>
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:TextBox ID="text_PS" runat="server" Text='<%# Eval("PS") %>' TextMode="MultiLine" Rows="4" Width="100%"></asp:TextBox>
                    </EditItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="feedback" HeaderText="使用者回饋資料" SortExpression="feedback" />

                <asp:CommandField ShowEditButton="True" />

            </Fields>
            <FooterStyle BackColor="#990000" Font-Bold="True" ForeColor="White" />
            <HeaderStyle BackColor="#990000" Font-Bold="True" ForeColor="White" />
            <PagerStyle BackColor="#FFCC66" ForeColor="#333333" HorizontalAlign="Center" />
            <RowStyle BackColor="#FFFBD6" ForeColor="#333333" />
            <AlternatingRowStyle BackColor="White" />
            <CommandRowStyle BackColor="#FFFFC0" Font-Bold="True" />
            <EditRowStyle Width="100%" />
        </asp:DetailsView>

        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:MENU %>" DeleteCommand="DELETE FROM [TB_MISservice] WHERE [NO] = @NO" InsertCommand="INSERT INTO [TB_MISservice] ([NO], [category],[type], [problem], [emp_no], [emp_cne], [situation], [testsituation], [testfeedback], [priority], [date], [enddate1], [enddate2], [finishdate], [testfinishdate], [mis_no], [mis_cne], [PS], [feedback]) VALUES (@NO, @category,@type, @problem, @emp_no, @emp_cne, @situation, @testsituation, @testfeedback, @priority, @date, @enddate1, @enddate2, @finishdate, @testfinishdate, @mis_no, @mis_cne, @PS, @feedback)" SelectCommand="SELECT [NO], [category],[type], [problem], [emp_no], [emp_cne], [situation], [testsituation], [testfeedback], [priority], CONVERT(varchar(100), date, 23) as 'date'  ,CONVERT(varchar(100), enddate1, 23) as 'enddate1' ,CONVERT(varchar(100), enddate2, 23) as 'enddate2', CONVERT(varchar(100), finishdate, 23) as 'finishdate', [mis_no], [mis_cne], [PS], [feedback] FROM [TB_MISservice] WHERE ([NO] = @NO)" UpdateCommand="UPDATE [TB_MISservice] SET [category] = @category,[type] = @type, [problem] = @problem, [emp_no] = @emp_no, [emp_cne] = @emp_cne, [situation] = @situation, [testsituation] = @testsituation, [testfeedback] = @testfeedback, [priority] = @priority, [date] = @date, [enddate1] = @enddate1, [enddate2] = @enddate2, [finishdate] = @finishdate, [testfinishdate] = @testfinishdate, [mis_no] = @mis_no, [mis_cne] = @mis_cne, [PS] = @PS, [feedback] = @feedback WHERE [NO] = @NO">
            <DeleteParameters>
                <asp:Parameter Name="NO" Type="String" />
            </DeleteParameters>
            <InsertParameters>
                <asp:Parameter Name="NO" Type="String" />
                <asp:Parameter Name="category" Type="String" />
                <asp:Parameter Name="type" />
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
            <SelectParameters>
                <asp:QueryStringParameter Name="NO" QueryStringField="pid" Type="String" />
            </SelectParameters>
            <UpdateParameters>
                <asp:Parameter Name="category" Type="String" />
                <asp:Parameter Name="type" />
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

    </div>
    <div class="col-md-2">
    </div>


</asp:Content>
