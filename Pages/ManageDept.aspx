<%@ Page Title="" Language="C#" MasterPageFile="~/Master/JuicERP.Master" AutoEventWireup="true" CodeBehind="ManageDept.aspx.cs" Inherits="JuicERP.Pages.ManageDept" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="col-md-2">
    </div>
    <div class="col-md-8">
        <div class="panel panel-info" style="font-family: 微軟正黑體; font-size: medium;">
            <div class="panel-heading" style="font-size: large; text-align: center;">員工個人資料變更申請</div>
            <div class="panel-body" style="text-align: center">
                <asp:Label ID="Label3" runat="server"></asp:Label>
                <asp:DropDownList ID="DropDownList1" runat="server" AppendDataBoundItems="True" AutoPostBack="True" DataSourceID="SqlDataSource2" DataTextField="emp_cne" DataValueField="emp_no" OnSelectedIndexChanged="DropDownList1_SelectedIndexChanged">
                    <asp:ListItem>請選澤</asp:ListItem>
                </asp:DropDownList>
                <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:MENU %>" SelectCommand="select b.emp_no,a.emp_cne
from pay11 a,TB_Userdata b
where b.hrcheck='N' and a.emp_no=b.emp_no"></asp:SqlDataSource>
                <div align="center">
                    <asp:DetailsView ID="DetailsView1" runat="server" Height="50px" Width="80%" AutoGenerateRows="False" DataSourceID="SqlDataSource1">
                        <Fields>
                            <asp:BoundField DataField="tel1" HeaderText="舊室內電話" SortExpression="tel1" />
                            <asp:BoundField DataField="tel11" HeaderText="新室內電話" SortExpression="tel11" />
                            <asp:BoundField DataField="mtel" HeaderText="舊個人手機" SortExpression="mtel" />
                            <asp:BoundField DataField="mtel1" HeaderText="新個人手機" SortExpression="mtel1" />
                            <asp:BoundField DataField="addr1" HeaderText="舊聯絡地址" SortExpression="addr1" />
                            <asp:BoundField DataField="addr11" HeaderText="新聯絡地址" SortExpression="addr11" />                          
                            <asp:BoundField DataField="attn" HeaderText="舊緊急聯絡人" SortExpression="attn" />
                            <asp:BoundField DataField="attn1" HeaderText="新緊急聯絡人" SortExpression="attn1" />
                            <asp:BoundField DataField="rela" HeaderText="舊聯絡人關係" SortExpression="rela" />
                            <asp:BoundField DataField="rela1" HeaderText="新聯絡人關係" SortExpression="rela1" />
                            <asp:BoundField DataField="rela_addr" HeaderText="舊聯絡人住址" SortExpression="rela_addr" />
                            <asp:BoundField DataField="rela_addr1" HeaderText="新聯絡人住址" SortExpression="rela_addr1" />
                            <asp:BoundField DataField="rela_tel" HeaderText="舊聯絡人電話" SortExpression="rela_tel" />
                            <asp:BoundField DataField="rela_tel1" HeaderText="新聯絡人電話" SortExpression="rela_tel1" />
                        </Fields>
                    </asp:DetailsView>
                    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:MENU %>" SelectCommand=" select a.[tel1],b.[tel1], a.[mtel],b.[mtel],a.[addr1] ,b.[addr1] ,a.[attn]  ,b.[attn]  ,a.[rela],b.[rela],a.[rela_addr]  ,b.[rela_addr]  ,a.[rela_tel],b.[rela_tel]
  from pay11 a,TB_Userdata b
  where a.emp_no=b.emp_no and a.emp_no=@emp_no and b.hrcheck='N' ">
                        <SelectParameters>
                            <asp:ControlParameter ControlID="DropDownList1" Name="emp_no" PropertyName="SelectedValue" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                    <hr />
                    <asp:Button ID="Button1" runat="server" CssClass="btn btn-success btn-sm" OnClick="Button1_Click" Text="核可此員工個人資料變更" Visible="False" />
                    <br />
                    <asp:Button ID="Button2" runat="server" CssClass="btn btn-danger btn-sm" OnClick="Button2_Click" Text="退件" Visible="False" />
                    <asp:Label ID="Label4" runat="server" Text="理由" Visible="False"></asp:Label>
                    <asp:TextBox ID="TextBox1" runat="server" Visible="False" Width="370px"></asp:TextBox>
                </div>

            </div>
        </div>
    </div>
</asp:Content>
