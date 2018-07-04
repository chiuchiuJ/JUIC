using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace JuicERP.Pages
{
    public partial class Join : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            //登入檢查
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
            
            DAL.JuicDao dao = new DAL.JuicDao("MENU");

            var getuser = dao.GetUsername(User.Identity.Name.ToString());//待新增
            if (getuser.Rows.Count != 0)
            {
                Label1.Text = getuser.Rows[0]["username"].ToString();

            }

            //-------------------------------------------------------------------------------------
            //檢查是否有瀏覽此頁面全縣

            //string strConn1 = ConfigurationManager.ConnectionStrings["MENU"].ConnectionString;
            //using (SqlConnection conn = new SqlConnection(strConn1))
            //{
            //    String QQ = "select userid from chuckMenuControl where Title='公司活動報名' and userid='" + User.Identity.Name.ToString() + "'";

            //    SqlDataAdapter da = new SqlDataAdapter(QQ, conn);
            //    DataSet ds = new DataSet();
            //    da.Fill(ds);
            //    if (ds.Tables[0].Rows.Count == 0)
            //    {
            //        string strJS = "alert('未授權您使用此頁面');history.go(-1);";
            //        Page.ClientScript.RegisterStartupScript(this.GetType(), "", strJS, true);
            //    }
            //    ds.Clear();
            //}


        }

        protected void gvSIGNUP_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            //點擊按鈕將顯示隱藏的使用者控制項
            if (e.CommandName == "post")
            {
                //Console.Write("OK");
                //Button1.Text = e.CommandArgument.ToString();
                //Button2.Text = "QQ";

                ModalPanel.Visible = true;

                Signup.gettitle(e.CommandArgument.ToString().Split(new string[] { ",," }, StringSplitOptions.RemoveEmptyEntries)[0].Trim());
                Signup.getcontent(e.CommandArgument.ToString().Split(new string[] { ",," }, StringSplitOptions.RemoveEmptyEntries)[1].Trim());
                //Signup.Startdate(e.CommandArgument.ToString().Split(new string[] { ",," }, StringSplitOptions.RemoveEmptyEntries)[2].Trim());
                Signup.Enddate(e.CommandArgument.ToString().Split(new string[] { ",," }, StringSplitOptions.RemoveEmptyEntries)[2].Trim(), e.CommandArgument.ToString().Split(new string[] { ",," }, StringSplitOptions.RemoveEmptyEntries)[3].Trim());
                Signup.Enddate(e.CommandArgument.ToString().Split(new string[] { ",," }, StringSplitOptions.RemoveEmptyEntries)[2].Trim(), e.CommandArgument.ToString().Split(new string[] { ",," }, StringSplitOptions.RemoveEmptyEntries)[3].Trim());
                Signup.Addons1(e.CommandArgument.ToString().Split(new string[] { ",," }, StringSplitOptions.RemoveEmptyEntries)[4].Trim());
                Signup.Addons2(e.CommandArgument.ToString().Split(new string[] { ",," }, StringSplitOptions.RemoveEmptyEntries)[5].Trim());
                Signup.getuser(e.CommandArgument.ToString().Split(new string[] { ",," }, StringSplitOptions.RemoveEmptyEntries)[6].Trim());
                Signup.eventID(e.CommandArgument.ToString().Split(new string[] { ",," }, StringSplitOptions.RemoveEmptyEntries)[7].Trim());
                Signup.getactivedate(e.CommandArgument.ToString().Split(new string[] { ",," }, StringSplitOptions.RemoveEmptyEntries)[8].Trim(), e.CommandArgument.ToString().Split(new string[] { ",," }, StringSplitOptions.RemoveEmptyEntries)[9].Trim());
                              Signup.FileURL(e.CommandArgument.ToString().Split(new string[] { ",," }, StringSplitOptions.RemoveEmptyEntries)[10].Trim());

            }
            if(e.CommandName == "excel")
            {
                string strJS = "location.href = ('../files/signup/活動報名統計表格.xlsx');";
                Page.ClientScript.RegisterStartupScript(this.GetType(), "", strJS, true);
            }
            if (e.CommandName == "remove")
            {
                DAL.JuicDao dao = new DAL.JuicDao("MENU");
                var GetSingupTotalid = dao.GetSingupTotalid(e.CommandArgument.ToString(), User.Identity.Name.ToString());
                string Totalid = "";
                if (GetSingupTotalid.Rows.Count != 0)
                {
                    Totalid = GetSingupTotalid.Rows[0]["ID"].ToString();

                }
                
                dao.RemoveSignup(e.CommandArgument.ToString(), User.Identity.Name.ToString(), Totalid);//待新增

            }
        }

        protected void gvSIGNUP_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            

            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                if (e.Row.Cells[1].Text.Trim() == Label1.Text.Trim())
                {
                    Button btn = (Button)e.Row.FindControl("excel");
                    btn.Visible = true;
                    Button btn1 = (Button)e.Row.FindControl("edit2");
                    btn1.Visible = true;
                    Button btn2 = (Button)e.Row.FindControl("remove");
                    btn2.Visible = true;
                }
            }

                //dbeDataContext db = new dbeDataContext();
                //var c = (from v in db.CAGRIs where v.UserID != Convert.ToInt32(Session["user"]) select v).ToArray();
                //if (c != null)
                //{
                //    foreach (var item in c)
                //    {
                //        if (e.Row.RowType == DataControlRowType.DataRow)
                //        {
                //            int callID = Convert.ToInt32(DataBinder.Eval(e.Row.DataItem, "CagriID"));
                //            if (callID == item.CagriID)
                //            {
                //                e.Row.Enabled = false;
                //                continue;
                //            }
                //        }
                //    }
                //}
            }
    }
}