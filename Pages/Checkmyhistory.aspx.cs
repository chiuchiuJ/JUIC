using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;
using System.Configuration;

namespace JuicERP.Pages
{
    public partial class Checkmyhistory : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            DAL.JuicDao dao = new DAL.JuicDao("MENU");
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
                //檢查是否有查詢所有人出勤之權限

                var tb = dao.checkcontrol(User.Identity.Name.ToString(), 2);
                //有查詢所有人出勤權限 取消按鈕
                if (tb.Rows.Count != 0)
                {
                    DropDownList1.DataSourceID = "SqlDataSource5";
                }




                Label1.Text = User.Identity.Name.ToString();
                Label2.Text = User.Identity.Name.ToString();


                var getpay11info = dao.getpay11info(User.Identity.Name.ToString());
                if (getpay11info.Rows.Count != 0)
                {
                    Label3.Text = getpay11info.Rows[0]["emp_cne"].ToString() + "的到職日期是" + getpay11info.Rows[0]["a_d"].ToString() + ",目前休假狀況如下";
                }
                //Label3.Text = "您的到職日期是" + DetailsView1.Rows[0].Cells[1].Text + ",目前休假狀況如下";

                //20180508;04794;jana要求顯示個人本月請假狀況一覽
                //DB8Init();

            }



            if (!IsPostBack)
            {
                //string add = DetailsView1.Rows[0].Cells[1].Text;
                //int a = int.Parse(add.Substring(0, 4));
                //int b = int.Parse(add.Substring(4, 2));
                ////int a = 2014;
                ////int b = 11;
                //int b1 = int.Parse(add.Substring(4, 2));

                //int c = DateTime.Now.Year;
                //int d = DateTime.Now.Month;
                //int yearplus = 1;

                //for (int i1 = 0; i1 <= (12 - b); i1++)
                //{
                //    int y1 = a * 100 + b1;
                //    DropDownList2.Items.Add(y1.ToString());
                //    b1++;
                //}
                //for (int i2 = 1; i2 < (c - a); i2++)
                //{

                //    for (int i2month = 1; i2month <= 12; i2month++)
                //    {
                //        int y2 = (a + yearplus) * 100 + i2month;
                //        DropDownList2.Items.Add(y2.ToString());
                //    }
                //    yearplus++;


                //}
                //for (int i3 = 1; i3 <= d; i3++)
                //{
                //    int y3 = c * 100 + i3;
                //    DropDownList2.Items.Add(y3.ToString());
                //}

                //顯示近兩個月出勤狀況

                int a = int.Parse(DateTime.Now.AddMonths(-1).ToString("yyyy"));
                int b = int.Parse(DateTime.Now.AddMonths(-1).ToString("MM"));


                for (int i = 1; i >= 0; i--)
                {
                    int time = int.Parse(DateTime.Now.AddMonths(-1 + i).ToString("yyyy")) * 100 + int.Parse(DateTime.Now.AddMonths(-1 + i).ToString("MM"));
                    DropDownList2.Items.Add(time.ToString());

                }
            }
            //20180510;04794;jana要求顯示個人考勤狀況一覽
            GVgetData();

        }

        //private void DB8Init()
        //{
        //    System.Configuration.ConnectionStringSettings cs;
        //    cs = ConfigurationManager.ConnectionStrings["MENU"];
        //    String connString = cs.ConnectionString;
        //    SqlConnection dbConnection = new SqlConnection(connString);
        //    String query;
        //    DataSet ds = new DataSet();
        //    string g_nowdate = DateTime.Now.ToString("yyyyMM");
        //    query = @"SELECT emp_cne as '員工姓名',ymd_s as '請假起日' 
        //                    ,ymd_e as '請假迄日',pay0602 as '假別',hs as '時數'
        //              FROM leaverecord 
        //              WHERE emp_no=@emp_no 
        //                    and left(ymd_s,6) =@g_nowdate
        //              ORDER BY ymd_s ";

        //    SqlCommand dbCommand = new SqlCommand(query, dbConnection);
        //    dbCommand.Parameters.Add(new SqlParameter("emp_no", Label1.Text));
        //    dbCommand.Parameters.Add(new SqlParameter("g_nowdate", g_nowdate));
        //    SqlDataAdapter sqlDataAdapter = new SqlDataAdapter(dbCommand);
        //    try
        //    {
        //        sqlDataAdapter.Fill(ds);
        //    }
        //    catch { }
        //    GridView3.DataSource = ds;
        //    GridView3.DataBind();
        //}

        protected void check_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                //if (e.Row.Cells[4].Text.Trim() == "已完成")
                //    e.Row.BackColor = System.Drawing.Color.LightCyan;

                string year = e.Row.Cells[0].Text.Substring(0, 4);
                string month = e.Row.Cells[0].Text.Substring(4, 2);
                string day = e.Row.Cells[0].Text.Substring(6, 2);

                e.Row.Cells[0].Text = year + "年" + month + "月" + day + "日";

                string year1 = e.Row.Cells[1].Text.Substring(0, 4);
                string month1 = e.Row.Cells[1].Text.Substring(4, 2);
                string day1 = e.Row.Cells[1].Text.Substring(6, 2);

                DateTime date = DateTime.Parse(year1 + "-" + month1 + "-" + day1);
                //e.Row.Cells[1].Text = date.DayOfWeek.ToString();
                e.Row.Cells[1].Text = System.Globalization.DateTimeFormatInfo.CurrentInfo.DayNames[(byte)date.DayOfWeek];


            }
        }

        protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                string year1 = e.Row.Cells[1].Text.Substring(0, 4);
                string month1 = e.Row.Cells[1].Text.Substring(4, 2);
                string day1 = e.Row.Cells[1].Text.Substring(6, 2);

                string year2 = e.Row.Cells[2].Text.Substring(0, 4);
                string month2 = e.Row.Cells[2].Text.Substring(4, 2);
                string day2 = e.Row.Cells[2].Text.Substring(6, 2);

                DateTime date1 = DateTime.Parse(year1 + "/" + month1 + "/" + day1);
                DateTime date2 = DateTime.Parse(year2 + "/" + month2 + "/" + day2);

                if (DateTime.Now >= date1 && DateTime.Now <= date2)
                {
                    e.Row.BackColor = System.Drawing.Color.PaleGreen;
                }
                if (DateTime.Now >= date2)
                {
                    e.Row.Visible = false;
                }
                if (e.Row.Cells[4].Text == "0.0000")
                {
                    e.Row.Cells[4].ForeColor = System.Drawing.Color.Red;
                }
            }
        }

        protected void DropDownList1_SelectedIndexChanged(object sender, EventArgs e)
        {
            Label1.Text = DropDownList1.SelectedValue.Trim();
            DAL.JuicDao dao = new DAL.JuicDao("MENU");
            var getpay11info = dao.getpay11info(Label1.Text);
            //無新增公告權限 取消按鈕
            if (getpay11info.Rows.Count != 0)
            {
                Label3.Text = getpay11info.Rows[0]["emp_cne"].ToString() + "的到職日期是" + getpay11info.Rows[0]["a_d"].ToString() + ",目前休假狀況如下";
            }
        }

        protected void GridView2_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {  //-- 當 GridView呈現「每一列」資料列（記錄）的時候，才會執行這裡！
               //-- 所以這裡就像迴圈一樣，會反覆執行喔！！

                if (e.Row.Cells[4].Text == "Y")
                {
                    for (int i = 0; i <= e.Row.Cells.Count - 1; i++)
                    {
                        e.Row.Cells[i].BackColor = System.Drawing.Color.Pink;
                        e.Row.Cells[i].Font.Bold = true;
                    }
                }
                //"&nbsp;"
            }
        }

        protected void CheckBox1_CheckedChanged(object sender, EventArgs e)
        {
            if (CheckBox1.Checked)
            {
                GridView2.Visible = true;
                GridView2.DataSourceID = "SqlDataSource6";
            }
            else
            {
                GridView2.Visible = false;
            }
        }
        private void GVgetData()
        {
            GridView3.DataSource = getData();
            GridView3.DataBind();
        }

        private DataSet getData()
        {
            string yymm = DropDownList2.SelectedItem.Text;
            string[] strary1 = { "平日加班", "假日加班", "病假", "生理假", "事假", "家庭照顧假", "婚假", "產檢假", "產假", "陪產假", "喪假", "特休", "補休", "曠職", "公出", "公假", "出差", "公傷" };
            //                      00          01          02      03      04          05          06      07      08      09          10      11      12      13      14      15      16      17
            string[] strary2 = { "1", "3", "D", "O", "C", "N", "I", "P", "J", "Q", "K", "H", "L", "E", "S", "G", "R", "F" }; //put all into this array
            //                    00   01   02   03   04   05   06   07   08   09   10  11   12    13   14   15   16   17
            DataSet ds = new DataSet();
            String connectString = System.Web.Configuration.WebConfigurationManager.ConnectionStrings["MENU"].ConnectionString;
            SqlConnection cn = new SqlConnection(connectString);
            for (int i = 0; i < strary1.Length; i++)
            {
                String selectString;
                if (i == 0)
                {
                    selectString = @"select '平日加班' rllu_name,sum(b.total) total 
	                                from (
		                                select emp_no,sum(thn) total
		                                from v_pay004 
		                                where yymm=@yymm and rllu ='1' and emp_no=@emp_no
		                                group by emp_no,rllu,rllu_name
		                                union
		                                select emp_no,sum(thn) total
		                                from v_pay004 
		                                where yymm=@yymm and rllu ='2' and emp_no=@emp_no
		                                group by emp_no,rllu,rllu_name
	                                    ) as B group by emp_no ";
                }
                else if (i == 1)
                {
                    selectString = @"select '假日加班' rllu_name,sum(b.total) total 
	                                from (
		                                select emp_no,sum(thn) total
		                                from v_pay004 
		                                where yymm=@yymm and rllu ='3' and emp_no=@emp_no
		                                group by emp_no,rllu,rllu_name
		                                union
		                                select emp_no,sum(thn) total
		                                from v_pay004 
		                                where yymm=@yymm and rllu ='8' and emp_no=@emp_no
		                                group by emp_no,rllu,rllu_name
	                                    ) as B group by emp_no ";
                }
                else
                {
                    selectString = @"SELECT rllu_name,sum(chs) total
	                                FROM v_pay004 
	                                WHERE  yymm=@yymm and emp_no=@emp_no and rllu=@rllu
	                                GROUP BY emp_no,rllu,rllu_name ";
                }
                SqlCommand cmd = new SqlCommand(selectString, cn);
                cmd.Parameters.AddWithValue("@yymm", yymm);
                cmd.Parameters.AddWithValue("@emp_no", Label1.Text);
                cmd.Parameters.AddWithValue("@rllu", strary2[i]);
                SqlDataAdapter da = new SqlDataAdapter(cmd);

                cn.Open();
                da.Fill(ds);
                if (ds.Tables[0].Rows.Count == i)
                {
                    DataRow new_row = ds.Tables[0].NewRow();
                    new_row["rllu_name"] = strary1[i];
                    new_row["total"] = "0";
                    ds.Tables[0].Rows.Add(new_row);
                }
                cn.Close();

            }

            DataSet dtNew = new DataSet();
            DataTable Table = new DataTable();
            dtNew.Tables.Add(Table);
            dtNew.Tables[0].Columns.Add("類別");
            for (int i = 0; i < strary1.Length; i++)
            {
                dtNew.Tables[0].Columns.Add(strary1[i]);
            }

            DataRow dr = dtNew.Tables[0].NewRow();
            dtNew.Tables[0].Rows.Add(dr);
            dtNew.Tables[0].Rows[0][0] = "時數";
            for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
            {
                for (int j = 1; j < ds.Tables[0].Columns.Count; j++)
                {
                    dtNew.Tables[0].Rows[j - 1][i + 1] = ds.Tables[0].Rows[i][j].ToString();
                }
            }
            return dtNew;
        }

        protected void GridView3_DataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                e.Row.Cells[0].Font.Size = 10;
                e.Row.Cells[0].ForeColor = System.Drawing.ColorTranslator.FromHtml("#CCCCFF");
                e.Row.Cells[0].Font.Bold = true;
                e.Row.Cells[0].BackColor = System.Drawing.ColorTranslator.FromHtml("#003399");
            }
        }
    }
}