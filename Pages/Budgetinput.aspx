<%@ Page Title="" Language="C#" MasterPageFile="~/Master/JuicERP.Master" AutoEventWireup="true" CodeBehind="Budgetinput.aspx.cs" Inherits="JuicERP.Pages.Budgetinput" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.8.2/jquery.min.js"></script>
    <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.9.1/jquery-ui.min.js"></script>
    <script type="text/javascript" src="../js/gridviewScroll.min.js"></script>
    <script type="text/javascript">
        $(document).ready(function () {
            gridviewScroll();
            gridviewScroll1();
            gridviewScroll2();
        });

        function gridviewScroll() {
            $('#<%=GridView1.ClientID%>').gridviewScroll({
            width: 1080,
            height: 500,
            freezesize: 4

        });
    }
    function gridviewScroll1() {
        debugger;
        $('#<%=GridView2.ClientID%>').gridviewScroll({
            width: 1080,
            height: 500,
            freezesize: 4

        });

    }

    function gridviewScroll2() {
        $('#<%=GridView3.ClientID%>').gridviewScroll({
            width: 1080,
            height: 500,
            freezesize: 2

        });
    }
    </script>

    <script type="text/javascript">

        //  選擇 GridView 全部的 checkbox
        //  傳入控制checkbox全選的checkbox物件
        function checkAll0(header) {
            $('#<%= GridView2.ClientID %> input[type=checkbox]').prop("checked", header.checked);

    }
    </script>
    <script type="text/javascript">

        //  選擇 GridView 全部的 checkbox
        //  傳入控制checkbox全選的checkbox物件
        function checkAll(header) {
            $('#<%= GridView3.ClientID %> input[type=checkbox]').prop("checked", header.checked);

    }
    </script>
    <%--    凍結窗格指令--%>
    <style type="text/css">
        .GridviewScrollHeader TH, .GridviewScrollHeader TD {
            padding: 1px;
            font-weight: bold;
            white-space: nowrap;
            border-right: 1px solid #AAAAAA;
            border-bottom: 1px solid #AAAAAA;
            background-color: #EFEFEF;
            text-align: left;
            vertical-align: bottom;
        }

        .GridviewScrollItem TD {
            padding: 1px;
            white-space: nowrap;
            border-right: 1px solid #AAAAAA;
            border-bottom: 1px solid #AAAAAA;
            background-color: #FFFFFF;
            height: 40px;
        }

        .GridviewScrollPager {
            border-top: 1px solid #AAAAAA;
            background-color: #FFFFFF;
        }

            .GridviewScrollPager TD {
                padding-top: 3px;
                font-size: 14px;
                padding-left: 5px;
                padding-right: 5px;
            }

            .GridviewScrollPager A {
                color: #666666;
            }

            .GridviewScrollPager SPAN {
                font-size: 16px;
                font-weight: bold;
            }
    </style>
    <%--    凍結窗格指令--%>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div style="font-family: 微軟正黑體">
        <asp:Panel ID="Panel1" runat="server" ScrollBars="Horizontal">
            <div align="center">
                <asp:Label ID="Label7" runat="server" Text="業務單位業績預估表" Font-Size="Large" Font-Bold="True"></asp:Label>
                <br />
                所屬客戶：<asp:DropDownList ID="DropDownList3" runat="server" AutoPostBack="True" AppendDataBoundItems="True" DataSourceID="SqlDataSource7" DataTextField="emp_deptCh" DataValueField="emp_dept">
                    <%--            <asp:ListItem Value="">請選擇</asp:ListItem>--%>
                </asp:DropDownList>
                <asp:SqlDataSource ID="SqlDataSource7" runat="server" ConnectionString="<%$ ConnectionStrings:MENU %>" SelectCommand="SELECT * FROM [TB_BudgetLevel] WHERE (([TypeWrt] = @TypeWrt) AND ([emp_no] = @emp_no))">
                    <SelectParameters>
                        <asp:Parameter DefaultValue="sa" Name="TypeWrt" Type="String" />
                        <asp:ControlParameter ControlID="Label1" Name="emp_no" PropertyName="Text" Type="String" />
                    </SelectParameters>
                </asp:SqlDataSource>
                選擇業務：<asp:DropDownList ID="DropDownList4" runat="server" AppendDataBoundItems="True" AutoPostBack="True" DataSourceID="SqlDataSource6" DataTextField="emp_cne" DataValueField="emp_cne">
                    <asp:ListItem Selected="True" Value="%%">不分</asp:ListItem>
                </asp:DropDownList>
                <asp:SqlDataSource ID="SqlDataSource6" runat="server" ConnectionString="<%$ ConnectionStrings:MENU %>" SelectCommand="select distinct emp_cne from TB_BudgetTableSales"></asp:SqlDataSource>
                <br />
                <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" CellPadding="3" DataKeyNames="no" DataSourceID="SqlDataSource1" GridLines="Vertical" OnRowDataBound="GridView1_RowDataBound" BackColor="White" BorderColor="#999999" BorderStyle="None" BorderWidth="1px" AllowPaging="True" PageSize="20">
                    <AlternatingRowStyle BackColor="#DCDCDC" />
                    <Columns>
                        <asp:BoundField DataField="no" HeaderText="no" InsertVisible="False" ReadOnly="True" SortExpression="no" Visible="False" />
                        <asp:TemplateField HeaderText="員編" SortExpression="emp_no">
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox3" runat="server" Text='<%# Bind("emp_no") %>'></asp:TextBox>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="emp_no" runat="server" Text='<%# Bind("emp_no") %>' Width="50px"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="業務" SortExpression="emp_cne">
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox4" runat="server" Text='<%# Bind("emp_cne") %>'></asp:TextBox>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="emp_cne" runat="server" Text='<%# Bind("emp_cne") %>' Width="50px"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="客戶名稱" SortExpression="CUS_NE2">
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox28" runat="server" Text='<%# Bind("CUS_NE2") %>'></asp:TextBox>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="CUS_NE2" runat="server" Text='<%# Bind("CUS_NE2") %>' Width="200px"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="年度" SortExpression="year">
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox30" runat="server" Text='<%# Bind("year") %>'></asp:TextBox>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="year" runat="server" Text='<%# Bind("year") %>' Width="40px"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="1月營收" SortExpression="mon1">
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("mon1") %>'></asp:TextBox>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:TextBox ID="mon1" runat="server" Text='<%# Bind("mon1") %>' Width="100px" Style="text-align: right"></asp:TextBox>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="毛利" SortExpression="mon1gp">
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("mon1gp") %>'></asp:TextBox>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:TextBox ID="mon1gp" runat="server" Text='<%# Bind("mon1gp") %>' Width="50px" Style="text-align: right"></asp:TextBox>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="2月營收" SortExpression="mon2">
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox5" runat="server" Text='<%# Bind("mon2") %>'></asp:TextBox>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:TextBox ID="mon2" runat="server" Text='<%# Bind("mon2") %>' Width="100px" Style="text-align: right"></asp:TextBox>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="毛利" SortExpression="mon2gp">
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox6" runat="server" Text='<%# Bind("mon2gp") %>'></asp:TextBox>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:TextBox ID="mon2gp" runat="server" Text='<%# Bind("mon2gp") %>' Width="50px" Style="text-align: right"></asp:TextBox>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="3月營收" SortExpression="mon3">
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox7" runat="server" Text='<%# Bind("mon3") %>'></asp:TextBox>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:TextBox ID="mon3" runat="server" Text='<%# Bind("mon3") %>' Width="100px" Style="text-align: right"></asp:TextBox>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="毛利" SortExpression="mon3gp">
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox8" runat="server" Text='<%# Bind("mon3gp") %>'></asp:TextBox>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:TextBox ID="mon3gp" runat="server" Text='<%# Bind("mon3gp") %>' Width="50px" Style="text-align: right"></asp:TextBox>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="4月營收" SortExpression="mon4">
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox9" runat="server" Text='<%# Bind("mon4") %>'></asp:TextBox>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:TextBox ID="mon4" runat="server" Text='<%# Bind("mon4") %>' Width="100px" Style="text-align: right"></asp:TextBox>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="毛利" SortExpression="mon4gp">
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox10" runat="server" Text='<%# Bind("mon4gp") %>'></asp:TextBox>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:TextBox ID="mon4gp" runat="server" Text='<%# Bind("mon4gp") %>' Width="50px" Style="text-align: right"></asp:TextBox>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="5月營收" SortExpression="mon5">
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox11" runat="server" Text='<%# Bind("mon5") %>'></asp:TextBox>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:TextBox ID="mon5" runat="server" Text='<%# Bind("mon5") %>' Width="100px" Style="text-align: right"></asp:TextBox>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="毛利" SortExpression="mon5gp">
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox12" runat="server" Text='<%# Bind("mon5gp") %>'></asp:TextBox>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:TextBox ID="mon5gp" runat="server" Text='<%# Bind("mon5gp") %>' Width="50px" Style="text-align: right"></asp:TextBox>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="6月營收" SortExpression="mon6">
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox13" runat="server" Text='<%# Bind("mon6") %>'></asp:TextBox>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:TextBox ID="mon6" runat="server" Text='<%# Bind("mon6") %>' Width="100px" Style="text-align: right"></asp:TextBox>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="毛利" SortExpression="mon6gp">
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox14" runat="server" Text='<%# Bind("mon6gp") %>'></asp:TextBox>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:TextBox ID="mon6gp" runat="server" Text='<%# Bind("mon6gp") %>' Width="50px" Style="text-align: right"></asp:TextBox>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="7月營收" SortExpression="mon7">
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox15" runat="server" Text='<%# Bind("mon7") %>'></asp:TextBox>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:TextBox ID="mon7" runat="server" Text='<%# Bind("mon7") %>' Width="100px" Style="text-align: right"></asp:TextBox>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="毛利" SortExpression="mon7gp">
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox16" runat="server" Text='<%# Bind("mon7gp") %>'></asp:TextBox>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:TextBox ID="mon7gp" runat="server" Text='<%# Bind("mon7gp") %>' Width="50px" Style="text-align: right"></asp:TextBox>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="8月營收" SortExpression="mon8">
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox17" runat="server" Text='<%# Bind("mon8") %>'></asp:TextBox>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:TextBox ID="mon8" runat="server" Text='<%# Bind("mon8") %>' Width="100px" Style="text-align: right"></asp:TextBox>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="毛利" SortExpression="mon8gp">
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox18" runat="server" Text='<%# Bind("mon8gp") %>'></asp:TextBox>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:TextBox ID="mon8gp" runat="server" Text='<%# Bind("mon8gp") %>' Width="50px" Style="text-align: right"></asp:TextBox>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="9月營收" SortExpression="mon9">
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox19" runat="server" Text='<%# Bind("mon9") %>'></asp:TextBox>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:TextBox ID="mon9" runat="server" Text='<%# Bind("mon9") %>' Width="100px" Style="text-align: right"></asp:TextBox>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="毛利" SortExpression="mon9gp">
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox20" runat="server" Text='<%# Bind("mon9gp") %>'></asp:TextBox>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:TextBox ID="mon9gp" runat="server" Text='<%# Bind("mon9gp") %>' Width="50px" Style="text-align: right"></asp:TextBox>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="10月營收" SortExpression="mon10">
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox21" runat="server" Text='<%# Bind("mon10") %>'></asp:TextBox>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:TextBox ID="mon10" runat="server" Text='<%# Bind("mon10") %>' Width="100px" Style="text-align: right"></asp:TextBox>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="毛利" SortExpression="mon10gp">
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox22" runat="server" Text='<%# Bind("mon10gp") %>'></asp:TextBox>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:TextBox ID="mon10gp" runat="server" Text='<%# Bind("mon10gp") %>' Width="50px" Style="text-align: right"></asp:TextBox>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="11月營收" SortExpression="mon11">
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox23" runat="server" Text='<%# Bind("mon11") %>'></asp:TextBox>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:TextBox ID="mon11" runat="server" Text='<%# Bind("mon11") %>' Width="100px" Style="text-align: right"></asp:TextBox>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="毛利" SortExpression="mon11gp">
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox24" runat="server" Text='<%# Bind("mon11gp") %>'></asp:TextBox>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:TextBox ID="mon11gp" runat="server" Text='<%# Bind("mon11gp") %>' Width="50px" Style="text-align: right"></asp:TextBox>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="12月營收" SortExpression="mon12">
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox25" runat="server" Text='<%# Bind("mon12") %>'></asp:TextBox>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:TextBox ID="mon12" runat="server" Text='<%# Bind("mon12") %>' Width="100px" Style="text-align: right"></asp:TextBox>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="毛利" SortExpression="mon12gp">
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox26" runat="server" Text='<%# Bind("mon12gp") %>'></asp:TextBox>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:TextBox ID="mon12gp" runat="server" Text='<%# Bind("mon12gp") %>' Width="50px" Style="text-align: right"></asp:TextBox>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="備註" SortExpression="PS">
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox29" runat="server" Text='<%# Bind("PS") %>'></asp:TextBox>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:TextBox ID="PS" runat="server" Text='<%# Bind("PS") %>'></asp:TextBox>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="modi" HeaderText="modi" SortExpression="modi" Visible="False" />
                    </Columns>
                    <FooterStyle BackColor="#CCCCCC" ForeColor="Black" />
                    <HeaderStyle BackColor="#000084" Font-Bold="True" ForeColor="White" />
                    <PagerStyle BackColor="#999999" ForeColor="Black" HorizontalAlign="Center" />
                    <RowStyle BackColor="#EEEEEE" ForeColor="Black" />
                    <SelectedRowStyle BackColor="#008A8C" Font-Bold="True" ForeColor="White" />
                    <SortedAscendingCellStyle BackColor="#F1F1F1" />
                    <SortedAscendingHeaderStyle BackColor="#0000A9" />
                    <SortedDescendingCellStyle BackColor="#CAC9C9" />
                    <SortedDescendingHeaderStyle BackColor="#000065" />
                    <%--           <HeaderStyle CssClass="GridviewScrollHeader" />
            <RowStyle CssClass="GridviewScrollItem" />
            <PagerStyle CssClass="GridviewScrollPager" />--%>
                </asp:GridView>




                <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:MENU %>" DeleteCommand="DELETE FROM [TB_BudgetTableSales] WHERE [no] = @no" InsertCommand="INSERT INTO [TB_BudgetTableSales] ([emp_no], [emp_cne], [dept_no], [CUS_NE2], [PS], [mon1], [mon1gp], [mon2], [mon2gp], [mon3], [mon3gp], [mon4], [mon4gp], [mon5], [mon5gp], [mon6], [mon6gp], [mon7], [mon7gp], [mon8], [mon8gp], [mon9], [mon9gp], [mon10], [mon10gp], [mon11], [mon11gp], [mon12], [mon12gp], [modi], [year]) VALUES (@emp_no, @emp_cne, @dept_no, @CUS_NE2, @PS, @mon1, @mon1gp, @mon2, @mon2gp, @mon3, @mon3gp, @mon4, @mon4gp, @mon5, @mon5gp, @mon6, @mon6gp, @mon7, @mon7gp, @mon8, @mon8gp, @mon9, @mon9gp, @mon10, @mon10gp, @mon11, @mon11gp, @mon12, @mon12gp, @modi, @year)" SelectCommand="SELECT * FROM [TB_BudgetTableSales] WHERE ([emp_cne] LIKE @emp_cne ) and ([dept_no] LIKE @dept_no )" UpdateCommand="UPDATE [TB_BudgetTableSales] SET [emp_no] = @emp_no, [emp_cne] = @emp_cne,  [CUS_NE2] = @CUS_NE2, [PS] = @PS, [mon1] = @mon1, [mon1gp] = @mon1gp, [mon2] = @mon2, [mon2gp] = @mon2gp, [mon3] = @mon3, [mon3gp] = @mon3gp, [mon4] = @mon4, [mon4gp] = @mon4gp, [mon5] = @mon5, [mon5gp] = @mon5gp, [mon6] = @mon6, [mon6gp] = @mon6gp, [mon7] = @mon7, [mon7gp] = @mon7gp, [mon8] = @mon8, [mon8gp] = @mon8gp, [mon9] = @mon9, [mon9gp] = @mon9gp, [mon10] = @mon10, [mon10gp] = @mon10gp, [mon11] = @mon11, [mon11gp] = @mon11gp, [mon12] = @mon12, [mon12gp] = @mon12gp, [modi] = @modi, [year] = @year WHERE [no] = @no">
                    <DeleteParameters>
                        <asp:Parameter Name="no" Type="Int32" />
                    </DeleteParameters>
                    <InsertParameters>
                        <asp:Parameter Name="emp_no" Type="String" />
                        <asp:Parameter Name="emp_cne" Type="String" />
                        <asp:Parameter Name="dept_no" />
                        <asp:Parameter Name="CUS_NE2" Type="String" />
                        <asp:Parameter Name="PS" Type="String" />
                        <asp:Parameter Name="mon1" Type="Int32" />
                        <asp:Parameter Name="mon1gp" Type="Decimal" />
                        <asp:Parameter Name="mon2" Type="Int32" />
                        <asp:Parameter Name="mon2gp" Type="Decimal" />
                        <asp:Parameter Name="mon3" Type="Int32" />
                        <asp:Parameter Name="mon3gp" Type="Decimal" />
                        <asp:Parameter Name="mon4" Type="Int32" />
                        <asp:Parameter Name="mon4gp" Type="Decimal" />
                        <asp:Parameter Name="mon5" Type="Int32" />
                        <asp:Parameter Name="mon5gp" Type="Decimal" />
                        <asp:Parameter Name="mon6" Type="Int32" />
                        <asp:Parameter Name="mon6gp" Type="Decimal" />
                        <asp:Parameter Name="mon7" Type="Int32" />
                        <asp:Parameter Name="mon7gp" Type="Decimal" />
                        <asp:Parameter Name="mon8" Type="Int32" />
                        <asp:Parameter Name="mon8gp" Type="Decimal" />
                        <asp:Parameter Name="mon9" Type="Int32" />
                        <asp:Parameter Name="mon9gp" Type="Decimal" />
                        <asp:Parameter Name="mon10" Type="Int32" />
                        <asp:Parameter Name="mon10gp" Type="Decimal" />
                        <asp:Parameter Name="mon11" Type="Int32" />
                        <asp:Parameter Name="mon11gp" Type="Decimal" />
                        <asp:Parameter Name="mon12" Type="Int32" />
                        <asp:Parameter Name="mon12gp" Type="Decimal" />
                        <asp:Parameter Name="modi" Type="String" />
                        <asp:Parameter Name="year" Type="Int32" />
                    </InsertParameters>
                    <SelectParameters>
                        <asp:ControlParameter ControlID="DropDownList4" Name="emp_cne" PropertyName="SelectedValue" />
                        <asp:ControlParameter ControlID="DropDownList3" Name="dept_no" PropertyName="SelectedValue" />
                    </SelectParameters>
                    <UpdateParameters>
                        <asp:Parameter Name="emp_no" Type="String" />
                        <asp:Parameter Name="emp_cne" Type="String" />
                        <asp:Parameter Name="CUS_NE2" Type="String" />
                        <asp:Parameter Name="PS" Type="String" />
                        <asp:Parameter Name="mon1" Type="Int32" />
                        <asp:Parameter Name="mon1gp" Type="Decimal" />
                        <asp:Parameter Name="mon2" Type="Int32" />
                        <asp:Parameter Name="mon2gp" Type="Decimal" />
                        <asp:Parameter Name="mon3" Type="Int32" />
                        <asp:Parameter Name="mon3gp" Type="Decimal" />
                        <asp:Parameter Name="mon4" Type="Int32" />
                        <asp:Parameter Name="mon4gp" Type="Decimal" />
                        <asp:Parameter Name="mon5" Type="Int32" />
                        <asp:Parameter Name="mon5gp" Type="Decimal" />
                        <asp:Parameter Name="mon6" Type="Int32" />
                        <asp:Parameter Name="mon6gp" Type="Decimal" />
                        <asp:Parameter Name="mon7" Type="Int32" />
                        <asp:Parameter Name="mon7gp" Type="Decimal" />
                        <asp:Parameter Name="mon8" Type="Int32" />
                        <asp:Parameter Name="mon8gp" Type="Decimal" />
                        <asp:Parameter Name="mon9" Type="Int32" />
                        <asp:Parameter Name="mon9gp" Type="Decimal" />
                        <asp:Parameter Name="mon10" Type="Int32" />
                        <asp:Parameter Name="mon10gp" Type="Decimal" />
                        <asp:Parameter Name="mon11" Type="Int32" />
                        <asp:Parameter Name="mon11gp" Type="Decimal" />
                        <asp:Parameter Name="mon12" Type="Int32" />
                        <asp:Parameter Name="mon12gp" Type="Decimal" />
                        <asp:Parameter Name="modi" Type="String" />
                        <asp:Parameter Name="year" Type="Int32" />
                        <asp:Parameter Name="no" Type="Int32" />
                    </UpdateParameters>
                </asp:SqlDataSource>
                <div style="color: #FF0000">*毛利預估請填入不大於1的小數，如毛利率35%→0.35</div>
                <asp:Button ID="Button2" runat="server" OnClick="Button2_Click" Text="更新業績預估" CssClass="btn btn-success" />
                <br /><br />
                <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl="~/files/budget/久國業務一部預算簽核表.xlsx" CssClass="btn btn-primary " Enabled="False">久國業一預算簽核表</asp:HyperLink>
                <asp:HyperLink ID="HyperLink2" runat="server" NavigateUrl="~/files/budget/久國業務二部預算簽核表.xlsx" CssClass="btn btn-warning " Enabled="False">久國業二預算簽核表</asp:HyperLink>
                <asp:HyperLink ID="HyperLink3" runat="server" NavigateUrl="~/files/budget/久股業務一部預算簽核表.xlsx" CssClass="btn btn-danger " Enabled="False">久股業一預算簽核表</asp:HyperLink>
                <asp:HyperLink ID="HyperLink4" runat="server" NavigateUrl="~/files/budget/久股業務二部預算簽核表.xlsx" CssClass="btn btn-default " Enabled="False">久股業二預算簽核表</asp:HyperLink>
                <br />簽核表下載後，若業績預算有做更動，可點選EXCEL內「資料」→「全部重新整理」與資料庫同步
            </div>
        </asp:Panel>
        <asp:Panel ID="Panel2" runat="server" ScrollBars="Horizontal">


            <div align="center">
                <asp:DropDownList ID="DropDownList2" runat="server" DataSourceID="SqlDataSource5" DataTextField="emp_deptCh" DataValueField="emp_dept" AutoPostBack="True">
                </asp:DropDownList>
                <asp:Label ID="Label4" runat="server" Font-Bold="True" Font-Size="Large" Text="預算資料填寫(J久股T久威)"></asp:Label>
                <asp:SqlDataSource ID="SqlDataSource5" runat="server" ConnectionString="<%$ ConnectionStrings:MENU %>" SelectCommand="SELECT ([emp_dept]+[emp_deptCh]) as [emp_deptCh], [emp_dept] FROM [TB_BudgetLevel] WHERE (([emp_no] = @emp_no) AND ([emp_dept] &lt;&gt; @emp_dept)) AND ([TypeWrt]&lt;&gt;@TypeWrt)">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="Label1" Name="emp_no" PropertyName="Text" Type="String" />
                        <asp:Parameter DefaultValue="ALL" Name="emp_dept" Type="String" />
                        <asp:Parameter DefaultValue="sa" Name="TypeWrt" />
                    </SelectParameters>
                </asp:SqlDataSource>
                <br />


                <asp:GridView ID="GridView2" runat="server" AutoGenerateColumns="False" BackColor="White" BorderColor="#999999" BorderStyle="Solid" BorderWidth="1px" CellPadding="3" DataKeyNames="no" DataSourceID="SqlDataSource2" ForeColor="Black" GridLines="Vertical" OnRowDataBound="GridView2_RowDataBound">
                    <AlternatingRowStyle BackColor="#CCCCCC" />
                    <Columns>
                        <asp:TemplateField HeaderText="修改" ItemStyle-HorizontalAlign="Center">
                            <HeaderTemplate>
                                <%--<asp:CheckBox ID="cbHeader" runat="server" onclick="checkAll0(this);" />--%>
                                <asp:CheckBox ID="cbSelecteds" runat="server" AutoPostBack="true" OnCheckedChanged="cbSelecteds_CheckedChanged" />
                            </HeaderTemplate>
                            <EditItemTemplate>
                                <%--                   <asp:CheckBox ID="CheckBox1" runat="server" />--%>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:CheckBox ID="cbSelected1" runat="server" />
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="no" HeaderText="no" InsertVisible="False" ReadOnly="True" SortExpression="no" Visible="False" />
                        <%--                    <asp:TemplateField HeaderText="員編" SortExpression="emp_no">
                        <EditItemTemplate>
                            <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("emp_no") %>'></asp:TextBox>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="emp_no" runat="server" Text='<%# Bind("emp_no") %>' Width="50px"></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="編輯者" SortExpression="emp_cne">
                        <EditItemTemplate>
                            <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("emp_cne") %>'></asp:TextBox>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="emp_cne" runat="server" Text='<%# Bind("emp_cne") %>' Width="70px"></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="修改日期" SortExpression="editdate">
                        <EditItemTemplate>
                            <asp:TextBox ID="TextBox3" runat="server" Text='<%# Bind("editdate") %>'></asp:TextBox>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="editdate" runat="server" Text='<%# Bind("editdate") %>'  Width="80px"></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>--%>
                        <asp:TemplateField HeaderText="年度" SortExpression="year">
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox4" runat="server" Text='<%# Bind("year") %>'></asp:TextBox>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="year" runat="server" Text='<%# Bind("year") %>' Width="50px"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="科目代碼" SortExpression="AccNO">
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox6" runat="server" Text='<%# Bind("AccNO") %>'></asp:TextBox>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="AccNO" runat="server" Text='<%# Bind("AccNO") %>' Width="70px"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="科目名稱" SortExpression="AccName">
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox7" runat="server" Text='<%# Bind("AccName") %>'></asp:TextBox>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="AccName" runat="server" Text='<%# Bind("AccName") %>' Width="150px"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="部門代號" SortExpression="dept_no">
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox8" runat="server" Text='<%# Bind("dept_no") %>'></asp:TextBox>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="dept_no" runat="server" Text='<%# Bind("dept_no") %>' Width="60px"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="1月支出預算" SortExpression="mon01">
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox9" runat="server" Text='<%# Bind("mon01") %>'></asp:TextBox>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:TextBox ID="mon01" runat="server" Text='<%# Bind("mon01") %>' Width="100px" Style="text-align: right"></asp:TextBox>
                                  <%-- <asp:TextBox ID="mon01" runat="server" Text='<%# Bind("mon01") %>' Width="100px" Style="text-align: right" AutoPostBack="True" OnTextChanged="ValuesTextBox_TextChanged"></asp:TextBox>--%>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="2月支出預算" SortExpression="mon02">
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox10" runat="server" Text='<%# Bind("mon02") %>'></asp:TextBox>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:TextBox ID="mon02" runat="server" Text='<%# Bind("mon02") %>' Width="100px" Style="text-align: right"></asp:TextBox>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="3月支出預算" SortExpression="mon03">
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox11" runat="server" Text='<%# Bind("mon03") %>'></asp:TextBox>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:TextBox ID="mon03" runat="server" Text='<%# Bind("mon03") %>' Width="100px" Style="text-align: right"></asp:TextBox>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="4月支出預算" SortExpression="mon04">
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox12" runat="server" Text='<%# Bind("mon04") %>'></asp:TextBox>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:TextBox ID="mon04" runat="server" Text='<%# Bind("mon04") %>' Width="100px" Style="text-align: right"></asp:TextBox>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="5月支出預算" SortExpression="mon05">
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox13" runat="server" Text='<%# Bind("mon05") %>'></asp:TextBox>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:TextBox ID="mon05" runat="server" Text='<%# Bind("mon05") %>' Width="100px" Style="text-align: right"></asp:TextBox>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="6月支出預算" SortExpression="mon06">
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox14" runat="server" Text='<%# Bind("mon06") %>'></asp:TextBox>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:TextBox ID="mon06" runat="server" Text='<%# Bind("mon06") %>' Width="100px" Style="text-align: right"></asp:TextBox>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="7月支出預算" SortExpression="mon07">
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox15" runat="server" Text='<%# Bind("mon07") %>'></asp:TextBox>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:TextBox ID="mon07" runat="server" Text='<%# Bind("mon07") %>' Width="100px" Style="text-align: right"></asp:TextBox>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="8月支出預算" SortExpression="mon08">
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox16" runat="server" Text='<%# Bind("mon08") %>'></asp:TextBox>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:TextBox ID="mon08" runat="server" Text='<%# Bind("mon08") %>' Width="100px" Style="text-align: right"></asp:TextBox>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="9月支出預算" SortExpression="mon09">
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox17" runat="server" Text='<%# Bind("mon09") %>'></asp:TextBox>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:TextBox ID="mon09" runat="server" Text='<%# Bind("mon09") %>' Width="100px" Style="text-align: right"></asp:TextBox>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="10月支出預算" SortExpression="mon10">
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox18" runat="server" Text='<%# Bind("mon10") %>'></asp:TextBox>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:TextBox ID="mon10" runat="server" Text='<%# Bind("mon10") %>' Width="100px" Style="text-align: right"></asp:TextBox>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="11月支出預算" SortExpression="mon11">
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox19" runat="server" Text='<%# Bind("mon11") %>'></asp:TextBox>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:TextBox ID="mon11" runat="server" Text='<%# Bind("mon11") %>' Width="100px" Style="text-align: right"></asp:TextBox>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="12月支出預算" SortExpression="mon12">
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox20" runat="server" Text='<%# Bind("mon12") %>'></asp:TextBox>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:TextBox ID="mon12" runat="server" Text='<%# Bind("mon12") %>' Width="100px" Style="text-align: right"></asp:TextBox>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="備註" SortExpression="ps">
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox5" runat="server" Text='<%# Bind("ps") %>'></asp:TextBox>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:TextBox ID="ps" runat="server" Text='<%# Bind("ps") %>' Width="150px"></asp:TextBox>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                    <FooterStyle BackColor="#CCCCCC" />

                    <HeaderStyle BackColor="Black" Font-Bold="True" ForeColor="White" />

                    <PagerStyle BackColor="#999999" ForeColor="Black" HorizontalAlign="Center" />

                    <SelectedRowStyle BackColor="#000099" Font-Bold="True" ForeColor="White" />
                    <SortedAscendingCellStyle BackColor="#F1F1F1" />
                    <SortedAscendingHeaderStyle BackColor="#808080" />
                    <SortedDescendingCellStyle BackColor="#CAC9C9" />
                    <SortedDescendingHeaderStyle BackColor="#383838" />
                    <%--                <HeaderStyle CssClass="GridviewScrollHeader" />
        <RowStyle CssClass="GridviewScrollItem" />
        <PagerStyle CssClass="GridviewScrollPager" />--%>
                </asp:GridView>
                <asp:Button ID="Button3" runat="server" OnClick="Button3_Click" Text="更新預算資料" CssClass="btn btn-success" />
                <br />
                <asp:Button ID="Button5" runat="server" CssClass="btn btn-warning" OnClick="Button5_Click" Text="列印預算資料" />
                <br />
                <br />
                <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:MENU %>" DeleteCommand="DELETE FROM [TB_BudgetTable] WHERE [no] = @no" InsertCommand="INSERT INTO [TB_BudgetTable] ([emp_no], [emp_cne], [editdate], [year], [ps], [AccNO], [AccName], [dept_no], [mon01], [mon02], [mon03], [mon04], [mon05], [mon06], [mon07], [mon08], [mon09], [mon10], [mon11], [mon12]) VALUES (@emp_no, @emp_cne, @editdate, @year, @ps, @AccNO, @AccName, @dept_no, @mon01, @mon02, @mon03, @mon04, @mon05, @mon06, @mon07, @mon08, @mon09, @mon10, @mon11, @mon12)" SelectCommand="SELECT * FROM [TB_BudgetTable] WHERE ([dept_no] = @dept_no) and ([TypeWrt]='n0') order by [AccNo]" UpdateCommand="UPDATE [TB_BudgetTable] SET [emp_no] = @emp_no, [emp_cne] = @emp_cne, [editdate] = @editdate, [year] = @year, [ps] = @ps, [AccNO] = @AccNO, [AccName] = @AccName, [dept_no] = @dept_no, [mon01] = @mon01, [mon02] = @mon02, [mon03] = @mon03, [mon04] = @mon04, [mon05] = @mon05, [mon06] = @mon06, [mon07] = @mon07, [mon08] = @mon08, [mon09] = @mon09, [mon10] = @mon10, [mon11] = @mon11, [mon12] = @mon12 WHERE [no] = @no">
                    <DeleteParameters>
                        <asp:Parameter Name="no" Type="Int32" />
                    </DeleteParameters>
                    <InsertParameters>
                        <asp:Parameter Name="emp_no" Type="String" />
                        <asp:Parameter Name="emp_cne" Type="String" />
                        <asp:Parameter Name="editdate" Type="DateTime" />
                        <asp:Parameter Name="year" Type="Int32" />
                        <asp:Parameter Name="ps" Type="String" />
                        <asp:Parameter Name="AccNO" Type="Int32" />
                        <asp:Parameter Name="AccName" Type="String" />
                        <asp:Parameter Name="dept_no" Type="String" />
                        <asp:Parameter Name="mon01" Type="Int32" />
                        <asp:Parameter Name="mon02" Type="Int32" />
                        <asp:Parameter Name="mon03" Type="Int32" />
                        <asp:Parameter Name="mon04" Type="Int32" />
                        <asp:Parameter Name="mon05" Type="Int32" />
                        <asp:Parameter Name="mon06" Type="Int32" />
                        <asp:Parameter Name="mon07" Type="Int32" />
                        <asp:Parameter Name="mon08" Type="Int32" />
                        <asp:Parameter Name="mon09" Type="Int32" />
                        <asp:Parameter Name="mon10" Type="Int32" />
                        <asp:Parameter Name="mon11" Type="Int32" />
                        <asp:Parameter Name="mon12" Type="Int32" />
                    </InsertParameters>
                    <SelectParameters>
                        <asp:ControlParameter ControlID="DropDownList2" Name="dept_no" PropertyName="SelectedValue" Type="String" DefaultValue="" />
                    </SelectParameters>
                    <UpdateParameters>
                        <asp:Parameter Name="emp_no" Type="String" />
                        <asp:Parameter Name="emp_cne" Type="String" />
                        <asp:Parameter Name="editdate" Type="DateTime" />
                        <asp:Parameter Name="year" Type="Int32" />
                        <asp:Parameter Name="ps" Type="String" />
                        <asp:Parameter Name="AccNO" Type="Int32" />
                        <asp:Parameter Name="AccName" Type="String" />
                        <asp:Parameter Name="dept_no" Type="String" />
                        <asp:Parameter Name="mon01" Type="Int32" />
                        <asp:Parameter Name="mon02" Type="Int32" />
                        <asp:Parameter Name="mon03" Type="Int32" />
                        <asp:Parameter Name="mon04" Type="Int32" />
                        <asp:Parameter Name="mon05" Type="Int32" />
                        <asp:Parameter Name="mon06" Type="Int32" />
                        <asp:Parameter Name="mon07" Type="Int32" />
                        <asp:Parameter Name="mon08" Type="Int32" />
                        <asp:Parameter Name="mon09" Type="Int32" />
                        <asp:Parameter Name="mon10" Type="Int32" />
                        <asp:Parameter Name="mon11" Type="Int32" />
                        <asp:Parameter Name="mon12" Type="Int32" />
                        <asp:Parameter Name="no" Type="Int32" />
                    </UpdateParameters>
                </asp:SqlDataSource>
            </div>
        </asp:Panel>
        <asp:Panel ID="Panel3" runat="server" ScrollBars="Horizontal" Visible="true">
            <div align="center">

                <asp:Label ID="Label8" runat="server" Font-Bold="True" Font-Size="Large" Text="跨部門預算表填寫"></asp:Label>

                <asp:DropDownList ID="DropDownList1" runat="server" AutoPostBack="True" DataSourceID="SqlDataSource4" DataTextField="depa_ne2" DataValueField="depa_no" Height="30px" Width="300px" AppendDataBoundItems="True">
                    <asp:ListItem Selected="True" Value="%%">全部門列表</asp:ListItem>
                </asp:DropDownList>
                <asp:Label ID="Label11" runat="server" Text="QQQ" Visible="False"></asp:Label>
                <asp:Label ID="Label12" runat="server" Text="QQQ" Visible="False"></asp:Label>
                <br />
                <br />
                <asp:Label ID="Label10" runat="server" Font-Bold="True" Font-Size="Large" Text="選擇其他跨部門的預算類別"></asp:Label>
                <asp:DropDownList ID="DropDownList5" runat="server" AppendDataBoundItems="True" AutoPostBack="True" DataSourceID="SqlDataSource8" DataTextField="TypeWrtCh" DataValueField="TypeWrt" OnSelectedIndexChanged="DropDownList5_SelectedIndexChanged" Width="200px">
                    <asp:ListItem>請選擇</asp:ListItem>
                </asp:DropDownList>
                <asp:SqlDataSource ID="SqlDataSource8" runat="server" ConnectionString="<%$ ConnectionStrings:MENU %>" SelectCommand="SELECT * FROM TB_BudgetLevel WHERE emp_dept='ALL' and emp_no=@emp_no">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="Label1" Name="emp_no" PropertyName="Text" />
                    </SelectParameters>
                </asp:SqlDataSource>
                <br />
                <asp:Label ID="Label9" runat="server" Font-Size="Larger" ForeColor="Red"></asp:Label>
                <asp:SqlDataSource ID="SqlDataSource4" runat="server" ConnectionString="<%$ ConnectionStrings:MENU %>" SelectCommand="SELECT *
  FROM [juic].[dbo].[chuck12deptlist]
