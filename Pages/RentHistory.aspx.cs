using JuicERP.DAL;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace JuicERP.Pages
{
    public partial class RentHistory : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {            //登入檢查
            if (!IsPostBack)
            {
                if (User.Identity.IsAuthenticated)
                {
                    // 正確登入
                }
                else
                {
                    string strJS = "alert('瀏覽此頁面需先登入');location.href = ('JuicWMS2.aspx');";
                    Page.ClientScript.RegisterStartupScript(this.GetType(), "", strJS, true);
                    // 違法登入！！！！
                }
            }
            //-------------------------------------------------------------------------------------
            Label1.Text = User.Identity.Name.ToString();
        }

        protected void GridView3_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "cancel")
            {
                DateTime endtime = DateTime.Parse(e.CommandArgument.ToString().Split(new string[] { ",," }, StringSplitOptions.RemoveEmptyEntries)[1].Trim());
                //超過三天的租借記錄無法取消
                if (DateTime.Now.AddDays(-3) < endtime)
                {
                    JuicDao dao = new JuicDao("MENU");

                    dao.DeleteConferenceroom(e.CommandArgument.ToString().Split(new string[] { ",," }, StringSplitOptions.RemoveEmptyEntries)[0].Trim());

                    Label2.Text = "已取消此租借";
                }
                else
                {
                    Label2.Text = "超過三天之租借記錄無法取消";
                }

            }
        }

        protected void GridView2_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "cancel")
            {
               string gotoYN = e.CommandArgument.ToString().Split(new string[] { ",," }, StringSplitOptions.RemoveEmptyEntries)[1].Trim();
                //已出發之公務車無法取消
                if (gotoYN == "N")
                {
                    JuicDao dao = new JuicDao("MENU");

                    dao.DeleteCarrent(e.CommandArgument.ToString().Split(new string[] { ",," }, StringSplitOptions.RemoveEmptyEntries)[0].Trim());

                    Label3.Text = "已取消此租借";
                }
                else
                {
                    Label3.Text = "已出發之公務車無法取消";
                }

            }
        }
    }
}