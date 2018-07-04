using JuicERP.DAL;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;


namespace JuicERP.Pages
{
    public partial class MisservicePrint : System.Web.UI.Page
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
            Labelname.Text = User.Identity.Name.ToString();

            Label1.Text = DetailsView1.Rows[2].Cells[1].Text;

            Label2.Text = DetailsView1.Rows[0].Cells[1].Text;

            Label3.Text = DetailsView1.Rows[1].Cells[1].Text;

            //依當前使用者填入部門
            //JuicDao dao = new JuicDao("MENU");
            //var dept = dao.GetDept(Page.User.Identity.Name.ToString());
            //if (dept.Rows.Count != 0)
            //{
            //    Label4.Text = dept.Rows[0]["DEPA_NE1"].ToString();
            //}
            //else
            //{
            //    Label4.Text = "";
            //}
            if (DetailsView2.Rows.Count != 0)
            {
                Label4.Text = DetailsView2.Rows[2].Cells[1].Text;
            }

            LabelPS.Text = DetailsView1.Rows[3].Cells[1].Text;
            Labeltestfeedback.Text = DetailsView1.Rows[4].Cells[1].Text; ;


            //Label4.Text= DetailsView2.Rows[2].Cells[1].Text;

            //TextBox1.Text= DetailsView1.Rows[1].Cells[1].Text;  
            //StringEscapeUtils.escapeHtml(xxxxxx);
        }
    }
}