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
    public partial class Paysearch2 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            JuicDao dao = new JuicDao("MENU");
            var user = dao.GetUser(this.User.Identity.Name.ToString());
            string usname = user.Rows[0]["username"].ToString().Trim();



            if (!IsPostBack)
            {
                TextBox3.Text = usname;
                Label22.Text = "%" + usname + "%";
            }

            //檢查是否有財會核決權限
            var check = dao.checkcontrol(User.Identity.Name.ToString(), 24);//待新增
            //有核決權限，識別碼OK
            if (check.Rows.Count != 0)
            {

                checkma.Text = "OK";
            }
            //檢查是否有查他人請款單權限
            var check2 = dao.checkcontrol(User.Identity.Name.ToString(), 25);//待新增
            //有核決權限，可以性名方式搜尋
            if (check.Rows.Count != 0)
            {
                TextBox3.ReadOnly = false;
            }
        }

        protected void Button6_Click(object sender, EventArgs e)
        {
            Label22.Text = "%" + TextBox3.Text + "%";

        }

        protected void service_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            string strConn = ConfigurationManager.ConnectionStrings["MENU"].ConnectionString;
            //if (e.CommandName == "check")
            //{
            //    string id = e.CommandArgument.ToString().Trim();
            //    using (SqlConnection conn = new SqlConnection(strConn))
            //    {
            //        string strCmd = "Update TB_Payment set [check]=@check where id='" + id + "'";
            //        using (SqlCommand cmd = new SqlCommand(strCmd, conn))
            //        {
            //            cmd.Parameters.AddWithValue("@check", "Y");

            //            string message = "";

            //            try
            //            {
            //                conn.Open();
            //                cmd.ExecuteNonQuery();
            //                message = "此請款單已核決成功";

            //            }
            //            catch (Exception ex)
            //            {
            //                message = ex.Message;
            //            }
            //            finally
            //            {
            //                conn.Close();
            //                string strJS = "alert('" + message + "');";//location.href = ('Pay.aspx');
            //                Page.ClientScript.RegisterStartupScript(this.GetType(), "", strJS, true);
            //                service.DataSourceID = "SqlDataSource5";
            //            }
            //        }
            //    }
            //}
            //if (e.CommandName == "giveup")
            //{
            //    string id = e.CommandArgument.ToString().Trim();
            //    using (SqlConnection conn = new SqlConnection(strConn))
            //    {
            //        string strCmd = "Update TB_Payment set [check]=@check where id='" + id + "'";
            //        using (SqlCommand cmd = new SqlCommand(strCmd, conn))
            //        {
            //            cmd.Parameters.AddWithValue("@check", "G");

            //            string message = "";

            //            try
            //            {
            //                conn.Open();
            //                cmd.ExecuteNonQuery();
            //                message = "此請款單已核決成功";

            //            }
            //            catch (Exception ex)
            //            {
            //                message = ex.Message;
            //            }
            //            finally
            //            {
            //                conn.Close();
            //                string strJS = "alert('" + message + "');";//location.href = ('Pay.aspx');
            //                Page.ClientScript.RegisterStartupScript(this.GetType(), "", strJS, true);
            //                service.DataSourceID = "SqlDataSource5";
            //            }
            //        }
            //    }
            //}
            if (e.CommandName == "remove")
            {
                using (SqlConnection conn = new SqlConnection(strConn))
                {

                    string strCmd = "DELETE FROM TB_Payallowance where id='" + e.CommandArgument.ToString() + "'";

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
                            service.DataSourceID = "SqlDataSource5";
                        }


                    }
                }
            }
            if (e.CommandName == "print1")
            {

                string url = "PayPrint0.aspx?pid=" + e.CommandArgument.ToString().Trim();
                string strJS = "location.href = ('" + url + "');";
                Page.ClientScript.RegisterStartupScript(this.GetType(), "", strJS, true);
            }

        }

        protected void service_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            JuicDao dao = new JuicDao("MENU");
            var user = dao.GetUser(this.User.Identity.Name.ToString());
            string usname = user.Rows[0]["username"].ToString().Trim();
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                if (e.Row.Cells[2].Text.Trim() == usname)
                {
                    Button btn = (Button)e.Row.FindControl("remove");
                    btn.Visible = true;
                    //Button btn2 = (Button)e.Row.FindControl("edit");
                    //btn2.Visible = true;
                }
                Button btn2 = (Button)e.Row.FindControl("print1");
                btn2.Visible = true;
            }

        }
    }
}