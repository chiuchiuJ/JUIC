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
using System.Data.SqlClient;

namespace JuicERP.Pages
{
    public partial class DeputyOrder : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {

            }

            //檢查是否有查詢庫存權限
            DAL.JuicDao dao = new DAL.JuicDao("MENU");
            var tb = dao.checkcontrol(User.Identity.Name.ToString(), 11);
            //無查詢庫存權限 取消按鈕 
            if (tb.Rows.Count == 0)
            {
                //Button1.Enabled = false;
                //txtExportExcel.Enabled = false;
                //Button1.Text = "未擁有查詢庫存權限";

            }
            Label1.Text = User.Identity.Name.ToString();
        }
        protected void ListBox_Change_Command(object sender, CommandEventArgs e)
        {
            String strTempText = String.Empty;
            String strTempValue = String.Empty;

            try
            {
                switch (e.CommandName)
                {
                    // 移動到右邊
                    case "Right":
                        LB_LIST2.Items.AddRange(
                            (from ListItem LI in LB_LIST1.Items where LI.Selected select LI).ToArray<ListItem>());

                        for (int i = 0; i < LB_LIST1.Items.Count; i++)
                        {
                            if (LB_LIST1.Items[i].Selected)
                            {
                                LB_LIST1.Items.RemoveAt(i);
                                i--;
                            }
                        }
                        break;
                    // 全部移動到右邊
                    case "RightAll":
                        LB_LIST2.Items.AddRange(
                            (from ListItem LI in LB_LIST1.Items select LI).ToArray<ListItem>());
                        for (int i = 0; i < LB_LIST1.Items.Count; i++)
                        {
                            LB_LIST1.Items.RemoveAt(i);
                            i--;
                        }
                        break;
                    // 移動到左邊
                    case "Left":
                        LB_LIST1.Items.AddRange(
                            (from ListItem LI in LB_LIST2.Items where LI.Selected select LI).ToArray<ListItem>());

                        for (int i = 0; i < LB_LIST2.Items.Count; i++)
                        {
                            if (LB_LIST2.Items[i].Selected)
                            {
                                LB_LIST2.Items.RemoveAt(i);
                                i--;
                            }
                        }
                        break;
                    // 全部移動到左邊
                    case "LeftAll":
                        LB_LIST1.Items.AddRange(
                            (from ListItem LI in LB_LIST2.Items select LI).ToArray<ListItem>());
                        for (int i = 0; i < LB_LIST2.Items.Count; i++)
                        {
                            LB_LIST2.Items.RemoveAt(i);
                            i--;
                        }
                        break;
                    // 往上移動
                    case "Up":
                        for (int i = 0; i < LB_LIST2.Items.Count; i++)
                        {
                            if (LB_LIST2.Items[i].Selected && !i.Equals(0))
                            {
                                strTempText = LB_LIST2.Items[i - 1].Text;
                                strTempValue = LB_LIST2.Items[i - 1].Value;
                                LB_LIST2.Items[i - 1].Text = LB_LIST2.Items[i].Text;
                                LB_LIST2.Items[i - 1].Value = LB_LIST2.Items[i].Value;
                                LB_LIST2.Items[i].Text = strTempText;
                                LB_LIST2.Items[i].Value = strTempValue;
                                LB_LIST2.Items[i - 1].Selected = true;
                                LB_LIST2.Items[i].Selected = false;
                            }
                        }
                        break;
                    // 往下移動
                    case "Down":
                        for (int i = LB_LIST2.Items.Count - 1; i >= 0; i--)
                        {
                            if (LB_LIST2.Items[i].Selected && !i.Equals(LB_LIST2.Items.Count - 1))
                            {
                                strTempText = LB_LIST2.Items[i + 1].Text;
                                strTempValue = LB_LIST2.Items[i + 1].Value;
                                LB_LIST2.Items[i + 1].Text = LB_LIST2.Items[i].Text;
                                LB_LIST2.Items[i + 1].Value = LB_LIST2.Items[i].Value;
                                LB_LIST2.Items[i].Text = strTempText;
                                LB_LIST2.Items[i].Value = strTempValue;
                                LB_LIST2.Items[i + 1].Selected = true;
                                LB_LIST2.Items[i].Selected = false;
                            }
                        }


                        break;
                }
            }
            catch { }

        }

        //存檔
        protected void Button1_Click(object sender, EventArgs e)
        {
            String connectString = System.Web.Configuration.WebConfigurationManager.ConnectionStrings["MENU"].ConnectionString;
            String sqlstr;
            SqlConnection cn = new SqlConnection(connectString);
            SqlTransaction trans;
            string strJS;
            if (Presafe_check())
            {
                using (SqlConnection conn = new SqlConnection(connectString))
                {
                    sqlstr = @"DELETE FROM TB_DeputyOrder WHERE right(rtrim(depa_no),4)=@depa_no";
                    SqlCommand cmd = new SqlCommand(sqlstr, conn);
                    conn.Open();
                    trans = conn.BeginTransaction();
                    cmd.Transaction = trans;
                    cmd.Parameters.AddWithValue("depa_no", DropDownList1.SelectedValue);
                    if (cmd.ExecuteNonQuery() == 0)
                    {
                        trans.Rollback();
                        strJS = "alert('存檔失敗!');";
                        Page.ClientScript.RegisterStartupScript(this.GetType(), "", strJS, true);
                        Button1.Attributes.Add("onClientClick=", "return false");
                    }

                    for (int i = 0; i < LB_LIST2.Items.Count; i++)
                    {
                        
                        string emp_no = string.Empty;
                        string emplist = LB_LIST2.Items[i].Text.Trim();
                        emp_no = emplist.Split(' ')[0];
                        string empname = string.Empty;
                        empname = emplist.Split(' ')[2];
                        string depa_no=string.Empty;
                        //先找出於職務代理人檔的部門單位
                        sqlstr = @"SELECT rtrim(data2) from TB_Deputy WHERE emp_no=@emp_no";
                        cmd = new SqlCommand(sqlstr, conn);
                        cmd.Parameters.AddWithValue("emp_no", emp_no);
                        cmd.Transaction = trans;
                        SqlDataReader rsdb = cmd.ExecuteReader();
                        if (rsdb.Read())
                        {
                            depa_no = rsdb[0].ToString();
                        }
                        rsdb.Close();

                        sqlstr = @"INSERT INTO TB_DeputyOrder 
                                (depa_no,emp_no,empname,sequence,credatetime,creuser) 
                              values 
                                (@depa_no,@emp_no,@empname,@sequence,getdate(),@creuser)";
                        cmd =new SqlCommand(sqlstr, conn);
                        cmd.Transaction = trans;
                        cmd.Parameters.AddWithValue("depa_no", depa_no);
                        cmd.Parameters.AddWithValue("emp_no", emp_no);
                        cmd.Parameters.AddWithValue("empname", empname);
                        cmd.Parameters.AddWithValue("sequence", i);
                        cmd.Parameters.AddWithValue("creuser", Label1.Text);
                        if (cmd.ExecuteNonQuery() == 0)
                        {
                            trans.Rollback();
                            strJS = "alert('存檔失敗!');";
                            Page.ClientScript.RegisterStartupScript(this.GetType(), "", strJS, true);
                            Button1.Attributes.Add("onClientClick=", "return false");
                        }
                    }
                    trans.Commit();
                    //trans.Rollback();
                    conn.Close();
                }
            }
            else
            {
                Button1.Attributes.Add("onClientClick=", "return false");
            }
            strJS = "alert('存檔成功!');";
            Page.ClientScript.RegisterStartupScript(this.GetType(), "", strJS, true);
            LB_LIST1.Items.Clear();
            LB_LIST2.Items.Clear();
            DropDownList1.Enabled = true;
            DropDownList1.SelectedValue = "0";
            
        }

        private bool Presafe_check()
        {
            if (LB_LIST1.Items.Count > 0)
            {
                //若左邊還有項目則不給存檔 
                string strJS = "alert('左側挑選區尚有人員未挑選，不可存檔!');";
                Page.ClientScript.RegisterStartupScript(this.GetType(), "", strJS, true);
                return false;
            }
            if (LB_LIST2.Items.Count == 0)
            {
                //若右邊排序區無項目則不給存檔 
                string strJS = "alert('右側排序區未有人員，不可存檔!');";
                Page.ClientScript.RegisterStartupScript(this.GetType(), "", strJS, true);
                return false;
            }
            return true;
        }

        //重設
        protected void Button2_Click(object sender, EventArgs e)
        {
            //ContentPlaceHolder ContentID = (ContentPlaceHolder)Master.FindControl("ContentPlaceHolder1");
            ////將listbox清空
            //foreach (Control control in ContentID.Controls)
            //{
            //    if (control is TextBox)
            //    {
            //        ((TextBox)control).Text = "";
            //    }
            //    if (control is ListBox)
            //    {
            //        ((ListBox)control).Items.Clear();
            //    }
            //}

            LB_LIST1.Items.Clear();
            LB_LIST2.Items.Clear();

            LB_LIST1.Items.AddRange(
                           (from ListItem LI in ListBox3.Items select LI).ToArray<ListItem>());

            DropDownList1.Enabled = false;
        }

        //取消
        protected void Button3_Click(object sender, EventArgs e)
        {
            LB_LIST2.Items.Clear();
            DropDownList1.Enabled = true;
            DropDownList1.SelectedValue = "0";
        }

        protected void DropDownList1_SelectedIndexChanged(object sender, EventArgs e)
        {
            DropDownList1.Enabled = false;

        }
    }
}
