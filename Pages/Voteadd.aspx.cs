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
    public partial class Voteadd : System.Web.UI.Page
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
            //檢查是否有新增投票之權限
            DAL.JuicDao dao = new DAL.JuicDao("MENU");
            var tb = dao.checkcontrol(User.Identity.Name.ToString(), 5);
            //無新增投票權限 取消按鈕
            if (tb.Rows.Count == 0)
            {
                Button1.Enabled = false;
                Button1.Text = "尚未開通新增投票權限";
            }
        }

        //protected void Button1_Click(object sender, EventArgs e)
        //{
        //    int test;
        //    int.TryParse(TextBox4.Text, out test);
        //    Label1.Text = test.ToString();
        //}
        protected void CheckBoxList1_SelectedIndexChanged(object sender, EventArgs e)
        {
            Panel2.Visible = false;
            Panel3.Visible = false;

            if (CheckBoxList1.Items[1].Selected)
            {
                Panel2.Visible = true;
            }
            
            if (CheckBoxList1.Items[2].Selected)
            {
                Panel3.Visible = true;
            }
        }


        protected void DropDownList1_SelectedIndexChanged(object sender, EventArgs e)
        {
            int index1;
            int.TryParse(DropDownList1.SelectedValue, out index1);

            Label[] labs = new Label[] { votelistname11, votelistname12, votelistname13, votelistname14, votelistname15, votelistname16, votelistname17, votelistname18 };
            TextBox[] boxs = new TextBox[] { votelist11, votelist12, votelist13, votelist14, votelist15, votelist16, votelist17, votelist18 };
            foreach (Label item in labs)
            {
                item.Visible = false;
            }
            foreach (TextBox item in boxs)
            {
                item.Visible = false;
            }

            if (index1 == 0)
            {
                return;
            }

            int i =0;
            int i2 = 0;
            foreach (Label item in labs)
            {
                if(i<index1)
                {

                    item.Visible = true;
                    i++;
                }                               
            }
            foreach (TextBox item in boxs)
            {
                if (i2 < index1)
                {

                    item.Visible = true;
                    i2++;
                }
            }



        }

        protected void DropDownList2_SelectedIndexChanged(object sender, EventArgs e)
        {
            int index1;
            int.TryParse(DropDownList2.SelectedValue, out index1);

            Label[] labs = new Label[] { votelistname21, votelistname22, votelistname23, votelistname24, votelistname25, votelistname26, votelistname27, votelistname28 };
            TextBox[] boxs = new TextBox[] { votelist21, votelist22, votelist23, votelist24, votelist25, votelist26, votelist27, votelist28 };
            foreach (Label item in labs)
            {
                item.Visible = false;
            }
            foreach (TextBox item in boxs)
            {
                item.Visible = false;
            }

            if (index1 == 0)
            {
                return;
            }

            int i = 0;
            int i2 = 0;
            foreach (Label item in labs)
            {
                if (i < index1)
                {

                    item.Visible = true;
                    i++;
                }
            }
            foreach (TextBox item in boxs)
            {
                if (i2 < index1)
                {

                    item.Visible = true;
                    i2++;
                }
            }


        }



        protected void DropDownList3_SelectedIndexChanged(object sender, EventArgs e)
        {
            int index1;
            int.TryParse(DropDownList3.SelectedValue, out index1);

            Label[] labs = new Label[] { votelistname31, votelistname32, votelistname33, votelistname34, votelistname35, votelistname36, votelistname37, votelistname38 };
            TextBox[] boxs = new TextBox[] { votelist31, votelist32, votelist33, votelist34, votelist35, votelist36, votelist37, votelist38 };
            foreach (Label item in labs)
            {
                item.Visible = false;
            }
            foreach (TextBox item in boxs)
            {
                item.Visible = false;
            }

            if (index1 == 0)
            {
                return;
            }

            int i = 0;
            int i2 = 0;
            foreach (Label item in labs)
            {
                if (i < index1)
                {

                    item.Visible = true;
                    i++;
                }
            }
            foreach (TextBox item in boxs)
            {
                if (i2 < index1)
                {

                    item.Visible = true;
                    i2++;
                }
            }
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            //變數設定和檢查區域
            DateTime datenow = DateTime.Now;
            int Votelist1set = 0;
            int Votelist2set = 2;
            int Votelist3set = 2;

            if (CheckBox1.Checked)
            {
                Votelist1set = 1;
            }

            if (CheckBoxList1.Items[1].Selected)
            {
                Votelist2set = 0;
                if(CheckBox2.Checked)
                {
                    Votelist2set = 1;
                }
            }
            if (CheckBoxList1.Items[2].Selected)
            {
                Votelist3set = 0;
                if (CheckBox3.Checked)
                {
                    Votelist3set = 1;
                }
            }

            List<int> VoteNumber = new List<int>();
            List<string> VoteCHN = new List<string>();
            List<string> VoteItem = new List<string>();
            List<int> VoteItemno = new List<int>();

            int index1;
            int.TryParse(DropDownList1.SelectedValue, out index1);
            TextBox[] boxs1 = new TextBox[] { votelist11, votelist12, votelist13, votelist14, votelist15, votelist16, votelist17, votelist18 };
            int index2;
            int.TryParse(DropDownList2.SelectedValue, out index2);
            TextBox[] boxs2 = new TextBox[] { votelist21, votelist22, votelist23, votelist24, votelist25, votelist26, votelist27, votelist28 };
            int index3;
            int.TryParse(DropDownList3.SelectedValue, out index3);
            TextBox[] boxs3 = new TextBox[] { votelist31, votelist32, votelist33, votelist34, votelist35, votelist36, votelist37, votelist38 };

            //加入第一選項欄位
            int i1 = 0;
            foreach(TextBox item in boxs1)
            {
                if (i1 < index1)
                {
                    VoteNumber.Add(1);
                    VoteCHN.Add(TextBox1.Text);
                    VoteItem.Add(item.Text);
                    VoteItemno.Add(i1);
                    i1++;
                }
                else
                {
                    break;
                }
                
            }

            //加入第二選項欄位
            int i2 = 0;
            foreach (TextBox item in boxs2)
            {
                if (i2 < index2)
                {
                    VoteNumber.Add(2);
                    VoteCHN.Add(TextBox2.Text);
                    VoteItem.Add(item.Text);
                    VoteItemno.Add(i2);
                    i2++;
                }
                else
                {
                    break;
                }

            }

            //加入第三選項欄位
            int i3 = 0;
            foreach (TextBox item in boxs3)
            {
                if (i3 < index3)
                {
                    VoteNumber.Add(3);
                    VoteCHN.Add(TextBox3.Text);
                    VoteItem.Add(item.Text);
                    VoteItemno.Add(i3);
                    i3++;
                }
                else
                {
                    break;
                }

            }

            //程式碼執行區域
            //加入TB_Vote
            string strConn = ConfigurationManager.ConnectionStrings["MENU"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(strConn))
            {
                string strCmd = "Insert into TB_Vote(VoteTitle,VoteContent,VoteHolder,VoteStart,VoteEnd,VoteCreate,Votelist1,Votelist1set,Votelist2,Votelist2set,Votelist3,Votelist3set)values(@VoteTitle,@VoteContent,@VoteHolder,@VoteStart,@VoteEnd,@VoteCreate,@Votelist1,@Votelist1set,@Votelist2,@Votelist2set,@Votelist3,@Votelist3set)";
                using (SqlCommand cmd = new SqlCommand(strCmd, conn))
                {
                    cmd.Parameters.AddWithValue("@VoteTitle", title.Text);
                    cmd.Parameters.AddWithValue("@VoteContent", content.Text);
                    cmd.Parameters.AddWithValue("@VoteHolder", User.Identity.Name.ToString());
                    cmd.Parameters.AddWithValue("@VoteStart", DateTime.Parse(datestart.Text));
                    cmd.Parameters.AddWithValue("@VoteEnd", DateTime.Parse(dateend.Text));
                    cmd.Parameters.AddWithValue("@VoteCreate", datenow);
                    cmd.Parameters.AddWithValue("@Votelist1", TextBox1.Text);
                    cmd.Parameters.AddWithValue("@Votelist1set", Votelist1set);
                    cmd.Parameters.AddWithValue("@Votelist2", TextBox2.Text);
                    cmd.Parameters.AddWithValue("@Votelist2set", Votelist2set);
                    cmd.Parameters.AddWithValue("@Votelist3", TextBox3.Text);
                    cmd.Parameters.AddWithValue("@Votelist3set", Votelist3set);

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
                        string strJS = "alert('" + message + "');location.href = ('Join.aspx');";
                        Page.ClientScript.RegisterStartupScript(this.GetType(), "", strJS, true);
                    }
                    finally
                    {
                        conn.Close();
                    }

                }

            }
            //程式碼執行區域
            //取得TB_Vote的ID
            int VoteID;
            using (SqlConnection conn = new SqlConnection(strConn))
            {
                String QQ = "select VoteID from TB_Vote where VoteTitle='" + title.Text + "' and CONVERT(VARCHAR(10) , VoteCreate, 111 ) like'%" + datenow.ToString("yyyy/MM/dd") + "%'";

                SqlDataAdapter da = new SqlDataAdapter(QQ, conn);
                DataSet ds = new DataSet();
                da.Fill(ds);

                VoteID = int.Parse(ds.Tables[0].Rows[0][0].ToString().Trim());

                ds.Clear();
            }
            //程式碼執行區域
            //加入TB_VoteList
            for(int i=0;i<VoteNumber.Count;i++)
            {
                using (SqlConnection conn = new SqlConnection(strConn))
                {
                    string strCmd = "Insert into TB_VoteList(VoteID,VoteTitle,VoteNumber,VoteCHN,VoteItem,VoteItemno)values(@VoteID,@VoteTitle,@VoteNumber,@VoteCHN,@VoteItem,@VoteItemno)";
                    using (SqlCommand cmd = new SqlCommand(strCmd, conn))
                    {
                        cmd.Parameters.AddWithValue("@VoteID", VoteID);
                        cmd.Parameters.AddWithValue("@VoteTitle", title.Text);
                        cmd.Parameters.AddWithValue("@VoteNumber", VoteNumber[i]);
                        cmd.Parameters.AddWithValue("@VoteCHN", VoteCHN[i]);
                        cmd.Parameters.AddWithValue("@VoteItem", VoteItem[i]);
                        cmd.Parameters.AddWithValue("@VoteItemno", VoteItemno[i]);


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
                        }   
                        finally
                        {
                            conn.Close();
                            string strJS = "alert('" + message + "');location.href = ('Vote.aspx');";
                            Page.ClientScript.RegisterStartupScript(this.GetType(), "", strJS, true);
                        }

                    }

                }
            }
        }

    }
}