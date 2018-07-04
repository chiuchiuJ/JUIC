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
    public partial class VoteResult : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
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

        protected void DropDownList1_SelectedIndexChanged(object sender, EventArgs e)
        {
            string strConn1 = ConfigurationManager.ConnectionStrings["MENU"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(strConn1))
            {
                Labeltitle1.Text = "";
                Labeltitle2.Text = "";
                Labeltitle3.Text = "";
                Labeltitle1.Visible = true;
                Labeltitle2.Visible = true;
                Labeltitle3.Visible = true;
                GridView1.Visible = true;
                GridView2.Visible = true;
                GridView3.Visible = true;

                String QQ = "select Votelist1,Votelist1set,Votelist2,Votelist2set,Votelist3,Votelist3set from TB_Vote where VoteID='" + DropDownList1.SelectedValue + "'";

                SqlDataAdapter da = new SqlDataAdapter(QQ, conn);
                DataSet ds = new DataSet();
                da.Fill(ds);
                if (ds.Tables[0].Rows.Count != 0)
                {
                    if (ds.Tables[0].Rows[0][1].ToString().Trim()!="2")
                    Labeltitle1.Text = ds.Tables[0].Rows[0][0].ToString().Trim();
                    if (ds.Tables[0].Rows[0][3].ToString().Trim() != "2")
                        Labeltitle2.Text = ds.Tables[0].Rows[0][2].ToString().Trim();
                    if (ds.Tables[0].Rows[0][5].ToString().Trim() != "2")
                        Labeltitle3.Text = ds.Tables[0].Rows[0][4].ToString().Trim();
                }

                ds.Clear();
            }
        }
    }
}