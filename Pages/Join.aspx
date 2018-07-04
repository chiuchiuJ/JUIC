<%@ Page Title="" Language="C#" MasterPageFile="~/Master/JuicERP.Master" AutoEventWireup="true" CodeBehind="Join.aspx.cs" Inherits="JuicERP.Pages.Join" %>

<%@ Register Src="~/UserControls/Signup.ascx" TagPrefix="uc1" TagName="Signup" %>



<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="col-md-1">
    </div>
    <div class="col-md-10" style="font-family: 微軟正黑體">
        <asp:Panel ID="ModalPanel" runat="server" Visible="false">
            <uc1:Signup runat="server" ID="Signup" />
        </asp:Panel>

        <div class="panel panel-info">
            <div class="panel-heading" align="center" style="font-size: x-large; color: #000000; font-weight: bold; font-family: 微軟正黑體;">
                近期活動資訊
            </div>
            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:MENU %>" SelectCommand="SELECT * FROM [TB_SignupList] ORDER BY [Activedate] DESC"></asp:SqlDataSource>
            <asp:GridView ID="gvSIGNUP" runat="server" BorderStyle="None" CssClass="table table-hover table-striped" GridLines="Horizontal" AllowSorting="True" AutoGenerateColumns="False" AllowPaging="True" DataSourceID="SqlDataSource1" OnRowCommand="gvSIGNUP_RowCommand" OnRowDataBound="gvSIGNUP_RowDataBound">
                <PagerSettings Position="TopAndBottom" />
                <PagerStyle CssClass="pagination-ys" />
                <Columns>

                    <%--<asp:HyperLinkField DataTextField="title" Target="_parent" ItemStyle-Width="50%" HeaderText="公告事項" DataNavigateUrlFormatString="Announce.aspx?ID={0}" DataNavigateUrlFields="ID" />--%>
                    <%-- <asp:HyperLinkField DataNavigateUrlFields="pdfurl" Target="_blank" ItemStyle-Width="10%" Text="點我下載" HeaderText="PDF下載" DataTextFormatString="&lt;img src='../img/close.gif' style='cursor:hand' title='查看' onclick='ViewRecord({0})'&gt;" />--%>

                    <asp:BoundField DataField="Activedate" ItemStyle-Width="10%" HeaderText="活動日期" ItemStyle-ForeColor="Red" DataFormatString="{0:yyyy-MM-dd}" SortExpression="Activedate">

                        <ItemStyle ForeColor="Red" Width="10%" Font-Size="Small"/>
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
                            <asp:Button ID="Button3" runat="server" Text="報名GO" CommandName="post" CommandArgument='<%# Eval("Title")+",,"+Eval("Content")+",,"+Eval("Startdate")+",,"+Eval("Enddate")+",,"+Eval("Addons1")+",,"+Eval("Addons2")+",,"+User.Identity.Name.ToString()+",,"+Eval("ID")+",,"+Eval("Activedate")+",,"+Eval("Type")+",,"+Eval("FileURL") %>' CssClass="btn btn-success btn-xs" Font-Size="Small" />
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
    </div>
    <div class="col-md-1">
    </div>

</asp:Content>
