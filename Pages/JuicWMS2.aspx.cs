using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using NPOI.HSSF.UserModel;
using NPOI.SS.UserModel;
using System.IO;
using System.Configuration;
using System.Data.SqlClient;
using JuicERP.DAL;

namespace JuicERP.Pages
{
    public partial class JuicWMS2 : System.Web.UI.Page
    {
        private DataTable _result2
        {
            get
            {
                if (Session["_juicwmsresult"] == null)
                    Session["_juicwmsresult"] = new DataTable();
                return (DataTable)Session["_juicwmsresult"];
            }
            set
            {
                Session["_juicwmsresult"] = value;
            }
        }

        protected DataSet dsHolidays;//行事曆
        protected void Page_Load(object sender, EventArgs e)
        {



            if (!IsPostBack)
            {
                this._result2 = null;

                Calendar1.VisibleDate = DateTime.Today;//行事曆
                FillHolidayDataset();//行事曆上標註特殊日期(從資料庫匯入)

                TextBox5.Text = DateTime.Today.ToShortDateString();
            }


            //檢查是否有新增生日會之權限
            DAL.JuicDao dao = new DAL.JuicDao("MENU");
            var tb = dao.checkcontrol(User.Identity.Name.ToString(), 10);
            //無新增生日會權限 隱藏按鈕
            if (tb.Rows.Count == 0)
            {

                Button1.Enabled = false;
            }

            //檢查是否有新增表單辦法更新權限
            var tb2 = dao.checkcontrol(User.Identity.Name.ToString(), 1);
            if (tb2.Rows.Count == 0)
            {

                Panel3.Visible = false;
            }


            //顯示右方本月壽星一覽
            DateTime eventday = DateTime.Now;
            this._result2 = dao.GetBIR(eventday);
            GridView2.PageIndex = 0;

            BindData();
            //檢查是否有管理公告權限
            DAL.JuicDao dao2 = new DAL.JuicDao("MENU");
            var check = dao2.checkcontrol(User.Identity.Name.ToString(), 26);//待新增
            //有管理權限，顯示刪除按鈕
            if (check.Rows.Count != 0)
            {
                checkma.Text = "OK";

            }

            

        }

        protected void FillHolidayDataset()//取得月初和月尾的日期，做為取得本月資料的判斷值
        {
            DateTime firstDate = new DateTime(Calendar1.VisibleDate.Year,
                Calendar1.VisibleDate.Month, 1);
            DateTime lastDate = GetFirstDayOfNextMonth();
            dsHolidays = GetCurrentMonthData(firstDate, lastDate);
        }

        protected DateTime GetFirstDayOfNextMonth()//行事曆
        {
            int monthNumber, yearNumber;
            if (Calendar1.VisibleDate.Month == 12)
            {
                monthNumber = 1;
                yearNumber = Calendar1.VisibleDate.Year + 1;
            }
            else
            {
                monthNumber = Calendar1.VisibleDate.Month + 1;
                yearNumber = Calendar1.VisibleDate.Year;
            }
            DateTime lastDate = new DateTime(yearNumber, monthNumber, 1);
            return lastDate;
        }

        protected DataSet GetCurrentMonthData(DateTime firstDate, DateTime lastDate)//取得該月特定事件的日期、類型和資訊
        {
            DataSet dsMonth = new DataSet();
            System.Configuration.ConnectionStringSettings cs;
            cs = ConfigurationManager.ConnectionStrings["MENU"];
            String connString = cs.ConnectionString;
            SqlConnection dbConnection = new SqlConnection(connString);
            String query;
            query = "SELECT date,type,PS FROM TB_ImportantDays where date>=@firstDate and date<@lastDate";
            SqlCommand dbCommand = new SqlCommand(query, dbConnection);
            dbCommand.Parameters.Add(new SqlParameter("@firstDate", firstDate));
            dbCommand.Parameters.Add(new SqlParameter("@lastDate", lastDate));

            SqlDataAdapter sqlDataAdapter = new SqlDataAdapter(dbCommand);
            try
            {
                sqlDataAdapter.Fill(dsMonth);
            }
            catch { }
            return dsMonth;
        }


        protected void BindData(string sortExpression = "")
        {
            if (false == String.IsNullOrEmpty(sortExpression))
            {
                using (GVSortHelper gs = new GVSortHelper(ViewState, gvANN.ID))
                {
                    gs.SetSortExpression(sortExpression);
                    gs.SortGV(this._result2);
                }
            }
            GridView2.DataSource = this._result2; //繫結本月生日會資訊
            GridView2.DataBind();
        }

