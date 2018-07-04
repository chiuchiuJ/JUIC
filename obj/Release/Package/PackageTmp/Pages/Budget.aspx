<%@ Page Title="" Language="C#" MasterPageFile="~/Master/JuicERP.Master" AutoEventWireup="true" CodeBehind="Budget.aspx.cs" Inherits="JuicERP.Pages.Budget" %>

<%@ Register Src="~/UserControls/Budgetkeyin.ascx" TagPrefix="uc1" TagName="Budgetkeyin" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="col-md-1"></div>
    <div class="col-md-10" style="font-family: 微軟正黑體">

        <asp:Label ID="Label1" runat="server" Text="Label" Visible="false"></asp:Label>
        <asp:Button ID="Button1" runat="server" Text="Button" OnClick="Button1_Click" Visible="false" />
        <asp:Label ID="Label3" runat="server" Text="Label" Visible="false"></asp:Label>
        <asp:Label ID="Label5" runat="server" Text="Label" Visible="false"></asp:Label>
        <asp:Label ID="Label6" runat="server" Text="Label" Visible="false"></asp:Label>
        <br />
        <asp:Panel ID="Panel1" runat="server" Visible="false">
            <uc1:Budgetkeyin runat="server" ID="Budgetkeyin" />
        </asp:Panel>

        <ul class="nav nav-tabs">
            <li class="active"><a data-toggle="tab" href="#home">時程表</a></li>
            <li><a data-toggle="tab" href="#menu1">注意事項</a></li>
            <li><a data-toggle="tab" href="#menu2">說明</a></li>
            <li><a data-toggle="tab" href="#menu3">預算編寫</a></li>
            <li><a data-toggle="tab" href="#menu4">預算統計</a></li>
            <li><a data-toggle="tab" href="#menu5">相關功能</a></li>
        </ul>

        <div class="tab-content">
            <div id="home" class="tab-pane fade in active">
                <h3></h3>
                <p></p>
                <asp:Image runat="server" ImageUrl="~/files/budget/2018schedulea.png" Width="100%"></asp:Image>
            </div>
            <div id="menu1" class="tab-pane fade">
                <%--                <p style="font-size: larger"><strong>2018年度計劃匯率預測</strong></p>
                <p style="font-size: larger">USD/TWD：30.365</p>
                <p style="font-size: larger">CNY/TWD：4.5019</p>
                <p style="font-size: larger">JPY/TWD：0.2819</p>
                <p style="font-size: larger">HKD/TWD：3.9060</p>--%>
                <asp:Image runat="server" ImageUrl="~/files/budget/noticea.jpg" Width="100%"></asp:Image>
                <asp:Image runat="server" ImageUrl="~/files/budget/noticeb.jpg" Width="100%"></asp:Image>
                <%--                <asp:Image runat="server" ImageUrl="~/files/budget/notice3.jpg" Width="100%"></asp:Image>
                <asp:Image runat="server" ImageUrl="~/files/budget/notice4.jpg" Width="100%"></asp:Image>--%>
            </div>
            <div id="menu2" class="tab-pane fade">
                <h3></h3>
                <p></p>
                <asp:Image runat="server" ImageUrl="~/files/budget/2018item.png" Width="100%"></asp:Image>
            </div>
            <div id="menu3" class="tab-pane fade">
                <h3></h3>
                <p></p>


                <asp:Label ID="BudgetYN" runat="server" Text="您並無編輯預算的權限"></asp:Label>
                <br />
                <%--    <asp:HyperLink ID="HyperLink3" runat="server">HyperLink</asp:HyperLink>--%>
                <%-- <asp:Button ID="BudgetYNbtn" runat="server" Text="點我開啟預算編輯畫面" Enabled="False" OnClick="BudgetYNbtn_Click" CssClass="btn btn-success" />--%>
                <asp:HyperLink ID="HyperLink3" runat="server" CssClass="btn btn-success" Target="_blank" NavigateUrl="Budgetinput.aspx" Enabled="False" Font-Size="Larger">點我開啟預算編輯畫面</asp:HyperLink>
                <br />
                <br />
                <asp:HyperLink ID="HyperLink4" runat="server" CssClass="btn btn-danger" Target="_blank" NavigateUrl="BudgetReference.aspx">點我參考本年度預算實支比</asp:HyperLink>
                <br />  <br />
                                <asp:HyperLink ID="HyperLink8" runat="server" CssClass="btn btn-warning" Target="_blank" NavigateUrl="BudgetReference2.aspx">點我參考本年度預算明細帳</asp:HyperLink>
                <br />
                <hr />
                業績編寫人員可參考下述久國/久威本年度數據<br />
                <asp:HyperLink ID="HyperLink5" runat="server" CssClass="btn btn-primary" Target="_blank" NavigateUrl="~/files/budget/JUIC業務部門2017年實績.xlsx" Enabled="False">點我下載久威國際2017業績表</asp:HyperLink>
                <br />
                <br />
                <asp:HyperLink ID="HyperLink6" runat="server" CssClass="btn btn-warning" Target="_blank" NavigateUrl="~/files/budget/JUC業績預估(1-9實10-12估)營收預估表.xlsx" Enabled="False">點我下載久威股份2017預估營收表</asp:HyperLink> 
                <asp:HyperLink ID="HyperLink7" runat="server" CssClass="btn btn-primary" Target="_blank" NavigateUrl="~/files/budget/JUC業績預估(1-9實10-12估)實際營收表.xlsx" Enabled="False">點我下載久威股份2017實際營收表</asp:HyperLink>
                <br />
                ＰＳ：營收實際/預估表若無法下載，表示您尚未開通明年度業績編輯權限
                <br />
                <br />
                <br />
                <br />


            </div>
            <div id="menu4" class="tab-pane fade">
                <h3></h3>
                <p></p>
                <p><strong>統計表格與相關資料下載</strong></p>
                <p></p>
                <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl="~/files/budget/知識平台1.預算費用匯總表v2.xlsx" Target="_blank" Text="預算費用匯總表下載" CssClass="btn btn-success" Enabled="False"></asp:HyperLink>
                <br />
                <br />
                <asp:HyperLink ID="HyperLink2" runat="server" NavigateUrl="~/files/budget/知識平台2.業務業績預估表v2.xlsx" Target="_blank" Text="業務業績預估表下載" CssClass="btn btn-warning" Enabled="False"></asp:HyperLink>
                <br />
                <br />
                *此兩份資料表連結資料庫，會隨著資料庫更新而變動，可點選EXCEL上方[資料]&gt;[全部重新整理]更新
                (現階段僅提供具有「可設定預算編寫人員」者下載)
            </div>
            <div id="menu5" class="tab-pane fade">
                <h3></h3>
                <p></p>
                <asp:Label ID="Label8" runat="server" Text="" Font-Size="Larger"></asp:Label>
                <asp:Panel ID="Panel4" runat="server" Font-Names="微軟正黑體" Visible="False">
                    <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                        <ContentTemplate>
                            <asp:Label ID="Label7" runat="server" Text="業績編寫人員設定作業" Font-Size="X-Large"></asp:Label>
                            <br />
                            <br />
                            選擇業績編寫人員：<asp:DropDownList ID="DropDownList1" runat="server" DataSourceID="SqlDataSource5" DataTextField="username" DataValueField="userid" Width="200px"></asp:DropDownList>
                            <br />

                            選擇可編寫部門客戶：<asp:DropDownList ID="DropDownList8" runat="server" AutoPostBack="True">
                                <asp:ListItem Value="T3010">(久國)業務一部</asp:ListItem>
                                <asp:ListItem Value="T3020">(久國)業務二部</asp:ListItem>
                                <asp:ListItem Value="T9100">(久國)久鋐電子</asp:ListItem>
                                <asp:ListItem Value="J3010">(久股)業務一部</asp:ListItem>
                                <asp:ListItem Value="J3020">(久股)業務二部</asp:ListItem>
                                <asp:ListItem Value="J9100">(久股)廣田光電</asp:ListItem>
                            </asp:DropDownList>
                            <br />
                            <asp:Button ID="Button2" runat="server" Text="送出" CssClass="btn btn-primary" OnClick="Button2_Click" />

                            <br />
                            <hr />

                            <asp:Label ID="Label2" runat="server" Text="各部門預算編寫人員設定作業" Font-Size="X-Large"></asp:Label>
                            <br />
                            <br />
                            選擇預算編寫人員：<asp:DropDownList ID="DropDownList2" runat="server" DataSourceID="SqlDataSource5" DataTextField="username" DataValueField="userid" Width="200px"></asp:DropDownList>
                            <br />
                            <asp:RadioButtonList ID="RadioButtonList1" runat="server" AutoPostBack="True" RepeatDirection="Horizontal">
                                <asp:ListItem Selected="True" Value="JUIC">久威國際</asp:ListItem>
                                <asp:ListItem Value="JUTW">久威股份</asp:ListItem>
                            </asp:RadioButtonList>
                            <asp:SqlDataSource ID="SqlDataSource5" runat="server" ConnectionString="<%$ ConnectionStrings:MENU %>" SelectCommand="  SELECT userid,username  FROM bas03 order by userid"></asp:SqlDataSource>
                            選擇預算編寫部門：<asp:DropDownList ID="DropDownList3" runat="server" DataSourceID="SqlDataSource6" DataTextField="dept_name" DataValueField="dept_no" Width="200px"></asp:DropDownList><br />
                            <asp:SqlDataSource ID="SqlDataSource6" runat="server" ConnectionString="<%$ ConnectionStrings:MENU %>" SelectCommand="SELECT [dept_no], [dept_name] FROM [TB_BudgetDeptToType] WHERE ([Comp] = @Comp)">
                                <SelectParameters>
                                    <asp:ControlParameter ControlID="RadioButtonList1" Name="Comp" PropertyName="SelectedValue" Type="String" />
                                </SelectParameters>
                            </asp:SqlDataSource>
                            選擇可填寫的類別：<asp:DropDownList ID="DropDownList4" runat="server" DataSourceID="SqlDataSource7" DataTextField="TypeWrtCh" DataValueField="TypeWrt" Width="200px"></asp:DropDownList><br />
                            <asp:SqlDataSource ID="SqlDataSource7" runat="server" ConnectionString="<%$ ConnectionStrings:MENU %>" SelectCommand="SELECT [TypeWrt], [TypeWrtCh] FROM [TB_BudgetKeyType] WHERE ([TypeWrt] = @TypeWrt)">
                                <SelectParameters>
                                    <asp:Parameter DefaultValue="n0" Name="TypeWrt" Type="String" />
                                </SelectParameters>
                            </asp:SqlDataSource>
                            <asp:Button ID="Button5" runat="server" Text="送出" CssClass="btn btn-primary" OnClick="Button5_Click" />
                            <br />
                            <hr />
                            <asp:Label ID="Label10" runat="server" Text="跨部門預算編寫人員設定作業" Font-Size="Large"></asp:Label>
                            <br />
                            選擇預算編寫人員：<asp:DropDownList ID="DropDownList5" runat="server" DataSourceID="SqlDataSource5" DataTextField="username" DataValueField="userid" Width="200px"></asp:DropDownList><br />
                            選擇預算編寫部門：<asp:DropDownList ID="DropDownList6" runat="server" DataTextField="dept_name" DataValueField="dept_no" Width="200px">
                                <asp:ListItem Value="ALLJUIC">久國跨部門</asp:ListItem>
                                 <asp:ListItem Value="ALLJUTW">久股跨部門</asp:ListItem>
                            </asp:DropDownList><br />
                            選擇可填寫的類別：<asp:DropDownList ID="DropDownList7" runat="server" DataSourceID="SqlDataSource9" DataTextField="TypeWrtCh" DataValueField="TypeWrt" Width="200px"></asp:DropDownList>
                            <asp:SqlDataSource ID="SqlDataSource9" runat="server" ConnectionString="<%$ ConnectionStrings:MENU %>" SelectCommand="SELECT [TypeWrt], [TypeWrtCh] FROM [TB_BudgetKeyType] WHERE ([TypeWrt] &lt;&gt; @TypeWrt)">
                                <SelectParameters>
                                    <asp:Parameter DefaultValue="n0" Name="TypeWrt" Type="String" />
                                </SelectParameters>
                            </asp:SqlDataSource>
                            <br />
                            <asp:Button ID="Button6" runat="server" Text="送出" CssClass="btn btn-success" OnClick="Button6_Click" />
                            <br />
                            <hr />
                            <asp:Label ID="Label4" runat="server" Text="編寫人員一覽" Font-Size="Large"></asp:Label>
                            <asp:RadioButtonList ID="RadioButtonList2" runat="server" AutoPostBack="True" RepeatDirection="Horizontal">
                                <asp:ListItem Selected="True" Value="%ALL%">跨部門</asp:ListItem>
                                <asp:ListItem Value="%T%">久威國際</asp:ListItem>
                                <asp:ListItem Value="%J%">久威股份</asp:ListItem>
                            </asp:RadioButtonList>

                            <asp:GridView ID="GridView4" runat="server" AutoGenerateColumns="False" BackColor="White" BorderColor="#999999" BorderStyle="Solid" BorderWidth="1px" CellPadding="3" DataKeyNames="no" DataSourceID="SqlDataSource8" ForeColor="Black" GridLines="Vertical">
                                <AlternatingRowStyle BackColor="#CCCCCC" />
                                <Columns>
                                    <asp:CommandField ShowDeleteButton="True" />
                                    <asp:BoundField DataField="emp_no" HeaderText="編寫者id" SortExpression="emp_no" />
                                    <asp:BoundField DataField="emp_cne" HeaderText="編寫者姓名" SortExpression="emp_cne" />
                                    <asp:BoundField DataField="emp_deptCh" HeaderText="編寫者部門" SortExpression="emp_deptCh" />
                                    <asp:BoundField DataField="TypeWrtCh" HeaderText="可編寫類別" SortExpression="TypeWrtCh" />
                                </Columns>
                                <FooterStyle BackColor="#CCCCCC" />
                                <HeaderStyle BackColor="Black" Font-Bold="True" ForeColor="White" />
                                <PagerStyle BackColor="#999999" ForeColor="Black" HorizontalAlign="Center" />
                                <SelectedRowStyle BackColor="#000099" Font-Bold="True" ForeColor="White" />
                                <SortedAscendingCellStyle BackColor="#F1F1F1" />
                                <SortedAscendingHeaderStyle BackColor="#808080" />
                                <SortedDescendingCellStyle BackColor="#CAC9C9" />
                                <SortedDescendingHeaderStyle BackColor="#383838" />
                            </asp:GridView>
                            <asp:SqlDataSource ID="SqlDataSource8" runat="server" ConnectionString="<%$ ConnectionStrings:MENU %>" DeleteCommand="DELETE FROM [TB_BudgetLevel] WHERE [no] = @no" InsertCommand="INSERT INTO [TB_BudgetLevel] ([no], [emp_no], [emp_cne], [emp_dept], [emp_deptCh], [TypeWrt], [TypeWrtCh]) VALUES (@no, @emp_no, @emp_cne, @emp_dept, @emp_deptCh, @TypeWrt, @TypeWrtCh)" SelectCommand="SELECT * FROM [TB_BudgetLevel] WHERE [emp_dept] Like @emp_dept" UpdateCommand="UPDATE [TB_BudgetLevel] SET [emp_no] = @emp_no, [emp_cne] = @emp_cne, [emp_dept] = @emp_dept, [emp_deptCh] = @emp_deptCh, [TypeWrt] = @TypeWrt, [TypeWrtCh] = @TypeWrtCh WHERE [no] = @no">
                                <DeleteParameters>
                                    <asp:Parameter Name="no" Type="Int32" />
                                </DeleteParameters>
                                <InsertParameters>
                                    <asp:Parameter Name="no" Type="Int32" />
                                    <asp:Parameter Name="emp_no" Type="String" />
                                    <asp:Parameter Name="emp_cne" Type="String" />
                                    <asp:Parameter Name="emp_dept" Type="String" />
                                    <asp:Parameter Name="emp_deptCh" Type="String" />
                                    <asp:Parameter Name="TypeWrt" Type="String" />
                                    <asp:Parameter Name="TypeWrtCh" Type="String" />
                                </InsertParameters>
                                <SelectParameters>
                                    <asp:ControlParameter ControlID="RadioButtonList2" Name="emp_dept" PropertyName="SelectedValue" />
                                </SelectParameters>
                                <UpdateParameters>
                                    <asp:Parameter Name="emp_no" Type="String" />
                                    <asp:Parameter Name="emp_cne" Type="String" />
                                    <asp:Parameter Name="emp_dept" Type="String" />
                                    <asp:Parameter Name="emp_deptCh" Type="String" />
                                    <asp:Parameter Name="TypeWrt" Type="String" />
                                    <asp:Parameter Name="TypeWrtCh" Type="String" />
                                    <asp:Parameter Name="no" Type="Int32" />
                                </UpdateParameters>
                            </asp:SqlDataSource>
                            <br />
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </asp:Panel>
            </div>
        </div>


    </div>

    <div class="col-md-1"></div>
</asp:Content>
