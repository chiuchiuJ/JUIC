<%@ Page Title="" Language="C#" MasterPageFile="~/Master/JuicERP.Master" AutoEventWireup="true" CodeBehind="JuicWMS2.aspx.cs" Inherits="JuicERP.Pages.JuicWMS2" %>

<%@ Register Src="~/UserControls/QueryWindow.ascx" TagPrefix="uc1" TagName="QueryWindow" %>
<%@ Register Src="~/UserControls/ListPicker.ascx" TagPrefix="uc1" TagName="ListPicker" %>
<%@ Register Src="~/UserControls/MessageBox.ascx" TagPrefix="uc1" TagName="MessageBox" %>
<%@ Register Src="~/UserControls/Announce.ascx" TagPrefix="ucl" TagName="Announce" %>



<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <%--    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>--%>

    <%--    <table class="outer" cellpadding="6" cellspacing="1" border="0" width="100%" align="center">
	<tr class="myhead" align="left">
      <td  width="5%" colspan="2">
            &nbsp;
            </td>
      <td>&nbsp;<strong><a href="viewforum.php?forum=11&amp;sortname=t.topic_title&amp;since=0&amp;sortorder=DESC">主題</a></strong></td>
      <td width="10%" align="center" nowrap="nowrap"><strong><a href="viewforum.php?forum=11&amp;sortname=u.uname&amp;since=0&amp;sortorder=DESC">作者</a></strong></td>
      <td width="10%" align="center" nowrap="nowrap"><strong><a href="viewforum.php?forum=11&amp;sortname=t.topic_time&amp;since=0&amp;sortorder=DESC">發佈日期</a></strong></td>
      <td width="5%" align="center" nowrap="nowrap"><strong><a href="viewforum.php?forum=11&amp;sortname=t.topic_replies&amp;since=0&amp;sortorder=DESC">回覆</a></strong></td>
      <td width="5%" align="center" nowrap="nowrap"><strong><a href="viewforum.php?forum=11&amp;sortname=t.topic_views&amp;since=0&amp;sortorder=DESC">點選</a></strong></td>
      <td width="15%" align="center" nowrap="nowrap"><strong><a href="viewforum.php?forum=11&amp;sortname=p.post_time&amp;since=0&amp;sortorder=ASC">最後發表</a></strong></td>
	</tr>
        </table>--%>

    <div class="row">
        <div class="col-md-1">
        </div>
        <div class="col-md-7">
            <asp:Panel ID="ModalPanel" runat="server" Visible="false">
                <ucl:Announce runat="server" ID="Announce" />
            </asp:Panel>
            <div class="panel panel-info">
                <div class="panel-heading" align="center" style="font-size: large; color: #000000; font-weight: bold; font-family: 微軟正黑體;">
                    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:MENU %>" SelectCommand="SELECT * FROM [TB_AnnounceBeta] ORDER BY [postdate] DESC, [dept]"></asp:SqlDataSource>
                    最新公告
                </div>

                <asp:GridView ID="gvANN" runat="server" BorderStyle="None" CssClass="table table-hover" GridLines="Horizontal" AllowSorting="True" AutoGenerateColumns="False" AllowPaging="True" OnSorting="gvANN_Sorting" OnRowCommand="gvANN_RowCommand" DataSourceID="SqlDataSource1" EnableModelValidation="True" OnRowDataBound="gvANN_RowDataBound" PageSize="5">
                    <PagerSettings Position="Top" />
                    <PagerStyle CssClass="pagination-ys" />
                    <Columns>

                        <asp:BoundField DataField="dept" HeaderText="部門" HeaderStyle-Wrap="False" ItemStyle-Width="10%" />
                        <asp:BoundField DataField="postdate" HeaderText="日期" HeaderStyle-Wrap="False" ItemStyle-Width="15%" DataFormatString='{0:yyyy-MM-dd}' SortExpression="postdate" />
                        <asp:BoundField DataField="title" ItemStyle-Width="55%" HeaderText="公告事項" ItemStyle-ForeColor="Blue" />
                        <%--<asp:HyperLinkField DataTextField="title" Target="_parent" ItemStyle-Width="50%" HeaderText="公告事項" DataNavigateUrlFormatString="Announce.aspx?ID={0}" DataNavigateUrlFields="ID" />--%>
                        <%-- <asp:HyperLinkField DataNavigateUrlFields="pdfurl" Target="_blank" ItemStyle-Width="10%" Text="點我下載" HeaderText="PDF下載" DataTextFormatString="&lt;img src='../img/close.gif' style='cursor:hand' title='查看' onclick='ViewRecord({0})'&gt;" />--%>
                        <asp:TemplateField HeaderText="附件" ItemStyle-Width="7%">
                            <ItemTemplate>
                                <div style="text-align: center">
                                    <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl='<%# Eval("pdfurl")%>'>
                                        <asp:Image ID="Image1" runat="server" ImageUrl="~/img/pdf1.png" />
                                    </asp:HyperLink>

                                </div>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField ItemStyle-Width="13%">
                            <ItemTemplate>
                                <asp:Button ID="post" runat="server" Text="詳細" CommandName="post" CommandArgument='<%# Eval("title")+",,"+Eval("content")+",,"+Eval("postdate")+",,"+Eval("dept")+",,"+Eval("author")+",,"+Eval("ID") %>' CssClass="btn btn-warning btn-xs" />
                                <asp:Button ID="remove" runat="server" Text="刪除" CommandName="remove" CommandArgument='<%# Eval("ID")%>' CssClass="btn btn-danger btn-xs" Visible="False" />
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                    <RowStyle BackColor="#F7F7DE" Font-Size="Medium" VerticalAlign="Bottom" />
                    <HeaderStyle BackColor="#6B696B" Font-Bold="True" ForeColor="White" Font-Size="Medium" />

                </asp:GridView>

            </div>

            <div class="panel panel-danger">
                <div class="panel-heading" align="center" style="font-size: large; color: #000000; font-weight: bold; font-family: 微軟正黑體;">
                    管理辦法及表單更新一覽
                </div>
                <br />
                <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" CellPadding="4" DataSourceID="SqlDataSource4" ForeColor="Black" Width="100%" AllowPaging="True" BackColor="#CCCCCC" BorderColor="#999999" BorderStyle="Solid" BorderWidth="3px" CellSpacing="2" OnRowCommand="GridView1_RowCommand" OnRowDataBound="GridView1_RowDataBound">
                    <Columns>
                        <asp:BoundField DataField="postdate" DataFormatString="{0:yyyy-MM-dd}" HeaderText="生效日期" SortExpression="postdate" ItemStyle-Width="20%">
                            <ItemStyle Width="15%"></ItemStyle>
                        </asp:BoundField>
                        <asp:BoundField DataField="number" HeaderText="編號" SortExpression="number" ItemStyle-Width="80%">
                            <ItemStyle Width="15%" />
                        </asp:BoundField>
                        <asp:BoundField DataField="version" HeaderText="版本" SortExpression="version">
                        <ItemStyle Width="10%" />
                        </asp:BoundField>
                        <asp:BoundField DataField="content" HeaderText="文件/表單名稱" SortExpression="content">
                        <ItemStyle Width="53%" />
                        </asp:BoundField>
                        <asp:TemplateField>
                            <ItemTemplate>
                                <asp:Button ID="remove" runat="server" Text="刪除" CssClass="btn btn-danger btn-xs" CommandName="remove" CommandArgument='<%# Eval("ID")%>' Visible="False" />
                            </ItemTemplate>
                            <ItemStyle Width="7%" />
                        </asp:TemplateField>
                    </Columns>
                    <FooterStyle BackColor="#CCCCCC" />
                    <HeaderStyle BackColor="Black" Font-Bold="True" ForeColor="White" Font-Names="微軟正黑體" Font-Size="Medium" />
                    <%--<PagerStyle BackColor="#CCCCCC" ForeColor="Black" HorizontalAlign="Left" />--%>
                    <PagerStyle CssClass="pagination-ys" />
                    <RowStyle BackColor="White" Font-Names="微軟正黑體" Font-Size="Medium" />
                    <SelectedRowStyle BackColor="#000099" Font-Bold="True" ForeColor="White" />
                    <SortedAscendingCellStyle BackColor="#F1F1F1" />
                    <SortedAscendingHeaderStyle BackColor="#808080" />
                    <SortedDescendingCellStyle BackColor="#CAC9C9" />
                    <SortedDescendingHeaderStyle BackColor="#383838" />
                </asp:GridView>
                <asp:SqlDataSource ID="SqlDataSource4" runat="server" ConnectionString="<%$ ConnectionStrings:MENU %>" SelectCommand="SELECT [postdate], [content], [url], [PS], [ID], [number], [version] FROM [TB_AnnFormInfo] ORDER BY [postdate] DESC"></asp:SqlDataSource>
                <br />
                <asp:Panel ID="Panel3" runat="server">
                    新增表單辦法更新訊息：<br /> 日　　期：<asp:TextBox ID="TextBox5" runat="server" TextMode="Date"></asp:TextBox>
                    <br />
                    編　　號：<asp:TextBox ID="TextBox6" runat="server"></asp:TextBox>
                    <br />
                    版　　本：<asp:TextBox ID="TextBox7" runat="server"></asp:TextBox>
                    <br />
                    內　　容：<asp:TextBox ID="TextBox4" runat="server" Width="50%"></asp:TextBox>
                    <br />
                    <asp:Button ID="Button3" runat="server" Text="送出" CssClass="btn btn-success" OnClick="Button3_Click" />
                </asp:Panel>
            </div>
        </div>
        <div class="col-md-3">

            <asp:Calendar ID="Calendar1" runat="server" TodayDayStyle-BackColor="Red" BackColor="#FFFFCC" BorderStyle="Solid" Width="100%" OnSelectionChanged="Calendar1_SelectionChanged" OnDayRender="Calendar1_DayRender" OnVisibleMonthChanged="Calendar1_VisibleMonthChanged" BorderColor="Black" DayNameFormat="Shortest" Font-Names="Times New Roman" Font-Size="10pt" Height="220px" TitleFormat="Month">
                <DayHeaderStyle BackColor="#CCCCCC" Font-Names="微軟正黑體" Font-Size="7pt" ForeColor="#333333" Height="10pt" />
                <SelectedDayStyle BackColor="#CC3333" ForeColor="White" />
                <SelectorStyle BackColor="#CCCCCC" Font-Bold="True" Font-Names="Verdana" Font-Size="8pt" ForeColor="#333333" Width="1%" />
                <TitleStyle BackColor="Black" Font-Bold="True" Font-Italic="False" Font-Names="微軟正黑體" ForeColor="White" Font-Size="13pt" Height="14pt" />
                <TodayDayStyle BackColor="#CCCC99" ForeColor="White"></TodayDayStyle>
                <DayStyle Width="14%" />
                <NextPrevStyle Font-Size="8pt" ForeColor="White" />
                <OtherMonthDayStyle ForeColor="Silver" BackColor="White" />
                <WeekendDayStyle BackColor="Red" />
            </asp:Calendar>
            <asp:Label ID="Calendar1text3" runat="server" Font-Names="微軟正黑體" Font-Size="XX-Large"></asp:Label>
            <br />
            <asp:Label ID="Calendar1text" runat="server" Font-Names="微軟正黑體" Visible="False"></asp:Label>
            <%--        <br />--%>
            <asp:Label ID="Calendar1text2" runat="server" Font-Names="微軟正黑體" Visible="False"></asp:Label>
            <%--          <br />--%>
            <asp:Button ID="Button6" runat="server" Text="匯率一覽" CssClass="btn btn-default btn-block" Font-Names="微軟正黑體" OnClick="Button6_Click" />
            <asp:Panel ID="Panel4" runat="server" Visible="False" Font-Names="微軟正黑體"  HorizontalAlign="Center">
               <%-- <asp:GridView ID="GridView3" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource5" Width="60%" HorizontalAlign="Center">
                    <Columns>
                        <asp:BoundField DataField="CURR_K" HeaderText="幣別" SortExpression="CURR_K" />
                        <asp:BoundField DataField="BAS3201" HeaderText="匯率" SortExpression="BAS3201" />
                    </Columns>
                </asp:GridView>
                <asp:SqlDataSource ID="SqlDataSource5" runat="server" ConnectionString="<%$ ConnectionStrings:MENU %>" SelectCommand="SELECT TOP(4) [CURR_K], [BAS3201] FROM [BAS32] ORDER BY [S_D] DESC"></asp:SqlDataSource>--%>
                <asp:HyperLink ID="HyperLink9" runat="server" CssClass="btn btn-primary" Font-Names="微軟正黑體" NavigateUrl="~/files/title/匯率表.docx" Target="_blank">本月匯率表</asp:HyperLink>
                <asp:HyperLink ID="HyperLink10" runat="server" CssClass="btn btn-success" Font-Names="微軟正黑體" NavigateUrl="~/files/title/匯率表_lm.docx" Target="_blank">上月匯率表</asp:HyperLink>
            </asp:Panel>
            
            <asp:HyperLink ID="HyperLink2" runat="server" CssClass="btn btn-default btn-block" Font-Names="微軟正黑體" NavigateUrl="~/files/title/客戶基本資料詢SOP.pdf" Target="_blank">客戶資料查詢SOP</asp:HyperLink>
            <asp:Button ID="Button4" runat="server" Text="企業組織圖" CssClass="btn btn-default btn-block" Font-Names="微軟正黑體" OnClick="Button4_Click" />
            <asp:Panel ID="Panel1" runat="server" Visible="False" HorizontalAlign="Center">
                <asp:HyperLink ID="HyperLink3" runat="server" CssClass="btn btn-primary " Font-Names="微軟正黑體" NavigateUrl="~/files/title/久威國際股份有限公司組織圖20180401.pdf" Target="_blank">久威國際</asp:HyperLink>
                <asp:HyperLink ID="HyperLink4" runat="server" CssClass="btn btn-warning " Font-Names="微軟正黑體" NavigateUrl="~/files/title/蘇州久鋐電子有限公司組織圖20180101.pdf" Target="_blank">久鋐</asp:HyperLink>
                <asp:HyperLink ID="HyperLink5" runat="server" CssClass="btn btn-success " Font-Names="微軟正黑體" NavigateUrl="~/files/title/廣田光電(深圳)有限公司組織圖20180701.pdf" Target="_blank">廣田</asp:HyperLink>
            </asp:Panel>
            <asp:Button ID="Button5" runat="server" Text="座位表與聯繫方式" CssClass="btn btn-default btn-block" Font-Names="微軟正黑體" OnClick="Button5_Click" />
            <asp:Panel ID="Panel2" runat="server" Visible="False" HorizontalAlign="Center">
                <asp:HyperLink ID="HyperLink6" runat="server" CssClass="btn btn-primary " Font-Names="微軟正黑體" NavigateUrl="~/files/title/久威聯絡方式2018.07.xlsx" Target="_blank">久威國際</asp:HyperLink>
                <asp:HyperLink ID="HyperLink7" runat="server" CssClass="btn btn-warning " Font-Names="微軟正黑體" NavigateUrl="~/files/title/久鋐聯絡方式2017.12.xlsx" Target="_blank">久鋐</asp:HyperLink>
                <asp:HyperLink ID="HyperLink8" runat="server" CssClass="btn btn-success " Font-Names="微軟正黑體" NavigateUrl="~/files/title/廣田聯絡方式2017.11.xls" Target="_blank">廣田</asp:HyperLink>
            </asp:Panel>
            <asp:Button ID="Button1" runat="server" Text="新增生日會" CssClass="btn btn-default btn-block" Font-Names="微軟正黑體" OnClick="Button1_Click" />
            <asp:Panel ID="Addbirthdayevent" runat="server" Font-Names="微軟正黑體" Visible="false">
                <asp:Label ID="Label1" runat="server" Text="日期(需照格式)"></asp:Label><br />
                <%--        <input id="date1" name="date1" type="date"/>--%>
                <asp:TextBox ID="TextBox1" runat="server" Width="100%" TextMode="Date">2000-01-01</asp:TextBox><br />
                <asp:Label ID="Label2" runat="server" Text="活動細節"></asp:Label><br />
                <asp:TextBox ID="TextBox2" runat="server" TextMode="MultiLine" Rows="2" Width="100%"></asp:TextBox><br />
                <asp:Label ID="Label3" runat="server" Text="備註"></asp:Label><br />
                <asp:TextBox ID="TextBox3" runat="server" TextMode="MultiLine" Rows="2" Width="100%"></asp:TextBox><br />
                <asp:Button ID="Button2" runat="server" Text="送出" CssClass="btn btn-danger btn-block" Font-Names="微軟正黑體" OnClick="Button2_Click" />
            </asp:Panel>
            <br />
            <div class="panel panel-success" dir="ltr">
                <!-- Default panel contents -->
                <div class="panel-heading" align="center" style="font-family: 微軟正黑體">本月壽星一覽！</div>
                <div class="panel-body">
                    <asp:GridView ID="GridView2" runat="server" EnableModelValidation="True" AutoGenerateColumns="False" GridLines="None">
                        <Columns>
                            <asp:TemplateField ItemStyle-Width="100%">
                                <ItemTemplate>
                                    <div style="font-size: medium; color: #008080; font-weight: normal; font-family: 微軟正黑體;">慶生會日期：<%# Eval("eventdate") %></div>
                                    <div style="font-size: medium; color: #0000FF; font-weight: normal; font-family: 微軟正黑體;"><%# Eval("content") %></div>
                                    <br />
                                    <div style="font-size: medium; color: #008080; text-align: center; font-family: 微軟正黑體;">備註</div>
                                    <div style="font-size: medium; color: #800000; font-family: 微軟正黑體;"><%# Eval("PS") %></div>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>

                </div>

                <!-- Table -->
                <%--  <table class="table">
           <thead>
              <tr>
                  <th width="40%" class="" align="center">部門</th>
                  <th width="60%" class="" align='center' valign="middle">壽星</th>
                 </tr>
          </thead>
      <tbody>
    <tr>
        <td>
            <asp:Label ID="Label3" runat="server" Text="資訊部"></asp:Label>
        </td>
        <td>
            <asp:Label ID="Label4" runat="server" Text="喬治大大"></asp:Label>
        </td>
    </tr>
