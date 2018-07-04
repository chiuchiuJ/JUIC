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
    public partial class PaySearch : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            JuicDao dao = new JuicDao("MENU");
            var user = dao.GetUser(this.User.Identity.Name.ToString());
            string usname = user.Rows[0]["username"].ToString().Trim();
            
     

            if(!IsPostBack)
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
            if (check2.Rows.Count != 0)
            {
                TextBox3.ReadOnly = false;
            }
        }

        protected void Button6_Click(object sender, EventArgs e)
        {
            Label22.Text = "%" + TextBox3.Text + "%";
            if (CheckBoxList1.Items[0].Selected)
            {
                Label16.Text = CheckBoxList1.Items[0].Value;
            }
            else
            {
                Label16.Text = "QQ";
            }
            if (CheckBoxList1.Items[1].Selected)
            {
                Label17.Text = CheckBoxList1.Items[1].Value;
            }
            else
            {
                Label17.Text = "QQ";
            }
            if (CheckBoxList1.Items[2].Selected)
            {
                Label18.Text = CheckBoxList1.Items[2].Value;
            }
            else
            {
                Label18.Text = "QQ";
            }
            //
            if (CheckBoxList2.Items[0].Selected)
            {
                Label19.Text = CheckBoxList2.Items[0].Value;
            }
            else
            {
                Label19.Text = "QQ";
            }
            if (CheckBoxList2.Items[1].Selected)
            {
                Label20.Text = CheckBoxList2.Items[1].Value;
            }
            else
            {
                Label20.Text = "QQ";
            }
            if (CheckBoxList2.Items[2].Selected)
            {
                Label21.Text = CheckBoxList2.Items[2].Value;
            }
            else
            {
                Label21.Text = "QQ";
            }
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

                    string strCmd = "DELETE FROM TB_Payment where id='" + e.CommandArgument.ToString() + "'";
                    string strCmd2 = "DELETE FROM TB_Paymentdetail where paymentid='" + e.CommandArgument.ToString() + "'";
                    using (SqlCommand cmd = new SqlCommand(strCmd2, conn))
                    {

                        string message = "";

                        try
                        {
                            conn.Open();
                            cmd.ExecuteNonQuery();
        

                        }
                        catch (Exception ex)
                        {
                            message = ex.Message;
                        }
                        finally
                        {
                            conn.Close();

                        }


                    }
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

                string url = "PayPrint1.aspx?pid=" + e.CommandArgument.ToString().Split(new string[] { ",," }, StringSplitOptions.RemoveEmptyEntries)[0].Trim() + "&user=" + e.CommandArgument.ToString().Split(new string[] { ",," }, StringSplitOptions.RemoveEmptyEntries)[1].Trim();
                string strJS = "location.href = ('" + url + "');";
                Page.ClientScript.RegisterStartupScript(this.GetType(), "", strJS, true);
            }
            if (e.CommandName == "print2")
            {

                string url = "PayPrint2.aspx?pid=" + e.CommandArgument.ToString().Split(new string[] { ",," }, StringSplitOptions.RemoveEmptyEntries)[0].Trim() + "&user=" + e.CommandArgument.ToString().Split(new string[] { ",," }, StringSplitOptions.RemoveEmptyEntries)[1].Trim();
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
                //1070531;jesse;資材需求 增加支付對象  根據欄位順序6以後需要調整
                if (e.Row.Cells[3].Text.Trim() == usname && e.Row.Cells[9].Text.Trim() == "N")
                {
                    Button btn = (Button)e.Row.FindControl("remove");
                    btn.Visible = true;
                    //Button btn2 = (Button)e.Row.FindControl("edit");
                    //btn2.Visible = true;
                }
                if(checkma.Text=="OK"&& e.Row.Cells[9].Text.Trim() == "N")
                {
                    //Button btn = (Button)e.Row.FindControl("check");
                    //btn.Visible = true;
                }
                if (e.Row.Cells[7].Text.Trim() == "零用金")
                {
                    Button btn = (Button)e.Row.FindControl("print1");
                    btn.Visible = true;
                }
                else
                {
                    Button btn = (Button)e.Row.FindControl("print2");
                    btn.Visible = true;
                }
                if (e.Row.Cells[3].Text.Trim() == usname && e.Row.Cells[9].Text.Trim() == "Y")
                {
                    //Button btn = (Button)e.Row.FindControl("giveup");
                    //btn.Visible = true;
                }
                //美金顯示小數點
                //if  (e.Row.Cells[4].Text.Trim() == "USD" )
                //{
                //    e.Row.Cells[5].Text = "123";
                //}
            }
        }
    }
}