using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace JuicERP.Pages
{
    public partial class MISservicemanage : System.Web.UI.Page
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
            //設阻擋權限
            //string strJS = "alert('未授權您使用此頁面');history.go(-1);";
            //Page.ClientScript.RegisterStartupScript(this.GetType(), "", strJS, true);

            DAL.JuicDao dao = new DAL.JuicDao("MENU");
            var check = dao.checkcontrol(User.Identity.Name.ToString(), 23);//待新增
            //有管理權限，顯示管理按鈕
            if (check.Rows.Count == 0)
            {
                string strJS = "alert('未授權您使用此頁面');history.go(-1);";
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

                //問題類型更新
                DropDownList drp_cate = (DropDownList)DetailsView1.Rows[index].FindControl("drp_cate");
                //◆在UpdateParameters 已有Gender 的項目
                if (drp_cate.SelectedValue != "")
                {
                    SqlDataSource1.UpdateParameters["category"].DefaultValue = drp_cate.SelectedValue;
                }
                else
                {
                    SqlDataSource1.UpdateParameters["category"].DefaultValue = DetailsView2.Rows[0].Cells[1].Text.Trim();
                }
                //◆在UpdateParameters 無 Gender 的項目
                //SqlDataSource1.UpdateParameters.Add("Gender", drp_Gender.SelectedValue);       

                //問題分類更新
                DropDownList drp_type = (DropDownList)DetailsView1.Rows[index].FindControl("drp_type");
                //◆在UpdateParameters 已有Gender 的項目
                if (drp_type.SelectedValue != "")
                {
                    SqlDataSource1.UpdateParameters["type"].DefaultValue = drp_type.SelectedValue;
                }
                else
                {
                    SqlDataSource1.UpdateParameters["type"].DefaultValue = DetailsView2.Rows[4].Cells[1].Text.Trim();
                }
                //◆在UpdateParameters 無 Gender 的項目
                //SqlDataSource1.UpdateParameters.Add("Gender", drp_Gender.SelectedValue);       

                //問題內容更新
                TextBox text_pro = (TextBox)DetailsView1.Rows[index].FindControl("text_pro");
                SqlDataSource1.UpdateParameters["problem"].DefaultValue = text_pro.Text;
                //問題狀態更新
                DropDownList drp_sit = (DropDownList)DetailsView1.Rows[index].FindControl("drp_sit");
                if (drp_sit.SelectedValue != "")
                {
                    SqlDataSource1.UpdateParameters["situation"].DefaultValue = drp_sit.SelectedValue;
                }
                else
                {
                    SqlDataSource1.UpdateParameters["situation"].DefaultValue = DetailsView2.Rows[1].Cells[1].Text.Trim();
                }

                //測試狀態更新
                DropDownList drp_tsit = (DropDownList)DetailsView1.Rows[index].FindControl("drp_tsit");
                if (drp_tsit.SelectedValue != "")
                {
                    SqlDataSource1.UpdateParameters["testsituation"].DefaultValue = drp_tsit.SelectedValue;
                }
                else if (DetailsView2.Rows[2].Cells[1].Text.Trim() == "&nbsp;")
                {
                    SqlDataSource1.UpdateParameters["testsituation"].DefaultValue = null;
                }
                else
                {
                    SqlDataSource1.UpdateParameters["testsituation"].DefaultValue = DetailsView2.Rows[2].Cells[1].Text.Trim();
                }
                //申請日期更新
                TextBox text_date = (TextBox)DetailsView1.Rows[index].FindControl("text_date");
                SqlDataSource1.UpdateParameters["date"].DefaultValue = text_date.Text;
                //程式完成日期
                TextBox text_enddate1 = (TextBox)DetailsView1.Rows[index].FindControl("text_enddate1");
                SqlDataSource1.UpdateParameters["enddate1"].DefaultValue = text_enddate1.Text;
                //測試
                TextBox text_enddate2 = (TextBox)DetailsView1.Rows[index].FindControl("text_enddate2");
                SqlDataSource1.UpdateParameters["enddate2"].DefaultValue = text_enddate2.Text;
                //實際
                TextBox text_finishdate = (TextBox)DetailsView1.Rows[index].FindControl("text_finishdate");
                SqlDataSource1.UpdateParameters["finishdate"].DefaultValue = text_finishdate.Text;
                //處理狀況/被駐
                TextBox text_PS = (TextBox)DetailsView1.Rows[index].FindControl("text_PS");
                SqlDataSource1.UpdateParameters["PS"].DefaultValue = text_PS.Text;
                //測試回饋
                TextBox text_testfeedback = (TextBox)DetailsView1.Rows[index].FindControl("text_testfeedback");
                SqlDataSource1.UpdateParameters["testfeedback"].DefaultValue = text_testfeedback.Text;
            }
        }

        //protected void DetailsView1_ItemCommand(object sender, DetailsViewCommandEventArgs e)
        //{
        //    if (e.CommandName == "Update")
        //    {
        //        //取得哪Row的列索引
        //        int index = Convert.ToInt32(e.CommandArgument);

        //        //問題類型更新
        //        DropDownList drp_cate = (DropDownList)DetailsView1.Rows[index].FindControl("drp_cate");
        //        //◆在UpdateParameters 已有Gender 的項目
        //        //if(drp_cate.SelectedValue!="")
        //        SqlDataSource1.UpdateParameters["category"].DefaultValue = drp_cate.SelectedValue;
        //        //◆在UpdateParameters 無 Gender 的項目
        //        //SqlDataSource1.UpdateParameters.Add("Gender", drp_Gender.SelectedValue);       

        //        //問題內容更新
        //        TextBox text_pro = (TextBox)DetailsView1.Rows[index].FindControl("text_pro");
        //        SqlDataSource1.UpdateParameters["problem"].DefaultValue = text_pro.Text;
        //        //問題狀態更新
        //        DropDownList drp_sit = (DropDownList)DetailsView1.Rows[index].FindControl("drp_sit");
        //        if (drp_sit.SelectedValue != "")
        //            SqlDataSource1.UpdateParameters["situation"].DefaultValue = drp_sit.SelectedValue;
        //        //測試狀態更新
        //        DropDownList drp_tsit = (DropDownList)DetailsView1.Rows[index].FindControl("drp_tsit");
        //        if (drp_tsit.SelectedValue != "")
        //            SqlDataSource1.UpdateParameters["testsituation"].DefaultValue = drp_tsit.SelectedValue;
        //        //申請日期更新
        //        TextBox text_date = (TextBox)DetailsView1.Rows[index].FindControl("text_date");
        //        SqlDataSource1.UpdateParameters["date"].DefaultValue = text_date.Text;
        //        //程式完成日期
        //        TextBox text_enddate1 = (TextBox)DetailsView1.Rows[index].FindControl("text_enddate1");
        //        SqlDataSource1.UpdateParameters["enddate1"].DefaultValue = text_enddate1.Text;
        //        //測試
        //        TextBox text_enddate2 = (TextBox)DetailsView1.Rows[index].FindControl("text_enddate2");
        //        SqlDataSource1.UpdateParameters["enddate2"].DefaultValue = text_enddate2.Text;
        //        //實際
        //        TextBox text_finishdate = (TextBox)DetailsView1.Rows[index].FindControl("text_finishdate");
        //        SqlDataSource1.UpdateParameters["finishdate"].DefaultValue = text_finishdate.Text;
        //        //處理狀況/被駐
        //        TextBox text_PS = (TextBox)DetailsView1.Rows[index].FindControl("text_PS");
        //        SqlDataSource1.UpdateParameters["PS"].DefaultValue = text_PS.Text;
        //    }
        //}

        protected void DetailsView1_ModeChanged(object sender, EventArgs e)
        {
            Response.Redirect("MISservice.aspx");
        }
    }
}