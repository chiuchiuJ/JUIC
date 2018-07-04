<%@ Page Title="" Language="C#" MasterPageFile="~/Master/JuicERP.Master" AutoEventWireup="true" CodeBehind="AddAnounce.aspx.cs" Inherits="JuicERP.Pages.AddAnounce" %>

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
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="row">
        <div class="col-md-2"></div>
        <div class="col-md-8">
            <div class="list-group">
                <a class="list-group-item active">
                    <div style="text-align: center">新增公告</div>
                </a>
                <a class="list-group-item">
                    <asp:Label ID="Label1" runat="server" Text="公告標題" Width="20%"></asp:Label>
                    <asp:TextBox ID="title" runat="server" Width="70%"></asp:TextBox>
                </a>
                <a class="list-group-item">
                    <asp:Label ID="Label2" runat="server" Text="部門別及作者" Width="20%"></asp:Label>
                    <asp:DropDownList ID="deptlist" runat="server" OnSelectedIndexChanged="deptlist_SelectedIndexChanged" Width="15%" AutoPostBack="True" AppendDataBoundItems="True" DataSourceID="SqlDataSource3" DataTextField="DEPA_NE2" DataValueField="DEPA_NE2">
                        <asp:ListItem>個人</asp:ListItem>
                    </asp:DropDownList>
                    <asp:TextBox ID="dept" runat="server" Visible="False">個人</asp:TextBox>
                    <asp:TextBox ID="author" runat="server" Width="55%" ToolTip="請輸入姓名"></asp:TextBox>
                </a>
                <a class="list-group-item">
                    <asp:Label ID="Label3" runat="server" Text="文章內容" Width="20%"></asp:Label>
                    <asp:TextBox ID="content" runat="server" Width="70%" TextMode="MultiLine" Rows="12"></asp:TextBox>
                </a>
                <a class="list-group-item" style="text-align: center">
                    <%--            <asp:Label ID="Label4" runat="server" Text="附件上傳" Width="20%"></asp:Label>
              
                        <asp:FileUpload ID="FileUpload1" runat="server" Font-Names="微軟正黑體" />

                    --%>
                                <div class="fileUpload btn btn-warning">
                <span>選擇上傳檔案(上限10mb)</span>
                <asp:FileUpload ID="FileUpload1" runat="server" Font-Names="微軟正黑體" EnableTheming="True" CssClass="upload" onchange=" document.getElementById('div1').innerHTML ='從'+this.value+'上傳檔案'" />
            </div><div id="div1" style="font-size: medium; color: #000080"></div>
                </a>
                <a style="align-items: center">
                    <asp:Button ID="Button1" runat="server" Text="送出" CssClass="btn btn-success" Width="49.6%" OnClick="Button1_Click" />
                    <asp:Button ID="Button3" runat="server" Text="重設" CssClass="btn btn-warning" Width="49.6%" OnClick="Button3_Click" />
                </a>
                <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:MENU %>" SelectCommand="SELECT * FROM [TB_AnnounceBeta]"></asp:SqlDataSource>


                <asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:MENU %>" SelectCommand="SELECT [DEPA_NE2], [DEPA_NO] FROM [BAS30]"></asp:SqlDataSource>


            </div>
        </div>
        <div class="col-md-2"></div>
    </div>
    <%--    <script type="text/javascript"><!--
today= new Date()
yudan=(today.getYear()+1900)+" 年 "+(today.getMonth()+1)+" 月 "+today.getDate()+" 日";
window.alert("歡迎光臨魚蛋村\n\n以下是日期資訊：\n今天是 "+yudan);
// --></script>--%>
</asp:Content>
