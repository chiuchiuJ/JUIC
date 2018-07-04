<%@ Page Title="" Language="C#" MasterPageFile="~/Master/JuicERP.Master" AutoEventWireup="true" CodeBehind="Signupadd.aspx.cs" Inherits="JuicERP.Pages.Signupadd" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">
        .fileUpload {
            position: relative;
            overflow: hidden;
            margin: 10px;
        }

            .fileUpload input.upload {
                position: absolute;
                top: 0;
                right: 0;
                margin: 0;
                padding: 0;
                font-size: 20px;
                cursor: pointer;
                opacity: 0;
                filter: alpha(opacity=0);
            }
    </style>
    <script>var imgDir = '<%=ResolveUrl("~/img") %>' + "/";	</script>
    <script src="<%=ResolveUrl("~/js/popcalendar.js") %>" charset="UTF-8"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">


    <div class="col-md-2"></div>
    <div class="col-md-8">
        <div class="list-group">
            <a class="list-group-item active">
                <div style="text-align: center; font-family: 微軟正黑體;">新增活動</div>
            </a>
            <a class="list-group-item" style="font-family: 微軟正黑體;">
                <asp:Label ID="Label1" runat="server" Text="活動標題" Width="20%" CssClass="text-center"></asp:Label>
                <asp:TextBox ID="title" runat="server" Width="70%"></asp:TextBox>
            </a>
            <a class="list-group-item" style="font-family: 微軟正黑體;">
                <asp:Label ID="Label7" runat="server" Text="活動日期" Width="20%" CssClass="text-center"></asp:Label>
                <asp:TextBox ID="TextBox3" runat="server" Width="67%" Text="日期格式：2000/01/01"
                    OnFocus="javascript:if(this.value=='日期格式：2000/01/01') {this.value=''}"
                    OnBlur="javascript:if(this.value==''){this.value='日期格式：2000/01/01'}">
                </asp:TextBox>
                <img align="middle" alt="" style="margin: 0 auto;" onclick="popUpCalendar(this, document.getElementById('<%= TextBox3.ClientID %>'), 'yyyy/mm/dd')" src="<%=ResolveUrl("~/img/calendar.gif") %>" />

            </a>
            <a class="list-group-item" style="font-family: 微軟正黑體;">
                <asp:Label ID="Label2" runat="server" Text="活動類別" Width="20%" CssClass="text-center"></asp:Label>
                <asp:DropDownList ID="DropDownList1" runat="server" Width="67%">
                    <asp:ListItem Value="0">請選擇</asp:ListItem>
                    <asp:ListItem Value="1">員工旅行、團體出遊</asp:ListItem>
                    <asp:ListItem Value="2">公司聚餐、休閒活動</asp:ListItem>
                    <asp:ListItem Value="3">課程報名、培訓計畫</asp:ListItem>
                    <asp:ListItem Value="4">其他活動事宜</asp:ListItem>
                </asp:DropDownList>
            </a>
            <a class="list-group-item" style="font-family: 微軟正黑體;">
                <asp:Label ID="Label3" runat="server" Text="活動詳細內容" Width="20%" CssClass="text-center"></asp:Label>
                <asp:TextBox ID="content" runat="server" Width="70%" TextMode="MultiLine" Rows="12"></asp:TextBox>
            </a>
            <a class="list-group-item" style="text-align: center; font-family: 微軟正黑體;">
                <asp:Label ID="Label5" runat="server" Text="報名開始日期" Width="14%"></asp:Label>
                <%--     <asp:TextBox ID="TextBox1" runat="server" Width="35%"></asp:TextBox>--%>
                <asp:TextBox ID="datestart" runat="server" Width="30%" Text="日期格式：2000/01/01"
                    OnFocus="javascript:if(this.value=='日期格式：2000/01/01') {this.value=''}"
                    OnBlur="javascript:if(this.value==''){this.value='日期格式：2000/01/01'}"></asp:TextBox>
                <img align="middle" alt="" style="margin: 0 auto;" onclick="popUpCalendar(this, document.getElementById('<%= datestart.ClientID %>'), 'yyyy/mm/dd')" src="<%=ResolveUrl("~/img/calendar.gif") %>" />&nbsp;~

            <asp:Label ID="Label6" runat="server" Text="報名結束日期" Width="14%"></asp:Label>
                <%--      <asp:TextBox ID="TextBox2" runat="server" Width="35%"></asp:TextBox>--%>
                <asp:TextBox ID="dateend" runat="server" Width="30%" Text="日期格式：2000/01/01"
                    OnFocus="javascript:if(this.value=='日期格式：2000/01/01') {this.value=''}"
                    OnBlur="javascript:if(this.value==''){this.value='日期格式：2000/01/01'}"></asp:TextBox>
                <img align="middle" alt="" style="margin: 0 auto;" onclick="popUpCalendar(this, document.getElementById('<%= dateend.ClientID %>'), 'yyyy/mm/dd')" src="<%=ResolveUrl("~/img/calendar.gif") %>" />

            </a>
            <a class="list-group-item" style="font-family: 微軟正黑體;">

                <asp:CheckBoxList ID="CheckBoxList1" runat="server" RepeatColumns="4" CssClass="text-center" Font-Size="Large" Width="100%" AutoPostBack="True" OnSelectedIndexChanged="CheckBoxList1_SelectedIndexChanged">
                    <asp:ListItem Value="0">開放親友參加</asp:ListItem>
                    <asp:ListItem Value="1">需填寫保險、伙食狀況資料表</asp:ListItem>
                </asp:CheckBoxList>
                <asp:CheckBoxList ID="CheckBoxList2" runat="server" RepeatColumns="4" CssClass="text-center" Font-Size="Large" Width="100%" Visible="False">
                    <asp:ListItem Value="0">提供身分證</asp:ListItem>
                    <asp:ListItem Value="1">提供出生年月日</asp:ListItem>
                    <asp:ListItem Value="2">提供飲食狀況(葷/素)</asp:ListItem>
                    <asp:ListItem Value="3">是否包車</asp:ListItem>
                </asp:CheckBoxList>

            </a>
           <div align="center">
                <div class="fileUpload btn btn-primary" >
                    <span>上傳附件(上限10mb)</span>
                    <asp:FileUpload ID="FileUpload1" runat="server" Font-Names="微軟正黑體" EnableTheming="True" CssClass="upload" onchange=" document.getElementById('div1').innerHTML ='從'+this.value+'上傳檔案'" />
                </div>
                <div id="div1" style="font-size: medium; color: #000080"></div>
          </div>
            <a style="align-items: center">
                <asp:Button ID="Button1" runat="server" Text="送出" CssClass="btn btn-success" Width="49.6%" OnClick="Button1_Click" />
                <asp:Button ID="Button3" runat="server" Text="重設" CssClass="btn btn-warning" Width="49.6%" />
            </a>
            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:MENU %>" SelectCommand="SELECT * FROM [TB_AnnounceBeta]"></asp:SqlDataSource>


        </div>
    </div>
    <div class="col-md-2"></div>


</asp:Content>
