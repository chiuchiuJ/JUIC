using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace JuicERP.Pages
{
    public partial class EMPWCRegulations : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            DAL.JuicDao dao = new DAL.JuicDao("MENU");
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
                //檢查是否有新增及修改員工福利權限
                var tb2 = dao.checkcontrol(User.Identity.Name.ToString(), 30);
                //無新增及修改員工福利權限 取消按鈕
                if (tb2.Rows.Count == 0)
                {
                    manage.Text = "false";
                }
                if (manage.Text=="true") { Button4.Visible = true; }

                var getuser = dao.GetUsername(User.Identity.Name.ToString());
                if (getuser.Rows.Count != 0)
                {
                    Label1.Text = getuser.Rows[0]["username"].ToString();
                }
                GVgetData();
            }
        }

        protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {  //-- 當 GridView呈現「每一列」資料列（記錄）的時候，才會執行這裡！
               //-- 所以這裡就像迴圈一樣，會反覆執行喔！！

                if (manage.Text == "true")
                {
                    Button btn = (Button)e.Row.FindControl("edit_btn");
                    Button btn2 = (Button)e.Row.FindControl("delete_btn");
                    if (btn != null) { btn.Visible = true; }
                    if (btn2 != null) { btn2.Visible = true; }
                }
            }
        }

        private DataSet getData()
        {
            String connectString = System.Web.Configuration.WebConfigurationManager.ConnectionStrings["MENU"].ConnectionString;
            SqlConnection cn = new SqlConnection(connectString);
            String selectString = @"SELECT [ID]
                                    ,[postdate]
                                    ,[title]
                                    ,[content]
                                    ,[pdfurl]
                                    ,[dept]
                                    ,[author]
                                 FROM [dbo].[TB_PersonalWelfareContent] ";
            SqlCommand cmd = new SqlCommand(selectString, cn);
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataSet ds = new DataSet();
            cn.Open();
            da.Fill(ds);
            cn.Close();
            return ds;
        }

        private void GVgetData()
        {
            DataTable dtBind = getData().Tables[0];
            GridView1.DataSource = dtBind;
            GridView1.DataBind();
            gvSIGNUP.DataSourceID = "SqlDataSource1";
            gvSIGNUP.DataBind();
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            //Response.AddHeader(
            //    "Content-Disposition",
            //string.Format("attachment; filename=001.pdf"));
            //Response.HeaderEncoding = System.Text.Encoding.GetEncoding("big5");
            //Response.AddHeader("Content-Disposition", "inline; filename=職工福利委員會福利管理辦法");
            //Response.ContentType = "Application/PDF";
            ////Response.WriteFile("D:\\PDFfile\\001.pdf");
            //Response.WriteFile("../files/empwc/TE-0010-02職工福利委員會福利管理辦法.pdf");
            //Response.End();
            Response.ContentType = "application/pdf";
            Response.WriteFile(Server.MapPath("../files/empwc/TE-0010-02.pdf"));
            Response.End();
            //Response.Redirect("../files/empwc/TE-0010-02職工福利委員會福利管理辦法.pdf");
            //Response.End();
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
            if (e.CommandName == "excel")
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
                gvSIGNUP.DataBind();
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
        }
        protected void Button2_Click(object sender, EventArgs e)
        {
            Panel1.Visible = false;
            TextBox[] textary = { TextBox1, TextBox2, TextBox3, TextBox4, TextBox5};
            for (int i=0;i< textary.Length; i++)
            {
                textary[i].Text = "";
            }
        }
        protected void Button3_Click(object sender, EventArgs e)
        {
            JuicERP.DAL.JuicDao dao = new DAL.JuicDao("MENU");

            string date = DateTime.Today.ToShortDateString();
            if (TextBox1.Text != "")
            {
                date = TextBox1.Text;
            }
            var tb = dao.InsertWelfare(date,TextBox2.Text , TextBox3.Text, TextBox4.Text, TextBox5.Text);

            string strJS = "alert('新增成功');location.href = ('EMPWCRegulations.aspx');";
            Page.ClientScript.RegisterStartupScript(this.GetType(), "", strJS, true);
        }
        protected void Button4_Click(object sender, EventArgs e)
        {
            if (Panel1.Visible == false)
            {
                Panel1.Visible = true;
            }
            else if (Panel1.Visible == true)
            {
                Panel1.Visible = false;
            }
        }

        //點擊編輯按鈕
        protected void GridView1_RowEditing(object sender, GridViewEditEventArgs e)
        {
            GridView1.EditIndex = e.NewEditIndex;
            GVgetData();
            DataSet ds = getData();
        }

        //點擊取消按鈕
        protected void GridView1_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            GridView1.EditIndex = -1;
            GVgetData();
        }

        //點擊更新按鈕

        protected void GridView1_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            String connectString = System.Web.Configuration.WebConfigurationManager.ConnectionStrings["MENU"].ConnectionString;
            string id = ((Label)GridView1.Rows[e.RowIndex].FindControl("lb_id")).Text.Trim();
            string postdate = ((System.Web.UI.WebControls.TextBox)GridView1.Rows[e.RowIndex].FindControl("txt_postdate")).Text.Trim();
            string title = ((System.Web.UI.WebControls.TextBox)GridView1.Rows[e.RowIndex].FindControl("txt_title")).Text.Trim();
            string content = ((System.Web.UI.WebControls.TextBox)GridView1.Rows[e.RowIndex].FindControl("txt_content")).Text;
            string dept = ((System.Web.UI.WebControls.TextBox)GridView1.Rows[e.RowIndex].FindControl("txt_dept")).Text.Trim();
            string author = ((System.Web.UI.WebControls.TextBox)GridView1.Rows[e.RowIndex].FindControl("txt_author")).Text.Trim();

            String sqlstr = @"UPDATE TB_PersonalWelfarecontent SET
                                postdate=@postdate,
	                            title=@title,
	                            content=@content,
	                            dept=@dept,
	                            author=@author
                            where id=@id";
            SqlConnection cn = new SqlConnection(connectString);
            SqlCommand cmd = new SqlCommand(sqlstr, cn);
            cmd.Parameters.AddWithValue("@postdate", postdate);
            cmd.Parameters.AddWithValue("@title", title);
            cmd.Parameters.AddWithValue("@content", content);
            cmd.Parameters.AddWithValue("@dept", dept);
            cmd.Parameters.AddWithValue("@author", author);
            cmd.Parameters.AddWithValue("@id", id);

            cn.Open();
            cmd.ExecuteNonQuery();
            cn.Close();
            GridView1.EditIndex = -1;
            GVgetData();

        }

        //點擊刪除按鈕
        protected void GridView1_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            String connectString = System.Web.Configuration.WebConfigurationManager.ConnectionStrings["MENU"].ConnectionString;
            String sqlstr = "DELETE FROM [TB_PersonalWelfareContent] WHERE id=@id";
            SqlConnection cn = new SqlConnection(connectString);

            SqlCommand cmd = new SqlCommand(sqlstr, cn);
            string id = ((Label)GridView1.Rows[e.RowIndex].FindControl("lb_id")).Text.Trim();  
            //cmd.Parameters.AddWithValue("@id", GridView1.Rows[e.RowIndex].Cells[0].Text.Trim());
            cmd.Parameters.AddWithValue("@id", id);
            cn.Open();
            cmd.ExecuteNonQuery();
            cn.Close();
            GVgetData();
        }
    }
}