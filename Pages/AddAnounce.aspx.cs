using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace JuicERP.Pages
{
    public partial class AddAnounce : System.Web.UI.Page
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
            //-------------------------------------------------------------------------------------
            //檢查是否有新增公告之權限
            DAL.JuicDao dao = new DAL.JuicDao("MENU");
            var tb = dao.checkcontrol(User.Identity.Name.ToString(), 1);
            //無新增公告權限 取消按鈕
            if (tb.Rows.Count == 0)
            {
                Button1.Enabled = false;
                Button1.Text = "尚未開通新增公告權限";
            }
        }

        protected void deptlist_SelectedIndexChanged(object sender, EventArgs e)
        {
            dept.Text = deptlist.SelectedItem.Text;
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            String fileNameraw = "";
            if (FileUpload1.HasFile)
            {
                String fileName = FileUpload1.FileName;
               fileNameraw = "~/files/ann/" + FileUpload1.FileName;

                String savePath = Server.MapPath("~/files/ann/");

                String saveResult = savePath + fileName;
                //-- 重點！！必須包含 Server端的「目錄」與「檔名」，才能使用 .SaveAs()方法！
                FileUpload1.SaveAs(saveResult);


                //若要更改檔名在此更改
                //if (TextBox1.Text != "")
                //{
                //    fileName = TextBox1.Text;
                //}


           
            }
            else
            {

            }


            string strConn = ConfigurationManager.ConnectionStrings["MENU"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(strConn))
            {
                string strCmd = "Insert into TB_AnnounceBeta(postdate,title,dept,author,content,pdfurl)values(@postdate,@title,@dept,@author,@content,@pdfurl)";
                using (SqlCommand cmd = new SqlCommand(strCmd, conn))
                {
                    cmd.Parameters.AddWithValue("@postdate", DateTime.Now);
                    cmd.Parameters.AddWithValue("@title", title.Text);
                    cmd.Parameters.AddWithValue("@dept", dept.Text);
                    cmd.Parameters.AddWithValue("@author", author.Text);
                    cmd.Parameters.AddWithValue("@content", content.Text);
                    cmd.Parameters.AddWithValue("@pdfurl", fileNameraw);

                    string message = "";

                    try
                    {
                        conn.Open();
                        cmd.ExecuteNonQuery();
                        message = "新增成功";

                    }
                    catch (Exception ex)
                    {
                        message = ex.Message;
                    }
                    finally
                    {
                        conn.Close();
                        string strJS = "alert('" + message + "');location.href = ('JuicWMS2.aspx');";
                        Page.ClientScript.RegisterStartupScript(this.GetType(), "", strJS, true);
                    }

                }
            }
        }

        protected void Button3_Click(object sender, EventArgs e)
        {

            title.Text = "";
            deptlist.SelectedIndex = 0;
            dept.Text= "";
            author.Text= "";
            content.Text= "";
            
        }

    }
}