using JuicERP.DAL;
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
    public partial class MISserviceupload : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            JuicDao dao = new JuicDao("MENU");
            ////取得單身資料
            //var MISupload = dao.GetMISupload(Request.QueryString["pid"].ToString());
            //if (MISupload.Rows.Count > 0)
            //{
            //    Image1.ImageUrl = MISupload.Rows[0]["upload"].ToString();
            //}
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            string ID = Request.QueryString["pid"].ToString();
            if (FileUpload1.HasFile)
            {
                //取得副檔名
                string ext = System.IO.Path.GetExtension(FileUpload1.FileName);
                if (ext == ".png" || ext == ".PNG" || ext == ".jpg" || ext == ".JPG" || ext == ".doc" || ext == ".DOC" || ext == ".docx" || ext == ".DOCX" || ext == ".xls" || ext == ".XLS" || ext == ".xlsx" || ext == ".XLSX" || ext == ".txt")
                {
                    //合乎黨名
                }
                else
                {
                    string strJS = "alert('請上傳png,jpg圖檔或docx,xlsx,pdf文件檔txt文字檔');";
                    Page.ClientScript.RegisterStartupScript(this.GetType(), "", strJS, true);
                    return;
                }

                //String fileName = ID + ext;
                //String fileName = DateTime.Now.Month.ToString()+ DateTime.Now.Day.ToString()+ DateTime.Now.Hour.ToString()+ DateTime.Now.Minute.ToString()+ FileUpload1.FileName;
                String fileName = Request.QueryString["pid"].ToString() + FileUpload1.FileName;
                String fileNameraw = FileUpload1.FileName;

                String savePath = Server.MapPath("~/files/mis/");

                String saveResult = savePath + fileName;
                //-- 重點！！必須包含 Server端的「目錄」與「檔名」，才能使用 .SaveAs()方法！
                FileUpload1.SaveAs(saveResult);


                //若要更改檔名在此更改


                string strConn = ConfigurationManager.ConnectionStrings["MENU"].ConnectionString;
                using (SqlConnection conn = new SqlConnection(strConn))
                {
                    //string strCmd = "UPDATE TB_MISservice SET  upload=@upload where NO=@NO";
                    string strCmd = "Insert into TB_MISserviceupload(misid,url,filename)values(@misid,@url,@filename)";
                    using (SqlCommand cmd = new SqlCommand(strCmd, conn))
                    {
                        //cmd.Parameters.AddWithValue("@upload", "~/files/mis/" + fileName);
                        //cmd.Parameters.AddWithValue("@NO", Request.QueryString["pid"].ToString());
                        cmd.Parameters.AddWithValue("@url", "~/files/mis/" + fileName);
                        cmd.Parameters.AddWithValue("@misid", Request.QueryString["pid"].ToString());
                        cmd.Parameters.AddWithValue("@filename", fileNameraw);

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
                            string strJS = "alert('" + message + "');location.href = ('MISserviceupload.aspx?pid=" + Request.QueryString["pid"].ToString() + "');";
                            Page.ClientScript.RegisterStartupScript(this.GetType(), "", strJS, true);
                        }
                        finally
                        {
                            conn.Close();
                            string strJS = "alert('" + message + "');location.href = ('MISserviceupload.aspx?pid=" + Request.QueryString["pid"].ToString() + "');";
                            Page.ClientScript.RegisterStartupScript(this.GetType(), "", strJS, true);
                        }
                    }
                }
            }
            else
            {
                string message = "請選擇要上傳的檔案";
                string strJS = "alert('" + message + "');location.href = ('MISserviceupload.aspx?pid=" + Request.QueryString["pid"].ToString() + "');";
                Page.ClientScript.RegisterStartupScript(this.GetType(), "", strJS, true);
            }
        }

        //protected void Button2_Click(object sender, EventArgs e)
        //{
        //    JuicDao dao = new JuicDao("MENU");
        //    //刪除資料夾內檔案
        //    var MISupload = dao.GetMISupload(Request.QueryString["pid"].ToString());
        //    if (MISupload.Rows.Count > 0)
        //    {
        //        string p_FilePath = MISupload.Rows[0]["upload"].ToString();
        //        System.IO.File.Delete(System.Web.Hosting.HostingEnvironment.MapPath(p_FilePath));
        //    }

        //    //刪除資料庫路徑
        //    var DeleteMISupload = dao.DeleteMISupload(Request.QueryString["pid"].ToString());



        //    string strJS = "alert('刪除成功');location.href = ('MISserviceupload.aspx?pid=" + Request.QueryString["pid"].ToString() + "');";
        //    Page.ClientScript.RegisterStartupScript(this.GetType(), "", strJS, true);


        //}

        protected void Button3_Click(object sender, EventArgs e)
        {
            string strJS = "location.href = ('MISservice.aspx');";
            Page.ClientScript.RegisterStartupScript(this.GetType(), "", strJS, true);
        }

        protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if(e.CommandName=="remove")
            {
                JuicDao dao = new JuicDao("MENU");
                //刪除資料夾內檔案
                //var MISupload = dao.GetMISupload(e.CommandArgument.ToString().Trim());
                //if (MISupload.Rows.Count > 0)
                //{
                    string p_FilePath = e.CommandArgument.ToString().Trim();
                    System.IO.File.Delete(System.Web.Hosting.HostingEnvironment.MapPath(p_FilePath));
                //}

                //刪除資料庫路徑
                var DeleteMISupload = dao.DeleteMISupload(e.CommandArgument.ToString().Trim());



                string strJS = "alert('刪除成功');location.href = ('MISserviceupload.aspx?pid=" + Request.QueryString["pid"].ToString() + "');";
                Page.ClientScript.RegisterStartupScript(this.GetType(), "", strJS, true);
            }
        }
    }
}