<%@ Page Title="" Language="C#" MasterPageFile="~/Master/JuicERP.Master" AutoEventWireup="true" CodeBehind="DeputyOrder.aspx.cs" Inherits="JuicERP.Pages.DeputyOrder" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <style type="text/css">
        input[type="radio"] {
            margin: 4px 4px 4px 4px;
        }

        .auto-style2 {
            width: 15%;
        }
    </style>

    <div style="padding-left:550px;width:100%">
        <h3>¾�ȥN�z�H�Ƨ�</h3>
    </div>
    <asp:Label ID="Label1" runat="server" Text="" Visible="false"></asp:Label>
    <div style="text-align: center;border:double">
        <table border="0" cellpadding="0" cellspacing="0" style="align-items: center; width: 1300px;">
            <tr>
                <td>
                </td>
                <td>
            </td>
            <td>
        <asp:Label runat="server">�������</asp:Label>

        <asp:DropDownList ID="DropDownList1" runat="server" AppendDataBoundItems="True" AutoPostBack="True" DataSourceID="SqlDataSource1" DataTextField="DEPA_NE1" DataValueField="rdata2" OnSelectedIndexChanged="DropDownList1_SelectedIndexChanged" Height="22px">
            <asp:ListItem Value="0" Selected="True">�п��</asp:ListItem>
        </asp:DropDownList>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:MENU %>" 
            SelectCommand="SELECT distinct(RIGHT(RTRIM(data2),4)) rdata2,
           coalesce((select DISTINCT DEPA_NE1 FROM JUIC.DBO.BAS30 WHERE DEPA_NO=DATA2),
           (select DISTINCT DEPA_NE1 FROM JUTW.DBO.BAS30 WHERE DEPA_NO=DATA2),'') DEPA_NE1 
            FROM TB_deputy  
            order by rdata2"></asp:SqlDataSource>
                    </td>
                </tr>
        </table>
    </div>
    <div style="text-align: center;">

        <table border="0" cellpadding="0" cellspacing="0" style="align-items: center; width: 1300px;">
            <tr>
                <td style="width: 20%"></td>
                <td style="text-align:center;border:thick"  >
                    <span>�D���</span>
                </td>
                <td style="width: 5%"></td>
                <td style="text-align:center" >
                    <span>�Ƨǰ�</span>
                </td>
                <td style="width: 5%"></td>
                <td style="width: 20%"></td>
            </tr>
            <tr>
                <td style="width: 30%"></td>

                <td style="width: 15%">
                    <asp:ListBox ID="LB_LIST1" runat="server" SelectionMode="Multiple"
                        Width="200px" Height="175px" DataSourceID="SqlDataSource2" DataTextField="data1" DataValueField="emp_no"></asp:ListBox>
                    <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:MENU %>"
                        SelectCommand="SELECT emp_no + '  ' + empname data1 ,emp_no
                                        FROM  TB_Deputyorder 
                                        WHERE right(rtrim(depa_no),4)=@data2
                                        order by sequence">
                        <SelectParameters>
                            <asp:ControlParameter ControlID="DropDownList1" Name="data2" PropertyName="SelectedValue" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                </td>
                <td style="width: 5%">
                    <asp:Button ID="BT_RightAll" runat="server" Text="��|" CommandName="RightAll"
                        OnCommand="ListBox_Change_Command" Width="30px" /><br />
                    <asp:Button ID="BT_Right" runat="server" Text="��" CommandName="Right"
                        OnCommand="ListBox_Change_Command" Width="30px" /><br />
                    <asp:Button ID="BT_Left" runat="server" Text="��" CommandName="Left"
                        OnCommand="ListBox_Change_Command" Width="30px" /><br />
                    <asp:Button ID="BT_LeftAll" runat="server" Text="|��" CommandName="LeftAll"
                        OnCommand="ListBox_Change_Command" Width="30px" />
                </td>
                <td style="width: 15%">
                    <asp:ListBox ID="LB_LIST2" runat="server" SelectionMode="Multiple"
                        Width="200px" Height="175px"></asp:ListBox>
                </td>
                <td style="width: 5%">
                    <asp:Button ID="LB_Up" runat="server" Text="��" CommandName="Up"
                        OnCommand="ListBox_Change_Command" Width="30px" /><br />
                    <asp:Button ID="LB_Down" runat="server" Text="��" CommandName="Down"
                        OnCommand="ListBox_Change_Command" Width="30px" />
                </td>
                <td style="width: 30%"></td>
            </tr>
            <tr>
                <td style="display:none">
                     <asp:ListBox ID="ListBox3" runat="server" SelectionMode="Multiple" 
                        Width="200px" Height="175px" DataSourceID="SqlDataSource2" DataTextField="data1" DataValueField="emp_no"></asp:ListBox>
                </td>
            </tr>
            <tr>
                <td></td>
                <td style="text-align:center;" colspan="3" >
                    <asp:Button ID="Button1" runat="server" Text="�s��" CssClass="btn btn-primary" Font-Names="�L�n������" OnClick="Button1_Click" />
                    <asp:Button ID="Button2" runat="server" Text="���]" CssClass="btn btn-warning" Font-Names="�L�n������" OnClick="Button2_Click" />
                    <asp:Button ID="Button3" runat="server" Text="����" CssClass="btn btn-danger"  Font-Names="�L�n������" OnClick="Button3_Click" />
                </td>
            </tr>
        </table>
    </div>

</asp:Content>
