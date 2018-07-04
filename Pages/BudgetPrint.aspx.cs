using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace JuicERP.Pages
{
    public partial class BudgetPrint : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {


            string year = Request.QueryString["year"].ToString();
            string user = Request.QueryString["user"].ToString();
            string dept = Request.QueryString["dept"].ToString();


            DAL.JuicDao dao = new DAL.JuicDao("MENU");

            //取得各部門編寫預算人員權限
            var GetBudgetLevelforprint = dao.GetBudgetLevelforprint(user, dept);//待新增
            if (GetBudgetLevelforprint.Rows.Count != 0)
            {
                Label7.Text = "部門：" + GetBudgetLevelforprint.Rows[0]["emp_deptCh"].ToString();

                if (GetBudgetLevelforprint.Rows[0]["emp_dept"].ToString().Substring(0, 1) == "T")
                {
                    Label5.Text = "久威國際股份有限公司";
                }
                else if (GetBudgetLevelforprint.Rows[0]["emp_dept"].ToString().Substring(0, 1) == "J")
                {
                    Label5.Text = "久威股份有限公司";
                }
                else
                {
                    Label5.Text = "久威國際股份有限公司";
                }
                GridView1.DataSourceID = "SqlDataSource1";
            }
            else
            {
                string strJS = "alert('非編輯者不可瀏覽');location.href = ('Budget.aspx');";
                Page.ClientScript.RegisterStartupScript(this.GetType(), "", strJS, true);
            }

        }

        protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                if (e.Row.Cells[17].Text.Trim() != "")
                {

                    if (int.Parse(e.Row.Cells[17].Text.Trim(), NumberStyles.AllowThousands | NumberStyles.AllowLeadingSign) < 0)
                    {
                        e.Row.Cells[17].ForeColor = System.Drawing.Color.Red;
                        e.Row.Cells[17].Text = "(" + (-(int.Parse(e.Row.Cells[17].Text.Trim(), NumberStyles.AllowThousands | NumberStyles.AllowLeadingSign))).ToString("N0") + ")";
                    }
                    else
                    {

                    }
                }
            }

            int iSumSalary0 = 0;
            int iSumSalary1 = 0;
            int iSumSalary2 = 0;
            int iSumSalary3 = 0;
            int iSumSalary4 = 0;
            int iSumSalary5 = 0;
            int iSumSalary6 = 0;
            int iSumSalary7 = 0;
            int iSumSalary8 = 0;
            int iSumSalary9 = 0;
            int iSumSalary10 = 0;
            int iSumSalary11 = 0;
            int iSumSalary12 = 0;
            int iSumSalary13 = 0;
            int iSumSalary14 = 0;
            int[] iSumSalary = { iSumSalary0, iSumSalary1, iSumSalary2, iSumSalary3, iSumSalary4, iSumSalary5, iSumSalary6, iSumSalary7, iSumSalary8, iSumSalary9, iSumSalary10, iSumSalary11, iSumSalary12, iSumSalary13, iSumSalary14 };
            //int[] iSumSalary = { iSumSalary0 };
            foreach (GridViewRow gvr in GridView1.Rows)
            {
                for (int i = 0; i <= iSumSalary.Length - 1; i++)
                {

                    iSumSalary[i] += int.Parse(gvr.Cells[i + 3].Text.Trim(), NumberStyles.AllowThousands | NumberStyles.AllowLeadingSign | NumberStyles.AllowParentheses);
                }



            }

            if (e.Row.RowType == DataControlRowType.Footer)
            {
                e.Row.Cells[1].Text = "合計";
                e.Row.Cells[1].HorizontalAlign = HorizontalAlign.Left;
                for (int i = 0; i <= iSumSalary.Length - 1; i++)
                {
                    if (iSumSalary[i] >= 0)
                    {
                        e.Row.Cells[i + 3].Text = iSumSalary[i].ToString("N0");
                    }
                    else
                    {
                        e.Row.Cells[i + 3].Text = "("+iSumSalary[i].ToString("N0")+")";
                        e.Row.Cells[i + 3].ForeColor = System.Drawing.Color.Red;
                    }

                }
                //e.Row.Cells[3].Text = iSumSalary0.ToString();
            }

        }
    }
}