using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace JuicERP.Pages
{
    public partial class ManageDept : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
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
            //檢查是否管理部權限
            DAL.JuicDao dao = new DAL.JuicDao("MENU");
            var tb = dao.checkcontrol(User.Identity.Name.ToString(), 28);
            //無新增公告權限 取消按鈕
            if (tb.Rows.Count == 0)
            {
                string strJS = "alert('此頁面僅供具管理部權限者使用');location.href = ('JuicWMS2.aspx');";
                Page.ClientScript.RegisterStartupScript(this.GetType(), "", strJS, true);
            }


            //確認還有幾筆個人資料更新未核可
            var UserdataCheckYN = dao.UserdataCheckYN();
            if (UserdataCheckYN.Rows.Count != 0)
            {
                Label3.Text = "您還有" + UserdataCheckYN.Rows.Count.ToString() + "筆未核可";
            }
            else
            {
                Label3.Text = "尚無待核可資料";
                DropDownList1.Visible = false;
            }
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            JuicERP.DAL.JuicDao dao = new DAL.JuicDao("MENU");


            //更新資料到pay11
            var updateuserdata = dao.UpdateUserdata(DropDownList1.SelectedValue);
            //更新TB_userdata狀態
            var userdataeditor = dao.Userdataeditor(User.Identity.Name.ToString(), DropDownList1.SelectedValue);

            string strJS = "alert('核可成功，請確認ERP資料是否已更新');location.href = ('ManageDept.aspx');";
            Page.ClientScript.RegisterStartupScript(this.GetType(), "", strJS, true);
        }

        protected void DropDownList1_SelectedIndexChanged(object sender, EventArgs e)
        {
            Button1.Visible = true;
            Button2.Visible = true;
            TextBox1.Visible = true;
            Label4.Visible = true;
        }

        protected void Button2_Click(object sender, EventArgs e)
        {
            JuicERP.DAL.JuicDao dao = new DAL.JuicDao("MENU");
            //退件
            var updateuserdata = dao.BkUserdata(TextBox1.Text,DropDownList1.SelectedValue);

            string strJS = "alert('退件成功，請提醒user更正資料');location.href = ('ManageDept.aspx');";
            Page.ClientScript.RegisterStartupScript(this.GetType(), "", strJS, true);
        }
    }
}