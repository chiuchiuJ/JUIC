<%@ Page Language="C#" MasterPageFile="~/Master/JuicERP.Master" AutoEventWireup="true" CodeBehind="EMPWCRegulations.aspx.cs" Inherits="JuicERP.Pages.EMPWCRegulations" %>

<%@ Register Src="~/UserControls/Signup.ascx" TagPrefix="uc1" TagName="Signup" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <script>var imgDir = '<%=ResolveUrl("~/img") %>' + "/";	</script>
    <script src="<%=ResolveUrl("~/js/popcalendar.js") %>" charset="UTF-8"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="col-md-10">

        <%--<div class="col-md-10" style="font-family: 微軟正黑體">
        <%--<h2>職工福利委員會福利管理辦法</h2>
        <br />
    </div>--%>
        <div class="panel panel-danger" style="font-family: 微軟正黑體;">
            <div class="panel-heading" align="center" style="font-size: large; color: #000000; font-weight: bold; font-family: 微軟正黑體;">
                個人福利內容一覽
            </div>
            <div>
                <asp:Label ID="manage" runat="server" Text="true" Visible="false"></asp:Label>
                <asp:Button ID="Button4" runat="server" Text="新增個人福利內容" CssClass="btn btn-default btn-block" Font-Names="微軟正黑體" Visible="false" OnClick="Button4_Click" />
                <asp:Panel ID="Panel1" runat="server" Visible="false">
                    新增個人福利內容：<br />
                    日　　期：<asp:TextBox ID="TextBox1" runat="server" TextMode="Date"></asp:TextBox>
                    <br />
                    主　　旨：<asp:TextBox ID="TextBox2" runat="server"></asp:TextBox>
                    <br />
                    內　　容：<asp:TextBox ID="TextBox3" runat="server" Width="50%" Height="80px" TextMode="MultiLine"></asp:TextBox>
                    <br />
                    部門單位：<asp:TextBox ID="TextBox4" runat="server"></asp:TextBox>
                    <br />
                    作　　者：<asp:TextBox ID="TextBox5" runat="server"></asp:TextBox>
                    <br />
                    <asp:Button ID="Button2" runat="server" Text="取消" CssClass="btn btn-warning" OnClick="Button2_Click" />
                    <asp:Button ID="Button3" runat="server" Text="送出" CssClass="btn btn-success" OnClick="Button3_Click" />
                </asp:Panel>
            </div>

            <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False"
                AllowPaging="True" AllowSorting="True" BackColor="White" BorderColor="White"
                BorderStyle="Ridge" BorderWidth="2px" CellPadding="3" CellSpacing="1"
                GridLines="Both" Width="100%"
                OnRowDataBound="GridView1_RowDataBound"
                OnRowCancelingEdit="GridView1_RowCancelingEdit"
                OnRowDeleting="GridView1_RowDeleting"
                OnRowEditing="GridView1_RowEditing"
                OnRowUpdating="GridView1_RowUpdating">
                <Columns>
                    <asp:BoundField DataField="ID" HeaderText="ID" ReadOnly="True" SortExpression="ID" ShowHeader="true" Visible="false" />
                    <asp:TemplateField HeaderText="發布日期">
                        <ItemTemplate>
                            <asp:Label ID="lb_id" runat="server" Text='<%#Bind("ID") %>' Visible="false"></asp:Label>
                            <asp:Label ID="lb_postdate" runat="server" Text='<%#Bind("postdate","{0:yyyy-MM-dd}") %>' HtmlEncode="False"></asp:Label>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:Label ID="lb_id" runat="server" Text='<%#Bind("ID") %>' Visible="false"></asp:Label>
                            <asp:TextBox ID="txt_postdate" TextMode="Date" runat="server" Text='<%#Bind("postdate","{0:yyyy-MM-dd}") %>'></asp:TextBox>
                        </EditItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="主旨" SortExpression="title">
                        <ItemTemplate>
                            <asp:Label ID="lb_title" runat="server" Text='<%#Bind("title") %>'></asp:Label>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:TextBox ID="txt_title" runat="server" Text='<%#Bind("title") %>'></asp:TextBox>
                        </EditItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="內容" SortExpression="content">
                        <ItemTemplate>
                            <asp:Label ID="lb_content" runat="server" Text='<%# Eval("content").ToString().Replace("\r\n", "<br/>") %>'></asp:Label>

                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:TextBox ID="txt_content" runat="server" Text='<%#Bind("content") %>' Height="200px" Width="200px" TextMode="MultiLine"></asp:TextBox>
                        </EditItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="部門單位" SortExpression="dept">
                        <ItemTemplate>
                            <asp:Label ID="lb_dept" runat="server" Text='<%#Bind("dept") %>'></asp:Label>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:TextBox ID="txt_dept" runat="server" Text='<%#Bind("dept") %>'></asp:TextBox>
                        </EditItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="作者" SortExpression="author">
                        <ItemTemplate>
                            <asp:Label ID="lb_author" runat="server" Text='<%#Bind("author") %>'></asp:Label>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:TextBox ID="txt_author" runat="server" Text='<%#Bind("author") %>'></asp:TextBox>
                        </EditItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField ItemStyle-Width="25%" HeaderText="">
                        <EditItemTemplate>
                            <asp:Button ID="update_btn" runat="server" CssClass="btn btn-primary btn-xs" Text="更新" CommandName="Update" />
                            <asp:Button ID="cancel_btn" runat="server" CssClass="btn btn-warning btn-xs" Text="取消" CommandName="Cancel" />
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Button ID="edit_btn" runat="server" CssClass="btn btn-warning btn-xs" Text="編輯" CommandName="Edit" Visible="false" />
                            <asp:Button ID="delete_btn" runat="server" CssClass="btn btn-danger btn-xs" Text="刪除" CommandName="Delete" Visible="false" OnClientClick="return confirm('確定要刪除此筆資料嗎?');" />
                        </ItemTemplate>

                        <ItemStyle Width="10%"></ItemStyle>
                    </asp:TemplateField>
                </Columns>
                <FooterStyle BackColor="#C6C3C6" ForeColor="Black" />
                <HeaderStyle BackColor="#4A3C8C" Font-Bold="True" ForeColor="#E7E7FF" />
                <PagerStyle BackColor="#C6C3C6" ForeColor="Black" HorizontalAlign="Right" />
                <RowStyle BackColor="#DEDFDE" ForeColor="Black" />
                <SelectedRowStyle BackColor="#9471DE" Font-Bold="True" ForeColor="White" />
                <SortedAscendingCellStyle BackColor="#F1F1F1" />
                <SortedAscendingHeaderStyle BackColor="#594B9C" />
                <SortedDescendingCellStyle BackColor="#CAC9C9" />
                <SortedDescendingHeaderStyle BackColor="#33276A" />
            </asp:GridView>
        </div>
    </div>
    <div class="col-md-2">
        <asp:Button ID="Button1" OnClick="Button1_Click" CssClass="btn btn-default btn-block" Font-Names="微軟正黑體" runat="server" Text="辦法簡章" />
    </div>
    <div class="col-md-10" style="font-family: 微軟正黑體">
        <asp:Panel ID="ModalPanel" runat="server" Visible="false">
            <uc1:Signup runat="server" ID="Signup" />
        </asp:Panel>
        <div class="panel-heading" align="center" style="font-size: x-large; color: #000000; font-weight: bold; font-family: 微軟正黑體;">
            近期活動資訊
        </div>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:MENU %>" SelectCommand="SELECT * FROM [TB_SignupList] ORDER BY [Activedate] DESC"></asp:SqlDataSource>
        <asp:GridView ID="gvSIGNUP" runat="server" BorderStyle="None" CssClass="table table-hover table-striped" GridLines="Horizontal" AllowSorting="True" AutoGenerateColumns="False" AllowPaging="True" DataSourceID="SqlDataSource1" OnRowCommand="gvSIGNUP_RowCommand" OnRowDataBound="gvSIGNUP_RowDataBound">
            <PagerSettings Position="TopAndBottom" />
            <PagerStyle CssClass="pagination-ys" />
            <Columns>
                <asp:BoundField DataField="Activedate" ItemStyle-Width="10%" HeaderText="活動日期" ItemStyle-ForeColor="Red" DataFormatString="{0:yyyy-MM-dd}" SortExpression="Activedate">
                    <ItemStyle ForeColor="Red" Width="10%" Font-Size="Small" />
                </asp:BoundField>
                <asp:BoundField DataField="emp_cne" HeaderText="創建者">
                    <ItemStyle Width="10%" />
                </asp:BoundField>
                <asp:BoundField DataField="Title" HeaderText="活動主題">
                    <ItemStyle ForeColor="Blue" Width="35%" />
                </asp:BoundField>
                <asp:BoundField DataField="Startdate" HeaderText="報名開始日" HeaderStyle-Wrap="False" ItemStyle-Width="10%" DataFormatString='{0:yyyy-MM-dd}'>
                    <HeaderStyle Wrap="False"></HeaderStyle>
                    <ItemStyle Width="10%" Font-Size="Small"></ItemStyle>
                </asp:BoundField>
                <asp:BoundField DataField="Enddate" HeaderText="報名截止日" HeaderStyle-Wrap="False" ItemStyle-Width="10%" DataFormatString='{0:yyyy-MM-dd}'>
                    <HeaderStyle Wrap="False"></HeaderStyle>
                    <ItemStyle Width="10%" Font-Size="Small"></ItemStyle>
                </asp:BoundField>
                <asp:TemplateField ItemStyle-Width="25%" HeaderText="詳細資訊">
                    <ItemTemplate>
                        <asp:Button ID="Button" runat="server" Text="報名GO" CommandName="post" CommandArgument='<%# Eval("Title")+",,"+Eval("Content")+",,"+Eval("Startdate")+",,"+Eval("Enddate")+",,"+Eval("Addons1")+",,"+Eval("Addons2")+",,"+User.Identity.Name.ToString()+",,"+Eval("ID")+",,"+Eval("Activedate")+",,"+Eval("Type")+",,"+Eval("FileURL") %>' CssClass="btn btn-success btn-xs" Font-Size="Small" />
                        <asp:Button ID="excel" runat="server" Text="EXCEL下載" CommandName="excel" CssClass="btn btn-primary btn-xs" Font-Size="Small" Visible="False" />
                        <asp:Button ID="edit2" runat="server" Text="編輯" CommandName="edit2" CommandArgument='<%# Eval("Title")+",,"+Eval("Content")+",,"+Eval("Startdate")+",,"+Eval("Enddate")+",,"+Eval("Addons1")+",,"+Eval("Addons2")+",,"+User.Identity.Name.ToString()+",,"+Eval("ID")+",,"+Eval("Activedate")+",,"+Eval("Type")+",,"+Eval("FileURL") %>' CssClass="btn btn-warning btn-xs" Font-Size="Small" Visible="False" Enabled="False" />
                        <asp:Button ID="remove" runat="server" Text="刪除" CommandName="remove" CommandArgument='<%# Eval("ID") %>' CssClass="btn btn-danger btn-xs" Font-Size="Small" Visible="False" />
                    </ItemTemplate>
                    <ItemStyle Width="25%"></ItemStyle>
                </asp:TemplateField>
            </Columns>
            <RowStyle BackColor="#F7F7DE" Font-Size="Medium" VerticalAlign="Bottom" />
            <HeaderStyle BackColor="#6B696B" Font-Bold="True" ForeColor="White" Font-Size="Medium" />
        </asp:GridView>
        <asp:Label ID="Label1" runat="server" Text="Label" Visible="False"></asp:Label>
    </div>

    <%--<a href="/files/empwc/TE-0010-02.pdf">xxx.pdf</a>--%>
    <%--<iframe runat ="server" src="getPdf.aspx" width="800px" height="600px" ></iframe>--%>
</asp:Content>
