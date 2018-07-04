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
    public partial class Download : System.Web.UI.Page
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
            //檢查是否有上傳檔案之權限
            DAL.JuicDao dao = new DAL.JuicDao("MENU");
            var tb = dao.checkcontrol(User.Identity.Name.ToString(), 19);
            //無上傳檔案權限，隱藏功能
            if (tb.Rows.Count == 0)
            {
                Panel1.Visible = false;
            }
            //檢查是否有刪除檔案之權限
            var tb2 = dao.checkcontrol(User.Identity.Name.ToString(), 20);
            //無刪除檔案權限，取消按鈕
            if (tb2.Rows.Count == 0)
            {
                for (int i = 0; i < GridView0.Rows.Count; i++)
                {
                    Button btn = (Button)GridView0.Rows[i].Cells[1].FindControl("Button2");
                    btn.Enabled = false;
                    //GridView0.Rows[i].Cells[1].FindControl("Button2").Visible = false;
                }
                for (int i = 0; i < GridView1.Rows.Count; i++)
                {
                    Button btn = (Button)GridView1.Rows[i].Cells[1].FindControl("Button2");
                    btn.Enabled = false;
                    //GridView0.Rows[i].Cells[1].FindControl("Button2").Visible = false;
                }
                for (int i = 0; i < GridView2.Rows.Count; i++)
                {
                    Button btn = (Button)GridView2.Rows[i].Cells[1].FindControl("Button2");
                    btn.Enabled = false;
                    //GridView0.Rows[i].Cells[1].FindControl("Button2").Visible = false;
                }
                for (int i = 0; i < GridView3.Rows.Count; i++)
                {
                    Button btn = (Button)GridView3.Rows[i].Cells[1].FindControl("Button2");
                    btn.Enabled = false;
                    //GridView0.Rows[i].Cells[1].FindControl("Button2").Visible = false;
                }


            }
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            if (FileUpload1.HasFile)
            {
                String fileName = FileUpload1.FileName;
                String fileNameraw = FileUpload1.FileName;

                String savePath = Server.MapPath("~/files/");
                
                String saveResult = savePath + fileName;
                //-- 重點！！必須包含 Server端的「目錄」與「檔名」，才能使用 .SaveAs()方法！
                FileUpload1.SaveAs(saveResult);


                //若要更改檔名在此更改
                if (TextBox1.Text != "")
                {
                    fileName = TextBox1.Text;
                }


                string strConn = ConfigurationManager.ConnectionStrings["MENU"].ConnectionString;
                using (SqlConnection conn = new SqlConnection(strConn))
                {
                    string strCmd = "Insert into TB_Downloadlist(class,filename,explanation,url,date,emp_no)values(@class,@filename,@explanation,@url,@date,@emp_no)";
                    using (SqlCommand cmd = new SqlCommand(strCmd, conn))
                    {
                        cmd.Parameters.AddWithValue("@class", DropDownList1.SelectedValue);
                        cmd.Parameters.AddWithValue("@filename", fileName);
                        cmd.Parameters.AddWithValue("@explanation", TextBox2.Text);
                        cmd.Parameters.AddWithValue("@url", "~/files/" + fileNameraw);
                        cmd.Parameters.AddWithValue("@date", DateTime.Now);
                        cmd.Parameters.AddWithValue("@emp_no", User.Identity.Name.ToString());

                        string message = "";

                        try
                        {
                            conn.Open();
                            cmd.ExecuteNonQuery();
                            message = "檔案上傳成功";

                        }
                        catch (Exception ex)
                        {
                            message = ex.Message;
                            string strJS = "alert('" + message + "');location.href = ('Download.aspx');";
                            Page.ClientScript.RegisterStartupScript(this.GetType(), "", strJS, true);
                        }
                        finally
                        {
                            conn.Close();
                            string strJS = "alert('" + message + "');location.href = ('Download.aspx');";
                            Page.ClientScript.RegisterStartupScript(this.GetType(), "", strJS, true);
                        }
                    }
                }
            }
            else
            {
                string message = "請選擇要上傳的檔案";
                string strJS = "alert('" + message + "');location.href = ('Download.aspx');";
                Page.ClientScript.RegisterStartupScript(this.GetType(), "", strJS, true);
            }
        }
        protected void CheckBox1_CheckedChanged(object sender, EventArgs e)
        {
            if(CheckBox1.Checked)
            {
                TextBox2.Visible = true;
            }
            else
            {
                TextBox2.Visible = false;
            }
        }


        protected void GridView0_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            //if (TextBox3.Visible == false)
            //{
            //    TextBox3.Text = e.CommandArgument.ToString();
            //    TextBox3.Visible = true;
            //}
            //else if (TextBox3.Visible == true)
            //{
            //    TextBox3.Visible = false;
            //    TextBox3.Text = "";
            //}
            if(e.CommandName=="post")
            {
                string message;
                if (e.CommandArgument.ToString() != null && e.CommandArgument.ToString() != "")
                {
                    message = e.CommandArgument.ToString();
                }
                else
                {
                    message = "此檔案沒有說明~";
                }


                string strJS = "alert('" + message + "');";
                Page.ClientScript.RegisterStartupScript(this.GetType(), "", strJS, true);
            }
            
            else if(e.CommandName == "del")
            {

                
                string p_FilePath = e.CommandArgument.ToString();
                System.IO.File.Delete(System.Web.Hosting.HostingEnvironment.MapPath(p_FilePath));

                string strConn = ConfigurationManager.ConnectionStrings["MENU"].ConnectionString;
                using (SqlConnection conn = new SqlConnection(strConn))
                {
                    string strCmd = "DELETE FROM TB_Downloadlist WHERE url = @url; ";
                    using (SqlCommand cmd = new SqlCommand(strCmd, conn))
                    {
                        cmd.Parameters.AddWithValue("@url", p_FilePath);
                        conn.Open();
                        cmd.ExecuteNonQuery();
                        conn.Close();
                        string strJS = "alert('檔案刪除成功');location.href = ('Download.aspx');";
                        Page.ClientScript.RegisterStartupScript(this.GetType(), "", strJS, true);
                    }
                }

            }

            

        }
    }
}
