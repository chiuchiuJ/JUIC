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
    public partial class User : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e) //寫入目前使用者姓名
        {            //登入檢查
            Label1.Text = User.Identity.Name.ToString();
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
                JuicDao dao = new JuicDao("MENU");

                var Userdata = dao.GetUserdata(User.Identity.Name.ToString());

                if (Userdata.Rows.Count != 0)
                {
                    //TextBox4.Text = Userdata.Rows[0]["tel1"].ToString();
                    TextBox5.Text = Userdata.Rows[0]["mtel"].ToString();
                    TextBox6.Text = Userdata.Rows[0]["addr1"].ToString();
                    //TextBox7.Text = Userdata.Rows[0]["addr2"].ToString();
                    Label4.Text = Userdata.Rows[0]["addr2"].ToString();
                    TextBox8.Text = Userdata.Rows[0]["attn"].ToString();
                    TextBox9.Text = Userdata.Rows[0]["rela_tel"].ToString();
                    TextBox10.Text = Userdata.Rows[0]["rela_addr"].ToString();
                    TextBox11.Text = Userdata.Rows[0]["rela"].ToString();
                    TextBox4.Text = Userdata.Rows[0]["tel1"].ToString();
                }

                var CheckUserdata = dao.CheckUserdata(User.Identity.Name.ToString());
                if (CheckUserdata.Rows.Count != 0)
                {
                    Label2.Visible = true;
                    Label3.Visible = true;
                }

                var Bkcomment = dao.Bkcomment(User.Identity.Name.ToString());
                if (Bkcomment.Rows.Count != 0)
                {
                    if (Bkcomment.Rows[0]["hrbkcomment"].ToString() != "")
                    {
                        Label5.Text = "先前個人資料修改被退件，請重新申請，退件理由：" + Bkcomment.Rows[0]["hrbkcomment"].ToString();
                    }

                }

            }
            //-------------------------------------------------------------------------------------



        }

        protected void Button1_Click(object sender, EventArgs e) //修改密碼
        {
            JuicERP.DAL.JuicDao dao = new DAL.JuicDao("MENU");

            var tb = dao.GetUser(User.Identity.Name.ToString());
            if (tb.Rows.Count > 0 && Decrypt(Convert.ToString(tb.Rows[0]["Password"]).Trim()) == TextBox1.Text.Trim())
            {
                dao = null;

                if (TextBox2.Text.Trim() == TextBox3.Text.Trim())
                {
                    string newpass = Encrypt(TextBox2.Text.Trim());

                    string strConn = ConfigurationManager.ConnectionStrings["MENU"].ConnectionString;
                    using (SqlConnection conn = new SqlConnection(strConn))
                    {
                        string strCmd = "UPDATE bas03 SET password=@password Where userid='" + User.Identity.Name.ToString() + "'";
                        using (SqlCommand cmd = new SqlCommand(strCmd, conn))
                        {
                            cmd.Parameters.AddWithValue("@password", newpass);

                            string message = "";

                            try
                            {
                                conn.Open();
                                cmd.ExecuteNonQuery();
                                message = "密碼修改成功";

                            }
                            catch (Exception ex)
                            {
                                message = ex.Message;
                                string strJS = "alert('" + message + "');location.href = ('User.aspx');";
                                Page.ClientScript.RegisterStartupScript(this.GetType(), "", strJS, true);
                            }
                            finally
                            {
                                conn.Close();
                                string strJS = "alert('" + message + "');location.href = ('User.aspx');";
                                Page.ClientScript.RegisterStartupScript(this.GetType(), "", strJS, true);
                                

                            }

                        }

                    }
                }
            }
            else
            {
                dao = null;
                string strJS = "alert('密碼輸入錯誤');location.href = ('User.aspx');";
                Page.ClientScript.RegisterStartupScript(this.GetType(), "", strJS, true);
                return;
            }





        }


        int[] p = { 173, 31, 59, 53, 227, 11, 301, 403, 143 };
        int[] s = { 5, 7, 11, 53, 59, 59, 61, 67, 71 };
        int counts = 9;
        int cjh = 259;
        private string Encrypt(string plainText) //加密演算
        {
            DateTime now = DateTime.Now;
            int key = (now.Minute * now.Second) % counts;
            string k0 = key.ToString();
            int ste = (now.Minute * now.Second) % 5;
            string s0 = ste.ToString();
            string encryptText = "";
            foreach (char c in plainText)
            {
                int v = (int)c;
                v = ModOfPower(v, p[key], cjh);
                encryptText += v.ToString().Length.ToString() + v.ToString();
                key = (key + ste) % counts;
            }
            return k0 + s0 + encryptText;
        }

        private string Decrypt(string encodedText) //解密演算
        {
            int k0 = encodedText[0] - '0';
            int s0 = encodedText[1] - '0';
            int key = k0;
            int ste = s0;
            string encryptText = encodedText.Substring(2);
            string plainText = "";
            int cIdx = 0;
            while (cIdx < encryptText.Length - 1)
            {
                int chrLength = encryptText[cIdx] - '0';
                cIdx++;
                int v = Convert.ToInt32(encryptText.Substring(cIdx, chrLength));
                cIdx += chrLength;
                v = ModOfPower(v, s[key], cjh);
                plainText += (char)v;
                key = (key + ste) % counts;
            }
            return plainText;
        }

        private int ModOfPower(int x, int pow, int mod)
        {
            int value = 1;
            for (int i = 0; i < pow; i++)
            {
                value = (value * x) % mod;
            }
            return value;
        }

        protected void Button2_Click(object sender, EventArgs e)
        {
            //顯示自己能瀏覽的網頁權限

            CheckBoxList1.Enabled = false;
            CheckBoxList2.Enabled = false;

            foreach (ListItem item in CheckBoxList1.Items)
            {
                item.Selected = false;
            }
            foreach (ListItem item in CheckBoxList2.Items)
            {
                item.Selected = false;
            }

            List<int> index = new List<int>();

            string strConn = ConfigurationManager.ConnectionStrings["MENU"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(strConn))
            {
                String QQ = "select userid,MenuId from TB_MenusControl where userid='" + User.Identity.Name.ToString() + "' order by MenuId";

                SqlDataAdapter da = new SqlDataAdapter(QQ, conn);
                DataSet ds = new DataSet();
                da.Fill(ds);
                if (ds.Tables[0].Rows.Count != 0)
                {
                    for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
                    {
                        index.Add(int.Parse(ds.Tables[0].Rows[i][1].ToString()));
                    }
                }

            }

            foreach (ListItem item in CheckBoxList1.Items) //動態勾選checkbox
            {
                if (index.Contains(int.Parse(item.Value)))
                {
                    item.Selected = true;
                }

            }
            foreach (ListItem item in CheckBoxList2.Items) //動態勾選checkbox
            {
                if (index.Contains(int.Parse(item.Value)))
                {
                    item.Selected = true;
                }
            }
        }

        protected void Button3_Click(object sender, EventArgs e)
        {
            JuicDao dao = new JuicDao("MENU");

            var DELUserdata = dao.DeleteUserdata(User.Identity.Name.ToString());

            var Userdata = dao.InsertUserdata(User.Identity.Name.ToString(), TextBox4.Text, TextBox6.Text, TextBox5.Text, TextBox8.Text, TextBox11.Text, TextBox10.Text, TextBox9.Text, "N");

            string strJS = "alert('申請成功，請在下方確認申請資料');location.href = ('User.aspx');";
            Page.ClientScript.RegisterStartupScript(this.GetType(), "", strJS, true);

        }
    }
}