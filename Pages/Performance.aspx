<%@ Page Title="" Language="C#" MasterPageFile="~/Master/JuicERP.Master" AutoEventWireup="true" CodeBehind="Performance.aspx.cs" Inherits="JuicERP.Pages.Performance" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">
        .auto-style2 {
            width: 100%;
        }

        .auto-style3 {
            width: 180px;
            height: 40px;
            text-align: center;
        }

        .auto-style4 {
            width: 200px;
            height: 40px;
            text-align: center;
        }

        .auto-style5 {
            width: 280px;
            height: 40px;
            text-align: center;
        }

        .auto-style6 {
            width: 100px;
            height: 40px;
            text-align: center;
        }

        .auto-style7 {
            width: 59px;
            height: 40px;
            text-align: center;
        }

        .auto-style31 {
            width: 180px;
            height: 80px;
        }

        .auto-style41 {
            width: 200px;
            height: 80px;
        }

        .auto-style51 {
            width: 280px;
            height: 80px;
        }

        .auto-style61 {
            width: 100px;
            height: 80px;
        }

        .auto-style71 {
            width: 59px;
            height: 80px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="col-md-1">
    </div>
    <div class="col-md-10" style="font-family: 微軟正黑體">
        <asp:DropDownList ID="DropDownList1" runat="server" AutoPostBack="True" Font-Size="Large" Height="39px" Width="288px">
            <asp:ListItem Value="20181">2018年上半年個人工作目標設定</asp:ListItem>
            <asp:ListItem Value="20182">2018年下半年個人工作目標設定</asp:ListItem>
        </asp:DropDownList>
        <asp:Button ID="Button1" runat="server" CssClass="btn btn-success" OnClick="Button1_Click" Text="新增" />
        <asp:Button ID="Button2" runat="server" CssClass="btn btn-warning" Text="修改" />
        <br />
        <asp:Label ID="Label1" runat="server" Text="Label"></asp:Label>
        <asp:Panel ID="Panel1" runat="server" Visible="False">
            <table class="auto-style2">
                <tr>
                    <td class="auto-style3">工作目標項目</td>
                    <td class="auto-style4">應達成目標<br />
                        (定量應制定公式)</td>
                    <td class="auto-style5">展開說明</td>
                    <td class="auto-style6">預定完成時間</td>
                    <td class="auto-style7">配分</td>
                </tr>
                <tr>
                    <td class="auto-style31">
                        <asp:TextBox ID="TextBoxEX1" runat="server" Height="100%" TextMode="MultiLine" Width="100%" ReadOnly="True"></asp:TextBox>
                    </td>
                    <td class="auto-style41">
                        <asp:TextBox ID="TextBoxEX2" runat="server" Height="100%" TextMode="MultiLine" Width="100%" ReadOnly="True"></asp:TextBox>
                    </td>
                    <td class="auto-style51">
                        <asp:TextBox ID="TextBoxEX3" runat="server" Height="100%" TextMode="MultiLine" Width="100%" ReadOnly="True"></asp:TextBox>
                    </td>
                    <td class="auto-style61">
                        <asp:TextBox ID="TextBoxEX4" runat="server" Height="100%" TextMode="Date" Width="100%" ReadOnly="True"></asp:TextBox>
                    </td>
                    <td class="auto-style71">
                        <asp:TextBox ID="TextBoxEX5" runat="server" Height="100%" TextMode="Number" Width="100%" ReadOnly="True"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td class="auto-style31">
                        <asp:TextBox ID="TextBox1" runat="server" Height="100%" TextMode="MultiLine" Width="100%"></asp:TextBox>
                    </td>
                    <td class="auto-style41">
                        <asp:TextBox ID="TextBox2" runat="server" Height="100%" TextMode="MultiLine" Width="100%"></asp:TextBox>
                    </td>
                    <td class="auto-style51">
                        <asp:TextBox ID="TextBox3" runat="server" Height="100%" TextMode="MultiLine" Width="100%"></asp:TextBox>
                    </td>
                    <td class="auto-style61">
                        <asp:TextBox ID="TextBox4" runat="server" Height="100%" TextMode="Date" Width="100%"></asp:TextBox>
                    </td>
                    <td class="auto-style71">
                        <asp:TextBox ID="TextBox5" runat="server" Height="100%" TextMode="Number" Width="100%"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td class="auto-style31">
                        <asp:TextBox ID="TextBox6" runat="server" Height="100%" TextMode="MultiLine" Width="100%"></asp:TextBox>
                    </td>
                    <td class="auto-style41">
                        <asp:TextBox ID="TextBox7" runat="server" Height="100%" TextMode="MultiLine" Width="100%"></asp:TextBox>
                    </td>
                    <td class="auto-style51">
                        <asp:TextBox ID="TextBox8" runat="server" Height="100%" TextMode="MultiLine" Width="100%"></asp:TextBox>
                    </td>
                    <td class="auto-style61">
                        <asp:TextBox ID="TextBox9" runat="server" Height="100%" TextMode="Date" Width="100%"></asp:TextBox>
                    </td>
                    <td class="auto-style71">
                        <asp:TextBox ID="TextBox10" runat="server" Height="100%" TextMode="Number" Width="100%"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td class="auto-style31">
                        <asp:TextBox ID="TextBox11" runat="server" Height="100%" TextMode="MultiLine" Width="100%"></asp:TextBox>
                    </td>
                    <td class="auto-style41">
                        <asp:TextBox ID="TextBox12" runat="server" Height="100%" TextMode="MultiLine" Width="100%"></asp:TextBox>
                    </td>
                    <td class="auto-style51">
                        <asp:TextBox ID="TextBox13" runat="server" Height="100%" TextMode="MultiLine" Width="100%"></asp:TextBox>
                    </td>
                    <td class="auto-style61">
                        <asp:TextBox ID="TextBox14" runat="server" Height="100%" TextMode="Date" Width="100%"></asp:TextBox>
                    </td>
                    <td class="auto-style71">
                        <asp:TextBox ID="TextBox15" runat="server" Height="100%" TextMode="Number" Width="100%"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td class="auto-style31">
                        <asp:TextBox ID="TextBox16" runat="server" Height="100%" TextMode="MultiLine" Width="100%"></asp:TextBox>
                    </td>
                    <td class="auto-style41">
                        <asp:TextBox ID="TextBox17" runat="server" Height="100%" TextMode="MultiLine" Width="100%"></asp:TextBox>
                    </td>
                    <td class="auto-style51">
                        <asp:TextBox ID="TextBox18" runat="server" Height="100%" TextMode="MultiLine" Width="100%"></asp:TextBox>
                    </td>
                    <td class="auto-style61">
                        <asp:TextBox ID="TextBox19" runat="server" Height="100%" TextMode="Date" Width="100%"></asp:TextBox>
                    </td>
                    <td class="auto-style71">
                        <asp:TextBox ID="TextBox20" runat="server" Height="100%" TextMode="Number" Width="100%"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td class="auto-style31">
                        <asp:TextBox ID="TextBox21" runat="server" Height="100%" TextMode="MultiLine" Width="100%"></asp:TextBox>
                    </td>
                    <td class="auto-style41">
                        <asp:TextBox ID="TextBox22" runat="server" Height="100%" TextMode="MultiLine" Width="100%"></asp:TextBox>
                    </td>
                    <td class="auto-style51">
                        <asp:TextBox ID="TextBox23" runat="server" Height="100%" TextMode="MultiLine" Width="100%"></asp:TextBox>
                    </td>
                    <td class="auto-style61">
                        <asp:TextBox ID="TextBox24" runat="server" Height="100%" TextMode="Date" Width="100%"></asp:TextBox>
                    </td>
                    <td class="auto-style71">
                        <asp:TextBox ID="TextBox25" runat="server" Height="100%" TextMode="Number" Width="100%"></asp:TextBox>
                    </td>
                </tr>
            </table>
            <asp:Button ID="Button3" runat="server" Text="送出" CssClass="btn btn" />
        </asp:Panel>
    </div>
    <div class="col-md-1">
    </div>
</asp:Content>
