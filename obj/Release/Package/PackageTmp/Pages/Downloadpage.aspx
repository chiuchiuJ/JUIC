<%@ Page Title="" Language="C#" MasterPageFile="~/Master/JuicERP.Master" AutoEventWireup="true" CodeBehind="Downloadpage.aspx.cs" Inherits="JuicERP.Pages.Downloadpage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">
        .fileUpload {
            position: relative;
            overflow: hidden;
            margin: 10px;
        }

            .fileUpload input.upload {
                position: absolute;
                top: 0;
                right: 0;
                margin: 0;
                padding: 0;
                font-size: 20px;
                cursor: pointer;
                opacity: 0;
                filter: alpha(opacity=0);
            }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="col-md-1">
    </div>
    <div class="col-md-10" style="font-size: large; font-family: 微軟正黑體;">
        <asp:Panel ID="Panel1" runat="server" Font-Names="微軟正黑體">
            <div class="fileUpload btn btn-warning">
                <span>選擇上傳檔案(上限10mb)</span>
                <asp:FileUpload ID="FileUpload1" runat="server" Font-Names="微軟正黑體" EnableTheming="True" CssClass="upload" onchange=" document.getElementById('div1').innerHTML ='從'+this.value+'上傳檔案'" />
            </div>
            <div id="div1" style="font-size: medium; color: #000080"></div>
            <asp:Label ID="Label1" runat="server" Text="自訂檔案名稱(可空白)"></asp:Label>
            <asp:TextBox ID="TextBox1" runat="server"></asp:TextBox>
            <asp:Label ID="Labelclass" runat="server" Text="檔案分類"></asp:Label>

            <asp:DropDownList ID="DropDownList1" runat="server">
                <asp:ListItem Value="file">檔案程式</asp:ListItem>
                <asp:ListItem Value="data">文件資料</asp:ListItem>
                <asp:ListItem Value="free">自由上傳/下載</asp:ListItem>


            </asp:DropDownList>

            <br />
            <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                <ContentTemplate>
                    <asp:CheckBox ID="CheckBox1" runat="server" Text="新增檔案說明" AutoPostBack="True" OnCheckedChanged="CheckBox1_CheckedChanged" />
                    <asp:TextBox ID="TextBox2" runat="server" TextMode="MultiLine" Width="100%" AutoPostBack="False" Height="100%" Rows="5" Font-Names="微軟正黑體" Visible="False"></asp:TextBox>
                </ContentTemplate>
            </asp:UpdatePanel>
            <asp:Button ID="Button3" runat="server" Text="上傳" OnClick="Button3_Click" CssClass="btn btn-success" Width="100%" />
            <hr />
        </asp:Panel>
                        <table border="1" style="table-layout:fixed; width:100%">
  </table>
        <table style="width: 100%;">
            <tr>
                <td width="35%" style=" width: 35%; vertical-align: top;">
                    <div style="overflow:scroll; width:350px;height:600px">
                    <asp:TreeView ID="TreeView2" runat="server" ImageSet="Arrows" OnSelectedNodeChanged="TreeView2_SelectedNodeChanged">
                        <HoverNodeStyle Font-Underline="True" ForeColor="#5555DD" />
                        <Nodes>
                            <asp:TreeNode Expanded="True" Text="個人常用項目" Value="%%">
                                <asp:TreeNode Text="dell-db管理" Value="manage"></asp:TreeNode>
                                <asp:TreeNode Text="檔案程式" Value="file"></asp:TreeNode>
                                <asp:TreeNode Text="文件資料" Value="data"></asp:TreeNode>
                                <asp:TreeNode Text="自由上傳/下載" Value="free"></asp:TreeNode>
                            </asp:TreeNode>
                        </Nodes>
                        <NodeStyle Font-Names="Tahoma" Font-Size="12pt" ForeColor="Black" HorizontalPadding="5px" NodeSpacing="0px" VerticalPadding="0px" />
                        <ParentNodeStyle Font-Bold="False" />
                        <SelectedNodeStyle Font-Underline="True" ForeColor="#5555DD" HorizontalPadding="0px" VerticalPadding="0px" />
                    </asp:TreeView>
                    <asp:TreeView ID="TreeView3" runat="server" ImageSet="Arrows" OnSelectedNodeChanged="TreeView3_SelectedNodeChanged">
                        <HoverNodeStyle Font-Underline="True" ForeColor="#5555DD" />
                        <Nodes>
                            <asp:TreeNode Text="檔案程式" Value="file"></asp:TreeNode>
                            <asp:TreeNode Text="文件資料" Value="data"></asp:TreeNode>
                            <asp:TreeNode Text="自由上傳/下載" Value="free"></asp:TreeNode>
                        </Nodes>
                        <NodeStyle Font-Names="Tahoma" Font-Size="12pt" ForeColor="Black" HorizontalPadding="5px" NodeSpacing="0px" VerticalPadding="0px" />
                        <ParentNodeStyle Font-Bold="False" />
                        <SelectedNodeStyle Font-Underline="True" ForeColor="#5555DD" HorizontalPadding="0px" VerticalPadding="0px" />
                    </asp:TreeView>
                    <asp:Button ID="Button4" runat="server" Text="刪除檔案" OnClick="Button4_Click" CssClass="btn btn-danger btn-sm" />
                    <br />
                    <asp:Button ID="Button1" runat="server" Text="dell-管理/全展開" OnClick="Button1_Click" CssClass="btn btn-success btn-sm" />
                    <%--     <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional">
                        <ContentTemplate>--%>
                    <asp:TreeView ID="TreeView1" runat="server" ExpandDepth="0" ImageSet="Simple" OnSelectedNodeChanged="TreeView1_SelectedNodeChanged" Width="100%">
                        <HoverNodeStyle Font-Underline="True" ForeColor="#5555DD" />
                        <NodeStyle Font-Names="Tahoma" Font-Size="12pt" ForeColor="Black" HorizontalPadding="0px" NodeSpacing="0px" VerticalPadding="0px" />
                        <ParentNodeStyle Font-Bold="False" />
                        <SelectedNodeStyle Font-Underline="True" HorizontalPadding="0px" VerticalPadding="0px" ForeColor="#5555DD" />
                    </asp:TreeView>
                        </div>
                </td>
                <td width="65%" valign="top">
       <%--             <asp:UpdatePanel ID="UpdatePanel2" runat="server" UpdateMode="Conditional">
                        <ContentTemplate>--%>
                            <asp:Panel ID="Panel2" runat="server">
                                <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" BackColor="White" BorderColor="#CCCCCC" BorderStyle="None" BorderWidth="1px" CellPadding="4" DataSourceID="SqlDataSource1" ForeColor="Black" GridLines="Horizontal" Width="100%" OnRowCommand="GridView1_RowCommand" AllowSorting="True">
                                    <Columns>
                                        <asp:BoundField DataField="filename" HeaderText="檔案名稱" SortExpression="filename" />
                                        <asp:TemplateField HeaderText="檔案下載" ItemStyle-Width="30%">
                                            <ItemTemplate>
                                                <%--              <div style="text-align:center">--%>
                                                <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl='<%# Eval("url")%>' Target="_blank">
                                                    <asp:Image ID="Image1" runat="server" ImageUrl="~/img/downloadimg.png" />
                                                </asp:HyperLink>
                                                <asp:Button ID="Button1" runat="server" Text="加入常用" CommandName="join" CommandArgument='<%# Eval("parenturl")+",,"+Eval("filename")+",,"+Eval("url") %>' CssClass="btn btn-warning btn-xs" />
                                                <%--                          <asp:Button ID="Button3" runat="server" Text="檔案說明" CommandName="post"  CommandArgument='<%# Eval("explanation") %>' CssClass="btn btn-warning btn-sm" />
                          <asp:Button ID="Button2" runat="server" Text="檔案刪除" CommandName="del"  CommandArgument='<%# Eval("url") %>' CssClass="btn btn-danger btn-sm" />        --%>
                                                <%--  </div>--%>
                                            </ItemTemplate>

                                        </asp:TemplateField>
                                    </Columns>
                                    <FooterStyle BackColor="#CCCC99" ForeColor="Black" />
                                    <HeaderStyle BackColor="#333333" Font-Bold="True" ForeColor="White" />
                                    <PagerStyle BackColor="White" ForeColor="Black" HorizontalAlign="Right" />
                                    <SelectedRowStyle BackColor="#CC3333" Font-Bold="True" ForeColor="White" />
                                    <SortedAscendingCellStyle BackColor="#F7F7F7" />
                                    <SortedAscendingHeaderStyle BackColor="#4B4B4B" />
                                    <SortedDescendingCellStyle BackColor="#E5E5E5" />
                                    <SortedDescendingHeaderStyle BackColor="#242121" />
                                </asp:GridView>
                                <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:MENU %>" SelectCommand="SELECT [parenturl], [filename], [url] FROM [TB_Downloadpage] WHERE ([parenturl] = @parenturl)">
                                    <SelectParameters>
                                        <asp:ControlParameter ControlID="TreeView1" Name="parenturl" PropertyName="SelectedValue" Type="String" />
                                    </SelectParameters>
                                </asp:SqlDataSource>
                            </asp:Panel>
                            <asp:Panel ID="Panel3" runat="server">
                                <asp:GridView ID="GridView2" runat="server" AutoGenerateColumns="False" BackColor="White" BorderColor="#CCCCCC" BorderStyle="None" BorderWidth="1px" CellPadding="4" DataSourceID="SqlDataSource2" ForeColor="Black" GridLines="Horizontal" Width="100%" OnRowCommand="GridView2_RowCommand" AllowSorting="True">
                                    <Columns>
                                        <asp:BoundField DataField="parenturl" HeaderText="母路徑" SortExpression="parenturl" />
                                        <%-- <asp:BoundField DataField="filename" HeaderText="檔案下載" SortExpression="filename" />--%>
                                        <asp:TemplateField HeaderText="檔案下載">
                                            <ItemTemplate>

                                                <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl='<%# Eval("url")%>' Target="_blank">
                             <%# Eval("filename")%>
                                                </asp:HyperLink>
                                            </ItemTemplate>

                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="設定" ItemStyle-Width="10%">
                                            <ItemTemplate>
                                                <asp:Button ID="Button1" runat="server" Text="移除常用" CommandName="remove" CommandArgument='<%# Eval("id") %>' CssClass="btn btn-warning btn-xs" />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                    </Columns>
                                    <FooterStyle BackColor="#CCCC99" ForeColor="Black" />
                                    <HeaderStyle BackColor="#333333" Font-Bold="True" ForeColor="White" />
                                    <PagerStyle BackColor="White" ForeColor="Black" HorizontalAlign="Right" />
                                    <SelectedRowStyle BackColor="#CC3333" Font-Bold="True" ForeColor="White" />
                                    <SortedAscendingCellStyle BackColor="#F7F7F7" />
                                    <SortedAscendingHeaderStyle BackColor="#4B4B4B" />
                                    <SortedDescendingCellStyle BackColor="#E5E5E5" />
                                    <SortedDescendingHeaderStyle BackColor="#242121" />
                                </asp:GridView>
                                <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:MENU %>" SelectCommand="SELECT [id],[userid],[parenturl], [filename], [url] FROM [TB_Downloaduser] WHERE ([class] like @class) and ([userid]=@userid)">
                                    <SelectParameters>
                                        <asp:ControlParameter ControlID="TreeView2" Name="class" PropertyName="SelectedValue" Type="String" />
                                        <asp:ControlParameter ControlID="Label4" Name="userid" PropertyName="Text" />
                                    </SelectParameters>
                                </asp:SqlDataSource>
                            </asp:Panel>
                            <asp:Panel ID="Panel4" runat="server">
                                <asp:GridView ID="GridView3" runat="server" AutoGenerateColumns="False" BackColor="White" BorderColor="#CCCCCC" BorderStyle="None" BorderWidth="1px" CellPadding="4" DataSourceID="SqlDataSource3" ForeColor="Black" GridLines="Horizontal" Width="100%" OnRowCommand="GridView3_RowCommand">
                                    <Columns>
                                        <%-- <asp:BoundField DataField="filename" HeaderText="檔案下載" SortExpression="filename" />--%>
                                        <asp:TemplateField HeaderText="檔案下載">
                                            <ItemTemplate>

                                                <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl='<%# Eval("url")%>' Target="_blank">
                             <%# Eval("filename")%>
                                                </asp:HyperLink>
                                            </ItemTemplate>

                                        </asp:TemplateField>
                                        <asp:BoundField DataField="explanation" HeaderText="說明" SortExpression="parenturl" />
                                        <asp:TemplateField HeaderText="設定" ItemStyle-Width="10%">
                                            <ItemTemplate>
                                                <asp:Button ID="Button1" runat="server" Text="加入常用" CommandName="join" CommandArgument='<%# Eval("filename")+",,"+Eval("url")+",,"+Eval("class") %>' CssClass="btn btn-warning btn-xs" />
                                            </ItemTemplate>

                                            <ItemStyle Width="10%"></ItemStyle>
                                        </asp:TemplateField>
                                    </Columns>
                                    <FooterStyle BackColor="#CCCC99" ForeColor="Black" />
                                    <HeaderStyle BackColor="#333333" Font-Bold="True" ForeColor="White" />
                                    <PagerStyle BackColor="White" ForeColor="Black" HorizontalAlign="Right" />
                                    <SelectedRowStyle BackColor="#CC3333" Font-Bold="True" ForeColor="White" />
                                    <SortedAscendingCellStyle BackColor="#F7F7F7" />
                                    <SortedAscendingHeaderStyle BackColor="#4B4B4B" />
                                    <SortedDescendingCellStyle BackColor="#E5E5E5" />
                                    <SortedDescendingHeaderStyle BackColor="#242121" />
                                </asp:GridView>
                                <asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:MENU %>" SelectCommand="SELECT * FROM [TB_Download] WHERE [class] = @class">
                                    <SelectParameters>
                                        <asp:ControlParameter ControlID="TreeView3" Name="class" PropertyName="SelectedValue" Type="String" />
                                    </SelectParameters>
                                </asp:SqlDataSource>
                            </asp:Panel>
                            <asp:Panel ID="Panel5" runat="server">
                                <asp:GridView ID="GridView4" runat="server" AutoGenerateColumns="False" BackColor="White" BorderColor="#CCCCCC" BorderStyle="None" BorderWidth="1px" CellPadding="4" DataSourceID="SqlDataSource4" ForeColor="Black" GridLines="Horizontal" Width="100%" OnRowCommand="GridView4_RowCommand">
                                    <Columns>
                                        <%-- <asp:BoundField DataField="filename" HeaderText="檔案下載" SortExpression="filename" />--%>
                                        <asp:TemplateField HeaderText="檔案下載">
                                            <ItemTemplate>

                                                <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl='<%# Eval("url")%>' Target="_blank">
                             <%# Eval("filename")%>
                                                </asp:HyperLink>
                                            </ItemTemplate>

                                        </asp:TemplateField>
                                        <asp:BoundField DataField="explanation" HeaderText="說明" SortExpression="parenturl" />
                                        <asp:TemplateField HeaderText="設定" ItemStyle-Width="10%">
                                            <ItemTemplate>
                                                <asp:Button ID="Button1" runat="server" Text="刪除" CommandName="remove" CommandArgument='<%# Eval("url") %>' CssClass="btn btn-warning btn-xs" />
                                            </ItemTemplate>

                                            <ItemStyle Width="10%"></ItemStyle>
                                        </asp:TemplateField>
                                    </Columns>
                                    <FooterStyle BackColor="#CCCC99" ForeColor="Black" />
                                    <HeaderStyle BackColor="#333333" Font-Bold="True" ForeColor="White" />
                                    <PagerStyle BackColor="White" ForeColor="Black" HorizontalAlign="Right" />
                                    <SelectedRowStyle BackColor="#CC3333" Font-Bold="True" ForeColor="White" />
                                    <SortedAscendingCellStyle BackColor="#F7F7F7" />
                                    <SortedAscendingHeaderStyle BackColor="#4B4B4B" />
                                    <SortedDescendingCellStyle BackColor="#E5E5E5" />
                                    <SortedDescendingHeaderStyle BackColor="#242121" />
                                </asp:GridView>
                                <asp:SqlDataSource ID="SqlDataSource4" runat="server" ConnectionString="<%$ ConnectionStrings:MENU %>" SelectCommand="SELECT * FROM [TB_Download] WHERE ([emp_no] = @emp_no)">
                                    <SelectParameters>
                                        <asp:ControlParameter ControlID="Label4" Name="emp_no" PropertyName="Text" Type="String" />
                                    </SelectParameters>
                                </asp:SqlDataSource>
                                <asp:SqlDataSource ID="SqlDataSource5" runat="server" ConnectionString="<%$ ConnectionStrings:MENU %>" SelectCommand="SELECT * FROM [TB_Download]"></asp:SqlDataSource>
                                <br />
                                <asp:Label ID="Label5" runat="server" Text="Label"></asp:Label>
                            </asp:Panel>
<%--                        </ContentTemplate>
                        <Triggers>
                            <asp:AsyncPostBackTrigger ControlID="GridView1" EventName="RowCommand" />
                            <asp:AsyncPostBackTrigger ControlID="GridView2" EventName="RowCommand" />
                            <asp:AsyncPostBackTrigger ControlID="GridView3" EventName="RowCommand" />
                            <asp:AsyncPostBackTrigger ControlID="GridView4" EventName="RowCommand" />
                        </Triggers>
                    </asp:UpdatePanel>--%>

                </td>
            </tr>
            <tr>
                <td colspan="2" width="100%">&nbsp;</td>
            </tr>
        </table>
        <asp:Button ID="Button2" runat="server" Text="dell-db路徑匯入資料庫" OnClick="Button2_Click" />
        <br />
        <asp:Label ID="Label3" runat="server" Text="Label"></asp:Label>
        <br />
        <asp:Label ID="Label4" runat="server" Text="Label" Visible="False"></asp:Label>
    </div>
    <div class="col-md-1">
    </div>
</asp:Content>