where [depa_no] like @depa_no1 or  [depa_no] like @depa_no2">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="Label11" Name="depa_no1" PropertyName="Text" />
                        <asp:ControlParameter ControlID="Label12" Name="depa_no2" PropertyName="Text" />
                    </SelectParameters>
                </asp:SqlDataSource>
                <asp:GridView ID="GridView3" runat="server" AutoGenerateColumns="False" BackColor="White" BorderColor="#999999" BorderStyle="Solid" BorderWidth="1px" CellPadding="3" CssClass="auto-style2" DataKeyNames="no" DataSourceID="SqlDataSource3" ForeColor="Black" GridLines="Vertical" OnRowDataBound="GridView3_RowDataBound" AllowPaging="True" PageSize="30">
                    <AlternatingRowStyle BackColor="#CCCCCC" />
                    <Columns>
                        <asp:TemplateField HeaderText="修改" ItemStyle-HorizontalAlign="Center">
                            <HeaderTemplate>
                                <asp:CheckBox ID="cbSelecteds2" runat="server" AutoPostBack="true" OnCheckedChanged="cbSelecteds2_CheckedChanged" />
                            </HeaderTemplate>
                            <EditItemTemplate>
                                <asp:CheckBox ID="CheckBox1" runat="server" />
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:CheckBox ID="che" runat="server" />
                            </ItemTemplate>

                            <ItemStyle HorizontalAlign="Center" />
                        </asp:TemplateField>
                        <asp:BoundField DataField="no" HeaderText="no" InsertVisible="False" ReadOnly="True" SortExpression="no" Visible="False" />
                        <%--                    <asp:TemplateField HeaderText="員編" SortExpression="emp_no">
                        <EditItemTemplate>
                            <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("emp_no") %>'></asp:TextBox>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="emp_no" runat="server" Text='<%# Bind("emp_no") %>' Width="50px"></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="編輯者" SortExpression="emp_cne">
                        <EditItemTemplate>
                            <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("emp_cne") %>'></asp:TextBox>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="emp_cne" runat="server" Text='<%# Bind("emp_cne") %>' Width="70px"></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="修改日期" SortExpression="editdate">
                        <EditItemTemplate>
                            <asp:TextBox ID="TextBox3" runat="server" Text='<%# Bind("editdate") %>'></asp:TextBox>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="editdate" runat="server" Text='<%# Bind("editdate") %>'  Width="80px"></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>--%>
                        <asp:TemplateField HeaderText="年度" SortExpression="year">
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox4" runat="server" Text='<%# Bind("year") %>'></asp:TextBox>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="year" runat="server" Text='<%# Bind("year") %>' Width="50px"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="科目代碼" SortExpression="AccNO">
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox6" runat="server" Text='<%# Bind("AccNO") %>'></asp:TextBox>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="AccNO" runat="server" Text='<%# Bind("AccNO") %>' Width="70px"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="科目名稱" SortExpression="AccName">
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox7" runat="server" Text='<%# Bind("AccName") %>'></asp:TextBox>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="AccName" runat="server" Text='<%# Bind("AccName") %>' Width="150px"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="部門代號" SortExpression="dept_no">
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox8" runat="server" Text='<%# Bind("dept_no") %>'></asp:TextBox>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="dept_no" runat="server" Text='<%# Bind("dept_no") %>' Width="60px"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="1月支出預算" SortExpression="mon01">
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox9" runat="server" Text='<%# Bind("mon01") %>'></asp:TextBox>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:TextBox ID="mon01" runat="server" Text='<%# Bind("mon01") %>' Width="100px" Style="text-align: right"></asp:TextBox>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="2月支出預算" SortExpression="mon02">
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox10" runat="server" Text='<%# Bind("mon02") %>'></asp:TextBox>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:TextBox ID="mon02" runat="server" Text='<%# Bind("mon02") %>' Width="100px" Style="text-align: right"></asp:TextBox>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="3月支出預算" SortExpression="mon03">
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox11" runat="server" Text='<%# Bind("mon03") %>'></asp:TextBox>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:TextBox ID="mon03" runat="server" Text='<%# Bind("mon03") %>' Width="100px" Style="text-align: right"></asp:TextBox>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="4月支出預算" SortExpression="mon04">
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox12" runat="server" Text='<%# Bind("mon04") %>'></asp:TextBox>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:TextBox ID="mon04" runat="server" Text='<%# Bind("mon04") %>' Width="100px" Style="text-align: right"></asp:TextBox>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="5月支出預算" SortExpression="mon05">
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox13" runat="server" Text='<%# Bind("mon05") %>'></asp:TextBox>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:TextBox ID="mon05" runat="server" Text='<%# Bind("mon05") %>' Width="100px" Style="text-align: right"></asp:TextBox>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="6月支出預算" SortExpression="mon06">
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox14" runat="server" Text='<%# Bind("mon06") %>'></asp:TextBox>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:TextBox ID="mon06" runat="server" Text='<%# Bind("mon06") %>' Width="100px" Style="text-align: right"></asp:TextBox>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="7月支出預算" SortExpression="mon07">
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox15" runat="server" Text='<%# Bind("mon07") %>'></asp:TextBox>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:TextBox ID="mon07" runat="server" Text='<%# Bind("mon07") %>' Width="100px" Style="text-align: right"></asp:TextBox>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="8月支出預算" SortExpression="mon08">
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox16" runat="server" Text='<%# Bind("mon08") %>'></asp:TextBox>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:TextBox ID="mon08" runat="server" Text='<%# Bind("mon08") %>' Width="100px" Style="text-align: right"></asp:TextBox>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="9月支出預算" SortExpression="mon09">
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox17" runat="server" Text='<%# Bind("mon09") %>'></asp:TextBox>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:TextBox ID="mon09" runat="server" Text='<%# Bind("mon09") %>' Width="100px" Style="text-align: right"></asp:TextBox>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="10月支出預算" SortExpression="mon10">
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox18" runat="server" Text='<%# Bind("mon10") %>'></asp:TextBox>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:TextBox ID="mon10" runat="server" Text='<%# Bind("mon10") %>' Width="100px" Style="text-align: right"></asp:TextBox>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="11月支出預算" SortExpression="mon11">
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox19" runat="server" Text='<%# Bind("mon11") %>'></asp:TextBox>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:TextBox ID="mon11" runat="server" Text='<%# Bind("mon11") %>' Width="100px" Style="text-align: right"></asp:TextBox>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="12月支出預算" SortExpression="mon12">
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox20" runat="server" Text='<%# Bind("mon12") %>'></asp:TextBox>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:TextBox ID="mon12" runat="server" Text='<%# Bind("mon12") %>' Width="100px" Style="text-align: right"></asp:TextBox>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="備註" SortExpression="ps">
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox5" runat="server" Text='<%# Bind("ps") %>'></asp:TextBox>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:TextBox ID="ps" runat="server" Text='<%# Bind("ps") %>' Width="150px"></asp:TextBox>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                    <FooterStyle BackColor="#CCCCCC" />
                    <HeaderStyle BackColor="Black" Font-Bold="True" ForeColor="White" />
                    <PagerStyle BackColor="#999999" ForeColor="Black" HorizontalAlign="Center" />
                    <SelectedRowStyle BackColor="#000099" Font-Bold="True" ForeColor="White" />
                    <SortedAscendingCellStyle BackColor="#F1F1F1" />
                    <SortedAscendingHeaderStyle BackColor="#808080" />
                    <SortedDescendingCellStyle BackColor="#CAC9C9" />
                    <SortedDescendingHeaderStyle BackColor="#383838" />
                    <%--        <HeaderStyle CssClass="GridviewScrollHeader" />
        <RowStyle CssClass="GridviewScrollItem" />
        <PagerStyle CssClass="GridviewScrollPager" />--%>
                </asp:GridView>
                <asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:MENU %>" DeleteCommand="DELETE FROM [TB_BudgetTable] WHERE [no] = @no" InsertCommand="INSERT INTO [TB_BudgetTable] ([emp_no], [emp_cne], [editdate], [year], [ps], [AccNO], [AccName], [dept_no], [mon01], [mon02], [mon03], [mon04], [mon05], [mon06], [mon07], [mon08], [mon09], [mon10], [mon11], [mon12]) VALUES (@emp_no, @emp_cne, @editdate, @year, @ps, @AccNO, @AccName, @dept_no, @mon01, @mon02, @mon03, @mon04, @mon05, @mon06, @mon07, @mon08, @mon09, @mon10, @mon11, @mon12)" SelectCommand="SELECT * FROM [TB_BudgetTable] WHERE ([TypeWrt]=@TypeWrt) and ([dept_no] like '%'+@dept_no+'%')" UpdateCommand="UPDATE [TB_BudgetTable] SET [emp_no] = @emp_no, [emp_cne] = @emp_cne, [editdate] = @editdate, [year] = @year, [ps] = @ps, [AccNO] = @AccNO, [AccName] = @AccName, [dept_no] = @dept_no, [mon01] = @mon01, [mon02] = @mon02, [mon03] = @mon03, [mon04] = @mon04, [mon05] = @mon05, [mon06] = @mon06, [mon07] = @mon07, [mon08] = @mon08, [mon09] = @mon09, [mon10] = @mon10, [mon11] = @mon11, [mon12] = @mon12 WHERE [no] = @no">
                    <DeleteParameters>
                        <asp:Parameter Name="no" Type="Int32" />
                    </DeleteParameters>
                    <InsertParameters>
                        <asp:Parameter Name="emp_no" Type="String" />
                        <asp:Parameter Name="emp_cne" Type="String" />
                        <asp:Parameter Name="editdate" Type="DateTime" />
                        <asp:Parameter Name="year" Type="Int32" />
                        <asp:Parameter Name="ps" Type="String" />
                        <asp:Parameter Name="AccNO" Type="Int32" />
                        <asp:Parameter Name="AccName" Type="String" />
                        <asp:Parameter Name="dept_no" Type="String" />
                        <asp:Parameter Name="mon01" Type="Int32" />
                        <asp:Parameter Name="mon02" Type="Int32" />
                        <asp:Parameter Name="mon03" Type="Int32" />
                        <asp:Parameter Name="mon04" Type="Int32" />
                        <asp:Parameter Name="mon05" Type="Int32" />
                        <asp:Parameter Name="mon06" Type="Int32" />
                        <asp:Parameter Name="mon07" Type="Int32" />
                        <asp:Parameter Name="mon08" Type="Int32" />
                        <asp:Parameter Name="mon09" Type="Int32" />
                        <asp:Parameter Name="mon10" Type="Int32" />
                        <asp:Parameter Name="mon11" Type="Int32" />
                        <asp:Parameter Name="mon12" Type="Int32" />
                    </InsertParameters>
                    <SelectParameters>
                        <asp:ControlParameter ControlID="Label6" Name="TypeWrt" PropertyName="Text" />
                        <asp:ControlParameter ControlID="DropDownList1" Name="dept_no" PropertyName="SelectedValue" />
                    </SelectParameters>
                    <UpdateParameters>
                        <asp:Parameter Name="emp_no" Type="String" />
                        <asp:Parameter Name="emp_cne" Type="String" />
                        <asp:Parameter Name="editdate" Type="DateTime" />
                        <asp:Parameter Name="year" Type="Int32" />
                        <asp:Parameter Name="ps" Type="String" />
                        <asp:Parameter Name="AccNO" Type="Int32" />
                        <asp:Parameter Name="AccName" Type="String" />
                        <asp:Parameter Name="dept_no" Type="String" />
                        <asp:Parameter Name="mon01" Type="Int32" />
                        <asp:Parameter Name="mon02" Type="Int32" />
                        <asp:Parameter Name="mon03" Type="Int32" />
                        <asp:Parameter Name="mon04" Type="Int32" />
                        <asp:Parameter Name="mon05" Type="Int32" />
                        <asp:Parameter Name="mon06" Type="Int32" />
                        <asp:Parameter Name="mon07" Type="Int32" />
                        <asp:Parameter Name="mon08" Type="Int32" />
                        <asp:Parameter Name="mon09" Type="Int32" />
                        <asp:Parameter Name="mon10" Type="Int32" />
                        <asp:Parameter Name="mon11" Type="Int32" />
                        <asp:Parameter Name="mon12" Type="Int32" />
                        <asp:Parameter Name="no" Type="Int32" />
                    </UpdateParameters>
                </asp:SqlDataSource>
                <asp:Button ID="Button4" runat="server" Text="更新預算資料" OnClick="Button4_Click" CssClass="btn btn-success" />

                <br />


                <br />
            </div>
        </asp:Panel>

        <asp:Label ID="Label3" runat="server" Text="Label" Visible="false"></asp:Label>
        <asp:Label ID="Label1" runat="server" Text="Label" Visible="false"></asp:Label>
        <asp:Label ID="Label6" runat="server" Text="Label" Visible="false"></asp:Label>
        <asp:Label ID="Label5" runat="server" Text="Label" Visible="false"></asp:Label>
    </div>
</asp:Content>
