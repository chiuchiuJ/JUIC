using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace JuicERP.Pages
{
    public partial class Misserviceusertest : System.Web.UI.Page
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
            if (User.Identity.Name.ToString() != DetailsView1.Rows[1].Cells[1].Text.Trim())
            {
                string strJS = "alert('僅供申請人編輯');history.go(-1);";
                Page.ClientScript.RegisterStartupScript(this.GetType(), "", strJS, true);
            }
        }

        protected void DetailsView1_ItemUpdated(object sender, DetailsViewUpdatedEventArgs e)
        {
            Response.Redirect("MISservice.aspx");
        }

        protected void DetailsView1_ItemCommand(object sender, DetailsViewCommandEventArgs e)
        {
            if (e.CommandName == "Update")
            {
                //取得哪Row的列索引
                int index = Convert.ToInt32(e.CommandArgument);
                DropDownList drp_testsituation = (DropDownList)DetailsView1.Rows[index].FindControl("drp_testsituation");

                //◆在UpdateParameters 已有Gender 的項目
                SqlDataSource1.UpdateParameters["testsituation"].DefaultValue = drp_testsituation.SelectedValue;
                //◆在UpdateParameters 無 Gender 的項目
                //SqlDataSource1.UpdateParameters.Add("Gender", drp_Gender.SelectedValue);       

                TextBox text_testfeedback = (TextBox)DetailsView1.Rows[index].FindControl("text_testfeedback");
                SqlDataSource1.UpdateParameters["testfeedback"].DefaultValue = text_testfeedback.Text;

                SqlDataSource1.UpdateParameters["enddate2"].DefaultValue = DateTime.Now.ToString();
            }
        }

        protected void DetailsView1_ModeChanged(object sender, EventArgs e)
        {
            Response.Redirect("MISservice.aspx");
        }
    }
}