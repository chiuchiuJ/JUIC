<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ListPicker.ascx.cs"
    Inherits="JuicERP.UserControls.ListPicker" %>
<asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional">
    <ContentTemplate>
        <table cellpadding="3" cellspacing="0">
            <tr>
                <td rowspan="4">
                    <div style="display: none">
                        <asp:ListBox ID="lbOrigin" runat="server" Visible="False"></asp:ListBox>
                    </div>
                    <div>
                        <asp:ListBox ID="lbSource" runat="server" Width="180px" Height="140px" SelectionMode="Multiple"></asp:ListBox>
                    </div>
                </td>
                <td>
                    <asp:ImageButton ID="ibtnAddAll" runat="server" ImageUrl="~/img/arrow_2.gif"
                        ToolTip="全部加入" OnClick="ibtnAddAll_Click" Height="30px" Width="30px" />
                </td>
                <td rowspan="4">
                    <asp:ListBox ID="lbDest" runat="server" Width="180px" Height="140px" SelectionMode="Multiple"></asp:ListBox>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:ImageButton ID="ibtnAddSelected" runat="server" ImageUrl="~/img/arrow.gif"
                        ToolTip="加入已選擇項目" OnClick="ibtnAddSelected_Click" Height="30px" Width="30px" />
                </td>
            </tr>
            <tr>
                <td>
                    <asp:ImageButton ID="ibtnRemoveSelected" runat="server" ImageUrl="~/img/back.gif"
                        ToolTip="移除已選擇項目" OnClick="ibtnRemoveSelected_Click" Height="30px" Width="30px" />
                </td>
            </tr>
            <tr>
                <td>
                    <asp:ImageButton ID="ibtnRemoveAll" runat="server" ImageUrl="~/img/back_2.gif"
                        ToolTip="全部移除" OnClick="ibtnRemoveAll_Click" Height="30px" Width="30px" />
                </td>
            </tr>
        </table>
        <div>
            <asp:Button ID="btnImportValues" runat="server" Text="匯入條件值" CssClass="btn btn-primary" OnClick="btnImportValues_Click" />
            <asp:Button ID="btnExit" runat="server" Text="離開" CssClass="btn btn-success" />
            <asp:HiddenField ID="hfPostBackTextBoxName" runat="server" />
        </div>
    </ContentTemplate>
    <Triggers>
        <asp:PostBackTrigger ControlID="btnExit" />
    </Triggers>
</asp:UpdatePanel>
