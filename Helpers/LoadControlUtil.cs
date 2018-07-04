using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
//using System.Web.UI.WebControls;
//using System.Web.UI.HtmlControls;
//using System.Diagnostics;
/// <summary>
/// MessageBox 的摘要描述
/// </summary>
public static class LoadControlUtil // Extension Method
{
    public static void ShowControl(this System.Web.UI.Page page, string dialogID, string titleName)
    {
        ClientScriptManager csm = page.ClientScript;
        string Script = @"
<script type=text/javascript>
var beforeAction = window.onload || function () {{}};
window.onload = function ()
{{
    beforeAction();
    LoadControl('{0}', '{1}', '{2}');
}}
</script>"; // 注意，有經過String.Format的話大括號要重複
        csm.RegisterStartupScript(csm.GetType(), "Show", String.Format(Script, dialogID, titleName, page.ResolveUrl("~/img/closebutton.ico")));
    }

    public static void ShowControl(this System.Web.UI.UpdatePanel udPnl, string dialogID, string titleName)
    {
        string Script = @"LoadControl('{0}', '{1}', '{2}');"; // 注意，有經過String.Format的話大括號要重複
        System.Web.UI.ScriptManager.RegisterClientScriptBlock(udPnl, udPnl.GetType(), "Show", String.Format(Script, dialogID, titleName, udPnl.Page.ResolveUrl("~/img/closebutton.ico")), true);
    }

    public static void Show(this System.Web.UI.UserControl ctl, System.Web.UI.UpdatePanel udPnl, string Message)
    {
        string Script = @"alert('{0}');"; // 注意，有經過String.Format的話大括號要重複
        System.Web.UI.ScriptManager.RegisterClientScriptBlock(udPnl, udPnl.GetType(), "Message", String.Format(Script, Message.Replace("\r\n", "\\n").Replace("'", "\\'").Replace("\"", "\\\"")), true);
    }

    public static void CloseControl(this System.Web.UI.UpdatePanel udPnl, string dialogID)
    {
        string Script = @"CloseControl('{0}');"; // 注意，有經過String.Format的話大括號要重複
        System.Web.UI.ScriptManager.RegisterClientScriptBlock(udPnl, udPnl.GetType(), "Close", String.Format(Script, dialogID), true);
    }

    public static void RunScript(this System.Web.UI.UpdatePanel ctl, string script)
    {
        System.Web.UI.ScriptManager.RegisterClientScriptBlock(ctl, ctl.GetType(), "Scripts", script, true);
    }
}