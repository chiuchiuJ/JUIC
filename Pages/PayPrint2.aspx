<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PayPrint2.aspx.cs" Inherits="JuicERP.Pages.PayPrint2" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style type="text/css">
        .auto-style2 {
            width: 280px;
            height: 30px;
        }
        .auto-style8 {
            width: 114px;
            height: 20px;
        }
        .auto-style11 {
            height: 20px;
        }
        .auto-style13 {
            width: 800px;
        }
        .auto-style20 {
            width: 114px;
        }
        .auto-style21 {
            height: 85px;
        }
        .auto-style22 {
            height: 22px;
        }
        .auto-style23 {
            width: 114px;
            height: 22px;
        }
    *{-webkit-box-sizing:border-box;-moz-box-sizing:border-box;box-sizing:border-box}*,:after,:before{color:#000!important;text-shadow:none!important;background:0 0!important;-webkit-box-shadow:none!important;box-shadow:none!important}input[type=checkbox],input[type=radio]{margin:4px 0 0;margin-top:1px\9;line-height:normal}input[type=checkbox],input[type=radio]{-webkit-box-sizing:border-box;-moz-box-sizing:border-box;box-sizing:border-box;padding:0}button,input,select,textarea{font-family:inherit;font-size:inherit;line-height:inherit}input{line-height:normal}button,input,optgroup,select,textarea{margin:0;font:inherit;color:inherit}label{display:inline-block;max-width:100%;margin-bottom:5px;font-weight:700}
        .auto-style24 {
            height: 20px;
            width: 271px;
        }
        .auto-style25 {
            height: 20px;
            width: 398px;
        }
        .auto-style26 {
            height: 50px;
        }
        .auto-style27 {
            width: 114px;
            height: 16px;
        }
        .auto-style28 {
            height: 16px;
        }
        .auto-style31 {
            /*width: 114px;
            height: 15px;*/
        }
        .auto-style32 {
            height: 12px;
        }
        .auto-style33 {
            width: 114px;
            height: 12px;
        }
    </style>
</head>
<body  style="margin:0px 0px 0px 0px">
    <form id="form1" runat="server" style="width: 800px">
        <asp:Panel ID="Panel2" runat="server">
            <div style="font-family: 標楷體">

                <img class="auto-style2" src="../img/logo.png" /><br />
                <div style="font-size: x-large; text-align: center; font-weight: bold;">
                    請款單<br />
                </div>
                <hr />
                <div style="text-align: right">申請日：<asp:Label ID="Label1" runat="server" Text="Label"></asp:Label></div>
<%--                <table border="1" class="auto-style13">--%>
                 <table border="1" cellpadding="0" cellspacing="0" border-collapse:collaps   class="auto-style13">
                    <tr>
                        <td class="auto-style8" style="text-align: center">支付對象</td>
                        <td class="auto-style11" colspan="4">
                            &nbsp;<asp:Label ID="Label3" runat="server" Text="Label"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td class="auto-style8" style="text-align: center">支付銀行</td>
                        <td class="auto-style11" colspan="4">
                            &nbsp;<asp:Label ID="Label22" runat="server" Text="Label"></asp:Label>
                        </td>
                    </tr>
                       <tr>
                        <td class="auto-style8" style="text-align: center">請款說明</td>
                        <td class="auto-style11" colspan="4">
                            &nbsp;<asp:Label ID="Label20" runat="server" Text="Label"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td class="auto-style20" style="text-align: center">費用部門</td>
                        <td colspan="2" style="text-align: center">請款內容</td>
                        <td class="auto-style20" style="text-align: center">金額</td>
                        <td class="auto-style20" style="text-align: center">備註</td>
                    </tr>
                    <tr>
                        <td class="auto-style20" style="border-bottom-style: none; text-align: center;">
                            <asp:Label ID="labpaydept1" runat="server" Text=""></asp:Label>
                        </td>
                        <td colspan="2" style="border-bottom-style: none">
                            <asp:Label ID="labpay1" runat="server" Text=""></asp:Label>
                        </td>
                        <td class="auto-style20" style="text-align: right; border-bottom-style: none;">
                            <asp:Label ID="labpayment1" runat="server" Text=""></asp:Label>
                        </td>
                        <td class="auto-style20" rowspan="11">
                            
                            <asp:Label ID="Label26" runat="server" Text=""></asp:Label>
                            <br />


                            <asp:Label ID="Label20a" runat="server"></asp:Label>
                            <br />
                                  <asp:Label ID="Label20b" runat="server" Visible="False"></asp:Label>
                            
                            <asp:Label ID="Label27" runat="server" Font-Size="Small">單別</asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td class="auto-style20" style="border-top-style: none; border-bottom-style: none; text-align: center;">
                            <asp:Label ID="labpaydept2" runat="server" Text=""></asp:Label>
                        </td>
                        <td class="auto-style22" colspan="2" style="border-top-style: none; border-bottom-style: none">
                            <asp:Label ID="labpay2" runat="server" Text=""></asp:Label>
                        </td>
                        <td class="auto-style23" style="text-align: right; border-top-style: none; border-bottom-style: none;">
                            <asp:Label ID="labpayment2" runat="server" Text=""></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td class="auto-style20" style="border-top-style: none; border-bottom-style: none; text-align: center;">
                            <asp:Label ID="labpaydept3" runat="server" Text=""></asp:Label>
                        </td>
                        <td class="auto-style11" colspan="2" style="border-top-style: none; border-bottom-style: none">
                            <asp:Label ID="labpay3" runat="server" Text=""></asp:Label>
                        </td>
                        <td class="auto-style8" style="text-align: right; border-top-style: none; border-bottom-style: none;">
                            <asp:Label ID="labpayment3" runat="server" Text=""></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td class="auto-style27" style="border-top-style: none; border-bottom-style: none; text-align: center;">
                            <asp:Label ID="labpaydept4" runat="server" Text=""></asp:Label>
                        </td>
                        <td colspan="2" style="border-top-style: none; border-bottom-style: none" class="auto-style28">
                            <asp:Label ID="labpay4" runat="server" Text=""></asp:Label>
                        </td>
                        <td class="auto-style27" style="text-align: right; border-top-style: none; border-bottom-style: none;">
                            <asp:Label ID="labpayment4" runat="server" Text=""></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td class="auto-style20" style="border-top-style: none; border-bottom-style: none; text-align: center;">
                            <asp:Label ID="labpaydept5" runat="server" Text=""></asp:Label>
                        </td>
                        <td colspan="2" style="border-top-style: none; border-bottom-style: none">
                            <asp:Label ID="labpay5" runat="server" Text=""></asp:Label>
                        </td>
                        <td class="auto-style20" style="text-align: right; border-top-style: none; border-bottom-style: none;">
                            <asp:Label ID="labpayment5" runat="server" Text=""></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td class="auto-style20" style="border-top-style: none; border-bottom-style: none; text-align: center;">
                            <asp:Label ID="labpaydept6" runat="server" Text=""></asp:Label>
                        </td>
                        <td colspan="2" style="border-top-style: none; border-bottom-style: none;">
                            <asp:Label ID="labpay6" runat="server" Text=""></asp:Label>
                        </td>
                        <td class="auto-style20" style="text-align: right; border-top-style: none; border-bottom-style: none;">
                            <asp:Label ID="labpayment6" runat="server" Text=""></asp:Label>
                        </td>
                    </tr>

                    <tr>
                        <td class="auto-style20" style="border-top-style: none; border-bottom-style: none; text-align: center;">
                            <asp:Label ID="labpaydept7" runat="server" Text=""></asp:Label>
                        </td>
                        <td colspan="2" style="border-top-style: none; border-bottom-style: none;">
                            <asp:Label ID="labpay7" runat="server" Text=""></asp:Label>
                        </td>
                        <td class="auto-style20" style="text-align: right; border-top-style: none; border-bottom-style: none;">
                            <asp:Label ID="labpayment7" runat="server" Text=""></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td class="auto-style20" style="border-top-style: none; border-bottom-style: none; text-align: center;">
                            <asp:Label ID="labpaydept8" runat="server" Text=""></asp:Label>
                        </td>
                        <td colspan="2" style="border-top-style: none; border-bottom-style: none;">
                            <asp:Label ID="labpay8" runat="server" Text=""></asp:Label>
                        </td>
                        <td class="auto-style20" style="text-align: right; border-top-style: none; border-bottom-style: none;">
                            <asp:Label ID="labpayment8" runat="server" Text=""></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td class="auto-style20" style="border-top-style: none; border-bottom-style: none; text-align: center;">
                            <asp:Label ID="labpaydept9" runat="server" Text=""></asp:Label>
                        </td>
                        <td colspan="2" style="border-top-style: none; border-bottom-style: none;">
                            <asp:Label ID="labpay9" runat="server" Text=""></asp:Label>
                        </td>
                        <td class="auto-style20" style="text-align: right; border-top-style: none; border-bottom-style: none;">
                            <asp:Label ID="labpayment9" runat="server" Text=""></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td class="auto-style31" style="border-top-style: none; border-bottom-style: none; text-align: center;">
                            <asp:Label ID="labpaydept10" runat="server" Text=""></asp:Label>
                        </td>
                        <td colspan="2" style="border-top-style: none; border-bottom-style: none;" class="auto-style32">
                            <asp:Label ID="labpay10" runat="server" Text=""></asp:Label>
                        </td>
                        <td class="auto-style31" style="text-align: right; border-top-style: none; border-bottom-style: none;">
                            <asp:Label ID="labpayment10" runat="server" Text=""></asp:Label>
                        </td>
                    </tr>
                       <tr>
                        <td class="auto-style20" style="border-top-style: none; border-bottom-style: none; text-align: center;">
                           </td>
                        <td colspan="2" style="border-top-style: none">
                            <asp:Label ID="labpay11" runat="server"></asp:Label>
                        </td>
                        <td class="auto-style31" style="text-align: right; border-top-style: none;">
                            <asp:Label ID="labpayment11" runat="server" Text=""></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="3" style="text-align: center">合&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 計</td>
                        <td class="auto-style20" style="text-align: right">
                            <asp:Label ID="Label25" runat="server" Text="Label"></asp:Label>&nbsp;
                        </td>
                    </tr>
                    <tr>
                        <td class="auto-style20" rowspan="3" style="text-align: center">付款條件</td>
                        <td class="auto-style20" style="text-align: center">付 款 日</td>
                        <td >
                            &nbsp;<asp:Label ID="Label19" runat="server"></asp:Label>
                        </td>
                        <td class="auto-style20" style="text-align: center">出帳銀行</td>
                        <td class="auto-style20" style="text-align: center">領款人簽收</td>
                    </tr>
                    <tr>
                        <td class="auto-style20" style="text-align: center">付款方式</td>
                        <td>
                            <%--<asp:RadioButtonList ID="RadioButtonList2" runat="server" RepeatDirection="Horizontal">
                                <asp:ListItem>匯款</asp:ListItem>
                                <asp:ListItem>現金</asp:ListItem>
                                <asp:ListItem>支票</asp:ListItem>
                                <asp:ListItem>L.C.</asp:ListItem>
                            </asp:RadioButtonList>--%>
                            &nbsp;<asp:Label ID="Label23" runat="server" Text="Label"></asp:Label>
                        </td>
                        <td class="auto-style20" rowspan="2">&nbsp;</td>
                        <td class="auto-style20" rowspan="2">&nbsp;</td>
                    </tr>
                    <tr>
                        <td class="auto-style20" style="text-align: center">匯&nbsp;&nbsp;&nbsp; 費</td>
                        <td >
             <%--               <asp:RadioButtonList ID="RadioButtonList3" runat="server" RepeatDirection="Horizontal">
                                <asp:ListItem>外加</asp:ListItem>
                                <asp:ListItem>內含</asp:ListItem>
                            </asp:RadioButtonList>--%>
                            &nbsp;<asp:Label ID="Label24" runat="server" Text="Label"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td class="auto-style11" colspan="5" style="text-align: center">簽核欄位</td>
                    </tr>
                    <tr>
                        <td class="auto-style21" colspan="5" style="text-align: center">
                            <asp:Label ID="Label21" runat="server" Width="100%"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td class="auto-style26" colspan="5" style="text-align: center">出納：&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 會計 :&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 財務：&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </td>
                    </tr>
                </table>

                <table style="width:100%;">
                    <tr>
                        <td class="auto-style24">Form No: TGS-0013-03(20180516) </td>
                        <td class="auto-style25"></td>
                        <td class="auto-style11">保存期間：7年</td>
                    </tr>
                </table>
                <br />
            </div>
        </asp:Panel>


        <br />


    </form>
</body>
</html>
