<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="JuicERP.Login" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>登入畫面</title>
    <link href="css/bootstrap.min.css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">
        <div style="text-align: center;">
            <div style="width: 400px; margin-left: auto; margin-right: auto;">
                <img alt="" src="img/logo.png" style="width: 409px; height: 50px" /><br />
            </div>
            <div style="width: 400px; margin-left: auto; margin-right: auto;">
                <asp:Login ID="Login1" runat="server" DisplayRememberMe="False"
                    OnAuthenticate="Login1_Authenticate" TitleText="">
   
                    
                </asp:Login>               
                 
            </div>
        </div>
    </form>
</body>
</html>