        protected void Calendar1_SelectionChanged(object sender, EventArgs e) //點擊月曆日期的事件
        {
            Calendar1text.Text = "";
            Calendar1text2.Text = "";
            Calendar1text3.Text = "";

            if (Calendar1.SelectedDate == DateTime.Now.Date)
            {

                Calendar1text3.Text = "今天唷!";

            }
            else if (Calendar1.SelectedDate.DayOfWeek == DayOfWeek.Sunday || Calendar1.SelectedDate.DayOfWeek == DayOfWeek.Saturday)
            {

                Calendar1text3.Text = "放假日";
            }
            else
            {

                Calendar1text3.Text = "正常上班";
            }


            //為保護個資法移除之生日顯示功能
            //string[] date = new String[10];
            //string[] nameabc = new String[10];
            //string[] name = new String[10];
            //int count = 0;

            //for (int i = 0; i <= (B.Rows.Count - 1); i++)
            //{
            //    date[count] = B.Rows[i].Cells[2].Text;
            //    nameabc[count] = B.Rows[i].Cells[1].Text;
            //    name[count] = B.Rows[i].Cells[0].Text;
            //    count = count + 1;
            //}

            //bool match = false;
            //int j = 0;
            //while ((!match) && (count > j))
            //{
            //    if (Calendar1.SelectedDate.ToString("MMdd") == date[j])
            //    {

            //        Calendar1text.Text = "It's " + nameabc[j] + "'s birthday!";
            //        Calendar1text2.Text = "這天是 " + name[j] + " 的生日唷!";
            //        match = true;
            //    }
            //    j++;
            //}

            FillHolidayDataset(); //取得本月事件日期的dateset
            DateTime nextDate;
            if (dsHolidays != null) //若點擊的日期為事件日期，則顯示事件資訊
            {
                foreach (DataRow dr in dsHolidays.Tables[0].Rows)
                {
                    nextDate = (DateTime)dr["date"];
                    if (nextDate == Calendar1.SelectedDate)
                    {
                        Calendar1text3.Text = dr["PS"].ToString();
                        //Calendar1text3.ForeColor = System.Drawing.Color.Blue;
                    }
                }
            }
        }



        protected void gvANN_Sorting(object sender, GridViewSortEventArgs e)
        {
            BindData(e.SortExpression);
        }



        //點擊gridview內的button會開啟詳細公告
        protected void gvANN_RowCommand(object sender, GridViewCommandEventArgs e)
        {

            if (e.CommandName == "post")
            {

                ModalPanel.Visible = true;

                Announce.gettitle(e.CommandArgument.ToString().Split(new string[] { ",," }, StringSplitOptions.RemoveEmptyEntries)[0].Trim());
                Announce.getcontent(e.CommandArgument.ToString().Split(new string[] { ",," }, StringSplitOptions.RemoveEmptyEntries)[1].Trim());
                Announce.getpostdate(e.CommandArgument.ToString().Split(new string[] { ",," }, StringSplitOptions.RemoveEmptyEntries)[2].Trim());
                Announce.getdept(e.CommandArgument.ToString().Split(new string[] { ",," }, StringSplitOptions.RemoveEmptyEntries)[3].Trim());
                Announce.getauthor(e.CommandArgument.ToString().Split(new string[] { ",," }, StringSplitOptions.RemoveEmptyEntries)[4].Trim());
                Announce.getattachment(e.CommandArgument.ToString().Split(new string[] { ",," }, StringSplitOptions.RemoveEmptyEntries)[5].Trim());
            }
            if (e.CommandName == "remove")
            {
                JuicDao dao = new JuicDao("MENU");
                //刪除資料夾內檔案
                var MISupload = dao.GetANNupload(e.CommandArgument.ToString());
                if (MISupload.Rows.Count > 0)
                {
                    if (MISupload.Rows[0]["pdfurl"].ToString() != "")
                    {
                        string p_FilePath = MISupload.Rows[0]["pdfurl"].ToString();
                        System.IO.File.Delete(System.Web.Hosting.HostingEnvironment.MapPath(p_FilePath));
                    }

                }

                //刪除資料庫路徑
                dao.DeleteANN(e.CommandArgument.ToString());

                gvANN.DataSourceID = "SqlDataSource1";

                //因updatepanel無法直行
                string strJS = "alert('刪除成功');location.href = ('JuicWMS2.aspx');";
                Page.ClientScript.RegisterStartupScript(this.GetType(), "", strJS, true);
            }
        }





