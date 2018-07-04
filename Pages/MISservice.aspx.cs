using NPOI.HSSF.UserModel;
using NPOI.SS.UserModel;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace JuicERP.Pages
{
    public partial class MISservice : System.Web.UI.Page
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
            //獲取使用者姓名
            string strConn = ConfigurationManager.ConnectionStrings["MENU"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(strConn))
            {
                string strCmdname = "SELECT username  FROM bas03 where userid='" + User.Identity.Name.ToString() + "'";
                SqlDataAdapter da2 = new SqlDataAdapter(strCmdname, conn);
                DataSet ds2 = new DataSet();
                da2.Fill(ds2);
                if (ds2.Tables[0].Rows.Count != 0)
                {
                    usname.Text = ds2.Tables[0].Rows[0][0].ToString().Trim();
                }
            }


            //檢查是否有資訊部管理權限
            DAL.JuicDao dao = new DAL.JuicDao("MENU");
            var check = dao.checkcontrol(User.Identity.Name.ToString(), 23);//待新增
            //有管理權限，顯示管理按鈕
            if (check.Rows.Count != 0)
            {
                //for (int i = 0; i < service.Rows.Count; i++)
                //{
                //    Button btn = (Button)service.Rows[i].Cells[1].FindControl("manage");
                //    btn.Visible = true;
                //    //GridView0.Rows[i].Cells[1].FindControl("Button2").Visible = false;
                //}
                checkma.Text = "OK";
            }
        }
        protected void service_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                //if (e.Row.Cells[4].Text.Trim() == "已完成")
                //    e.Row.Cells[4].BackColor = System.Drawing.Color.LightGreen;
                //else if (e.Row.Cells[4].Text.Trim() == "待測試")
                //    e.Row.Cells[4].BackColor = System.Drawing.Color.Gold;
                //else if (e.Row.Cells[4].Text.Trim() == "處理中")
                //    e.Row.Cells[4].BackColor = System.Drawing.Color.LightCyan;
                //else if (e.Row.Cells[4].Text.Trim() == "展延")
                //    e.Row.Cells[4].BackColor = System.Drawing.Color.Salmon;


                if (e.Row.Cells[5].Text.Trim() == "已完成")
                    e.Row.BackColor = System.Drawing.Color.LightCyan;
                else if (e.Row.Cells[5].Text.Trim() == "待測試")
                    e.Row.BackColor = System.Drawing.Color.Gold;
                else if (e.Row.Cells[5].Text.Trim() == "處理中")
                    e.Row.BackColor = System.Drawing.Color.LightPink;
                else if (e.Row.Cells[5].Text.Trim() == "展延")
                    e.Row.BackColor = System.Drawing.Color.Violet;
                else if (e.Row.Cells[5].Text.Trim() == "未開始")
                    e.Row.BackColor = System.Drawing.Color.White;
                else if (e.Row.Cells[5].Text.Trim() == "討論中")
                    e.Row.BackColor = System.Drawing.Color.Gold;
                else if (e.Row.Cells[5].Text.Trim() == "待修改")
                    e.Row.BackColor = System.Drawing.Color.Gold;

                if (checkma.Text== "OK")
                {
                    Button btn = (Button)e.Row.FindControl("manage");
                    btn.Visible = true;
                    Button btn3 = (Button)e.Row.FindControl("print");
                    btn3.Visible = true;
                }

                if (e.Row.Cells[4].Text.Trim() == usname.Text && e.Row.Cells[5].Text.Trim() == "未開始")
                {
                    Button btn = (Button)e.Row.FindControl("edit");
                    btn.Visible = true;
                    Button btn2 = (Button)e.Row.FindControl("remove");
                    btn2.Visible = true;

                }
                //不需完成也開放列印權限
                if (e.Row.Cells[4].Text.Trim() == usname.Text)
                {
                    Button btn3 = (Button)e.Row.FindControl("print");
                    btn3.Visible = true;
                }
                //測試完成或不需測試再開放列印權限
                //if (e.Row.Cells[4].Text.Trim() == usname.Text&& e.Row.Cells[6].Text.Trim() == "不需測試")
                //{
                //    Button btn3 = (Button)e.Row.FindControl("print");
                //    btn3.Visible = true;
                //}
                //else if (e.Row.Cells[4].Text.Trim() == usname.Text && e.Row.Cells[6].Text.Trim() == "測試完成")
                //{
                //    Button btn3 = (Button)e.Row.FindControl("print");
                //    btn3.Visible = true;
                //}
                if (e.Row.Cells[4].Text.Trim() == usname.Text && e.Row.Cells[5].Text.Trim() == "待測試")
                {
                    Button btn = (Button)e.Row.FindControl("usertest");
                    btn.Visible = true;

                }

            }





            //if (e.Row.RowType == DataControlRowType.Footer)
            //{
            //    e.Row.Cells[3].Text = "庫存不足，共 " + count + " 筆";
            //}
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            Panel1.Visible = true;
        }

        protected void Button2_Click(object sender, EventArgs e)
        {

            string strConn = ConfigurationManager.ConnectionStrings["MENU"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(strConn))
            {
                //獲取最新NO
                string strCmdNO = "SELECT top 1 NO FROM TB_MISservice ORDER BY NO DESC";
                SqlDataAdapter da = new SqlDataAdapter(strCmdNO, conn);
                DataSet ds = new DataSet();
                da.Fill(ds);
                int newno = 0;
                if (ds.Tables[0].Rows.Count != 0)
                {
                    newno = int.Parse(ds.Tables[0].Rows[0][0].ToString());
                    newno++;
                }
                ////獲取使用者姓名
                //string strCmdname = "SELECT username  FROM bas03 where userid='" + User.Identity.Name.ToString() + "'";
                //SqlDataAdapter da2 = new SqlDataAdapter(strCmdname, conn);
                //DataSet ds2 = new DataSet();
                //da2.Fill(ds2);
                //if (ds2.Tables[0].Rows.Count != 0)
                //{
                //    Button1.Text += ds2.Tables[0].Rows[0][0].ToString();
                //}

                string strCmd = "Insert into TB_MISservice(NO,category,type,problem,emp_no,emp_cne,situation,testsituation,testfeedback,priority,date)values(@NO,@category,@type,@problem,@emp_no,@emp_cne,@situation,@testsituation,@testfeedback,@priority,@date)";
                using (SqlCommand cmd = new SqlCommand(strCmd, conn))
                {
                    cmd.Parameters.AddWithValue("@NO", newno.ToString());
                    cmd.Parameters.AddWithValue("@category", DropDownList1.SelectedValue);
                    cmd.Parameters.AddWithValue("@type", "新建需求");
                    cmd.Parameters.AddWithValue("@problem", TextBox1.Text);
                    cmd.Parameters.AddWithValue("@emp_no", User.Identity.Name.ToString());
                    cmd.Parameters.AddWithValue("@emp_cne", usname.Text);
                    cmd.Parameters.AddWithValue("@situation", "未開始");
                    cmd.Parameters.AddWithValue("@testsituation", "未測試");
                    cmd.Parameters.AddWithValue("@testfeedback", "無資料");
                    cmd.Parameters.AddWithValue("@priority", "M");
                    cmd.Parameters.AddWithValue("@date", DateTime.Now);



                    string message = "";

                    try
                    {
                        conn.Open();
                        cmd.ExecuteNonQuery();
                        message = "加入成功";

                    }
                    catch (Exception ex)
                    {
                        message = ex.Message;
                    }
                    finally
                    {
                        conn.Close();
                        string strJS = "alert('" + message + "');location.href = ('MISservice.aspx');";
                        Page.ClientScript.RegisterStartupScript(this.GetType(), "", strJS, true);

                    }


                }
            }


        }

        protected void service_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            //
            if (e.CommandName == "manage")
            {
                string url = "MISservicemanage.aspx?pid=" + e.CommandArgument.ToString().Trim();
                string strJS = "location.href = ('" + url + "');";
                Page.ClientScript.RegisterStartupScript(this.GetType(), "", strJS, true);
            }
            if (e.CommandName == "edit")
            {
                string url = "MISserviceedit.aspx?pid=" + e.CommandArgument.ToString().Trim();
                string strJS = "location.href = ('" + url + "');";
                Page.ClientScript.RegisterStartupScript(this.GetType(), "", strJS, true);
            }
            if (e.CommandName == "print")
            {
                string url = "MISservicePrint.aspx?pid=" + e.CommandArgument.ToString().Split(new string[] { ",," }, StringSplitOptions.RemoveEmptyEntries)[0].Trim()+"&user="+ e.CommandArgument.ToString().Split(new string[] { ",," }, StringSplitOptions.RemoveEmptyEntries)[1].Trim();
                string strJS = "location.href = ('" + url + "');";
                Page.ClientScript.RegisterStartupScript(this.GetType(), "", strJS, true);
            }
            if (e.CommandName == "usertest")
            {
                string url = "MISserviceusertest.aspx?pid=" + e.CommandArgument.ToString().Trim();
                string strJS = "location.href = ('" + url + "');";
                Page.ClientScript.RegisterStartupScript(this.GetType(), "", strJS, true);
            }
            //開啟上傳附擋頁面
            if (e.CommandName == "upload")
            {
                string url = "MISserviceupload.aspx?pid=" + e.CommandArgument.ToString().Trim();
                string strJS = "location.href = ('" + url + "');";
                //彈出型視窗
                //string strJS = "window.open('http://www.smkproduction.eu5.org', '_blank');";
                Page.ClientScript.RegisterStartupScript(this.GetType(), "", strJS, true);
            }
            if (e.CommandName=="remove")
            {
                string strConn = ConfigurationManager.ConnectionStrings["MENU"].ConnectionString;
                using (SqlConnection conn = new SqlConnection(strConn))
                {

                    string strCmd = "DELETE FROM TB_MISservice where NO='" + e.CommandArgument.ToString() + "'";
                    using (SqlCommand cmd = new SqlCommand(strCmd, conn))
                    {

                        string message = "";

                        try
                        {
                            conn.Open();
                            cmd.ExecuteNonQuery();
                            message = "刪除成功";

                        }
                        catch (Exception ex)
                        {
                            message = ex.Message;
                        }
                        finally
                        {
                            conn.Close();
                            string strJS = "alert('" + message + "');";
                            Page.ClientScript.RegisterStartupScript(this.GetType(), "", strJS, true);
                            service.DataSourceID = "SqlDataSource1";
                        }


                    }
                }
            }
        }

        protected void btnexcel_Click(object sender, EventArgs e)
        {
            gridexcel.Visible = true;
            Response.ClearContent();
            Response.Write("<meta http-equiv=Content-Type content=text/html;charset=utf-8>");
            string excelFileName = "軟體系統問題追蹤與管理清單" + DateTime.Now.ToString("yyyyMMddHHmmss") + ".xls";
            Response.AddHeader("content-disposition", "attachment;filename=" + Server.UrlEncode(excelFileName));
            Response.ContentType = "application/excel";
            System.IO.StringWriter stringWrite = new System.IO.StringWriter();
            System.Web.UI.HtmlTextWriter htmlWrite = new HtmlTextWriter(stringWrite);
            gridexcel.RenderControl(htmlWrite);
            Response.Write(stringWrite.ToString());
            Response.End();
            gridexcel.Visible = false;
        }

        public override void VerifyRenderingInServerForm(Control control)
        {
            // '處理'GridView' 的控制項 'GridView' 必須置於有 runat=server 的表單標記之中   
        }

        protected void gridexcel_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if(e.Row.RowType == DataControlRowType.DataRow)
            {
                //if (e.Row.Cells[4].Text.Trim() == "已完成")
                //    e.Row.Cells[4].BackColor = System.Drawing.Color.LightGreen;
                //else if (e.Row.Cells[4].Text.Trim() == "待測試")
                //    e.Row.Cells[4].BackColor = System.Drawing.Color.Gold;
                //else if (e.Row.Cells[4].Text.Trim() == "處理中")
                //    e.Row.Cells[4].BackColor = System.Drawing.Color.LightCyan;
                //else if (e.Row.Cells[4].Text.Trim() == "展延")
                //    e.Row.Cells[4].BackColor = System.Drawing.Color.Salmon;


                if (e.Row.Cells[5].Text.Trim() == "已完成")
                    e.Row.BackColor = System.Drawing.Color.LightCyan;
                else if (e.Row.Cells[5].Text.Trim() == "待測試")
                    e.Row.BackColor = System.Drawing.Color.Gold;
                else if (e.Row.Cells[5].Text.Trim() == "處理中")
                    e.Row.BackColor = System.Drawing.Color.LightPink;
                else if (e.Row.Cells[5].Text.Trim() == "展延")
                    e.Row.BackColor = System.Drawing.Color.Violet;
                else if (e.Row.Cells[5].Text.Trim() == "未開始")
                    e.Row.BackColor = System.Drawing.Color.White;
                else if (e.Row.Cells[5].Text.Trim() == "討論中")
                    e.Row.BackColor = System.Drawing.Color.Gold;
                else if (e.Row.Cells[5].Text.Trim() == "待修改")
                    e.Row.BackColor = System.Drawing.Color.Gold;
            }
            }
    }
}