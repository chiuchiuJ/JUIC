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
    public partial class Vote : System.Web.UI.UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            btnExit.OnClientClick = "CloseControl(\"" + this.Parent.FindControl("ModalPanel").ClientID + "\");  return false;";


        }
        public void getVoteTitle(string VoteTitle)
        {
            Labeltitle.Text = VoteTitle;
        }
        public void getVoteContent(string VoteContent)
        {
            TextBoxContent.Text = VoteContent;
        }
        public void getVoteStart(string VoteStart)
        {

        }
        public void getVoteEnd(string VoteEnd)
        {
         
        }
        public void getVoteStartEnd(string VoteStart, string VoteEnd)
        {
            DateTime starttime = DateTime.Parse(VoteStart);
            DateTime endtime = DateTime.Parse(VoteEnd);
            if (DateTime.Now < endtime && DateTime.Now>starttime)
            {
                Label2.Text = "可投票";
                Label2.ForeColor = System.Drawing.Color.Empty;
                Panel2.Visible = true;
                Button1.Visible = true;
                Label3.Text = "投票結束日期：" + endtime.ToString("yyyy/MM/dd") + " 零時前";
            }
            else if(DateTime.Now > endtime)
            {
                Label2.Text = "投票已截止";
                Label2.ForeColor = System.Drawing.Color.Red;
                Panel2.Visible = false;
                Button1.Visible = false;
                Label3.Text = "投票結束日期：" + endtime.ToString("yyyy/MM/dd") + " 零時整";
            }
            else
            {
                Label2.Text = "投票尚未開始";
                Label2.ForeColor = System.Drawing.Color.Green;
                Panel2.Visible = false;
                Button1.Visible = false;
                Label3.Text = "投票開始日期：" + starttime.ToString("yyyy/MM/dd") + " 零時";
            }
        }
        public void getVotelist1(string Votelist1)
        {
            Labelvote1.Visible = false;
            if (Votelist1.Trim() != "")
            {
                Labelvote1.Visible = true;
                Labelvote1.Text = Votelist1;
            }
        }
        public void getVotelist1set(string Votelist1set, string VoteID)
        {
            RadioButtonList1.Visible = false;
            CheckBoxList1.Visible = false;
            RadioButtonList1.Items.Clear();
            CheckBoxList1.Items.Clear();

            if (Votelist1set=="2")
            {
                Labelvote1.Visible = false;
                return;
            }

            string VoteNumber = "1";

            string strConn = ConfigurationManager.ConnectionStrings["MENU"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(strConn))
            {
                String QQ = " select VoteItem from TB_VoteList where VoteNumber ='" + VoteNumber + "' and VoteID ='"+VoteID+"'";

                SqlDataAdapter da = new SqlDataAdapter(QQ, conn);
                DataSet ds = new DataSet();
                da.Fill(ds);
                
                if (Votelist1set == "0")
                {
                    for (int rows = 0; rows <= ds.Tables[0].Rows.Count - 1; rows++)
                    {
                        
                        RadioButtonList1.Items.Add(ds.Tables[0].Rows[rows][0].ToString().Trim());
                        RadioButtonList1.Items[rows].Value = rows.ToString();
                    }
                    RadioButtonList1.Visible = true;
                    RadioButtonList1.Items[0].Selected = true;
                }
                else if (Votelist1set == "1")
                {
                    Labelvote1.Text += "(可多選)";
                    for (int rows = 0; rows <= ds.Tables[0].Rows.Count - 1; rows++)
                    {
     
                        CheckBoxList1.Items.Add(ds.Tables[0].Rows[rows][0].ToString().Trim());
                        CheckBoxList1.Items[rows].Value = rows.ToString();
                    }
                    CheckBoxList1.Visible = true;
                    CheckBoxList1.Items[0].Selected = true;
                }

                ds.Clear();

            }

        }
        public void getVotelist2(string Votelist2)
        {
            Labelvote2.Visible = false;
            if (Votelist2.Trim() != "")
            {
                Labelvote2.Visible = true;
                Labelvote2.Text = Votelist2;
            }

        }
        public void getVotelist2set(string Votelist2set, string VoteID)
        {
            RadioButtonList2.Visible = false;
            CheckBoxList2.Visible = false;
            RadioButtonList2.Items.Clear();
            CheckBoxList2.Items.Clear();

            if (Votelist2set == "2")
            {
                Labelvote2.Visible = false;
                return;
            }

            string VoteNumber = "2";

            string strConn = ConfigurationManager.ConnectionStrings["MENU"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(strConn))
            {
                String QQ = " select VoteItem from TB_VoteList where VoteNumber ='" + VoteNumber + "' and VoteID ='" + VoteID + "'";

                SqlDataAdapter da = new SqlDataAdapter(QQ, conn);
                DataSet ds = new DataSet();
                da.Fill(ds);

                if (Votelist2set == "0")
                {
                    for (int rows = 0; rows <= ds.Tables[0].Rows.Count - 1; rows++)
                    {

                        RadioButtonList2.Items.Add(ds.Tables[0].Rows[rows][0].ToString().Trim());
                        RadioButtonList2.Items[rows].Value = rows.ToString();
                    }
                    RadioButtonList2.Visible = true;
                    RadioButtonList2.Items[0].Selected = true;
                }
                else if (Votelist2set == "1")
                {
                    Labelvote2.Text += "(可多選)";
                    for (int rows = 0; rows <= ds.Tables[0].Rows.Count - 1; rows++)
                    {

                        CheckBoxList2.Items.Add(ds.Tables[0].Rows[rows][0].ToString().Trim());
                        CheckBoxList2.Items[rows].Value = rows.ToString();
                    }
                    CheckBoxList2.Visible = true;
                    CheckBoxList2.Items[0].Selected = true;
                }

                ds.Clear();

            }
        }
        public void getVotelist3(string Votelist3)
        {
            Labelvote3.Visible = false;
            if (Votelist3.Trim() != "")
            {
                Labelvote3.Visible = true;
                Labelvote3.Text = Votelist3;
            }
        }
        public void getVotelist3set(string Votelist3set,string VoteID)
        {
            RadioButtonList3.Visible = false;
            CheckBoxList3.Visible = false;
            RadioButtonList3.Items.Clear();
            CheckBoxList3.Items.Clear();


            if (Votelist3set == "2")
            {
                Labelvote3.Visible = false;
                return;
            }

            string VoteNumber = "3";

            string strConn = ConfigurationManager.ConnectionStrings["MENU"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(strConn))
            {
                String QQ = " select VoteItem from TB_VoteList where VoteNumber ='" + VoteNumber + "' and VoteID ='" + VoteID + "'";

                SqlDataAdapter da = new SqlDataAdapter(QQ, conn);
                DataSet ds = new DataSet();
                da.Fill(ds);

                if (Votelist3set == "0")
                {
                    for (int rows = 0; rows <= ds.Tables[0].Rows.Count - 1; rows++)
                    {

                        RadioButtonList3.Items.Add(ds.Tables[0].Rows[rows][0].ToString().Trim());
                        RadioButtonList3.Items[rows].Value = rows.ToString();
                    }
                    RadioButtonList3.Visible = true;
                    RadioButtonList3.Items[0].Selected = true;
                }
                else if (Votelist3set == "1")
                {
                    Labelvote3.Text += "(可多選)";
                    for (int rows = 0; rows <= ds.Tables[0].Rows.Count - 1; rows++)
                    {
  
                        CheckBoxList3.Items.Add(ds.Tables[0].Rows[rows][0].ToString().Trim());
                        CheckBoxList3.Items[rows].Value = rows.ToString();
                    }
                    CheckBoxList3.Visible = true;
                    CheckBoxList3.Items[0].Selected = true;
                }

                ds.Clear();

            }
        }


        public void getUserID(string UserID)
        {

            string strConn = ConfigurationManager.ConnectionStrings["MENU"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(strConn))
            {
                String QQ = "select username from bas03 where userid='" + UserID + "'";

                SqlDataAdapter da = new SqlDataAdapter(QQ, conn);
                DataSet ds = new DataSet();
                da.Fill(ds);
                if (Labelusername.Text == "")
                {
                    Labelusername.Text = ds.Tables[0].Rows[0][0].ToString().Trim();
                }
                ds.Clear();
            }
            Labeluserid.Text = UserID;
        }
        public void getVoteID(string VoteID)
        {
            Labelvoteid.Text = VoteID;
        }
        public void getVoteHolder(string VoteHolder)
        {

        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            string strConn1 = ConfigurationManager.ConnectionStrings["MENU"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(strConn1))
            {
                String QQ = "select emp_no from TB_VoteResult where VoteID='" + Labelvoteid.Text + "' and emp_no='" + Labeluserid.Text + "'";

                SqlDataAdapter da = new SqlDataAdapter(QQ, conn);
                DataSet ds = new DataSet();
                da.Fill(ds);
                Labelvalid.Text = "";
                if (ds.Tables[0].Rows.Count != 0)
                {
                    Labelvalid.Text = ds.Tables[0].Rows[0][0].ToString().Trim();
                }
                ds.Clear();
            }
            if (Labelvalid.Text == Labeluserid.Text)
            {
                string errormessage = "你已經投票過囉!";

                string strJS1 = "alert('" + errormessage + "');";
                Page.ClientScript.RegisterStartupScript(this.GetType(), "", strJS1, true);
                return;
            }


            string strConn = ConfigurationManager.ConnectionStrings["MENU"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(strConn))
            {
                string strCmd = "Insert into TB_VoteResult(VoteID,VoteTitle,emp_no,emp_cne,VoteDate)values(@VoteID,@VoteTitle,@emp_no,@emp_cne,@VoteDate)";
                using (SqlCommand cmd = new SqlCommand(strCmd, conn))
                {
                    cmd.Parameters.AddWithValue("@VoteID", int.Parse(Labelvoteid.Text));
                    cmd.Parameters.AddWithValue("@VoteTitle", Labeltitle.Text);
                    cmd.Parameters.AddWithValue("@emp_no", Labeluserid.Text);
                    cmd.Parameters.AddWithValue("@emp_cne", Labelusername.Text);
                    cmd.Parameters.AddWithValue("@VoteDate", DateTime.Now);


                    string message = "";

                    try
                    {
                        conn.Open();
                        cmd.ExecuteNonQuery();

                    }
                    catch (Exception ex)
                    {
                        message = ex.Message;
                        string strJS = "alert('" + message + "');location.href = ('Vote.aspx');";
                        Page.ClientScript.RegisterStartupScript(this.GetType(), "", strJS, true);
                    }
                    finally
                    {
                        conn.Close();
                    }


                }
            }
                        
            List<string> VoteNumber = new List<string>();
            List<string> VoteItemno = new List<string>();
            int index = 0;
            

            if( RadioButtonList1.Items.Count> 0 )
            {
                VoteNumber.Add("1");
                VoteItemno.Add(RadioButtonList1.SelectedItem.Value);

                //VoteNumber[index] = "1";
                //VoteItemno[index] = RadioButtonList1.SelectedItem.Value;
                index++;
            }
            if (CheckBoxList1.Items.Count > 0)
            {
                for(int i=0;i<= CheckBoxList1.Items.Count-1;i++)
                {
            
                    if (CheckBoxList1.Items[i].Selected)
                    {
                        VoteNumber.Add("1");
                        //VoteItemno.Add(CheckBoxList1.SelectedItem.Value);
                        VoteItemno.Add(CheckBoxList1.Items[i].Value);


                        //VoteNumber[index] = "1";
                        //VoteItemno[index] = CheckBoxList1.Items[i].Value;
                        index++;
                    }
                }
                    
            }
            //else
            //{

            //            VoteNumber[0] = "1";
            //            VoteItemno[0] = CheckBoxList1.Items[0].Value;
            //            index++;

            //}
            if (RadioButtonList2.Items.Count > 0)
            {
                VoteNumber.Add("2");
                VoteItemno.Add(RadioButtonList2.SelectedItem.Value);

                //VoteNumber[index] = "2";
                //VoteItemno[index] = RadioButtonList2.SelectedItem.Value;
                index++;
            }
            if (CheckBoxList2.Items.Count > 0)
            {
                for (int i = 0; i <= CheckBoxList2.Items.Count - 1; i++)
                {
   
                    if (CheckBoxList2.Items[i].Selected)
                    {
                        VoteNumber.Add("2");
                        VoteItemno.Add(CheckBoxList2.Items[i].Value);

                        //VoteNumber[index] = "2";
                        //VoteItemno[index] = CheckBoxList2.Items[i].Value;
                        index++;
                    }
                }

            }
            if (RadioButtonList3.Items.Count > 0)
            {
                VoteNumber.Add("3");
                VoteItemno.Add(RadioButtonList3.SelectedItem.Value);

                //VoteNumber[index] = "3";
                //VoteItemno[index] = RadioButtonList3.SelectedItem.Value;
                index++;
            }
            if (CheckBoxList3.Items.Count > 0)
            {
                for (int i = 0; i <= CheckBoxList3.Items.Count - 1; i++)
                {

                    if (CheckBoxList3.Items[i].Selected)
                    {
                        VoteNumber.Add("3");
                        VoteItemno.Add(CheckBoxList3.Items[i].Value);

                        //VoteNumber[index] = "3";
                        //VoteItemno[index] = CheckBoxList3.Items[i].Value;
                        index++;
                    }
                }

            }

            for(int votecount=0;votecount<=index-1;votecount++)
            {

                Labeltest.Text = VoteItemno[votecount];

                using (SqlConnection conn = new SqlConnection(strConn))
                {
                    string strCmd = "Insert into TB_VoteResultList(VoteID,emp_no,VoteNumber,VoteItemno)values(@VoteID,@emp_no,@VoteNumber,@VoteItemno)";
                    using (SqlCommand cmd = new SqlCommand(strCmd, conn))
                    {
                        cmd.Parameters.AddWithValue("@VoteID", int.Parse(Labelvoteid.Text));
                        cmd.Parameters.AddWithValue("@emp_no", Labeluserid.Text);
                        cmd.Parameters.AddWithValue("@VoteNumber", VoteNumber[votecount]);
                        cmd.Parameters.AddWithValue("@VoteItemno", VoteItemno[votecount]);

                        string message = "";

                        try
                        {
                            conn.Open();
                            cmd.ExecuteNonQuery();
                            message = "投票完成";

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