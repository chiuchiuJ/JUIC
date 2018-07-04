<%@ Page Title="" Language="C#" MasterPageFile="~/Master/JuicERP.Master" AutoEventWireup="true" CodeBehind="JuicWMS.aspx.cs" Inherits="JuicERP.Pages.JuicWMS" %>

<%@ Register Src="~/UserControls/QueryWindow.ascx" TagPrefix="uc1" TagName="QueryWindow" %>
<%@ Register Src="~/UserControls/ListPicker.ascx" TagPrefix="uc1" TagName="ListPicker" %>
<%@ Register Src="~/UserControls/MessageBox.ascx" TagPrefix="uc1" TagName="MessageBox" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <style type="text/css">
        input[type="radio"] {
            margin: 4px 4px 4px 4px;
        }
    </style>
    <h3>即時庫存查詢</h3>
    <div style="">
    </div>
    <div>
        <div style="float: left">
            公司別：
        </div>
        <div style="float: left">
            <asp:RadioButtonList ID="rblCompany" runat="server" RepeatDirection="Horizontal">
                <asp:ListItem Selected="True" Value="JUIC">久威國際</asp:ListItem>
                <asp:ListItem Value="JU">久威</asp:ListItem>
            </asp:RadioButtonList>
        </div>
        <div style="clear: both"></div>
    </div>
    <div>
        <asp:Button ID="Button1" runat="server" CssClass="btn btn-primary" Text="查詢" OnClick="Button1_Click" />
        <asp:Button ID="txtExportExcel" runat="server" CssClass="btn btn-success" Text="匯出Excel" OnClick="txtExportExcel_Click" />
    </div>
    <div>
        查詢條件：
     
        <asp:Label ID="lblQueryCond" runat="server"></asp:Label>
    </div>
    <div>
        <uc1:MessageBox runat="server" ID="MessageBox1" />
    </div>
    <div>
        <asp:UpdatePanel runat="server" ID="UpdatePanel2">
            <ContentTemplate>
                <asp:GridView ID="gvWHQ" runat="server" AllowPaging="True" AllowSorting="True" CssClass="table table-hover table-striped" AutoGenerateColumns="False" PageSize="15" OnPageIndexChanging="gvWHQ_PageIndexChanging" OnSorting="gvWHQ_Sorting">
                    <PagerSettings Position="TopAndBottom" />
                    <PagerStyle CssClass="pagination-ys" />
                    <Columns>
                        <asp:BoundField DataField="JClass" HeaderText="商品類別" HeaderStyle-Wrap="False" />
                        <asp:BoundField DataField="JProdID" HeaderText="品號" SortExpression="JProdID" HeaderStyle-Wrap="False" />
                        <asp:BoundField DataField="JVProdID" HeaderText="廠商品號" SortExpression="JVProdID" HeaderStyle-Wrap="False" />
                        <asp:BoundField DataField="JSPEC" HeaderText="品名規格" SortExpression="JSPEC" HeaderStyle-Wrap="False" />
                        <asp:BoundField DataField="JLastQuan" HeaderText="庫存數量" HeaderStyle-Wrap="False" />
                        <asp:BoundField DataField="JUnit" HeaderText="單位" HeaderStyle-Wrap="False" />
                        <asp:BoundField DataField="JSCost" HeaderText="現行單價" HeaderStyle-Wrap="False" />
                        <asp:BoundField DataField="JCost" HeaderText="現行成本" SortExpression="JCost" HeaderStyle-Wrap="False" />
                        <asp:BoundField DataField="JWareHouse" HeaderText="倉庫別" SortExpression="JWareHouse" HeaderStyle-Wrap="False" />
                        <asp:BoundField DataField="JVendor" HeaderText="廠商別" SortExpression="JVendor" HeaderStyle-Wrap="False" />
                        <asp:BoundField DataField="JOutDate" HeaderText="最近銷貨日" SortExpression="JOutDate" HeaderStyle-Wrap="False" />
                        <asp:BoundField DataField="JInDate" HeaderText="最近進貨/入庫日" HeaderStyle-Wrap="False" />
                        <asp:BoundField DataField="JDelayDate" HeaderText="呆滯日" SortExpression="JDelayDate" HeaderStyle-Wrap="False" />
                        <asp:BoundField DataField="JYearMonth" HeaderText="成本年月" HeaderStyle-Wrap="False" />
                    </Columns>
                </asp:GridView>
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>

    <asp:Panel ID="ModalPanel" runat="server" CssClass="hide">
        <uc1:QueryWindow runat="server" ID="QueryWindow" />
    </asp:Panel>
    <asp:Panel ID="ModalPanelChild" runat="server" CssClass="hide">
        <uc1:ListPicker runat="server" ID="ListPicker" />
    </asp:Panel>
</asp:Content>
