<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="MISserviceupload.aspx.cs" Inherits="JuicERP.Pages.MISserviceupload" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:FileUpload ID="FileUpload1" runat="server" />
            <asp:Button ID="Button1" runat="server" Text="上傳附擋" OnClick="Button1_Click" />

            <asp:Button ID="Button3" runat="server" OnClick="Button3_Click" Text="回清單" />
            <br />
            <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource1" OnRowCommand="GridView1_RowCommand">
                <Columns>
                    <asp:BoundField DataField="url" HeaderText="url" SortExpression="url" Visible="False" />
                    <asp:HyperLinkField DataNavigateUrlFields="url" DataTextField="filename" HeaderText="上傳附件清單" />
                    <asp:TemplateField>
                        <ItemTemplate>
                            <asp:Button ID="remove" runat="server" Text="刪除" CommandName="remove" CommandArgument='<%# Eval("url") %>'/>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:MENU %>" SelectCommand="SELECT * FROM [TB_MISserviceupload] WHERE ([misid] = @misid)">
                <SelectParameters>
                    <asp:QueryStringParameter Name="misid" QueryStringField="pid" Type="String" />
                </SelectParameters>
            </asp:SqlDataSource>
        </div>
    </form>
</body>
</html>
