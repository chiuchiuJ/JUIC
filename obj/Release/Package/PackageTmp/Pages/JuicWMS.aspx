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
    <h3>�Y�ɮw�s�d��</h3>
    <div style="">
    </div>
    <div>
        <div style="float: left">
            ���q�O�G
        </div>
        <div style="float: left">
            <asp:RadioButtonList ID="rblCompany" runat="server" RepeatDirection="Horizontal">
                <asp:ListItem Selected="True" Value="JUIC">�[�°��</asp:ListItem>
                <asp:ListItem Value="JU">�[��</asp:ListItem>
            </asp:RadioButtonList>
        </div>
        <div style="clear: both"></div>
    </div>
    <div>
        <asp:Button ID="Button1" runat="server" CssClass="btn btn-primary" Text="�d��" OnClick="Button1_Click" />
        <asp:Button ID="txtExportExcel" runat="server" CssClass="btn btn-success" Text="�ץXExcel" OnClick="txtExportExcel_Click" />
    </div>
    <div>
        �d�߱���G
     
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
                        <asp:BoundField DataField="JClass" HeaderText="�ӫ~���O" HeaderStyle-Wrap="False" />
                        <asp:BoundField DataField="JProdID" HeaderText="�~��" SortExpression="JProdID" HeaderStyle-Wrap="False" />
                        <asp:BoundField DataField="JVProdID" HeaderText="�t�ӫ~��" SortExpression="JVProdID" HeaderStyle-Wrap="False" />
                        <asp:BoundField DataField="JSPEC" HeaderText="�~�W�W��" SortExpression="JSPEC" HeaderStyle-Wrap="False" />
                        <asp:BoundField DataField="JLastQuan" HeaderText="�w�s�ƶq" HeaderStyle-Wrap="False" />
                        <asp:BoundField DataField="JUnit" HeaderText="���" HeaderStyle-Wrap="False" />
                        <asp:BoundField DataField="JSCost" HeaderText="�{����" HeaderStyle-Wrap="False" />
                        <asp:BoundField DataField="JCost" HeaderText="�{�榨��" SortExpression="JCost" HeaderStyle-Wrap="False" />
                        <asp:BoundField DataField="JWareHouse" HeaderText="�ܮw�O" SortExpression="JWareHouse" HeaderStyle-Wrap="False" />
                        <asp:BoundField DataField="JVendor" HeaderText="�t�ӧO" SortExpression="JVendor" HeaderStyle-Wrap="False" />
                        <asp:BoundField DataField="JOutDate" HeaderText="�̪�P�f��" SortExpression="JOutDate" HeaderStyle-Wrap="False" />
                        <asp:BoundField DataField="JInDate" HeaderText="�̪�i�f/�J�w��" HeaderStyle-Wrap="False" />
                        <asp:BoundField DataField="JDelayDate" HeaderText="�b����" SortExpression="JDelayDate" HeaderStyle-Wrap="False" />
                        <asp:BoundField DataField="JYearMonth" HeaderText="�����~��" HeaderStyle-Wrap="False" />
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
