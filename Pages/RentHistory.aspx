<%@ Page Title="" Language="C#" MasterPageFile="~/Master/JuicERP.Master" AutoEventWireup="true" CodeBehind="RentHistory.aspx.cs" Inherits="JuicERP.Pages.RentHistory" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="../css/bootstrap-select.css" rel="stylesheet" />
    <link href="../css/bootstrap-select.min.css" rel="stylesheet" />
    <script src="../js/bootstrap-select.js" type="text/javascript"></script>
    <script src="//ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="row">
        <div class="col-md-2"></div>
        <div class="col-md-8" style="font-family: 微軟正黑體">
            <asp:Label ID="Label1" runat="server" Text="Label" Visible="False"></asp:Label>
            <div class="panel-group" id="accordion">
                <div class="panel panel-danger">
                    <div class="panel-heading" style="height: 50px">
                        <h4 class="panel-title" style="font-size: x-large" align="center">
                            <a data-toggle="collapse" data-parent="#accordion" href="#collapse1">您的會議室租借記錄</a>
                        </h4>
                    </div>
                    <div id="collapse1" class="panel-collapse collapse">
                        <div class="panel-body">
                                        <asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:MENU %>" SelectCommand="SELECT * FROM [TB_Conference] WHERE ([userid] = @userid) ORDER BY [rentdate], [starttime]">
                                <SelectParameters>
                                    <asp:ControlParameter ControlID="Label1" Name="userid" PropertyName="Text" Type="String" />
                                </SelectParameters>
                            </asp:SqlDataSource>
                            <asp:UpdatePanel ID="UpdatePanel3" runat="server">
                                <ContentTemplate>
                                    <asp:Label ID="Label2" runat="server" Text="" Font-Size="Larger" ForeColor="Red"></asp:Label>
                                    <asp:GridView ID="GridView3" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" DataSourceID="SqlDataSource3" CssClass="table table-hover table-striped" Font-Names="微軟正黑體" OnRowCommand="GridView3_RowCommand">
                                        <Columns>
                                            <asp:BoundField DataField="roomname" HeaderText="會議室名稱" />
                                            <asp:BoundField DataField="rentdate" HeaderText="租借日期" DataFormatString="{0:d}" />
                                            <asp:BoundField DataField="starttime" HeaderText="開始時間" DataFormatString="{0:HHmm}" />
                                            <asp:BoundField DataField="endtime" DataFormatString="{0:HHmm}" HeaderText="結束時間" />
                                            <asp:BoundField DataField="people" HeaderText="與會人數" />
                                            <asp:BoundField DataField="PS" HeaderText="備註" />
                                            <asp:TemplateField>
                                                <ItemTemplate>
                                                     <asp:Button ID="cancel" runat="server" Text="取消" CommandName="cancel" CommandArgument='<%# Eval("ID") +",,"+Eval("endtime")%>' CssClass="btn btn-danger btn-xs" />
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                        </Columns>
                                        <PagerSettings Position="TopAndBottom" />
                                        <PagerStyle CssClass="pagination-ys" />
                                    </asp:GridView>
                                </ContentTemplate>
                            </asp:UpdatePanel>
                        </div>
                    </div>
                </div>
            </div>

            <div class="panel-group" id="accordion">
                <div class="panel panel-warning">
                    <div class="panel-heading" style="height: 50px">
                        <h4 class="panel-title" style="font-size: x-large" align="center">
                            <a data-toggle="collapse" data-parent="#accordion" href="#collapse2">您的公務車租借記錄</a>
                        </h4>
                    </div>
                    <div id="collapse2" class="panel-collapse collapse">
                        <div class="panel-body">
                                    <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:MENU %>" SelectCommand="SELECT * FROM [TB_Carrentdata] WHERE ([emp_no] = @emp_no)">
                                <SelectParameters>
                                    <asp:ControlParameter ControlID="Label1" Name="emp_no" PropertyName="Text" Type="String" />
                                </SelectParameters>
                            </asp:SqlDataSource>
                            <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                                <ContentTemplate>
                                     <asp:Label ID="Label3" runat="server" Text="" Font-Size="Larger" ForeColor="Red"></asp:Label>
                                    <asp:GridView ID="GridView2" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" DataSourceID="SqlDataSource2" CssClass="table table-hover table-striped" Font-Names="微軟正黑體" OnRowCommand="GridView2_RowCommand">
                                        <Columns>
                                            <asp:BoundField DataField="car_name" HeaderText="車牌" SortExpression="car_name" />
                                            <asp:BoundField DataField="emp_cne" HeaderText="申請人" SortExpression="emp_cne" />
                                            <asp:BoundField DataField="username" HeaderText="使用人" SortExpression="username" />
                                            <asp:BoundField DataField="applydate" HeaderText="申請日期" DataFormatString="{0:yyyy/MM/dd}" SortExpression="applydate" />
                                            <asp:BoundField DataField="startrent" DataFormatString="{0:yyyy/MM/dd HH:mm}" HeaderText="預約時間" SortExpression="startrent" />
                                            <asp:BoundField DataField="endrent" DataFormatString="{0:yyyy/MM/dd HH:mm}" HeaderText="預約結束" SortExpression="endrent" />
                                            <asp:BoundField DataField="PS" HeaderText="備註" SortExpression="PS" />
                                            <asp:BoundField DataField="backYN" HeaderText="歸還" SortExpression="backYN" />
                                            <asp:TemplateField>
                                                   <ItemTemplate>
                                                     <asp:Button ID="cancel" runat="server" Text="取消" CommandName="cancel" CommandArgument='<%# Eval("id") +",,"+Eval("gotoYN")%>' CssClass="btn btn-danger btn-xs" />
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                        </Columns>
                                        <PagerSettings Position="TopAndBottom" />
                                        <PagerStyle CssClass="pagination-ys" />
                                    </asp:GridView>
                                </ContentTemplate>
                            </asp:UpdatePanel>
                        </div>
                    </div>
                </div>
            </div>
    
            <div class="col-md-2"></div>
        </div>
</asp:Content>
