<%@ Page Title="" Language="C#" MasterPageFile="~/Master/JuicERP.Master" AutoEventWireup="true" CodeBehind="PaySearch.aspx.cs" Inherits="JuicERP.Pages.PaySearch" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
        <div class="col-md-1">
    </div>
    <div class="col-md-10" style="font-family: 微軟正黑體">
        <h2>請款記錄查詢</h2>
        <br />
        申請員工(空白可查全部)：<asp:TextBox ID="TextBox3" runat="server" ReadOnly="True"></asp:TextBox>
        <asp:Label ID="Label22" runat="server" Text="%%" Visible="False"></asp:Label>
                ｜日期區間：<asp:TextBox ID="TextBox1" runat="server" TextMode="Date"></asp:TextBox>
        到<asp:TextBox ID="TextBox2" runat="server" TextMode="Date"></asp:TextBox>
        <br />
        核決狀況： 
        <asp:CheckBoxList ID="CheckBoxList1" runat="server" RepeatDirection="Horizontal" Visible="False">
            <asp:ListItem Selected="True" Value="N">未核決</asp:ListItem>
            <asp:ListItem Selected="True" Value="Y">已核決</asp:ListItem>
            <asp:ListItem Value="G">作廢</asp:ListItem>
        </asp:CheckBoxList>
        <asp:Label ID="Label16" runat="server" Text="N" Visible="False"></asp:Label>
        <asp:Label ID="Label17" runat="server" Text="Y" Visible="False"></asp:Label>
        <asp:Label ID="Label18" runat="server" Text="QQ" Visible="False"></asp:Label>
        表單類別：
        <asp:CheckBoxList ID="CheckBoxList2" runat="server" RepeatDirection="Horizontal">
            <asp:ListItem Selected="True">零用金</asp:ListItem>
            <asp:ListItem Selected="True">請款單(非月結)</asp:ListItem>
            <asp:ListItem Selected="True">請款單(月結)</asp:ListItem>
        </asp:CheckBoxList>
        <asp:Label ID="Label19" runat="server" Text="零用金" Visible="False"></asp:Label>
        <asp:Label ID="Label20" runat="server" Text="請款單(非月結)" Visible="False"></asp:Label>
        <asp:Label ID="Label21" runat="server" Text="請款單(月結)" Visible="False"></asp:Label>
    
        <asp:Button ID="Button6" runat="server" CssClass="btn btn-primary" Text="查詢請款單" OnClick="Button6_Click" />
        <br />     <br />
        <asp:GridView ID="service" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" BackColor="White" BorderColor="#DEDFDE" BorderStyle="None" BorderWidth="1px" CellPadding="4" CssClass="table table-hover" DataSourceID="SqlDataSource5" ForeColor="Black" GridLines="Vertical" OnRowCommand="service_RowCommand" OnRowDataBound="service_RowDataBound" PageSize="30">
            <FooterStyle BackColor="#CCCC99" />
            <HeaderStyle BackColor="#6B696B" Font-Bold="True" ForeColor="White" />
            <PagerSettings Position="TopAndBottom" />
            <PagerStyle BackColor="White" CssClass="pagination-ys" ForeColor="Black" HorizontalAlign="Right" />
            <AlternatingRowStyle BackColor="White" />
            <Columns>
                <asp:BoundField DataField="id" HeaderText="編號" SortExpression="id" />
                <asp:BoundField DataField="createdate" DataFormatString="{0:d}" HeaderText="單據日期" SortExpression="createdate" />
                <asp:BoundField DataField="paydate" DataFormatString="{0:d}" HeaderText="付款日期" SortExpression="paydate" />
                <asp:BoundField DataField="emp_cne" HeaderText="申請人" SortExpression="emp_cne" />
                <asp:BoundField DataField="curr_k" HeaderText="幣別" SortExpression="curr_k" />
                <asp:HyperLinkField DataNavigateUrlFields="id" DataNavigateUrlFormatString="Paydetail.aspx?pid={0}" DataTextField="payment2" HeaderText="支付總金額" SortExpression="payment2" Target="_blank" DataTextFormatString="{0:N0}" >
                <ItemStyle HorizontalAlign="Right" />
                </asp:HyperLinkField>
                <asp:BoundField DataField="target" HeaderText="支付對象" SortExpression="target" />
                <asp:BoundField DataField="formtype" HeaderText="單據類型" SortExpression="formtype" />
                <asp:BoundField DataField="paytype" HeaderText="申請類型" SortExpression="paytype" />
                <asp:BoundField DataField="check" HeaderText="核決狀況" SortExpression="check"  />
                <asp:TemplateField HeaderText="管理選項">
                    <ItemTemplate>
                        <asp:Button ID="manage" runat="server" CommandArgument='<%# Eval("id") %>' CommandName="manage" CssClass="btn btn-success btn-xs" Text="管理" Visible="false" Enabled="False" />
                        <asp:Button ID="edit" runat="server" CommandArgument='<%# Eval("id") %>' CommandName="edit" CssClass="btn btn-warning btn-xs" Text="編輯" Visible="false" Enabled="False" />
                        <asp:Button ID="check" runat="server" CommandArgument='<%# Eval("id") %>' CommandName="check" CssClass="btn btn-warning btn-xs" Text="核可" Visible="false" />
                        <asp:Button ID="remove" runat="server" CommandArgument='<%# Eval("id") %>' CommandName="remove" CssClass="btn btn-danger btn-xs" Text="刪除" Visible="false" />
                        <asp:Button ID="print1" runat="server" CommandArgument='<%# Eval("id")+",,"+Eval("emp_cne") %>' CommandName="print1" CssClass="btn btn-primary btn-xs" Text="列印" Visible="false" />
                        <asp:Button ID="print2" runat="server" CommandArgument='<%# Eval("id")+",,"+Eval("emp_cne") %>' CommandName="print2" CssClass="btn btn-primary btn-xs" Text="列印" Visible="false" />
                        <asp:Button ID="giveup" runat="server" CommandArgument='<%# Eval("id") %>' CommandName="giveup" CssClass="btn btn-primary btn-xs" Text="作廢" Visible="false" />
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
            <RowStyle BackColor="#F7F7DE" />
            <SelectedRowStyle BackColor="#CE5D5A" Font-Bold="True" ForeColor="White" />
            <SortedAscendingCellStyle BackColor="#FBFBF2" />
            <SortedAscendingHeaderStyle BackColor="#848384" />
            <SortedDescendingCellStyle BackColor="#EAEAD3" />
            <SortedDescendingHeaderStyle BackColor="#575357" />
        </asp:GridView>
        *核決狀況：Y=已核決  N=未核決  G=作廢<asp:Label ID="checkma" runat="server" Text="Label" Visible="False"></asp:Label>
