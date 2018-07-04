<%@ Page Title="" Language="C#" MasterPageFile="~/Master/JuicERP.Master" AutoEventWireup="true" CodeBehind="CarrentCheck.aspx.cs" Inherits="JuicERP.Pages.CarrentCheck" EnableEventValidation="false" %>

<%@ Register Src="~/UserControls/Cardetail.ascx" TagPrefix="uc1" TagName="Cardetail" %>




<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script>var imgDir = '<%=ResolveUrl("~/img") %>' + "/";	</script>
    <script src="<%=ResolveUrl("~/js/popcalendar.js") %>" charset="UTF-8"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="col-md-1">
    </div>
    <div class="col-md-10" style="font-family: 微軟正黑體">

        <asp:Panel ID="Panel1" runat="server">

            <div class="panel panel-primary">
                <div class="panel-heading">車輛租借逾時、延誤狀況一覽</div>
                <div class="panel-body">

                    s狀況說明：<br />
                    <asp:Label ID="Label4" runat="server" BackColor="Yellow" Text="提早/延誤30分以上出發"></asp:Label>
                    <br />
                    <asp:Label ID="Label3" runat="server" BackColor="Pink" Text="延誤60分鐘以上歸還"></asp:Label>
                    <br />
                    <asp:Label ID="Label10" runat="server" BackColor="Silver" Text="車輛檢查未完全"></asp:Label>
                    <br />
                    <asp:Label ID="Label11" runat="server" BackColor="Aquamarine" Text="租借超過3天(含例假日)"></asp:Label>
                    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:MENU %>" SelectCommand="SELECT * FROM [chuck07]"></asp:SqlDataSource>

                </div>
            </div>

        </asp:Panel>


        <asp:Panel ID="Panel2" runat="server" Visible="true">
            <div class="panel panel-info">
                <div class="panel-heading">EXCEL資料匯出</div>
                <div class="panel-body">
                </div>
                <asp:Button ID="btnexcel" runat="server" CssClass="btn btn-primary" OnClick="btnexcel_Click" Text="Excel下載" Visible="False" />
                <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl="~/files/公務車使用狀況(連結資料庫).xlsx" Target="_blank">excel資料下載</asp:HyperLink>
                <br />
                <asp:GridView ID="GridView2" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource2" OnRowDataBound="GridView2_RowDataBound" Visible="False">
                    <Columns>
                        <asp:BoundField DataField="car_name" HeaderText="車號" SortExpression="car_name" />
                        <asp:BoundField DataField="emp_no" HeaderText="員編" SortExpression="emp_no" />
                        <asp:BoundField DataField="emp_cne" HeaderText="租借人" SortExpression="emp_cne" />
                        <asp:BoundField DataField="username" HeaderText="使用人" SortExpression="username" />
                        <asp:BoundField DataField="godate" HeaderText="出發日" ReadOnly="True" SortExpression="godate" />
                        <asp:BoundField DataField="startrent" DataFormatString="{0:yyyy/MM/dd HH:mm}" HeaderText="預約出發" SortExpression="startrent" />
                        <asp:BoundField DataField="startrent2" DataFormatString="{0:yyyy/MM/dd HH:mm}" HeaderText="實際出發" SortExpression="startrent2" />
                        <asp:BoundField DataField="endrent" DataFormatString="{0:yyyy/MM/dd HH:mm}" HeaderText="預約歸還" SortExpression="endrent" />
                        <asp:BoundField DataField="endrent2" DataFormatString="{0:yyyy/MM/dd HH:mm}" HeaderText="實際歸還" SortExpression="endrent2" />
                        <asp:BoundField DataField="destination" HeaderText="目的地" SortExpression="destination" />
                        <asp:BoundField DataField="renttime" HeaderText="租借時數(小時)" ReadOnly="True" SortExpression="renttime" />
                        <asp:BoundField DataField="gotime" HeaderText="出發延誤(分)" ReadOnly="True" SortExpression="gotime" />
                        <asp:BoundField DataField="backtime" HeaderText="歸還延誤(分)" ReadOnly="True" SortExpression="backtime" />
                        <asp:BoundField DataField="PS" HeaderText="預約備註欄" SortExpression="PS" />
                        <asp:BoundField DataField="PS2" HeaderText="歸還備註欄" SortExpression="PS2" />
                        <asp:BoundField DataField="Check1" HeaderText="檢查1" SortExpression="Check1" />
                        <asp:BoundField DataField="Check2" HeaderText="檢查2" SortExpression="Check2" />
                        <asp:BoundField DataField="Check3" HeaderText="檢查3" SortExpression="Check3" />
                        <asp:BoundField DataField="Check4" HeaderText="檢查4" SortExpression="Check4" />
                        <asp:BoundField DataField="Check5" HeaderText="檢查5" SortExpression="Check5" />
                        <asp:BoundField DataField="Check6" HeaderText="檢查6" SortExpression="Check6" />
                    </Columns>
                </asp:GridView>
                <br />
                <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:MENU %>" SelectCommand="SELECT * FROM [chuck08]"></asp:SqlDataSource>
            </div>
        </asp:Panel>
        <asp:Panel ID="Panel3" runat="server" Visible="true">
            <div class="panel panel-warning ">
                <div class="panel-heading">歸還</div>
                <div class="panel-body">
                    <asp:GridView ID="GridView3" runat="server" AutoGenerateColumns="False" DataKeyNames="car_no" DataSourceID="SqlDataSource3" ShowFooter="True">
                        <Columns>
                            <asp:CommandField ShowDeleteButton="True" ShowEditButton="True" />
                            <asp:BoundField DataField="car_no" HeaderText="編號" ReadOnly="True" SortExpression="car_no" />
                            <asp:BoundField DataField="car_name" HeaderText="車牌號碼" SortExpression="car_name" />
                            <asp:BoundField DataField="useYN" HeaderText="是否租賃中(Y/N)" SortExpression="useYN" />
                            <asp:BoundField DataField="PS" HeaderText="備註" SortExpression="PS" />
                        </Columns>
                    </asp:GridView>
                    <asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:MENU %>" DeleteCommand="DELETE FROM [TB_Carlist] WHERE [car_no] = @car_no" InsertCommand="INSERT INTO [TB_Carlist] ([car_no], [car_name], [useYN], [PS]) VALUES (@car_no, @car_name, @useYN, @PS)" SelectCommand="SELECT [car_no], [car_name], [useYN], [PS] FROM [TB_Carlist]" UpdateCommand="UPDATE [TB_Carlist] SET [car_name] = @car_name, [useYN] = @useYN, [PS] = @PS WHERE [car_no] = @car_no">
                        <DeleteParameters>
                            <asp:Parameter Name="car_no" Type="Int32" />
                        </DeleteParameters>
                        <InsertParameters>
                            <asp:Parameter Name="car_no" Type="Int32" />
                            <asp:Parameter Name="car_name" Type="String" />
                            <asp:Parameter Name="useYN" Type="String" />
                            <asp:Parameter Name="PS" Type="String" />
                        </InsertParameters>
                        <UpdateParameters>
                            <asp:Parameter Name="car_name" Type="String" />
                            <asp:Parameter Name="useYN" Type="String" />
                            <asp:Parameter Name="PS" Type="String" />
                            <asp:Parameter Name="car_no" Type="Int32" />
                        </UpdateParameters>
                    </asp:SqlDataSource>
                </div>
            </div>
        </asp:Panel>
    </div>
    <div class="col-md-1">
    </div>
</asp:Content>
