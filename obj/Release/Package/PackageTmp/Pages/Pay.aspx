<%@ Page Title="" Language="C#" MasterPageFile="~/Master/JuicERP.Master" AutoEventWireup="true" CodeBehind="Pay.aspx.cs" Inherits="JuicERP.Pages.Pay" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <style type="text/css">
        .auto-style5 {
            width: 380px;
        }

        .auto-style6 {
            width: 120px;
        }
    </style>
    <script>var imgDir = '<%=ResolveUrl("~/img") %>' + "/";	</script>
    <script src="<%=ResolveUrl("~/js/popcalendar.js") %>" charset="UTF-8"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="col-md-1">
    </div>
    <div class="col-md-10" style="font-family: 微軟正黑體">
        <h2>請款單填寫</h2>
        <br />
        申請項目
        <asp:RadioButtonList ID="RadioButtonList1" runat="server" RepeatDirection="Horizontal" AutoPostBack="True" OnSelectedIndexChanged="RadioButtonList1_SelectedIndexChanged">
            <asp:ListItem Value="0">零用金預支</asp:ListItem>
            <asp:ListItem Value="1">零用金</asp:ListItem>
            <asp:ListItem Value="2">請款單(非月結)</asp:ListItem>
            <asp:ListItem Value="3">請款單(月結)</asp:ListItem>
        </asp:RadioButtonList>
        <%--20171026追加零用金預支--%>
        <asp:Panel ID="Panel0" runat="server" Visible="False">
            申請單位：<asp:DropDownList ID="DropDownListlend1" runat="server" AppendDataBoundItems="True" DataSourceID="SqlDataSource3" DataTextField="DEPA_NE2" DataValueField="DEPA_NO" Width="120px">
                <asp:ListItem Selected="True" Value="0">請選擇</asp:ListItem>
            </asp:DropDownList>
            <br />
            預支金額：<asp:TextBox ID="TextBoxlend1" runat="server" Width="120px"></asp:TextBox><br />
            領款人員：<asp:DropDownList ID="DropDownListlend2" runat="server" DataSourceID="SqlDataSourcelend1" DataTextField="username" DataValueField="userid" Width="120px"></asp:DropDownList>
            <asp:SqlDataSource ID="SqlDataSourcelend1" runat="server" ConnectionString="<%$ ConnectionStrings:MENU %>" SelectCommand="SELECT userid,username  FROM bas03 order by userid"></asp:SqlDataSource>
            <br />
            預支原因<br />
            <asp:TextBox ID="TextBoxlend2" runat="server" Height="80px" Width="750px" TextMode="MultiLine"></asp:TextBox>
            <br />
            <asp:Button ID="Button6" runat="server" CssClass="btn btn-success" OnClick="Button6_Click" Text="列印預支單" />
            <br />
        </asp:Panel>
        <asp:Panel ID="Panel1" runat="server" Visible="False">
            <asp:Panel ID="Panel5" runat="server">
                請款事由<br />
                <asp:TextBox ID="pay1text1" runat="server" Height="80px" Width="750px" TextMode="MultiLine"></asp:TextBox><br />
                申請部門<br />

                <asp:DropDownList ID="pay3drop31" runat="server" AppendDataBoundItems="True" DataSourceID="SqlDataSource3" DataTextField="DEPA_NE2" DataValueField="DEPA_NO" Width="171px">
                    <asp:ListItem Selected="True" Value="0">請選擇</asp:ListItem>
                </asp:DropDownList>
                <br />
                申請金額<br />
                <asp:TextBox ID="pay1text2" runat="server" Width="200px"></asp:TextBox>
                <%--  <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="pay1text2" ErrorMessage="請輸入數字" ValidationExpression="^[0-9]*$"></asp:RegularExpressionValidator>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="pay1text2" ErrorMessage="請輸入資料"></asp:RequiredFieldValidator>--%>
                <br />
            </asp:Panel>
            <asp:CheckBox ID="CheckBox1" runat="server" Text="多項目申請" AutoPostBack="True" OnCheckedChanged="CheckBox1_CheckedChanged" />
            <br />
            <asp:Panel ID="Panel4" runat="server" Visible="False">
                <table style="width: 60%;">
                    <tr>
                        <td colspan="2">項目費用列表</td>
                    </tr>
                    <tr>
                        <td>部門別</td>
                        <td class="auto-style5">申請金額(項目說明)</td>
                        <td class="auto-style6">金額</td>
                    </tr>
                    <tr>
                        <td class="auto-style6">
                            <asp:DropDownList ID="pay3drop21" runat="server" AppendDataBoundItems="True" DataSourceID="SqlDataSource3" DataTextField="DEPA_NE2" DataValueField="DEPA_NO" Width="95%">
                                <asp:ListItem Selected="True" Value="0">請選擇</asp:ListItem>
                            </asp:DropDownList>
                        </td>
                        <td class="auto-style5">
                            <asp:TextBox ID="pay3text43" runat="server" Width="95%"></asp:TextBox>
                        </td>
                        <td class="auto-style6">
                            <asp:TextBox ID="pay3text44" runat="server" Width="100%"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td class="auto-style6">
                            <asp:DropDownList ID="pay3drop22" runat="server" AppendDataBoundItems="True" DataSourceID="SqlDataSource3" DataTextField="DEPA_NE2" DataValueField="DEPA_NO" Width="95%">
                                <asp:ListItem Selected="True" Value="0">請選擇</asp:ListItem>
                            </asp:DropDownList>
                        </td>
                        <td class="auto-style5">
                            <asp:TextBox ID="pay3text45" runat="server" Width="95%"></asp:TextBox>
                        </td>
                        <td class="auto-style6">
                            <asp:TextBox ID="pay3text46" runat="server" Width="100%"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td class="auto-style6">
                            <asp:DropDownList ID="pay3drop23" runat="server" AppendDataBoundItems="True" DataSourceID="SqlDataSource3" DataTextField="DEPA_NE2" DataValueField="DEPA_NO" Width="95%">
                                <asp:ListItem Selected="True" Value="0">請選擇</asp:ListItem>
                            </asp:DropDownList>
                        </td>
                        <td class="auto-style5">
                            <asp:TextBox ID="pay3text47" runat="server" Width="95%"></asp:TextBox>
                        </td>
                        <td class="auto-style6">
                            <asp:TextBox ID="pay3text48" runat="server" Width="100%"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td class="auto-style6">
                            <asp:DropDownList ID="pay3drop24" runat="server" AppendDataBoundItems="True" DataSourceID="SqlDataSource3" DataTextField="DEPA_NE2" DataValueField="DEPA_NO" Width="95%">
                                <asp:ListItem Selected="True" Value="0">請選擇</asp:ListItem>
                            </asp:DropDownList>
                        </td>
                        <td class="auto-style5">
                            <asp:TextBox ID="pay3text49" runat="server" Width="95%"></asp:TextBox>
                        </td>
                        <td class="auto-style6">
                            <asp:TextBox ID="pay3text50" runat="server" Width="100%"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td class="auto-style6">
                            <asp:DropDownList ID="pay3drop25" runat="server" AppendDataBoundItems="True" DataSourceID="SqlDataSource3" DataTextField="DEPA_NE2" DataValueField="DEPA_NO" Width="95%">
                                <asp:ListItem Selected="True" Value="0">請選擇</asp:ListItem>
                            </asp:DropDownList>
                        </td>
                        <td class="auto-style5">
                            <asp:TextBox ID="pay3text51" runat="server" Width="95%"></asp:TextBox>
                        </td>
                        <td class="auto-style6">
                            <asp:TextBox ID="pay3text52" runat="server" Width="100%"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td class="auto-style6">
                            <asp:DropDownList ID="pay3drop26" runat="server" AppendDataBoundItems="True" DataSourceID="SqlDataSource3" DataTextField="DEPA_NE2" DataValueField="DEPA_NO" Width="95%">
                                <asp:ListItem Selected="True" Value="0">請選擇</asp:ListItem>
                            </asp:DropDownList>
                        </td>
                        <td class="auto-style5">
                            <asp:TextBox ID="pay3text53" runat="server" Width="95%"></asp:TextBox>
                        </td>
                        <td class="auto-style6">
                            <asp:TextBox ID="pay3text54" runat="server" Width="100%"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td class="auto-style6">
                            <asp:DropDownList ID="pay3drop27" runat="server" AppendDataBoundItems="True" DataSourceID="SqlDataSource3" DataTextField="DEPA_NE2" DataValueField="DEPA_NO" Width="95%">
                                <asp:ListItem Selected="True" Value="0">請選擇</asp:ListItem>
                            </asp:DropDownList>
                        </td>
                        <td class="auto-style5">
                            <asp:TextBox ID="pay3text55" runat="server" Width="95%"></asp:TextBox>
                        </td>
                        <td class="auto-style6">
                            <asp:TextBox ID="pay3text56" runat="server" Width="100%"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td class="auto-style6">
                            <asp:DropDownList ID="pay3drop28" runat="server" AppendDataBoundItems="True" DataSourceID="SqlDataSource3" DataTextField="DEPA_NE2" DataValueField="DEPA_NO" Width="95%">
                                <asp:ListItem Selected="True" Value="0">請選擇</asp:ListItem>
                            </asp:DropDownList>
                        </td>
                        <td class="auto-style5">
                            <asp:TextBox ID="pay3text57" runat="server" Width="95%"></asp:TextBox>
                        </td>
                        <td class="auto-style6">
                            <asp:TextBox ID="pay3text58" runat="server" Width="100%"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td class="auto-style6">
                            <asp:DropDownList ID="pay3drop29" runat="server" AppendDataBoundItems="True" DataSourceID="SqlDataSource3" DataTextField="DEPA_NE2" DataValueField="DEPA_NO" Width="95%">
                                <asp:ListItem Selected="True" Value="0">請選擇</asp:ListItem>
                            </asp:DropDownList>
                        </td>
                        <td class="auto-style5">
                            <asp:TextBox ID="pay3text59" runat="server" Width="95%"></asp:TextBox>
                        </td>
                        <td class="auto-style6">
                            <asp:TextBox ID="pay3text60" runat="server" Width="100%"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td class="auto-style6">
                            <asp:DropDownList ID="pay3drop30" runat="server" AppendDataBoundItems="True" DataSourceID="SqlDataSource3" DataTextField="DEPA_NE2" DataValueField="DEPA_NO" Width="95%">
                                <asp:ListItem Selected="True" Value="0">請選擇</asp:ListItem>
                            </asp:DropDownList>
                        </td>
                        <td class="auto-style5">
                            <asp:TextBox ID="pay3text61" runat="server" Width="95%"></asp:TextBox>
                        </td>
                        <td class="auto-style6">
                            <asp:TextBox ID="pay3text62" runat="server" Width="100%"></asp:TextBox>
                        </td>
                    </tr>
                </table>
            </asp:Panel>
            <br />
            <asp:Button ID="Button1" runat="server" Text="送出並列印表單" CssClass="btn btn-success " OnClick="Button1_Click" />
        </asp:Panel>
        <asp:Panel ID="Panel2" runat="server" Visible="False">
            支付項目種類<br />
            <asp:DropDownList ID="DropDownList1" runat="server" Height="35px" Width="200px" OnSelectedIndexChanged="DropDownList1_SelectedIndexChanged">
                <asp:ListItem Value="0">一般費用報支(含預付/暫付)</asp:ListItem>
                <asp:ListItem Value="1">員工報支</asp:ListItem>
                <asp:ListItem Value="2">交際費</asp:ListItem>
                <asp:ListItem Value="3">請採購(單筆)</asp:ListItem>
                <asp:ListItem Value="4">旅費報銷</asp:ListItem>
                <asp:ListItem Value="5">定期費用報支</asp:ListItem>
                <asp:ListItem Value="6">資材採購(原材料+訂單) </asp:ListItem>
                <asp:ListItem Value="7">資材採購(原材料+無訂單) </asp:ListItem>
                <asp:ListItem Value="8">雜項購置及修繕工程</asp:ListItem>
                <asp:ListItem Value="9">資訊設備採購</asp:ListItem>
                <asp:ListItem Value="10">薪酬費用(人事)</asp:ListItem>
                <asp:ListItem Value="11">外包加工</asp:ListItem>
               
            </asp:DropDownList>
            <br />
            支付對象<br />
            <asp:RadioButtonList ID="RadioButtonList7" runat="server" AutoPostBack="True" RepeatDirection="Horizontal" OnSelectedIndexChanged="RadioButtonList7_SelectedIndexChanged">
                <asp:ListItem Value="0" Selected="True">個人</asp:ListItem>
                <asp:ListItem Value="1">廠商</asp:ListItem>
                <asp:ListItem Value="2">其他</asp:ListItem>
            </asp:RadioButtonList>
            <asp:TextBox ID="TextBox2" runat="server" Visible="false"  placeholder="請輸入廠商關鍵字" OnTextChanged="TextBox2_TextChanged" AutoPostBack="True"></asp:TextBox>
            <asp:DropDownList ID="DropDownList5" runat="server"  Width="200px" OnSelectedIndexChanged="DropDownList5_SelectedIndexChanged" Visible="False" AppendDataBoundItems="True" AutoPostBack="True" DataSourceID="SqlDataSource4">
                <asp:ListItem Value="0">請選擇</asp:ListItem>
            </asp:DropDownList>
            <br />
            <asp:SqlDataSource ID="SqlDataSource4" runat="server" ConnectionString="<%$ ConnectionStrings:MENU %>">
            </asp:SqlDataSource>
            <asp:TextBox ID="pay2text1" runat="server" Width="195px"></asp:TextBox>
            <br />
            <asp:Label ID="Label18" runat="server" ForeColor="Red"></asp:Label>
            <br />
            支付銀行資料(若支付對象為自己可留空)<asp:Label ID="Label16" runat="server" Text="Label" Visible="False"></asp:Label>
            <br />
            <asp:TextBox ID="pay2text2" runat="server"></asp:TextBox>
            <asp:DropDownList ID="pay2drp2" runat="server" AppendDataBoundItems="True" AutoPostBack="True" DataSourceID="SqlDataSource5" DataTextField="b_ne" DataValueField="ac_no" OnSelectedIndexChanged="pay2drp2_SelectedIndexChanged" Visible="False" Width="200px">
                <asp:ListItem>請選擇銀行</asp:ListItem>
            </asp:DropDownList>
            <asp:SqlDataSource ID="SqlDataSource5" runat="server" ConnectionString="<%$ ConnectionStrings:MENU %>" SelectCommand="SELECT * FROM [buy38] WHERE ([sup_no] = @sup_no)">
                <SelectParameters>
                    <asp:ControlParameter ControlID="Label16" Name="sup_no" PropertyName="Text" Type="String" />
                </SelectParameters>
            </asp:SqlDataSource>
            <br />
            <br />
            幣別：<asp:DropDownList ID="DropDownList6" runat="server" AutoPostBack="True" Height="20px" OnSelectedIndexChanged="DropDownList6_SelectedIndexChanged" Width="100px">
                <asp:ListItem Value="NTD">新台幣</asp:ListItem>
                <asp:ListItem Value="RMB">人民幣</asp:ListItem>
                <asp:ListItem Value="JPY">日圓</asp:ListItem>
                <asp:ListItem Value="USD">美金</asp:ListItem>
                <asp:ListItem Value="HKD">港幣</asp:ListItem>
            </asp:DropDownList>
            <asp:Label ID="Label11" runat="server" ForeColor="Red" Text=""></asp:Label>
            ，金融機構代號：<asp:Label ID="Label12" runat="server" ForeColor="Red" Text=""></asp:Label>
            <asp:Label ID="Label12b" runat="server" ForeColor="Red"></asp:Label>
            ，帳號：<asp:Label ID="Label13" runat="server" ForeColor="Red" Text=""></asp:Label>
            ，戶名：<asp:Label ID="Label14" runat="server" ForeColor="Red" Text=""></asp:Label>
            ，收費別：<asp:Label ID="Label15" runat="server" ForeColor="Red" Text=""></asp:Label>
            <br />
            付款日期<br />
            <asp:TextBox ID="pay2text3" runat="server"></asp:TextBox><img align="middle" alt="" style="margin: 0 auto;" onclick="popUpCalendar(this, document.getElementById('<%= pay2text3.ClientID %>'), 'yyyy/mm/dd')" src="<%=ResolveUrl("~/img/calendar.gif") %>" />
            (YYYY/MM/DD 空白預設為下週四)<br />
            <asp:Label ID="Label20" runat="server" ForeColor="Red" Text="付款日期遇假日順延(部分廠商除外)，請款單將顯示調整後的日期"></asp:Label>
            <br />
            請款說明<br />
             
            <asp:TextBox ID="pay2text4" runat="server" Width="315px"></asp:TextBox>
            <br />
            付款方式<br />
            <asp:RadioButtonList ID="RadioButtonList2" runat="server" RepeatDirection="Horizontal" AutoPostBack="True" OnSelectedIndexChanged="RadioButtonList2_SelectedIndexChanged">
                <asp:ListItem Selected="True">匯款</asp:ListItem>
                <asp:ListItem>現金</asp:ListItem>
                <asp:ListItem>支票</asp:ListItem>
                <asp:ListItem>L.C.</asp:ListItem>
            </asp:RadioButtonList>
            <asp:Panel ID="Panel6" runat="server">
                匯費<asp:RadioButtonList ID="RadioButtonList3" runat="server" RepeatDirection="Horizontal">
                    <asp:ListItem>外加</asp:ListItem>
                    <asp:ListItem Selected="True">內含</asp:ListItem>
                </asp:RadioButtonList>
            </asp:Panel>
            <table style="width: 60%;">
                <tr>
                    <td colspan="2">項目費用列表</td>
                </tr>
                <tr>
                    <td>部門別</td>
                    <td class="auto-style5">項目說明</td>
                    <td class="auto-style6">金額</td>
                </tr>
                <tr>
                    <td class="auto-style6">
                        <asp:DropDownList ID="pay3drop11" runat="server" AppendDataBoundItems="True" DataSourceID="SqlDataSource3" DataTextField="DEPA_NE2" DataValueField="DEPA_NO" Width="95%">
                            <asp:ListItem Selected="True" Value="0">請選擇</asp:ListItem>
                        </asp:DropDownList>
                    </td>
                    <td class="auto-style5">
                        <asp:TextBox ID="pay3text23" runat="server" Width="95%"></asp:TextBox>
                    </td>
                    <td class="auto-style6">
                        <asp:TextBox ID="pay3text24" runat="server" Width="100%"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td class="auto-style6">
                        <asp:DropDownList ID="pay3drop12" runat="server" AppendDataBoundItems="True" DataSourceID="SqlDataSource3" DataTextField="DEPA_NE2" DataValueField="DEPA_NO" Width="95%">
                            <asp:ListItem Selected="True" Value="0">請選擇</asp:ListItem>
                        </asp:DropDownList>
                    </td>
                    <td class="auto-style5">
                        <asp:TextBox ID="pay3text25" runat="server" Width="95%"></asp:TextBox>
                    </td>
                    <td class="auto-style6">
                        <asp:TextBox ID="pay3text26" runat="server" Width="100%"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td class="auto-style6">
                        <asp:DropDownList ID="pay3drop13" runat="server" AppendDataBoundItems="True" DataSourceID="SqlDataSource3" DataTextField="DEPA_NE2" DataValueField="DEPA_NO" Width="95%">
                            <asp:ListItem Selected="True" Value="0">請選擇</asp:ListItem>
                        </asp:DropDownList>
                    </td>
                    <td class="auto-style5">
                        <asp:TextBox ID="pay3text27" runat="server" Width="95%"></asp:TextBox>
                    </td>
                    <td class="auto-style6">
                        <asp:TextBox ID="pay3text28" runat="server" Width="100%"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td class="auto-style6">
                        <asp:DropDownList ID="pay3drop14" runat="server" AppendDataBoundItems="True" DataSourceID="SqlDataSource3" DataTextField="DEPA_NE2" DataValueField="DEPA_NO" Width="95%">
                            <asp:ListItem Selected="True" Value="0">請選擇</asp:ListItem>
                        </asp:DropDownList>
                    </td>
                    <td class="auto-style5">
                        <asp:TextBox ID="pay3text29" runat="server" Width="95%"></asp:TextBox>
                    </td>
                    <td class="auto-style6">
                        <asp:TextBox ID="pay3text30" runat="server" Width="100%"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td class="auto-style6">
                        <asp:DropDownList ID="pay3drop15" runat="server" AppendDataBoundItems="True" DataSourceID="SqlDataSource3" DataTextField="DEPA_NE2" DataValueField="DEPA_NO" Width="95%">
                            <asp:ListItem Selected="True" Value="0">請選擇</asp:ListItem>
                        </asp:DropDownList>
                    </td>
                    <td class="auto-style5">
                        <asp:TextBox ID="pay3text31" runat="server" Width="95%"></asp:TextBox>
                    </td>
                    <td class="auto-style6">
                        <asp:TextBox ID="pay3text32" runat="server" Width="100%"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td class="auto-style6">
                        <asp:DropDownList ID="pay3drop16" runat="server" AppendDataBoundItems="True" DataSourceID="SqlDataSource3" DataTextField="DEPA_NE2" DataValueField="DEPA_NO" Width="95%">
                            <asp:ListItem Selected="True" Value="0">請選擇</asp:ListItem>
                        </asp:DropDownList>
                    </td>
                    <td class="auto-style5">
                        <asp:TextBox ID="pay3text33" runat="server" Width="95%"></asp:TextBox>
                    </td>
                    <td class="auto-style6">
                        <asp:TextBox ID="pay3text34" runat="server" Width="100%"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td class="auto-style6">
                        <asp:DropDownList ID="pay3drop17" runat="server" AppendDataBoundItems="True" DataSourceID="SqlDataSource3" DataTextField="DEPA_NE2" DataValueField="DEPA_NO" Width="95%">
                            <asp:ListItem Selected="True" Value="0">請選擇</asp:ListItem>
                        </asp:DropDownList>
                    </td>
                    <td class="auto-style5">
                        <asp:TextBox ID="pay3text35" runat="server" Width="95%"></asp:TextBox>
                    </td>
                    <td class="auto-style6">
                        <asp:TextBox ID="pay3text36" runat="server" Width="100%"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td class="auto-style6">
                        <asp:DropDownList ID="pay3drop18" runat="server" AppendDataBoundItems="True" DataSourceID="SqlDataSource3" DataTextField="DEPA_NE2" DataValueField="DEPA_NO" Width="95%">
                            <asp:ListItem Selected="True" Value="0">請選擇</asp:ListItem>
                        </asp:DropDownList>
                    </td>
                    <td class="auto-style5">
                        <asp:TextBox ID="pay3text37" runat="server" Width="95%"></asp:TextBox>
                    </td>
                    <td class="auto-style6">
                        <asp:TextBox ID="pay3text38" runat="server" Width="100%"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td class="auto-style6">
                        <asp:DropDownList ID="pay3drop19" runat="server" AppendDataBoundItems="True" DataSourceID="SqlDataSource3" DataTextField="DEPA_NE2" DataValueField="DEPA_NO" Width="95%">
                            <asp:ListItem Selected="True" Value="0">請選擇</asp:ListItem>
                        </asp:DropDownList>
                    </td>
                    <td class="auto-style5">
                        <asp:TextBox ID="pay3text39" runat="server" Width="95%"></asp:TextBox>
                    </td>
                    <td class="auto-style6">
                        <asp:TextBox ID="pay3text40" runat="server" Width="100%"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td class="auto-style6">
                        <asp:DropDownList ID="pay3drop20" runat="server" AppendDataBoundItems="True" DataSourceID="SqlDataSource3" DataTextField="DEPA_NE2" DataValueField="DEPA_NO" Width="95%">
                            <asp:ListItem Selected="True" Value="0">請選擇</asp:ListItem>
                        </asp:DropDownList>
                    </td>
                    <td class="auto-style5">
                        <asp:TextBox ID="pay3text41" runat="server" Width="95%"></asp:TextBox>
                    </td>
                    <td class="auto-style6">
                        <asp:TextBox ID="pay3text42" runat="server" Width="100%"></asp:TextBox>
                    </td>
                </tr>
            </table>
            <br />
            <%-- <table style="width: 60%;">
                <tr>
                    <td colspan="2" style="text-align: center">項目費用列表</td>
                </tr>
                <tr>
                    <td class="auto-style5">說明</td>
                    <td>金額</td>
                </tr>
                <tr>
                    <td class="auto-style5">
                        <asp:TextBox ID="pay2text5" runat="server" Width="95%"></asp:TextBox>
                    </td>
                    <td>
                        <asp:TextBox ID="pay2text6" runat="server" Width="100%"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td class="auto-style5">
                        <asp:TextBox ID="pay2text7" runat="server" Width="95%"></asp:TextBox>
                    </td>
                    <td>
                        <asp:TextBox ID="pay2text8" runat="server" Width="100%"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td class="auto-style5">
                        <asp:TextBox ID="pay2text9" runat="server" Width="95%"></asp:TextBox>
                    </td>
                    <td>
                        <asp:TextBox ID="pay2text10" runat="server" Width="100%"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td class="auto-style5">
                        <asp:TextBox ID="pay2text11" runat="server" Width="95%"></asp:TextBox>
                    </td>
                    <td>
                        <asp:TextBox ID="pay2text12" runat="server" Width="100%"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td class="auto-style5">
                        <asp:TextBox ID="pay2text13" runat="server" Width="95%"></asp:TextBox>
                    </td>
                    <td>
                        <asp:TextBox ID="pay2text14" runat="server" Width="100%"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td class="auto-style5">
                        <asp:TextBox ID="pay2text15" runat="server" Width="95%"></asp:TextBox>
                    </td>
                    <td>
                        <asp:TextBox ID="pay2text16" runat="server" Width="100%"></asp:TextBox>
                    </td>
                </tr>
            </table>--%>

            <asp:Button ID="Button2" runat="server" CssClass="btn btn-success " Text="送出並列印表單" OnClick="Button2_Click" />
            <br />
            <br />

        </asp:Panel>
        <asp:Panel ID="Panel3" runat="server" Visible="False">
            支付項目種類<br />
            <asp:DropDownList ID="DropDownList2" runat="server" Height="35px" Width="200px">
                <asp:ListItem Value="0">一般費用報支(含預付/暫付)</asp:ListItem>
                <asp:ListItem Value="1">交際費、請採購(單筆)</asp:ListItem>
                <asp:ListItem Value="2">資材採購(原材料+訂單)</asp:ListItem>
                <asp:ListItem Value="3">資材採購(原材料+無訂單)</asp:ListItem>
                <asp:ListItem Value="4">雜項購置及修繕工程</asp:ListItem>
                <asp:ListItem Value="5">資訊設備採購</asp:ListItem>
                <asp:ListItem Value="6">外包加工</asp:ListItem>
                 <asp:ListItem Value="7">定期性費用</asp:ListItem>
            </asp:DropDownList>
            <br />
            支付對象<br /> 
            <asp:TextBox ID="TextBox3" runat="server" placeholder="請輸入支付對象關鍵字" OnTextChanged="TextBox3_TextChanged" AutoPostBack="True" ></asp:TextBox>
            <asp:DropDownList ID="DropDownList3" runat="server" Height="35px" Width="200px" DataSourceID="SqlDataSource2" DataTextField="SUP_NE2" DataValueField="SUP_NO" AutoPostBack="True" OnSelectedIndexChanged="DropDownList3_SelectedIndexChanged" AppendDataBoundItems="True">
                <asp:ListItem Value="0">請選擇</asp:ListItem>
            </asp:DropDownList>
            <br />
            <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:MENU %>" >
                <SelectParameters>
                </SelectParameters>
            </asp:SqlDataSource>
            <br />
            月結資料：<asp:Label ID="Label3" runat="server" ForeColor="Red" Text="未選擇"></asp:Label>

            <asp:Label ID="monthdata1" runat="server" Text="Label" Visible="False"></asp:Label>
            <asp:Label ID="monthdata2" runat="server" Text="Label" Visible="False"></asp:Label>
            <asp:Label ID="monthdata3" runat="server" Text="Label" Visible="False"></asp:Label>
            <asp:Label ID="monthdata4" runat="server" Text="Label" Visible="False"></asp:Label>
            <br />
            支付銀行資料<asp:Label ID="Label17" runat="server" Text="Label" Visible="False"></asp:Label>
            <br />
            <asp:DropDownList ID="DropDownList4" runat="server" Height="35px" Width="200px" Visible="False">
                <asp:ListItem>銀行A</asp:ListItem>
                <asp:ListItem>銀行B</asp:ListItem>
            </asp:DropDownList>
            <asp:TextBox ID="pay3textbank" runat="server" Width="190px"></asp:TextBox>
            <asp:DropDownList ID="pay3drpbank" runat="server" AppendDataBoundItems="True" AutoPostBack="True" DataSourceID="SqlDataSource6" DataTextField="b_ne" DataValueField="ac_no" OnSelectedIndexChanged="pay3drpbank_SelectedIndexChanged" Visible="False" Width="200px">
                <asp:ListItem>請選擇銀行</asp:ListItem>
            </asp:DropDownList>
            <asp:SqlDataSource ID="SqlDataSource6" runat="server" ConnectionString="<%$ ConnectionStrings:MENU %>" SelectCommand="SELECT * FROM [buy38] WHERE ([sup_no] = @sup_no)">
                <SelectParameters>
                    <asp:ControlParameter ControlID="Label17" Name="sup_no" PropertyName="Text" Type="String" />
                </SelectParameters>
            </asp:SqlDataSource>
            <br />
            幣別：<asp:Label ID="Label6" runat="server" ForeColor="Red" Text=""></asp:Label>
            ，金融機構代號：<asp:Label ID="Label7" runat="server" ForeColor="Red" Text=""></asp:Label>
            <asp:Label ID="Label7b" runat="server" ForeColor="Red"></asp:Label>
            ，帳號：<asp:Label ID="Label8" runat="server" ForeColor="Red" Text=""></asp:Label>
            ，戶名：<asp:Label ID="Label9" runat="server" ForeColor="Red" Text=""></asp:Label>
            ，收費別：<asp:Label ID="Label10" runat="server" ForeColor="Red" Text=""></asp:Label>
            <br />

            帳款歸屬日期(為判斷結帳日期，請確實填入)<br />
            <asp:TextBox ID="pay3text1" runat="server"></asp:TextBox><img align="middle" alt="" style="margin: 0 auto;" onclick="popUpCalendar(this, document.getElementById('<%= pay3text1.ClientID %>'), 'yyyy/mm/dd')" src="<%=ResolveUrl("~/img/calendar.gif") %>" />
            (YYYY/MM/DD 空白預設為今日)<br />
            請款說明<br />
             
            <asp:TextBox ID="pay3text2" runat="server" Width="315px"></asp:TextBox>
            <br />
            付款方式<br />
            <asp:RadioButtonList ID="RadioButtonList4" runat="server" Height="20px" RepeatDirection="Horizontal" Width="187px" AutoPostBack="True" OnSelectedIndexChanged="RadioButtonList4_SelectedIndexChanged">
                <asp:ListItem Selected="True">匯款</asp:ListItem>
                <asp:ListItem>現金</asp:ListItem>
                <asp:ListItem>支票</asp:ListItem>
                <asp:ListItem>L.C.</asp:ListItem>
            </asp:RadioButtonList>
            <asp:RadioButtonList ID="RadioButtonList6" runat="server" RepeatDirection="Horizontal" Visible="False">
                <asp:ListItem Selected="True">當月結</asp:ListItem>
                <asp:ListItem>次月結</asp:ListItem>
            </asp:RadioButtonList>
            <asp:Panel ID="Panel7" runat="server">
                匯費<asp:RadioButtonList ID="RadioButtonList5" runat="server" RepeatDirection="Horizontal">
                    <asp:ListItem>外加</asp:ListItem>
                    <asp:ListItem Selected="True">內含</asp:ListItem>
                </asp:RadioButtonList>
            </asp:Panel>
            <asp:Button ID="Button4" runat="server" CssClass="btn btn-primary btn-xs" OnClick="Button4_Click" Text="預覽付款日期" />
            <asp:Label ID="Label4" runat="server"></asp:Label>
            <br />
            <asp:Label ID="Label19" runat="server" ForeColor="Red" Text="付款日期遇假日順延(部分廠商除外)，請款單將顯示調整後的日期"></asp:Label>
            <br />
            <table style="width: 60%;">
                <tr>
                    <td colspan="2">項目費用列表</td>
                </tr>
                <tr>
                    <td>部門別</td>
                    <td class="auto-style5">項目說明</td>
                    <td class="auto-style6">金額</td>
                </tr>
                <tr>
                    <td class="auto-style6">
                        <asp:DropDownList ID="pay3drop1" runat="server" Width="95%" DataSourceID="SqlDataSource3" DataTextField="DEPA_NE2" DataValueField="DEPA_NO" AppendDataBoundItems="True">
                            <asp:ListItem Selected="True" Value="0">請選擇</asp:ListItem>
                        </asp:DropDownList>
                    </td>
                    <td class="auto-style5">
                        <asp:TextBox ID="pay3text3" runat="server" Width="95%"></asp:TextBox>
                    </td>
                    <td class="auto-style6">
                        <asp:TextBox ID="pay3text4" runat="server" Width="100%"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td class="auto-style6">
                        <asp:DropDownList ID="pay3drop2" runat="server" Width="95%" DataSourceID="SqlDataSource3" DataTextField="DEPA_NE2" DataValueField="DEPA_NO" AppendDataBoundItems="True">
                            <asp:ListItem Selected="True" Value="0">請選擇</asp:ListItem>
                        </asp:DropDownList>
                    </td>
                    <td class="auto-style5">
                        <asp:TextBox ID="pay3text5" runat="server" Width="95%"></asp:TextBox>
                    </td>
                    <td class="auto-style6">
                        <asp:TextBox ID="pay3text6" runat="server" Width="100%"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td class="auto-style6">
                        <asp:DropDownList ID="pay3drop3" runat="server" Width="95%" DataSourceID="SqlDataSource3" DataTextField="DEPA_NE2" DataValueField="DEPA_NO" AppendDataBoundItems="True">
                            <asp:ListItem Selected="True" Value="0">請選擇</asp:ListItem>
                        </asp:DropDownList>
                    </td>
                    <td class="auto-style5">
                        <asp:TextBox ID="pay3text7" runat="server" Width="95%"></asp:TextBox>
                    </td>
                    <td class="auto-style6">
                        <asp:TextBox ID="pay3text8" runat="server" Width="100%"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td class="auto-style6">
                        <asp:DropDownList ID="pay3drop4" runat="server" Width="95%" DataSourceID="SqlDataSource3" DataTextField="DEPA_NE2" DataValueField="DEPA_NO" AppendDataBoundItems="True">
                            <asp:ListItem Selected="True" Value="0">請選擇</asp:ListItem>
                        </asp:DropDownList>
                    </td>
                    <td class="auto-style5">
                        <asp:TextBox ID="pay3text9" runat="server" Width="95%"></asp:TextBox>
                    </td>
                    <td class="auto-style6">
                        <asp:TextBox ID="pay3text10" runat="server" Width="100%"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td class="auto-style6">
                        <asp:DropDownList ID="pay3drop5" runat="server" Width="95%" DataSourceID="SqlDataSource3" DataTextField="DEPA_NE2" DataValueField="DEPA_NO" AppendDataBoundItems="True">
                            <asp:ListItem Selected="True" Value="0">請選擇</asp:ListItem>
                        </asp:DropDownList>
                    </td>
                    <td class="auto-style5">
                        <asp:TextBox ID="pay3text11" runat="server" Width="95%"></asp:TextBox>
                    </td>
                    <td class="auto-style6">
                        <asp:TextBox ID="pay3text12" runat="server" Width="100%"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td class="auto-style6">
                        <asp:DropDownList ID="pay3drop6" runat="server" Width="95%" DataSourceID="SqlDataSource3" DataTextField="DEPA_NE2" DataValueField="DEPA_NO" AppendDataBoundItems="True">
                            <asp:ListItem Selected="True" Value="0">請選擇</asp:ListItem>
                        </asp:DropDownList>
                    </td>
                    <td class="auto-style5">
                        <asp:TextBox ID="pay3text13" runat="server" Width="95%"></asp:TextBox>
                    </td>
                    <td class="auto-style6">
                        <asp:TextBox ID="pay3text14" runat="server" Width="100%"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td class="auto-style6">
                        <asp:DropDownList ID="pay3drop7" runat="server" Width="95%" DataSourceID="SqlDataSource3" DataTextField="DEPA_NE2" DataValueField="DEPA_NO" AppendDataBoundItems="True">
                            <asp:ListItem Selected="True" Value="0">請選擇</asp:ListItem>
                        </asp:DropDownList>
                    </td>
                    <td class="auto-style5">
                        <asp:TextBox ID="pay3text15" runat="server" Width="95%"></asp:TextBox>
                    </td>
                    <td class="auto-style6">
                        <asp:TextBox ID="pay3text16" runat="server" Width="100%"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td class="auto-style6">
                        <asp:DropDownList ID="pay3drop8" runat="server" Width="95%" DataSourceID="SqlDataSource3" DataTextField="DEPA_NE2" DataValueField="DEPA_NO" AppendDataBoundItems="True">
                            <asp:ListItem Selected="True" Value="0">請選擇</asp:ListItem>
                        </asp:DropDownList>
                    </td>
                    <td class="auto-style5">
                        <asp:TextBox ID="pay3text17" runat="server" Width="95%"></asp:TextBox>
                    </td>
                    <td class="auto-style6">
                        <asp:TextBox ID="pay3text18" runat="server" Width="100%"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td class="auto-style6">
                        <asp:DropDownList ID="pay3drop9" runat="server" Width="95%" DataSourceID="SqlDataSource3" DataTextField="DEPA_NE2" DataValueField="DEPA_NO" AppendDataBoundItems="True">
                            <asp:ListItem Selected="True" Value="0">請選擇</asp:ListItem>
                        </asp:DropDownList>
                    </td>
                    <td class="auto-style5">
                        <asp:TextBox ID="pay3text19" runat="server" Width="95%"></asp:TextBox>
                    </td>
                    <td class="auto-style6">
                        <asp:TextBox ID="pay3text20" runat="server" Width="100%"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td class="auto-style6">
                        <asp:DropDownList ID="pay3drop10" runat="server" Width="95%" DataSourceID="SqlDataSource3" DataTextField="DEPA_NE2" DataValueField="DEPA_NO" AppendDataBoundItems="True">
                            <asp:ListItem Selected="True" Value="0">請選擇</asp:ListItem>
                        </asp:DropDownList>
                    </td>
                    <td class="auto-style5">
                        <asp:TextBox ID="pay3text21" runat="server" Width="95%"></asp:TextBox>
                    </td>
                    <td class="auto-style6">
                        <asp:TextBox ID="pay3text22" runat="server" Width="100%"></asp:TextBox>
                    </td>
                </tr>
            </table>
            <asp:Button ID="Button3" runat="server" CssClass="btn btn-success " OnClick="Button3_Click" Text="送出並列印表單" Visible="False" />
            <asp:Button ID="Button5" runat="server" CssClass="btn btn-success " OnClick="Button5_Click" Text="送出並列印表單" />
            <br />

        </asp:Panel>
        <%--        <h2>請款記錄查詢</h2>
        <br />
        申請員工：<asp:TextBox ID="TextBox3" runat="server"></asp:TextBox>
        <asp:Label ID="Label22" runat="server" Text="%%" Visible="False"></asp:Label>
                ｜日期區間：<asp:TextBox ID="TextBox1" runat="server" TextMode="Date"></asp:TextBox>
        到<asp:TextBox ID="TextBox2" runat="server" TextMode="Date"></asp:TextBox>
        <br />
        核決狀況： 
        <asp:CheckBoxList ID="CheckBoxList1" runat="server" RepeatDirection="Horizontal">
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
                <asp:HyperLinkField DataNavigateUrlFields="id" DataNavigateUrlFormatString="Paydetail.aspx?pid={0}" DataTextField="payment" HeaderText="支付總金額" SortExpression="payment" Target="_blank" DataTextFormatString="{0:N0}" />
                <asp:BoundField DataField="formtype" HeaderText="單據類型" SortExpression="formtype" />
                <asp:BoundField DataField="paytype" HeaderText="申請類型" SortExpression="paytype" />
                <asp:BoundField DataField="check" HeaderText="核決狀況" SortExpression="check" />
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
        </asp:GridView>--%>
        <%-- <asp:SqlDataSource ID="SqlDataSource5" runat="server" ConnectionString="<%$ ConnectionStrings:MENU %>" SelectCommand="SELECT * FROM [TB_Payment] WHERE (([createdate] &gt;= @createdate) AND ([createdate] &lt;= @createdate2)) and (([formtype]=@formtype1) or([formtype]=@formtype2) or([formtype]=@formtype3))and(([check]=@check1)  or([check]=@check2)  or([check]=@check3)) and ([emp_cne] like @emp_cne)ORDER BY [id] DESC">
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
        </asp:SqlDataSource>--%>
        <br />

        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="emp_no" DataSourceID="SqlDataSource1" Visible="False">
            <Columns>
                <asp:BoundField DataField="emp_no" HeaderText="emp_no" ReadOnly="True" SortExpression="emp_no" />
                <asp:BoundField DataField="emp_cne" HeaderText="emp_cne" SortExpression="emp_cne" />
                <asp:BoundField DataField="DEPA_NE1" HeaderText="DEPA_NE1" SortExpression="DEPA_NE1" />
                <asp:BoundField DataField="DEPA_NO" HeaderText="DEPA_NO" SortExpression="DEPA_NO" />
            </Columns>
        </asp:GridView>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:MENU %>" SelectCommand="SELECT * FROM [chuck06] WHERE ([emp_no] = @emp_no)">
            <SelectParameters>
                <asp:ControlParameter ControlID="Labuserid" Name="emp_no" PropertyName="Text" Type="String" />
            </SelectParameters>
        </asp:SqlDataSource>
        <asp:Label ID="Labuserid" runat="server" Visible="False"></asp:Label>
        <hr />
        <br />
        <asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:MENU %>" SelectCommand="SELECT [DEPA_NE2], [DEPA_NO] FROM [TB_PayDeptList]" OnSelecting="SqlDataSource3_Selecting"></asp:SqlDataSource>
        <asp:TextBox ID="TextBox1" runat="server" AutoPostBack="True" OnTextChanged="TextBox1_TextChanged" Visible="False"></asp:TextBox>
        <br />
        <br />
    </div>
    <div class="col-md-1">
    </div>
</asp:Content>
