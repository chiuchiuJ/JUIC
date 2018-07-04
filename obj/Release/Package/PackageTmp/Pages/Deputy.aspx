<%@ Page Title="" Language="C#" MasterPageFile="~/Master/JuicERP.Master" MaintainScrollPositionOnPostback="true" EnableEventValidation="false" AutoEventWireup="true" CodeBehind="Deputy.aspx.cs" Inherits="JuicERP.Pages.Deputy" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <%--<style type="text/css">
        .header { position:absolute; }
    </style>--%>
    <style type="text/css">
        <!--
        .DataGridFixedHeader {
            background-color: white;
            position: relative;
            top: expression(this.offsetParent.scrollTop);
        }
        -->
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="col-md-12" style="font-family: 微軟正黑體; margin 300px; top: 0px; left: 0px; width: 90%; text-align: center;">
        <h3 style="font-weight: normal; color: #000080;">職務代理人查詢</h3>
        <asp:Label ID="Label1" runat="server" Text="" Visible="false"></asp:Label>
        <asp:TextBox ID="TextBox1" runat="server"></asp:TextBox>
        <asp:Button ID="Button1" runat="server" Text="員工名稱查詢(空白為全部查詢)" OnClick="Button1_Click" />
        <div class="col-md-12" style="text-align: center;">
            <asp:Label ID="manage" runat="server" Text="true" Visible="false"></asp:Label>
            <asp:Button ID="Button2" runat="server" Text="新增資料" CssClass="btn btn-success" OnClick="Button2_Click" />
            <asp:Button ID="Button5" runat="server" Text="匯出資料" CssClass="btn btn-primary" OnClick="Button5_Click" />
        </div>
        <asp:FormView ID="fv_Insert2" runat="server" DataKeyNames="emp_no" DefaultMode="Insert" Visible="False" HorizontalAlign="Center" Width="443px">
            <InsertItemTemplate>
                <asp:Label ID="Label2" runat="server" Text="" ForeColor="Red"></asp:Label><br />
                員工姓名:
                        <asp:DropDownList ID="DropDownList7" runat="server" DataSource='<%# ddlbind()%>' DataValueField="emp_no" DataTextField="emp_cne" Width="60%" AppendDataBoundItems="True">
                            <asp:ListItem Value="" Text="請選擇"></asp:ListItem>
                        </asp:DropDownList>
                <br />
                第一代理人:
                        <asp:DropDownList ID="DropDownList8" runat="server" DataSource='<%# ddlbind()%>' DataValueField="emp_no" DataTextField="emp_cne" Width="60%" AppendDataBoundItems="True">
                            <asp:ListItem Value="" Text="請選擇"></asp:ListItem>
                        </asp:DropDownList>
                <br />
                第二代理人:
                        <asp:DropDownList ID="DropDownList9" runat="server" DataSource='<%# ddlbind()%>' DataValueField="emp_no" DataTextField="emp_cne" Width="60%" AppendDataBoundItems="True">
                            <asp:ListItem Value="" Text="請選擇"></asp:ListItem>
                        </asp:DropDownList>
                <br />
                備註:
                        <asp:TextBox ID="TextBox2" runat="server" Width="70%"></asp:TextBox>
                <br />
                <asp:Button ID="Button3" runat="server" Text="新增" CssClass="btn btn-success" OnClick="Button3_Click" />
                &nbsp;
                <asp:Button ID="Button4" runat="server" Text="取消" CssClass="btn btn-warning" OnClick="Button4_Click" />
                <br />
            </InsertItemTemplate>
        </asp:FormView>
        
            <asp:GridView ID="GridView1" HorizontalAlign="Center" runat="server" AllowSorting="True" AutoGenerateColumns="False" OnRowCreated="GridView1_RowCreated" 
                    OnRowDataBound="GridView1_RowDataBound" 
                    OnRowCancelingEdit="GridView1_RowCancelingEdit" 
                    OnRowDeleting="GridView1_RowDeleting" 
                    OnRowEditing="GridView1_RowEditing" 
                    OnRowUpdating="GridView1_RowUpdating" 
                    CellPadding="4" 
                    ForeColor="#333333" Width="80%" >
                <AlternatingRowStyle BackColor="White" />
                <Columns>
                    <%--欄位--%>
                    <asp:BoundField HeaderText="員工編號" DataField="emp_no" ReadOnly="true" SortExpression="emp_no" />
                    <asp:TemplateField HeaderText="部門單位" SortExpression="data2">
                        <ItemTemplate>
                            <asp:Label ID="lb_Depa" runat="server" Text='<%#Bind("DEPA_NE1") %>'></asp:Label>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:Label ID="lb_Depa" runat="server" Text='<%#Bind("DEPA_NE1") %>'></asp:Label>
                        </EditItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="員工姓名" SortExpression="empname">
                        <ItemTemplate>
                            <asp:Label ID="lb_Name" runat="server" Text='<%#Bind("empname") %>'></asp:Label>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:Label ID="lb_Name" runat="server" Text='<%#Bind("empname") %>'></asp:Label>
                        </EditItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="第一代理人員工編號">
                        <ItemTemplate>
                            <asp:Label ID="lb_emp_no1" runat="server" Text='<%#Bind("emp_no1") %>'>
                            </asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="第一代理人員工姓名">
                        <ItemTemplate>
                            <asp:Label ID="lb_empname1" runat="server" Text='<%#Bind("empname1") %>'></asp:Label>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:DropDownList ID="DropDownList1" runat="server" DataSource='<%# ddlbind()%>' DataValueField="emp_no" DataTextField="emp_cne" Width="80%">
                            </asp:DropDownList>
                            <%--<asp:TextBox ID="tbx_empname1" runat="server" Text='<%#Bind("empname1") %>'></asp:TextBox>--%>
                        </EditItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="第二代理人員工編號">
                        <ItemTemplate>
                            <asp:Label ID="lb_emp_no2" runat="server" Text='<%#Bind("emp_no2") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="第二代理人員工姓名">
                        <ItemTemplate>
                            <asp:Label ID="lb_empname2" runat="server" Text='<%#Bind("empname2") %>'></asp:Label>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:DropDownList ID="DropDownList2" runat="server" DataSource='<%# ddlbind()%>' DataValueField="emp_no" DataTextField="emp_cne" Width="80%">
                            </asp:DropDownList>
                        </EditItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="備註">
                        <ItemTemplate>
                            <asp:Label ID="lb_data1" runat="server" Text='<%#Bind("data1") %>'></asp:Label>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:TextBox ID="TextBox3" runat="server" Text='<%#Bind("data1") %>'></asp:TextBox>
                        </EditItemTemplate>
                    </asp:TemplateField>
                    <%--指令--%>
                    <asp:TemplateField HeaderText="管理">
                        <EditItemTemplate>
                            <asp:Button ID="update_btn" runat="server" CssClass="btn btn-primary btn-xs" Text="更新" CommandName="Update" />
                            <asp:Button ID="cancel_btn" runat="server" CssClass="btn btn-warning btn-xs" Text="取消" CommandName="Cancel" />
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Button ID="edit_btn" runat="server" CssClass="btn btn-warning btn-xs" Text="編輯" CommandName="Edit" Visible="false" />
                            <asp:Button ID="delete_btn" runat="server" CssClass="btn btn-danger btn-xs" Text="刪除" CommandName="Delete" Visible="false" OnClientClick="return confirm('確定要刪除此筆資料嗎?');" />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <%--<asp:TemplateField HeaderText="CGender">
                    <EditItemTemplate>
                        <asp:DropDownList ID="dll_MbGender" runat="server" SelectedValue='<%#Bind("CGender") %>'>
                            <asp:ListItem Value="False">Female</asp:ListItem>
                            <asp:ListItem Value="True">Male</asp:ListItem>
                        </asp:DropDownList>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:DropDownList ID="dll_MbGender" runat="server" Enabled="false" SelectedValue='<%#Bind("CGender") %>'>
                            <asp:ListItem Value="False">Female</asp:ListItem>
                            <asp:ListItem Value="True">Male</asp:ListItem>
                        </asp:DropDownList>
                    </ItemTemplate>
                </asp:TemplateField>--%>
                </Columns>
                <EditRowStyle BackColor="#7C6F57" />
                <FooterStyle BackColor="#1C5E55" Font-Bold="True" ForeColor="White" />
                <HeaderStyle CssClass="header" BackColor="#1C5E55" Font-Bold="True" ForeColor="White" />
                <PagerStyle BackColor="#666666" ForeColor="White" HorizontalAlign="Center" />
                <RowStyle BackColor="#E3EAEB" />
                <SelectedRowStyle BackColor="#C5BBAF" Font-Bold="True" ForeColor="#333333" />
                <SortedAscendingCellStyle BackColor="#F8FAFA" />
                <SortedAscendingHeaderStyle BackColor="#246B61" />
                <SortedDescendingCellStyle BackColor="#D4DFE1" />
                <SortedDescendingHeaderStyle BackColor="#15524A" />
            </asp:GridView>
        </div>
</asp:Content>