</tbody>
  </table>--%>
                <asp:GridView ID="B" runat="server" DataSourceID="SqlDataSource3" Width="100%" AutoGenerateColumns="False" CssClass="table table-hover table-striped" BorderStyle="None" GridLines="None" Font-Names="微軟正黑體">

                    <Columns>
                        <asp:BoundField DataField="emp_cne" HeaderText="壽星" />
                        <asp:BoundField DataField="emp_ene" HeaderText="英文名字" />
                        <%--             <asp:BoundField DataField="birthday" HeaderText="生日" HtmlEncode="False" ApplyFormatInEditMode="True" />--%>
                    </Columns>
                    <RowStyle BackColor="#99FFCC" Font-Size="Medium" VerticalAlign="Bottom" />
                    <HeaderStyle BackColor="#FFFFCC" Font-Bold="True" ForeColor="#000066" Font-Size="Medium" HorizontalAlign="Center" />
                </asp:GridView>
                <asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:MENU %>" SelectCommand="SELECT emp_cne, emp_ene, SUBSTRING(birthday, 5, 4) AS birthday FROM chuck05 WHERE (MONTH(birthday) - MONTH(GETDATE()) = 0)"></asp:SqlDataSource>
                <asp:Label ID="checkma" runat="server" Text="" Visible="False"></asp:Label>

            </div>
        </div>
        <div class="col-md-1">
        </div>
    </div>
    <%--        </ContentTemplate>
    </asp:UpdatePanel>--%>
    <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:MENU %>" SelectCommand="SELECT * FROM [TB_Birthday] ORDER BY [dept] DESC"></asp:SqlDataSource>
</asp:Content>
