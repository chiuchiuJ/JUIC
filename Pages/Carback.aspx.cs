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
    public partial class Carback : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string car = DetailsView1.Rows[0].Cells[1].Text.Trim();

            DAL.JuicDao dao = new DAL.JuicDao("MENU");
            var GetCarkm = dao.GetCarkm(car);//待新增
            if (GetCarkm.Rows.Count != 0)
            {

                string km = GetCarkm.Rows[0]["gasoline2"].ToString();
                if (km == "")
                {
                    Label9.Text = "由於上一使用者未填入歸還里程數，需手動填寫";
                }
                else
                {
                    TextBox1.Text = km;
                }

            }


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
            }
            //-------------------------------------------------------------------------------------
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            string check1, check2, check3, check4;

            if (CheckBoxList1.Items[0].Selected)
            {
                check1 = "Y";
            }
            else
            {
                check1 = "N";
            }

            if (CheckBoxList1.Items[1].Selected)
            {
                check2 = "Y";
            }
            else
            {
                check2 = "N";
            }

            if (CheckBoxList1.Items[2].Selected)
            {
                check3 = "Y";
            }
            else
            {
                check3 = "N";
            }

            if (CheckBoxList1.Items[3].Selected)
            {
                check4 = "Y";
            }
            else
            {
                check4 = "N";
            }

            //if (CheckBox1.Checked)
            //{
            //    check1 = CheckBox1.Text;
            //}
            //else
            //{
            //    check1 = "N";
            //}
            //if (CheckBox2.Checked)
            //{
            //    check2 = CheckBox2.Text;
            //}
            //else
            //{
            //    check2 = "N";
            //}
            //if (CheckBox3.Checked)
            //{
            //    check3 = CheckBox3.Text;
            //}
            //else
            //{
            //    check3 = "N";
            //}
            //if (CheckBox4.Checked)
            //{
            //    check4 = CheckBox4.Text;
            //}
            //else
            //{
            //    check4 = "N";
            //}

            DateTime date1 = DateTime.Parse((datestart.Text + " " + DropDownList2.SelectedItem.Text + ":" + DropDownList3.SelectedItem.Text));

            DateTime date2 = DateTime.Parse((dateend.Text + " " + DropDownList4.SelectedItem.Text + ":" + DropDownList5.SelectedItem.Text));


            string strConn = ConfigurationManager.ConnectionStrings["MENU"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(strConn))
            {
                string strCmd = "  Update TB_Carrentdata SET startrent2=@startrent2,endrent2=@endrent2,gasoline1=@gasoline1,gasoline2=@gasoline2,Fuelcosts=@Fuelcosts,PS2=@PS2,Check1=@Check1,Check2=@Check2,Check3=@Check3,Check4=@Check4 where id='" + Request.QueryString["pid"] + "'";
                using (SqlCommand cmd = new SqlCommand(strCmd, conn))
                {
                    cmd.Parameters.AddWithValue("@startrent2", date1);
                    cmd.Parameters.AddWithValue("@endrent2", date2);
                    //cmd.Parameters.AddWithValue("@backYN", "Y");
                    cmd.Parameters.AddWithValue("@gasoline1", int.Parse(TextBox1.Text));
                    cmd.Parameters.AddWithValue("@gasoline2", int.Parse(TextBox2.Text));
                    int i = 0;
                    if(TextBox3.Text!="")
                    {
                        i = int.Parse(TextBox3.Text);
                    }
                    cmd.Parameters.AddWithValue("@Fuelcosts", i);
                    cmd.Parameters.AddWithValue("@PS2", TextBox4.Text);
                    cmd.Parameters.AddWithValue("@Check1", check1);
                    cmd.Parameters.AddWithValue("@Check2", check2);
                    cmd.Parameters.AddWithValue("@Check3", check3);
                    cmd.Parameters.AddWithValue("@Check4", check4);
                    //cmd.Parameters.AddWithValue("@Check6", "N");
                    //cmd.Parameters.AddWithValue("@Check6", "N");

                    string message = "";

                    try
                    {
                        conn.Open();
                        cmd.ExecuteNonQuery();
                        message = "歸還作業完成";

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
    }
}