&nbsp;<asp:SqlDataSource ID="SqlDataSource5" runat="server" ConnectionString="<%$ ConnectionStrings:MENU %>" SelectCommand="SELECT * ,cast(payment  AS float) as 'payment2' FROM [TB_Payment] WHERE (([createdate] &gt;= @createdate) AND ([createdate] &lt;= @createdate2)) and (([formtype]=@formtype1) or([formtype]=@formtype2) or([formtype]=@formtype3))and(([check]=@check1)  or([check]=@check2)  or([check]=@check3)) and ([emp_cne] like @emp_cne)ORDER BY [id] DESC">
            <SelectParameters>
                <asp:ControlParameter ControlID="TextBox1" DefaultValue="2017/01/01" Name="createdate" PropertyName="Text" Type="DateTime" />
                <asp:ControlParameter ControlID="TextBox2" DefaultValue="2030/01/01" Name="createdate2" PropertyName="Text" Type="DateTime" />
                <asp:ControlParameter ControlID="Label19" DefaultValue="" Name="formtype1" PropertyName="Text" />
                <asp:ControlParameter ControlID="Label20" Name="formtype2" PropertyName="Text" DefaultValue="" />
                <asp:ControlParameter ControlID="Label21" Name="formtype3" PropertyName="Text" />
                <asp:ControlParameter ControlID="Label16" Name="check1" PropertyName="Text" />
                <asp:ControlParameter ControlID="Label17" Name="check2" PropertyName="Text" />
                <asp:ControlParameter ControlID="Label18" Name="check3" PropertyName="Text" />
                <asp:ControlParameter ControlID="Label22" DefaultValue="" Name="emp_cne" PropertyName="Text" />
            </SelectParameters>
        </asp:SqlDataSource>
        <br />

        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="emp_no" DataSourceID="SqlDataSource1" Visible="False">
            <Columns>
                <asp:BoundField DataField="emp_no" HeaderText="emp_no" ReadOnly="True" SortExpression="emp_no" />
                <asp:BoundField DataField="emp_cne" HeaderText="emp_cne" SortExpression="emp_cne" />
                <asp:BoundField DataField="DEPA_NE1" HeaderText="DEPA_NE1" SortExpression="DEPA_NE1" />
            </Columns>
        </asp:GridView>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:MENU %>" SelectCommand="SELECT * FROM [chuck06] WHERE ([emp_no] = @emp_no)">
            <SelectParameters>
                <asp:ControlParameter ControlID="Labuserid" Name="emp_no" PropertyName="Text" Type="String" />
            </SelectParameters>
        </asp:SqlDataSource>
        <asp:Label ID="Labuserid" runat="server" Visible="False"></asp:Label>
        <br />
        <asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:MENU %>" SelectCommand="SELECT [DEPA_NE2], [DEPA_NO] FROM [BAS30]"></asp:SqlDataSource>
        <br />
        <br />
    </div>
    <div class="col-md-1">
    </div>

</asp:Content>
