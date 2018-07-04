using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace JuicERP.Pages
{
    public partial class Budget : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Budgetkeyin.getuserid(User.Identity.Name.ToString());
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
            DAL.JuicDao dao = new DAL.JuicDao("MENU");
            var BudgetinputYN = dao.GetBudgetLevelALL(User.Identity.Name.ToString());
            if (BudgetinputYN.Rows.Count > 0)
            {
                HyperLink3.Enabled = true;
                BudgetYN.Text = "您有 ";
                for (int i = 0; i < BudgetinputYN.Rows.Count; i++)
                {
                    BudgetYN.Text += BudgetinputYN.Rows[i]["emp_deptCh"].ToString() + "的" + BudgetinputYN.Rows[i]["TypeWrtCh"].ToString() + "權限。";
                }

            }
            var Budgetsa = dao.GetBudgetLevelsa(User.Identity.Name.ToString());
            if (Budgetsa.Rows.Count > 0)
            {
                HyperLink5.Enabled = true;
                HyperLink6.Enabled = true;
                HyperLink7.Enabled = true;
            }
            //檢查是否有預算編寫人員設定作業權限
            var check = dao.checkcontrol(User.Identity.Name.ToString(), 27);//待新增
            //有權限
            if (check.Rows.Count != 0)
            {
                Panel4.Visible = true;
                HyperLink1.Enabled = true;
                HyperLink2.Enabled = true;
            }
            else
            {
                Label8.Text = "您並無設定預算編寫人員權限";
            }

        }



        protected void Button1_Click(object sender, EventArgs e)
        {

        }

        protected void Button5_Click(object sender, EventArgs e)
        {
            DAL.JuicDao dao = new DAL.JuicDao("MENU");

            var dept = dao.InsertBudgetLevel(DropDownList2.SelectedValue, DropDownList2.SelectedItem.Text, DropDownList3.SelectedValue, DropDownList3.SelectedItem.Text, DropDownList4.SelectedValue, DropDownList4.SelectedItem.Text);//待新增

            GridView4.DataSourceID = "SqlDataSource8";
        }
        protected void Button2_Click(object sender, EventArgs e)
        {
            DAL.JuicDao dao = new DAL.JuicDao("MENU");

            var dept = dao.InsertBudgetLevel(DropDownList1.SelectedValue, DropDownList1.SelectedItem.Text, DropDownList8.SelectedValue, DropDownList8.SelectedItem.Text, "sa", "業績預估填寫");//待新增

            GridView4.DataSourceID = "SqlDataSource8";
        }
        protected void Button6_Click(object sender, EventArgs e)
        {
            DAL.JuicDao dao = new DAL.JuicDao("MENU");
            if (DropDownList6.SelectedValue == "ALLJUIC")
            {
                var dept = dao.InsertBudgetLevel2(DropDownList5.SelectedValue, DropDownList5.SelectedItem.Text, "ALL", "久國跨部門", DropDownList7.SelectedValue, DropDownList7.SelectedItem.Text, "JUIC");//待新增

            }
            else if (DropDownList6.SelectedValue == "ALLJUTW")
            {
                var dept = dao.InsertBudgetLevel2(DropDownList5.SelectedValue, DropDownList5.SelectedItem.Text, "ALL", "久股跨部門", DropDownList7.SelectedValue, DropDownList7.SelectedItem.Text, "JUTW");//待新增

            }

            GridView4.DataSourceID = "SqlDataSource8";
        }

        //protected void BudgetYNbtn_Click(object sender, EventArgs e)
        //{

        //    //Panel1.Visible = true;
        //    string strJS = "location.href = ('Budgetinput.aspx');";
        //    Page.ClientScript.RegisterStartupScript(this.GetType(), "", strJS, true);

        //}
    }
}