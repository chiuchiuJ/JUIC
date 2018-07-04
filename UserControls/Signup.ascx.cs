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

namespace JuicERP.UserControls
{
    public partial class Signup : System.Web.UI.UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            btnExit.OnClientClick = "CloseControl(\"" + this.Parent.FindControl("ModalPanel").ClientID + "\");  return false;";
        }
        public void SetDbName(string dbName)
        {
            Annname.Value = dbName;
        }
        public void gettitle(string title)//接收由母網頁傳來的資訊
        {
            Label1.Text = title;
        }
        public void getcontent(string content)//接收由母網頁傳來的資訊
        {

            TextBox1.Text = content;

        }
        public void Startdate(string Startdate)//接收由母網頁傳來的資訊
        {

        }
        public void Enddate(string Startdate, string Enddate)//接收由母網頁傳來的資訊
        {
            DateTime starttime = DateTime.Parse(Startdate);
            DateTime endtime = DateTime.Parse(Enddate);
            //判斷報名日期是否已過期
            //用現在時間與截止時間做判別
            if (DateTime.Now < endtime && DateTime.Now > starttime)
            {
                Label2.Text = "可報名";
                Label2.ForeColor = System.Drawing.Color.Empty;
                Panel2.Visible = true;
                Button1.Visible = true;
                Label3.Text = "截止日期：" + endtime.ToString("yyyy/MM/dd") + " 零時前";
            }
            else if (DateTime.Now > endtime)
            {
                Label2.Text = "報名已截止";
                Label2.ForeColor = System.Drawing.Color.Red;
                Panel2.Visible = false;
                Button1.Visible = false;
                Label3.Text = "截止日期：" + endtime.ToString("yyyy/MM/dd") + " 零時整";
            }
            else
            {
                Label2.Text = "報名尚未開始";
                Label2.ForeColor = System.Drawing.Color.Green;
                Panel2.Visible = false;
                Button1.Visible = false;
                Label3.Text = "開始日期：" + endtime.ToString("yyyy/MM/dd") + " 零時";
            }

        }
        public void Addons1(string Addons1)
        {
            //接收由母網頁傳來的資訊，並判斷是否開放編輯使用者
            if (Addons1 == "1")
            {
                TextBox3.ReadOnly = false;
                Label4.Text = "本活動開放親友參加，請在下方填寫人數";
            }
            else
            {
                TextBox3.ReadOnly = true;
                Label4.Text = "";
            }
        }
        public void Addons2(string Addons2)
        {
            //接收由母網頁傳來的資訊，並判斷是否開放多人報名
            if (Addons2 == "1")
            {
                Button2.Visible = true;
                Button1.Visible = false;
            }
            else
            {
                Button1.Visible = true;
                Button2.Visible = false;
            }
        }
        public void getuser(string getuser)// 接收由母網頁傳來的資訊
        {
            JuicDao dao = new JuicDao("MENU");

            var GetUsername = dao.GetUsername(getuser);
            LabeluserID.Text = getuser;
            if (GetUsername.Rows.Count != 0)
            {
                LabeluserName.Text = GetUsername.Rows[0]["username"].ToString();
            }

        }

        public void eventID(string eventID)// 接收由母網頁傳來的資訊
        {
            LabelID.Text = eventID;
        }

        public void getactivedate(string getactivedate, string type)// 接收由母網頁傳來的活動日期和類別
        {
            DateTime acttime = DateTime.Parse(getactivedate);
            Label9.Text = "活動日期：" + acttime.ToString("yyyy/MM/dd");
            Label5.Text = "活動類別：" + type;
        }


        public void FileURL(string FileURL)
        {
            if (FileURL != "0")
            {
                HyperLink1.Visible = true;
                // 接收由母網頁傳來的資訊，並判斷是否提供選擇素食與否
                HyperLink1.NavigateUrl = FileURL;
                HyperLink1.Text = FileURL.Split(new string[] { "/" }, StringSplitOptions.RemoveEmptyEntries)[3].Trim();

            }
            else
            {
                HyperLink1.Visible = false;
            }

        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            // 將報名結果匯入資料庫

            //判斷使用者是否已報名
            string strConn1 = ConfigurationManager.ConnectionStrings["MENU"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(strConn1))
            {
                String QQ = "select emp_no from TB_SignupTotal where eventID='" + LabelID.Text + "' and emp_no='" + LabeluserID.Text + "'";

                SqlDataAdapter da = new SqlDataAdapter(QQ, conn);
                DataSet ds = new DataSet();
                da.Fill(ds);
                if (ds.Tables[0].Rows.Count != 0)
                {
                    Labelvalid.Text = ds.Tables[0].Rows[0][0].ToString().Trim();
                }
                ds.Clear();
            }

            if (Labelvalid.Text == LabeluserID.Text)
            {
                string errormessage = "你已經報名過囉!(修改報名資訊請洽資訊組)";

                string strJS1 = "alert('" + errormessage + "');";
                Page.ClientScript.RegisterStartupScript(this.GetType(), "", strJS1, true);
                return;
                //因使用者已報名，跳出事件
            }





            //防呆，人數輸入錯誤跳出警告
            int people;
            bool peopleresult = int.TryParse(TextBox3.Text.Trim(), out people);
            if (peopleresult == false || people < 1)
            {
                string errormessage2 = "請確認輸入正確人數";

                string strJS1 = "alert('" + errormessage2 + "');";
                Page.ClientScript.RegisterStartupScript(this.GetType(), "", strJS1, true);
                TextBox3.Focus();

                return;
            }

            //建立報名資料在TB_SignupTotal
            string strConn = ConfigurationManager.ConnectionStrings["MENU"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(strConn))
            {
                string strCmd = "Insert into TB_SignupTotal(eventID,title,emp_no,emp_cne,People,PS,DetailTable)values(@eventID,@title,@emp_no,@emp_cne,@People,@PS,@DetailTable)";
                using (SqlCommand cmd = new SqlCommand(strCmd, conn))
                {
                    cmd.Parameters.AddWithValue("@eventID", int.Parse(LabelID.Text));
                    cmd.Parameters.AddWithValue("@title", Label1.Text);
                    cmd.Parameters.AddWithValue("@emp_no", LabeluserID.Text);
                    cmd.Parameters.AddWithValue("@emp_cne", LabeluserName.Text);
                    cmd.Parameters.AddWithValue("@People", people);
                    cmd.Parameters.AddWithValue("@PS", TextBox2.Text);
                    cmd.Parameters.AddWithValue("@DetailTable", "0");

                    string message = "";

                    try
                    {
                        conn.Open();
                        cmd.ExecuteNonQuery();
                        message = "報名成功";

                    }
                    catch (Exception ex)
                    {
                        message = ex.Message;
                    }
                    finally
                    {
                        conn.Close();
                        string strJS = "alert('" + message + "');location.href = ('Join.aspx');";
                        Page.ClientScript.RegisterStartupScript(this.GetType(), "", strJS, true);
                    }


                }
            }


        }

        protected void Button2_Click(object sender, EventArgs e)
        {
            // 將報名結果匯入資料庫

            //判斷使用者是否已報名
            string strConn1 = ConfigurationManager.ConnectionStrings["MENU"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(strConn1))
            {
                String QQ = "select emp_no from TB_SignupTotal where eventID='" + LabelID.Text + "' and emp_no='" + LabeluserID.Text + "'";

                SqlDataAdapter da = new SqlDataAdapter(QQ, conn);
                DataSet ds = new DataSet();
                da.Fill(ds);
                if (ds.Tables[0].Rows.Count != 0)
                {
                    Labelvalid.Text = ds.Tables[0].Rows[0][0].ToString().Trim();
                }
                ds.Clear();
            }

            if (Labelvalid.Text == LabeluserID.Text)
            {
                string errormessage = "你已經報名過囉!(修改報名資訊請洽資訊組)";

                string strJS1 = "alert('" + errormessage + "');";
                Page.ClientScript.RegisterStartupScript(this.GetType(), "", strJS1, true);
                return;
                //因使用者已報名，跳出事件
            }





            //防呆，人數輸入錯誤跳出警告
            int people;
            bool peopleresult = int.TryParse(TextBox3.Text.Trim(), out people);
            if (peopleresult == false || people < 1)
            {
                string errormessage2 = "請確認輸入正確人數";

                string strJS1 = "alert('" + errormessage2 + "');";
                Page.ClientScript.RegisterStartupScript(this.GetType(), "", strJS1, true);
                TextBox3.Focus();

                return;
            }


            string strConn = ConfigurationManager.ConnectionStrings["MENU"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(strConn))
            {
                string strCmd = "Insert into TB_SignupTotal(eventID,title,emp_no,emp_cne,People,PS,DetailTable)values(@eventID,@title,@emp_no,@emp_cne,@People,@PS,@DetailTable)";
                using (SqlCommand cmd = new SqlCommand(strCmd, conn))
                {
                    cmd.Parameters.AddWithValue("@eventID", int.Parse(LabelID.Text));
                    cmd.Parameters.AddWithValue("@title", Label1.Text);
                    cmd.Parameters.AddWithValue("@emp_no", LabeluserID.Text);
                    cmd.Parameters.AddWithValue("@emp_cne", LabeluserName.Text);
                    cmd.Parameters.AddWithValue("@People", people);
                    cmd.Parameters.AddWithValue("@PS", TextBox2.Text);
                    cmd.Parameters.AddWithValue("@DetailTable", "1");

                    string message = "";

                    try
                    {
                        conn.Open();
                        cmd.ExecuteNonQuery();
                        message = "報名成功";

                    }
                    catch (Exception ex)
                    {
                        message = ex.Message;
                    }
                    finally
                    {
                        conn.Close();
                        //string strJS = "alert('" + message + "');location.href = ('Join.aspx');";
                        //Page.ClientScript.RegisterStartupScript(this.GetType(), "", strJS, true);
                    }


                }
            }
            //取得方才報名的序號
            JuicDao dao = new JuicDao("MENU");
            var GetSingupTotalid = dao.GetSingupTotalid(LabelID.Text, LabeluserID.Text);
            int SingupTotalid = 0;
            if (GetSingupTotalid.Rows.Count != 0)
            {
                SingupTotalid = int.Parse(GetSingupTotalid.Rows[0]["ID"].ToString());
            }
            //建立空白同行者資料在TB_SignupTotalDetail
            string strConn2 = ConfigurationManager.ConnectionStrings["MENU"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(strConn2))
            {
                for (int i = 0; i < people; i++)
                {
                    //string strCmd = "Insert into TB_SignupTotalDetail(SignupTotalid,Name,IDnumber,Birthday,Old,Who,Bigbus,Eat,PS)values(@SignupTotalid,@Name,@IDnumber,@Birthday,@Old,@Who,@Bigbus,@Eat,@PS)";
                    string strCmd = "Insert into TB_SignupTotalDetail(SignupTotalid,Name)values(@SignupTotalid,@Name)";
                    using (SqlCommand cmd = new SqlCommand(strCmd, conn))
                    {

                        cmd.Parameters.AddWithValue("@SignupTotalid", SingupTotalid);
                        if (i == 0)
                        {
                            cmd.Parameters.AddWithValue("@Name", LabeluserName.Text);
                        }
                        else
                        {
                            cmd.Parameters.AddWithValue("@Name", "");
                        }


                        string message = "";

                        try
                        {
                            conn.Open();
                            cmd.ExecuteNonQuery();
                            //message = "報名成功";

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

                }
                string strJS = "alert('報名成功，請繼續填寫詳細資訊');location.href = ('Signupresult.aspx');";
                Page.ClientScript.RegisterStartupScript(this.GetType(), "", strJS, true);
            }
        }
    }
}
