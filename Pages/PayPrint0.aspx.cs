using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace JuicERP.Pages
{
    public partial class PayPrint0 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            DAL.JuicDao dao = new DAL.JuicDao("MENU");
            var GetPayallowance = dao.GetPayallowance(Request.QueryString["pid"].ToString());//待新增
            if (GetPayallowance.Rows.Count != 0)
            {
                string date = GetPayallowance.Rows[0]["date"].ToString();
                Label2.Text = DateTime.Parse(date).ToString("yyyy年MM月dd日");

                Label7.Text = GetPayallowance.Rows[0]["dept_cne"].ToString();
                string comment = GetPayallowance.Rows[0]["comment"].ToString();
                comment = comment.Replace("\r\n", "<br>");
                Label8.Text = comment;
                int money = int.Parse(GetPayallowance.Rows[0]["money"].ToString());

                Label9.Text = money.ToString("N0");
                //20180504;04794;jana需求 將領款人名字帶空白
                //Label10.Text = GetPayallowance.Rows[0]["payeename"].ToString();




            }
        }
    }
}