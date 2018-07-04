using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace JuicERP.UserControls
{
    public partial class Cardetail : System.Web.UI.UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Button2.OnClientClick = "CloseControl(\"" + this.Parent.FindControl("ModalPanel").ClientID + "\");  return false;";
        }
        public void getid(string id)
        {
            Label1.Text = id;
        }
        public void getuser(string username)
        {
            TextBox1.Text = username;
        }
        public void getcar_name(string carname)
        {
            TextBox0.Text = carname;
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            //string datest1 = datestart.Text + " " + TextBox4.Text + ":" + TextBox5.Text;
            //string datest2 = dateend.Text + " " + TextBox6.Text + ":" + TextBox7.Text;
            string datest1 = datestart.Text + " " + DropDownList1.SelectedItem.Text + ":" + TextBox5.Text;
            string datest2 = dateend.Text + " " + DropDownList2.SelectedItem.Text + ":" + TextBox7.Text;
            DateTime date1 = DateTime.Parse(datest1);
            DateTime date2 = DateTime.Parse(datest2);


            string strConn = ConfigurationManager.ConnectionStrings["MENU"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(strConn))
            {
                string strCmd = "Insert into TB_CarrentResult(rentid,realuser,department,begintime,finishtime,gasoline1,gasoline2,Fuelcosts,PS,car_name)values(@rentid,@realuser,@department,@begintime,@finishtime,@gasoline1,@gasoline2,@Fuelcosts,@PS,@car_name)";
                using (SqlCommand cmd = new SqlCommand(strCmd, conn))
                {
                    cmd.Parameters.AddWithValue("@rentid", int.Parse(Label1.Text));
                    cmd.Parameters.AddWithValue("@realuser", TextBox1.Text);
                    cmd.Parameters.AddWithValue("@department", TextBox2.Text);
                    cmd.Parameters.AddWithValue("@begintime", date1);
                    cmd.Parameters.AddWithValue("@finishtime", date2);
                    cmd.Parameters.AddWithValue("@gasoline1", int.Parse(TextBox8.Text));
                    cmd.Parameters.AddWithValue("@gasoline2", int.Parse(TextBox9.Text));
                    cmd.Parameters.AddWithValue("@Fuelcosts", int.Parse(TextBox3.Text));
                    cmd.Parameters.AddWithValue("@PS", TextBox10.Text);
                    cmd.Parameters.AddWithValue("@car_name", TextBox0.Text);
                    string message = "";

                    try
                    {
                        conn.Open();
                        cmd.ExecuteNonQuery();
                        //message = "預約成功";

                    }
                    catch (Exception ex)
                    {
                        message = ex.Message;
                        string strJS = "alert('" + message + "');location.href = ('CarrentCheck.aspx');";
                        Page.ClientScript.RegisterStartupScript(this.GetType(), "", strJS, true);

                    }
                    finally
                    {
                        conn.Close();
                        //string strJS = "alert('" + message + "');location.href = ('Cardetail.aspx');";
                        //Page.ClientScript.RegisterStartupScript(this.GetType(), "", strJS, true);
                    }

                }

                string strCmd2 = "UPDATE TB_Carrent SET backYN=@backYN Where id='" + Label1.Text + "'";
                using (SqlCommand cmd = new SqlCommand(strCmd2, conn))
                {
                    cmd.Parameters.AddWithValue("@backYN", "Y");
           
                    string message = "";

                    try
                    {
                        conn.Open();
                        cmd.ExecuteNonQuery();
                        message = "完成";

                    }
                    catch (Exception ex)
                    {
                        message = ex.Message;
                        string strJS = "alert('" + message + "');location.href = ('CarrentCheck.aspx');";
                        Page.ClientScript.RegisterStartupScript(this.GetType(), "", strJS, true);

                    }
                    finally
                    {
                        conn.Close();
                        string strJS = "alert('" + message + "');location.href = ('CarrentCheck.aspx');";
                        Page.ClientScript.RegisterStartupScript(this.GetType(), "", strJS, true);
                    }

                }
            }
        }

        protected void Button2_Click(object sender, EventArgs e)
        {

        }
    }
}