        protected void Calendar1_DayRender(object sender, DayRenderEventArgs e)
        {
            //為保護個資法移除之生日顯示功能
            //Style vacationStyle = new Style();
            //vacationStyle.BackColor = System.Drawing.Color.LightPink;
            //vacationStyle.BorderWidth = 1;



            //for (int i = 0; i <= (B.Rows.Count - 1); i++)
            //{
            //    if (e.Day.Date.ToString("MMdd") == B.Rows[i].Cells[2].Text)
            //    {
            //        e.Cell.ApplyStyle(vacationStyle);
            //    }
            //}



            //將國定假日、特殊日期等顯示在月曆上(改變顏色)
            DateTime nextDate;  //行事曆
            string type;

            if (dsHolidays != null)
            {
                foreach (DataRow dr in dsHolidays.Tables[0].Rows)
                {
                    nextDate = (DateTime)dr["date"];
                    type = dr["type"].ToString().Trim();
                    if (nextDate == e.Day.Date && type == "1") //type1為國定假日，標是為紅色
                    {
                        e.Cell.BackColor = System.Drawing.Color.Red;

                    }
                    else if (nextDate == e.Day.Date && type == "2")//type2為公司重大會議等，標是為藍色
                    {
                        e.Cell.BackColor = System.Drawing.Color.LightBlue;
                        e.Cell.BorderWidth = 1;
                        e.Cell.BorderColor = System.Drawing.Color.Black;
                    }
                    else if (nextDate == e.Day.Date && type == "3")//type3為公司重大活動等，標是為粉色
                    {
                        e.Cell.BackColor = System.Drawing.Color.HotPink;
                        e.Cell.BorderWidth = 1;
                        e.Cell.BorderColor = System.Drawing.Color.Black;
                    }

                }
            }

        }



        protected void Button1_Click(object sender, EventArgs e) //顯示新增生日會按鈕
        {
            if (Addbirthdayevent.Visible == false)
            {
                Addbirthdayevent.Visible = true;
            }
            else if (Addbirthdayevent.Visible == true)
            {
                Addbirthdayevent.Visible = false;
            }
        }

        protected void Button2_Click(object sender, EventArgs e) //新增生日會
        {
            //string date = Request.Form["date1"];

            string strConn = ConfigurationManager.ConnectionStrings["MENU"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(strConn))
            {
                string strCmd = "Insert into TB_Birthdayevent(eventdate,content,PS)values(@eventdate,@content,@PS)";
                using (SqlCommand cmd = new SqlCommand(strCmd, conn))
                {
                    cmd.Parameters.AddWithValue("@eventdate", DateTime.Parse(TextBox1.Text));
                    //cmd.Parameters.AddWithValue("@eventdate", DateTime.Parse(date));
                    cmd.Parameters.AddWithValue("@content", TextBox2.Text);
                    cmd.Parameters.AddWithValue("@PS", TextBox3.Text);

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
                        Addbirthdayevent.Visible = false;
                        Button1.Text = message;
                    }
                    finally
                    {
                        conn.Close();
                        Addbirthdayevent.Visible = false;
                        Button1.Text = message;
                        Button1.BackColor = System.Drawing.Color.LightGreen;
                    }
                }
            }
        }

        protected void Calendar1_VisibleMonthChanged(object sender, MonthChangedEventArgs e)
        {
            FillHolidayDataset(); //當月份更換後，重新繫結當月份的日期事件資料
        }

        protected void gvANN_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                if (checkma.Text == "OK")
                {
                    Button btn = (Button)e.Row.FindControl("remove");
                    btn.Visible = true;
                }
            }
        }

        protected void Button4_Click(object sender, EventArgs e)
        {
            if(Panel1.Visible==false)
            {
                Panel1.Visible = true;
            }
            else if (Panel1.Visible == true)
            {
                Panel1.Visible = false;
            }
        }

        protected void Button5_Click(object sender, EventArgs e)
        {
            if (Panel2.Visible == false)
            {
                Panel2.Visible = true;
            }
            else if (Panel2.Visible == true)
            {
                Panel2.Visible = false;
            }
        }

        protected void Button3_Click(object sender, EventArgs e)
        {
            JuicERP.DAL.JuicDao dao = new DAL.JuicDao("MENU");

            string date = DateTime.Today.ToShortDateString();
            if (TextBox5.Text!="")
            {
                date = TextBox5.Text; 
            }
            var tb = dao.InsertAnnFormInfo(TextBox4.Text, date,TextBox6.Text,TextBox7.Text);

            string strJS = "alert('新增成功');location.href = ('JuicWMS2.aspx');";
            Page.ClientScript.RegisterStartupScript(this.GetType(), "", strJS, true);
        }

        protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "remove")
            {
                JuicERP.DAL.JuicDao dao = new DAL.JuicDao("MENU");

                var tb = dao.DelAnnFormInfo(e.CommandArgument.ToString());

                string strJS = "alert('刪除成功');location.href = ('JuicWMS2.aspx');";
                Page.ClientScript.RegisterStartupScript(this.GetType(), "", strJS, true);
            }
        }

        protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                DAL.JuicDao dao = new DAL.JuicDao("MENU");
                var tb = dao.checkcontrol(User.Identity.Name.ToString(), 1);

                if (tb.Rows.Count !=0)
                {
                    Button btn = (Button)e.Row.FindControl("remove");
                    btn.Visible = true;
                }
            }
        }

        //20180508;04094;evonne要求不顯示此匯率表
        protected void Button6_Click(object sender, EventArgs e)
        {
            if (Panel4.Visible == false)
            {
                Panel4.Visible = true;
            }
            else if (Panel4.Visible == true)
            {
                Panel4.Visible = false;
            }
        }
    }
}