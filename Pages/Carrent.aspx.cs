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
    public partial class Carrent : System.Web.UI.Page
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
                Label1.Text = DateTime.Now.ToString("yyyy/MM/dd");
                Label2.Text = DateTime.Now.AddDays(3).ToString("yyyy/MM/dd");
            }
            //-------------------------------------------------------------------------------------

            //獲取使用者姓名
            string strConn0 = ConfigurationManager.ConnectionStrings["MENU"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(strConn0))
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

            //檢查是否有公務車租借權限
            DAL.JuicDao dao = new DAL.JuicDao("MENU");
            var tb2 = dao.checkcontrol(User.Identity.Name.ToString(), 16);
            //無公務車租借權限 取消按鈕
            if (tb2.Rows.Count == 0)
            {
                Button1.Enabled = false;
                Button1.Text = "您還不能租借公務車";
            }

            var tb3 = dao.checkcontrol(User.Identity.Name.ToString(), 17);
            //無公務車租借權限 取消按鈕
            if (tb3.Rows.Count != 0)
            {
                manage.Text = "true";
            }

            string strConn = ConfigurationManager.ConnectionStrings["MENU"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(strConn))
            {
                String QQ = "select car_name from TB_Carrentdata where ('" + DateTime.Now.ToString("yyyy/MM/dd HH:mm") + "' BETWEEN startrent AND [endrent]) and (backYN<>'Y')";

                SqlDataAdapter da = new SqlDataAdapter(QQ, conn);
                DataSet ds = new DataSet();
                da.Fill(ds);
                if (ds.Tables[0].Rows.Count != 0)

                {
                    Label9.Text = "";
                    for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
                    {
                        Label9.Text += ds.Tables[0].Rows[i][0].ToString() + " / ";
                    }

                }

            }
        }

        protected void Calendar1_DayRender(object sender, DayRenderEventArgs e)
        {
            //20180529;jesse;kelly要求以前的資料也能查出 將限制14天日期註解
            //e.Day.IsSelectable = e.Day.Date >= DateTime.Today.AddDays(-14);

            //Style vacationStyle = new Style();
            //vacationStyle.BackColor = System.Drawing.Color.Yellow;
            //vacationStyle.BorderWidth = 1;
            //if (e.Day.IsSelectable)
            //{
            //    e.Cell.ApplyStyle(vacationStyle);
            //}
        }

        protected void Calendar1_SelectionChanged(object sender, EventArgs e)
        {
            Label1.Text = Calendar1.SelectedDate.ToString("yyyy/MM/dd");
            Label2.Text = Calendar1.SelectedDate.AddDays(3).ToString("yyyy/MM/dd");
        }

        protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {  //-- 當 GridView呈現「每一列」資料列（記錄）的時候，才會執行這裡！
               //-- 所以這裡就像迴圈一樣，會反覆執行喔！！

                if (DateTime.Parse(e.Row.Cells[3].Text) <= DateTime.Now)
                {
                    if (DateTime.Parse(e.Row.Cells[4].Text) >= DateTime.Now)
                    {
                        for (int i = 0; i <= e.Row.Cells.Count - 1; i++)
                        {
                            e.Row.Cells[i].BackColor = System.Drawing.Color.Pink;
                            e.Row.Cells[i].Font.Bold = true;
                        }
                    }

                }

                if (DateTime.Parse(e.Row.Cells[3].Text) <= DateTime.Now)
                {
                    if (DateTime.Parse(e.Row.Cells[4].Text) >= DateTime.Now)
                    {
                        if (e.Row.Cells[5].Text.Trim() == "N")
                        {
                            for (int i = 0; i <= e.Row.Cells.Count - 1; i++)
                            {
                                e.Row.Cells[i].BackColor = System.Drawing.Color.Silver;
                                e.Row.Cells[i].Font.Bold = true;
                            }
                        }
                    }

                }

                if (e.Row.Cells[6].Text.Trim() == "Y")
                {
                    {
                        for (int i = 0; i <= e.Row.Cells.Count - 1; i++)
                        {
                            e.Row.Cells[i].BackColor = System.Drawing.Color.PaleGreen;
                            e.Row.Cells[i].Font.Bold = true;
                        }
                    }
                }
                //本人+user
                if (e.Row.Cells[1].Text.Trim() == usname.Text && e.Row.Cells[5].Text.Trim() == "N")
                {
                    Button btn = (Button)e.Row.FindControl("remove");
                    btn.Visible = true;
                }
                if ((e.Row.Cells[1].Text.Trim() == usname.Text || e.Row.Cells[2].Text.Trim() == usname.Text) && e.Row.Cells[5].Text.Trim() == "Y")
                {
                    Button btn = (Button)e.Row.FindControl("back");
                    btn.Visible = true;
                }
                if (manage.Text == "true" && e.Row.Cells[5].Text.Trim() == "N")
                {
                    Button btn = (Button)e.Row.FindControl("remove");
                    Button btn2 = (Button)e.Row.FindControl("go");
                    btn.Visible = true;
                    btn2.Visible = true;
                }
                if (manage.Text == "true" && e.Row.Cells[5].Text.Trim() == "Y" && e.Row.Cells[6].Text.Trim() == "N")
                {
                    Button btn = (Button)e.Row.FindControl("checkback");
                    btn.Visible = true;
                }
                if (manage.Text == "true")
                {
                    Button btn = (Button)e.Row.FindControl("manage");
                    Button btn2 = (Button)e.Row.FindControl("back");
                    btn.Visible = true;
                    btn2.Visible = true;
                }

            }
        }
        protected void Button1_Click(object sender, EventArgs e)
        {
            Panel1.Visible = true;
        }

        protected void Button2_Click(object sender, EventArgs e)
        {
            string datest1 = datestart.Text + " " + DropDownList2.SelectedItem.Text + ":" + DropDownList3.SelectedItem.Text;
            string datest2 = dateend.Text + " " + DropDownList4.SelectedItem.Text + ":" + DropDownList5.SelectedItem.Text;
            DateTime date1 = DateTime.Parse((datestart.Text + " " + DropDownList2.SelectedItem.Text + ":" + DropDownList3.SelectedItem.Text));
            DateTime date2 = DateTime.Parse((dateend.Text + " " + DropDownList4.SelectedItem.Text + ":" + DropDownList5.SelectedItem.Text));

            //判斷是否已有人預約
            string strConn = ConfigurationManager.ConnectionStrings["MENU"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(strConn))
            {
                //String QQ = "select * from TB_Carrent where (startrent BETWEEN '"+ (datestart.Text + " " + DropDownList2.SelectedItem.Text + ":" + DropDownList3.SelectedItem.Text) + "' AND  '" + (dateend.Text + " " + DropDownList4.SelectedItem.Text + ":" + DropDownList5.SelectedItem.Text) + "') or (endrent BETWEEN  '" + (datestart.Text + " " + DropDownList2.SelectedItem.Text + ":" + DropDownList3.SelectedItem.Text) + "' AND  '" + (dateend.Text + " " + DropDownList4.SelectedItem.Text + ":" + DropDownList5.SelectedItem.Text) + "') and (car_no='"+ DropDownList1.SelectedValue + "')";
                String QQ = "select * from TB_Carrentdata where (((startrent BETWEEN '" + datest1 + "' AND  '" + datest2 + "')and(startrent<>'" + datest2 + "')) or ((endrent BETWEEN  '" + datest1 + "' AND  '" + datest2 + "')and(endrent <>'" + datest1 + "')) or (startrent < '" + datest1 + "' AND endrent> '" + datest2 + "')) and (car_no='" + DropDownList1.SelectedValue + "')";



                SqlDataAdapter da = new SqlDataAdapter(QQ, conn);
                DataSet ds = new DataSet();
                da.Fill(ds);
                if (ds.Tables[0].Rows.Count != 0)
                {
                    for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
                    {
                        if (ds.Tables[0].Rows[i]["backYN"].ToString().Trim()=="Y" )
                        {
                            //107/07/19 Jesse 修改 若該車已經歸還則可以預約
                        }
                        else
                        {
                            conn.Close();
                            string strJS = "alert('此時段已有人預約');location.href = ('Carrent.aspx');";
                            Page.ClientScript.RegisterStartupScript(this.GetType(), "", strJS, true);
                            return;
                        }
                      
                    }
                }

            }

            string myname = "unknown";
            using (SqlConnection conn = new SqlConnection(strConn))
            {
                String QQ = "select username from bas03 where userid='" + User.Identity.Name.ToString() + "'";

                SqlDataAdapter da = new SqlDataAdapter(QQ, conn);
                DataSet ds = new DataSet();
                da.Fill(ds);
                if (ds.Tables[0].Rows.Count != 0)
                {
                    myname = ds.Tables[0].Rows[0][0].ToString();
                }

            }
            if (TextBox1.Text.Trim() == "")
            {
                TextBox1.Text = myname;
            }
            using (SqlConnection conn = new SqlConnection(strConn))
            {
                string strCmd = "Insert into TB_Carrentdata(car_no,car_name,emp_no,emp_cne,username,applydate,startrent,endrent,destination,gotoYN,backYN,PS)values(@car_no,@car_name,@emp_no,@emp_cne,@username,@applydate,@startrent,@endrent,@destination,@gotoYN,@backYN,@PS)";
                using (SqlCommand cmd = new SqlCommand(strCmd, conn))
                {
                    cmd.Parameters.AddWithValue("@car_no", DropDownList1.SelectedValue);
                    cmd.Parameters.AddWithValue("@car_name", DropDownList1.SelectedItem.Text);
                    cmd.Parameters.AddWithValue("@emp_no", User.Identity.Name.ToString());
                    cmd.Parameters.AddWithValue("@emp_cne", myname);
                    cmd.Parameters.AddWithValue("@username", TextBox1.Text);
                    cmd.Parameters.AddWithValue("@applydate", DateTime.Now);
                    //cmd.Parameters.AddWithValue("@startrent", DateTime.Parse(datestart.Text));
                    //cmd.Parameters.AddWithValue("@endrent", DateTime.Parse(dateend.Text));
                    cmd.Parameters.AddWithValue("@startrent", date1);
                    cmd.Parameters.AddWithValue("@endrent", date2);
                    cmd.Parameters.AddWithValue("@destination", TextBox2.Text);
                    cmd.Parameters.AddWithValue("@gotoYN", "N");
                    cmd.Parameters.AddWithValue("@backYN", "N");
                    cmd.Parameters.AddWithValue("@PS", TextBox3.Text);
                    string message = "";

                    try
                    {
                        conn.Open();
                        cmd.ExecuteNonQuery();
                        message = "預約成功";

                    }
                    catch (Exception ex)
                    {
                        message = ex.Message;
                        string strJS = "alert('" + message + "');location.href = ('Carrent.aspx');";
                        Page.ClientScript.RegisterStartupScript(this.GetType(), "", strJS, true);

                    }
                    finally
                    {
                        conn.Close();
                        string strJS = "alert('" + message + "');location.href = ('Carrent.aspx');";
                        Page.ClientScript.RegisterStartupScript(this.GetType(), "", strJS, true);
                    }

                }
            }
        }

        protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "manage")
            {
                string url = "Carmanage.aspx?pid=" + e.CommandArgument.ToString().Trim();
                string strJS = "location.href = ('" + url + "');";
                Page.ClientScript.RegisterStartupScript(this.GetType(), "", strJS, true);
            }
            if (e.CommandName == "back")
            {
                string url = "Carback.aspx?pid=" + e.CommandArgument.ToString().Trim();
                string strJS = "location.href = ('" + url + "');";
                Page.ClientScript.RegisterStartupScript(this.GetType(), "", strJS, true);
            }
            if (e.CommandName == "go")
            {
                string strConn = ConfigurationManager.ConnectionStrings["MENU"].ConnectionString;
                using (SqlConnection conn = new SqlConnection(strConn))
                {
                    string strCmd = "  Update TB_Carrentdata SET gotoYN=@gotoYN where id='" + e.CommandArgument.ToString() + "'";
                    using (SqlCommand cmd = new SqlCommand(strCmd, conn))
                    {
                        cmd.Parameters.AddWithValue("@gotoYN", "Y");

                        string message = "";

                        try
                        {
                            conn.Open();
                            cmd.ExecuteNonQuery();
                            message = "出發確認作業完成";

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
                            GridView1.DataSourceID = "SqlDataSource3";
                        }

                    }
                }


            }

            if (e.CommandName == "checkback")
            {
                string strConn = ConfigurationManager.ConnectionStrings["MENU"].ConnectionString;
                using (SqlConnection conn = new SqlConnection(strConn))
                {
                    string strCmd = "  Update TB_Carrentdata SET backYN=@backYN where id='" + e.CommandArgument.ToString() + "'";
                    using (SqlCommand cmd = new SqlCommand(strCmd, conn))
                    {
                        cmd.Parameters.AddWithValue("@backYN", "Y");

                        string message = "";

                        try
                        {
                            conn.Open();
                            cmd.ExecuteNonQuery();
                            message = "確認歸還";

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
                            GridView1.DataSourceID = "SqlDataSource3";
                        }

                    }
                }


            }

            if (e.CommandName == "remove")
            {
                string strConn = ConfigurationManager.ConnectionStrings["MENU"].ConnectionString;
                using (SqlConnection conn = new SqlConnection(strConn))
                {

                    string strCmd = "DELETE FROM TB_Carrentdata where id='" + e.CommandArgument.ToString() + "'";
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
                            GridView1.DataSourceID = "SqlDataSource3";
                        }


                    }
                }
            }
        }
    }
}