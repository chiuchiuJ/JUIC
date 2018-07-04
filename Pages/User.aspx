<%@ Page Title="" Language="C#" MasterPageFile="~/Master/JuicERP.Master" AutoEventWireup="true" CodeBehind="User.aspx.cs" Inherits="JuicERP.Pages.User" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">
        .auto-style2 {
            width: 50%;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">


    <div class="col-md-2">
    </div>
    <div class="col-md-8">
        <div class="panel panel-info" style="font-family: 微軟正黑體; font-size: medium;">
            <div class="panel-heading" style="font-size: large; text-align: center;">使用者密碼修改</div>
            <div class="panel-body" style="text-align: center">
                請輸入舊密碼：<asp:TextBox ID="TextBox1" runat="server" TextMode="Password"></asp:TextBox><br />
                <br />
                請輸入新密碼：<asp:TextBox ID="TextBox2" runat="server" TextMode="Password"></asp:TextBox><br />
                請確認新密碼：<asp:TextBox ID="TextBox3" runat="server" TextMode="Password"></asp:TextBox><br />
                <br />
                <asp:Button ID="Button1" runat="server" Text="修改密碼" OnClick="Button1_Click" CssClass="btn btn-danger" />
            </div>
        </div>
        <div class="panel panel-info" style="font-family: 微軟正黑體; font-size: medium;">
            <div class="panel-heading" style="font-size: large; text-align: center;">個人資料修改</div>
            <div class="panel-body">
                <div align="center">
                    <asp:Label ID="Label3" runat="server" Text="您已提交資料變更申請，因人事部門尚未核可，下述為資料庫原始資料" ForeColor="Red" Visible="False"></asp:Label>
                </div>

                <table style="width: 100%;">
                    <tr>
                        <td class="auto-style2" align="right">室內電話：</td>
                        <td>

                            <asp:TextBox ID="TextBox4" runat="server"></asp:TextBox>

                        </td>
                    </tr>
                    <tr>
                        <td class="auto-style2" align="right">個人手機：</td>
                        <td>

                            <asp:TextBox ID="TextBox5" runat="server"></asp:TextBox>

                        </td>
                    </tr>
                    <tr>
                        <td class="auto-style2" align="right">聯絡地址：</td>
                        <td>

                            <asp:TextBox ID="TextBox6" runat="server" Width="400px"></asp:TextBox>

                        </td>
                    </tr>
                    <tr>
                        <td class="auto-style2" align="right">戶籍地址：</td>
                        <td>

                            <asp:TextBox ID="TextBox7" runat="server" Width="400px" ReadOnly="True" Visible="False"></asp:TextBox><asp:Label ID="Label4" runat="server" Text="Label"></asp:Label>
                            <br />
                            (戶籍地址變更請聯繫人事並檢附身分證影本)
                        </td>
                    </tr>
                    <%--<tr>
                        <td class="auto-style2" align="right">&nbsp;</td>
                        <td>&nbsp;</td>
                    </tr>--%>
                    <tr>
                        <td class="auto-style2" align="right">緊急聯絡人：</td>
                        <td>

                            <asp:TextBox ID="TextBox8" runat="server"></asp:TextBox>

                        </td>
                    </tr>
                    <tr>
                        <td class="auto-style2" align="right">聯絡人手機：</td>
                        <td>

                            <asp:TextBox ID="TextBox9" runat="server"></asp:TextBox>

                        </td>
                    </tr>
                    <tr>
                        <td class="auto-style2" align="right">聯絡人地址：</td>
                        <td>

                            <asp:TextBox ID="TextBox10" runat="server" Width="400px"></asp:TextBox>

                        </td>
                    </tr>
                    <tr>
                        <td class="auto-style2" align="right">關係：</td>
                        <td>

                            <asp:TextBox ID="TextBox11" runat="server"></asp:TextBox>

                        </td>
                    </tr>
                </table>
                <br />
                <div align="center">
                    <asp:Button ID="Button3" runat="server" Text="個人資料修改申請(需人事部門核可)" OnClick="Button3_Click" CssClass="btn btn-primary" />
                    <hr />
                    <asp:Label ID="Label2" runat="server" Text="您申請變更的資料如下" ForeColor="Red" Visible="False"></asp:Label>
                    <asp:Label ID="Label5" runat="server" BackColor="Yellow" Font-Bold="True" ForeColor="#CC0066"></asp:Label>
                    <br />
                    <asp:DetailsView ID="DetailsView1" runat="server" AutoGenerateRows="False" DataSourceID="SqlDataSource4" Height="50px" Width="70%">
                        <Fields>
                            <asp:BoundField DataField="tel1" HeaderText="室內電話" SortExpression="tel1" />
                            <asp:BoundField DataField="mtel" HeaderText="個人手機" SortExpression="mtel" />
                            <asp:BoundField DataField="addr1" HeaderText="聯絡地址" SortExpression="addr1" />
                            <asp:BoundField DataField="attn" HeaderText="緊急聯絡人" SortExpression="attn" />
                            <asp:BoundField DataField="rela" HeaderText="聯絡人關係" SortExpression="rela" />
                            <asp:BoundField DataField="rela_addr" HeaderText="聯絡人住址" SortExpression="rela_addr" />
                            <asp:BoundField DataField="rela_tel" HeaderText="聯絡人電話" SortExpression="rela_tel" />
                        </Fields>
                    </asp:DetailsView>
                    <asp:SqlDataSource ID="SqlDataSource4" runat="server" ConnectionString="<%$ ConnectionStrings:MENU %>" SelectCommand="SELECT [tel1], [addr1],[mtel], [attn], [rela], [rela_addr], [rela_tel] FROM [TB_Userdata] WHERE ([emp_no] = @emp_no) and (hrcheck='N') ORDER BY [id] DESC">
                        <SelectParameters>
                            <asp:ControlParameter ControlID="Label1" Name="emp_no" PropertyName="Text" Type="String" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                </div>
            </div>
        </div>


        <div class="panel panel-warning" style="font-family: 微軟正黑體; font-size: medium;">
            <div class="panel-heading" style="font-size: large; text-align: center;">帳號權限</div>
            <div class="panel-body">
                <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:MENU %>" SelectCommand="SELECT [userid], [username], [department], [level] FROM [TB_Level] WHERE ([userid] = @userid)">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="Label1" Name="userid" PropertyName="Text" Type="String" />
                    </SelectParameters>
                </asp:SqlDataSource>
                <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource1" EnableModelValidation="True" Width="100%">
                    <Columns>
                        <asp:BoundField DataField="userid" HeaderText="使用者ID" SortExpression="userid" ItemStyle-HorizontalAlign="Center" />
                        <asp:BoundField DataField="username" HeaderText="使用者名稱" SortExpression="username" ItemStyle-HorizontalAlign="Center" />
                        <asp:BoundField DataField="department" HeaderText="所屬部門" SortExpression="department" ItemStyle-HorizontalAlign="Center" />
                        <asp:BoundField DataField="level" HeaderText="權限等級" SortExpression="level" ItemStyle-HorizontalAlign="Center" />
                    </Columns>
                </asp:GridView>
                <asp:Label ID="Label1" runat="server" Text="Label" Visible="False"></asp:Label>
            </div>
        </div>

        <div class="panel panel-success" style="font-family: 微軟正黑體; font-size: medium;">
            <div class="panel-heading" style="font-size: large; text-align: center;">網站瀏覽權限</div>
            <div class="panel-body">
                <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                    <ContentTemplate>
                        <div style="text-align: center">若有開通需求請填寫線上權限申請表單<asp:Button ID="Button2" runat="server" Text="查看自己網頁權限" CssClass="btn btn-primary btn-sm" OnClick="Button2_Click" /></div>

                        <br />
                        <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:MENU %>" SelectCommand="  SELECT [MenuId]
      ,[ParentMenuId]
      ,[Title]
      ,[Description]
      ,[Url]
  FROM [juic].[dbo].[TB_Menus]
  where ParentMenuId=0
  order by ParentMenuId"></asp:SqlDataSource>
                        <asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:MENU %>" SelectCommand="  SELECT [MenuId]
      ,[ParentMenuId]
      ,[Title]
      ,[Description]
      ,[Url]
  FROM [juic].[dbo].[TB_Menus]
  where ParentMenuId!=0
  order by ParentMenuId"></asp:SqlDataSource>

                        <asp:CheckBoxList ID="CheckBoxList1" runat="server" DataSourceID="SqlDataSource2" DataTextField="Title" DataValueField="MenuId" Font-Names="微軟正黑體" Font-Size="Medium" RepeatColumns="5" RepeatDirection="Horizontal" Width="100%"></asp:CheckBoxList>
                        <br />
                        <asp:CheckBoxList ID="CheckBoxList2" runat="server" DataSourceID="SqlDataSource3" DataTextField="Title" DataValueField="MenuId" Font-Names="微軟正黑體" Font-Size="Medium" RepeatColumns="5" RepeatDirection="Horizontal" Width="100%"></asp:CheckBoxList>
                    </ContentTemplate>
                    <Triggers>
                        <asp:AsyncPostBackTrigger ControlID="Button2" EventName="Click" />
                    </Triggers>
                </asp:UpdatePanel>
            </div>
        </div>
    </div>
    <div class="col-md-2">
    </div>
</asp:Content>
