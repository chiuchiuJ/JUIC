using JuicERP.DAL;
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
    public partial class Conferenceroom : System.Web.UI.Page
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
            //檢查是否有租借會議室之權限
            DAL.JuicDao dao = new DAL.JuicDao("MENU");
            var tb = dao.checkcontrol(User.Identity.Name.ToString(), 7);
            //無借會議室權限 取消按鈕
            if (tb.Rows.Count == 0)
            {
                Button1.Enabled = false;
                Button1.Text = "尚未開通租借會議室權限";
            }
            var tb2 = dao.checkcontrol(User.Identity.Name.ToString(), 6);
            if (tb2.Rows.Count != 0)
            {
                checkma.Text = "OK";
                Panel2.Visible = true;
            }

            if (!IsPostBack)
            {
                Calendar1.SelectedDate = DateTime.Now.Date;
                Calendar1_SelectionChanged(sender, EventArgs.Empty);
                //Label3.Text = Calendar1.SelectedDate.ToString("yyyy/MM/dd");
                Calendar2.SelectedDate = DateTime.Now.Date;
                Calendar2_SelectionChanged(sender, EventArgs.Empty);
            }

            //ScriptManager1.RegisterAsyncPostBackControl(GridView1);

        }

        protected void Calendar1_DayRender(object sender, DayRenderEventArgs e)
        {
            e.Day.IsSelectable = (e.Day.Date >= DateTime.Today) && (e.Day.Date <= DateTime.Now.AddDays(29)) && (e.Day.IsWeekend == false);


            Style vacationStyle = new Style();
            //vacationStyle.BackColor = System.Drawing.Color.PapayaWhip;
            //vacationStyle.BorderWidth = 1;
            vacationStyle.Font.Size = 12;
            vacationStyle.ForeColor = System.Drawing.Color.Red;
            //vacationStyle.Font.Bold = true;
            if (e.Day.IsSelectable)
            {
                e.Cell.ApplyStyle(vacationStyle);
            }

        }



        protected void Calendar1_SelectionChanged(object sender, EventArgs e)
        {
            labtime1.Text = "預約日期" + Calendar1.SelectedDate.ToString("yyyy/MM/dd");
            Label1.Text = Calendar1.SelectedDate.ToString("yyyy/MM/dd") + "會議室租借情況";
            //string strJS = "document.all('ctl00_ContentPlaceHolder1_Label3').innerText='"+ Calendar1.SelectedDate.ToString("yyyy/MM/dd") + "';";
            //ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "", strJS, true);
        }







        protected void Button1_Click(object sender, EventArgs e)
        {
            string datest1;
            string datest2;
            DateTime date1;
            DateTime date2;
            if (Calendar1.SelectedDate.ToString("yyyy") != "0001")
            {
                datest1 = Calendar1.SelectedDate.ToString("yyyy/MM/dd") + " " + Drptime1.SelectedItem.Text + ":" + Drptime2.SelectedItem.Text;
                datest2 = Calendar1.SelectedDate.ToString("yyyy/MM/dd") + " " + Drptime3.SelectedItem.Text + ":" + Drptime4.SelectedItem.Text;
                date1 = DateTime.Parse((Calendar1.SelectedDate.ToString("yyyy/MM/dd") + " " + Drptime1.SelectedItem.Text + ":" + Drptime2.SelectedItem.Text));
                date2 = DateTime.Parse((Calendar1.SelectedDate.ToString("yyyy/MM/dd") + " " + Drptime3.SelectedItem.Text + ":" + Drptime4.SelectedItem.Text));
            }
            else
            {
                datest1 = DateTime.Now.ToString("yyyy/MM/dd") + " " + Drptime1.SelectedItem.Text + ":" + Drptime2.SelectedItem.Text;
                datest2 = DateTime.Now.ToString("yyyy/MM/dd") + " " + Drptime3.SelectedItem.Text + ":" + Drptime4.SelectedItem.Text;
                date1 = DateTime.Parse((DateTime.Now.ToString("yyyy/MM/dd") + " " + Drptime1.SelectedItem.Text + ":" + Drptime2.SelectedItem.Text));
                date2 = DateTime.Parse((DateTime.Now.ToString("yyyy/MM/dd") + " " + Drptime3.SelectedItem.Text + ":" + Drptime4.SelectedItem.Text));
            }


            //判斷是否已有人預約
            string strConn = ConfigurationManager.ConnectionStrings["MENU"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(strConn))
            {
                //String QQ = "select * from TB_Carrent where (startrent BETWEEN '" + (datestart.Text + " " + DropDownList2.SelectedItem.Text + ":" + DropDownList3.SelectedItem.Text) + "' AND  '" + (dateend.Text + " " + DropDownList4.SelectedItem.Text + ":" + DropDownList5.SelectedItem.Text) + "') or (endrent BETWEEN  '" + (datestart.Text + " " + DropDownList2.SelectedItem.Text + ":" + DropDownList3.SelectedItem.Text) + "' AND  '" + (dateend.Text + " " + DropDownList4.SelectedItem.Text + ":" + DropDownList5.SelectedItem.Text) + "') and (car_no='" + DropDownList1.SelectedValue + "')";
                String QQ = "select * from TB_Conference where (((starttime BETWEEN '" + datest1 + "' AND  '" + datest2 + "') and(starttime <>'" + datest2 + "')) or ((endtime BETWEEN  '" + datest1 + "' AND  '" + datest2 + "')and(endtime <>'" + datest1 + "')) or (starttime < '" + datest1 + "' AND endtime> '" + datest2 + "')) and (Roomid='" + DropDownList1.SelectedValue + "')";

                SqlDataAdapter da = new SqlDataAdapter(QQ, conn);
                DataSet ds = new DataSet();
                da.Fill(ds);
                if (ds.Tables[0].Rows.Count != 0)
                {
                    for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
                    {
                        conn.Close();
                        string strJS = "alert('此時段已有人預約');";
                        //Page.ClientScript.RegisterStartupScript(this.GetType(), "", strJS, true);
                        ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "", strJS, true);
                        return;
                    }
                }

            }

            //取得申請者姓名
            JuicDao dao = new JuicDao("MENU");
            var name = dao.GetUser(Page.User.Identity.Name.ToString());
            string username = "租借人待確認";
            if (name.Rows.Count > 0)
            {
                username = name.Rows[0]["username"].ToString();

            }

            using (SqlConnection conn = new SqlConnection(strConn))
            {
                string strCmd = "Insert into TB_Conference(Roomid,Roomname,rentdate,starttime,endtime,userid,username,purpose,water,people,PS)values(@Roomid,@Roomname,@rentdate,@starttime,@endtime,@userid,@username,@purpose,@water,@people,@PS)";
                using (SqlCommand cmd = new SqlCommand(strCmd, conn))
                {
                    cmd.Parameters.AddWithValue("@Roomid", DropDownList1.SelectedValue);
                    cmd.Parameters.AddWithValue("@Roomname", DropDownList1.SelectedItem.Text);
                    cmd.Parameters.AddWithValue("@rentdate", Calendar1.SelectedDate.ToString("yyyy/MM/dd"));
                    cmd.Parameters.AddWithValue("@starttime", date1);
                    cmd.Parameters.AddWithValue("@endtime", date2);
                    cmd.Parameters.AddWithValue("@userid", User.Identity.Name.ToString());
                    cmd.Parameters.AddWithValue("@username", username);
                    cmd.Parameters.AddWithValue("@purpose", TextBoxwhy1.Text);
                    cmd.Parameters.AddWithValue("@water", Drpwater1.SelectedItem.Text);
                    cmd.Parameters.AddWithValue("@people", Drpman1.SelectedItem.Text);
                    cmd.Parameters.AddWithValue("@PS", TextBoxPS1.Text);

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
                        string strJS = "alert('" + message + "');location.href = ('Conferenceroom.aspx');";
                        //Page.ClientScript.RegisterStartupScript(this.GetType(), "", strJS, true);
                        ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "", strJS, true);
                    }
                    finally
                    {
                        conn.Close();
                        string strJS = "alert('" + message + "');location.href = ('Conferenceroom.aspx');";
                        //Page.ClientScript.RegisterStartupScript(this.GetType(), "", strJS, true);
                        ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "", strJS, true);

                    }

                }
            }



        }

        protected void Button2_Click(object sender, EventArgs e)
        {
            if (Panel1.Visible == false)
            {
                Panel1.Visible = true;
                Button1.Visible = true;
            }
            else
            {
                Panel1.Visible = false;
            }
            Panel3.Visible = false;
        }

        protected void GridView3_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            JuicDao dao = new JuicDao("MENU");
            var name = dao.GetUser(Page.User.Identity.Name.ToString());
            string username = "";
            if (name.Rows.Count > 0)
            {
                username = name.Rows[0]["username"].ToString();

            }

            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                e.Row.Cells[1].ForeColor = System.Drawing.Color.Red;
                e.Row.Cells[2].ForeColor = System.Drawing.Color.Red;



                if (e.Row.Cells[3].Text.Trim() == username.Trim()||checkma.Text=="OK")
                {
                    Button btn = (Button)e.Row.FindControl("del");
                    btn.Visible = true;
                    Button btn2 = (Button)e.Row.FindControl("back");
                    btn2.Visible = true;

                }
            }
            
        }
        protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            var id = (HiddenField) e.Row.FindControl("HiddenField1");
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                switch (int.Parse(id.Value))
                {
                    case 1:
                    //case "會議室-T301":
                        e.Row.Attributes.Add("style", "background-color:#bfd2fc");
                        break;
                    case 2:
                    //case "會議室-T302":
                        e.Row.Attributes.Add("style", "background-color:#f7d7b2");
                        break;
                    case 3:
                    //case "會議室-T303":
                        e.Row.Attributes.Add("style", "background-color:#c8f7c0");
                        break;
                    case 4:
                    //case "會議室-T305":
                        e.Row.Attributes.Add("style", "background-color:#ff8cc3");
                        break;
                    default:
                        break;
                }
                
            }
        }
        protected void GridView1_RowDeleted(object sender, GridViewDeletedEventArgs e)
        {
            string strJS = "alert('刪除成功');location.href = ('Conferenceroom.aspx');";
            Page.ClientScript.RegisterStartupScript(this.GetType(), "", strJS, true);
            //ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "", strJS, true);
        }

        protected void GridView1_RowUpdated(object sender, GridViewUpdatedEventArgs e)
        {
            string strJS = "alert('更新成功');location.href = ('Conferenceroom.aspx');";
            Page.ClientScript.RegisterStartupScript(this.GetType(), "", strJS, true);
            //ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "", strJS, true);
        }

        protected void Calendar2_SelectionChanged(object sender, EventArgs e)
        {
            GridView1.DataSourceID = SqlDataSource3.ID;
        }

        protected void Button3_Click(object sender, EventArgs e)
        {
            GridView1.DataSourceID = SqlDataSource4.ID;
        }

        protected void Button4_Click(object sender, EventArgs e)
        {
            GridView1.DataSourceID = SqlDataSource4.ID;
            Response.ClearContent();
            Response.Write("<meta http-equiv=Content-Type content=text/html;charset=utf-8>");
            string excelFileName = "會議室租借狀況" + DateTime.Now.ToString("yyyyMMddHHmmss") + ".xls";
            Response.AddHeader("content-disposition", "attachment;filename=" + Server.UrlEncode(excelFileName));
            Response.ContentType = "application/excel";
            System.IO.StringWriter stringWrite = new System.IO.StringWriter();
            System.Web.UI.HtmlTextWriter htmlWrite = new HtmlTextWriter(stringWrite);
            GridView1.RenderControl(htmlWrite);
            Response.Write(stringWrite.ToString());
            Response.End();
        }
        public override void VerifyRenderingInServerForm(Control control)
        {
            // '處理'GridView' 的控制項 'GridView' 必須置於有 runat=server 的表單標記之中   
        }

        protected void Button5_Click(object sender, EventArgs e)
        {
            DAL.JuicDao dao = new DAL.JuicDao("MENU");
            dao.BackupConferenceRent(DateTime.Now.AddDays(-3));
            dao.DeleteConferenceRent(DateTime.Now.AddDays(-3));//待新增
        }

        protected void Button6_Click(object sender, EventArgs e)
        {
            if (Panel3.Visible == false)
            {
                Panel3.Visible = true;

            }
            else
            {
                Panel3.Visible = false;
            }
            Panel1.Visible = false;
        }

        protected void pzbtn_Click(object sender, EventArgs e)
        {

            string datest1;
            string datest2;
            DateTime date1;
            DateTime date2;

            datest1 = pztex0.Text + " " + pzdrp2.SelectedItem.Text + ":" + pzdrp3.SelectedItem.Text;
            datest2 = pztex0.Text + " " + pzdrp4.SelectedItem.Text + ":" + pzdrp5.SelectedItem.Text;
            date1 = DateTime.Parse(datest1);
            date2 = DateTime.Parse(datest2);

            int plusday = 1;
            int.TryParse(pztex1.Text, out plusday);
            int count = 1;
            int.TryParse(pztex2.Text, out count);

            //判斷是否有人預約功能暫時保留
            //for (int i = 0; i < count; i++)
            //{
            //    //判斷是否已有人預約
            //    string strConn = ConfigurationManager.ConnectionStrings["MENU"].ConnectionString;
            //    using (SqlConnection conn = new SqlConnection(strConn))
            //    {

            //        //String QQ = "select * from TB_Carrent where (startrent BETWEEN '" + (datestart.Text + " " + DropDownList2.SelectedItem.Text + ":" + DropDownList3.SelectedItem.Text) + "' AND  '" + (dateend.Text + " " + DropDownList4.SelectedItem.Text + ":" + DropDownList5.SelectedItem.Text) + "') or (endrent BETWEEN  '" + (datestart.Text + " " + DropDownList2.SelectedItem.Text + ":" + DropDownList3.SelectedItem.Text) + "' AND  '" + (dateend.Text + " " + DropDownList4.SelectedItem.Text + ":" + DropDownList5.SelectedItem.Text) + "') and (car_no='" + DropDownList1.SelectedValue + "')";
            //        String QQ = "select * from TB_Conference where (((starttime BETWEEN '" + datest1 + "' AND  '" + datest2 + "') and(starttime <>'" + datest2 + "')) or ((endtime BETWEEN  '" + datest1 + "' AND  '" + datest2 + "')and(endtime <>'" + datest1 + "')) or (starttime < '" + datest1 + "' AND endtime> '" + datest2 + "')) and (Roomid='" + DropDownList1.SelectedValue + "')";

            //        SqlDataAdapter da = new SqlDataAdapter(QQ, conn);
            //        DataSet ds = new DataSet();
            //        da.Fill(ds);
            //        if (ds.Tables[0].Rows.Count != 0)
            //        {
            //            for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
            //            {
            //                conn.Close();
            //                string strJS = "alert('此時段已有人預約');";
            //                //Page.ClientScript.RegisterStartupScript(this.GetType(), "", strJS, true);
            //                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "", strJS, true);
            //                return;
            //            }
            //        }

            //    }
            //}



            //取得申請者姓名
            JuicDao dao = new JuicDao("MENU");
            var name = dao.GetUser(Page.User.Identity.Name.ToString());
            string username = "租借人待確認";
            if (name.Rows.Count > 0)
            {
                username = name.Rows[0]["username"].ToString();

            }

            string strConn = ConfigurationManager.ConnectionStrings["MENU"].ConnectionString;

            for (int i = 0; i < count; i++)
            {
                using (SqlConnection conn = new SqlConnection(strConn))
                {
                    string strCmd = "Insert into TB_Conference(Roomid,Roomname,rentdate,starttime,endtime,userid,username,purpose,water,people,PS)values(@Roomid,@Roomname,@rentdate,@starttime,@endtime,@userid,@username,@purpose,@water,@people,@PS)";
                    using (SqlCommand cmd = new SqlCommand(strCmd, conn))
                    {
                        cmd.Parameters.AddWithValue("@Roomid", pzdrp1.SelectedValue);
                        cmd.Parameters.AddWithValue("@Roomname", pzdrp1.SelectedItem.Text);
                        cmd.Parameters.AddWithValue("@rentdate", date1.AddDays(plusday * i).Date);
                        cmd.Parameters.AddWithValue("@starttime", date1.AddDays(plusday * i));
                        cmd.Parameters.AddWithValue("@endtime", date2.AddDays(plusday * i));
                        cmd.Parameters.AddWithValue("@userid", User.Identity.Name.ToString());
                        cmd.Parameters.AddWithValue("@username", username);
                        cmd.Parameters.AddWithValue("@purpose", pztex3.Text);
                        cmd.Parameters.AddWithValue("@water", pzdrp6.SelectedItem.Text);
                        cmd.Parameters.AddWithValue("@people", pzdrp7.SelectedItem.Text);
                        cmd.Parameters.AddWithValue("@PS", pztex4.Text);

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
                            string strJS = "alert('" + message + "');location.href = ('Conferenceroom.aspx');";
                            //Page.ClientScript.RegisterStartupScript(this.GetType(), "", strJS, true);
                            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "", strJS, true);
                        }
                        finally
                        {
                            conn.Close();
                            string strJS = "alert('" + message + "');location.href = ('Conferenceroom.aspx');";
                            //Page.ClientScript.RegisterStartupScript(this.GetType(), "", strJS, true);
                            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "", strJS, true);

                        }

                    }
                }
            }

        }

        protected void GridView3_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            JuicDao dao = new JuicDao("MENU");
            
            if (e.CommandName == "del")
            {
                var name = dao.conferdel(e.CommandArgument.ToString().Trim());
                string strJS = "alert('刪除成功');location.href = ('Conferenceroom.aspx');";
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "", strJS, true);
            }
            if (e.CommandName == "back")
            {
                var name2 = dao.conferback(e.CommandArgument.ToString().Trim());
                string strJS = "alert('以現在時間提前歸還');location.href = ('Conferenceroom.aspx');";
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "", strJS, true);
            }
        }
    }
}