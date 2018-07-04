using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace JuicERP.UserControls
{
    public partial class Budgetkeyin : System.Web.UI.UserControl
    {
        string userid0 = "";
        public void getuserid(string id) //獲取母網頁傳出的文字資訊
        {
            userid0 = id;
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            DAL.JuicDao dao = new DAL.JuicDao("MENU");

            //取得各部門編寫預算人員權限
            var BudgetLevel0 = dao.GetBudgetLevel0(userid0);//待新增
            if (BudgetLevel0.Rows.Count != 0)
            {
                Label1.Text = BudgetLevel0.Rows[0]["emp_dept"].ToString();
                Label4.Text = BudgetLevel0.Rows[0]["emp_deptCh"].ToString() + "明年度預算表";
                Panel2.Visible = true;
            }
            else
            {
                Panel2.Visible = false;
            }
            //取得跨部門編寫預算人員權限(如人事等資料)
            var BudgetLevel = dao.GetBudgetLevelalljuic(userid0);//待新增
            if (BudgetLevel.Rows.Count != 0)
            {

                Label6.Text = BudgetLevel.Rows[0]["TypeWrt"].ToString();
                Label9.Text = "以下編寫的是 " + BudgetLevel.Rows[0]["TypeWrtCh"].ToString();
                Panel3.Visible = true;
            }
            else
            {
                Panel3.Visible = false;
            }

            //判斷使用者是否為有寫邊寫業務營收權限，有的話開啟panel
            var BudgetTableSales = dao.BudgetTableSales(userid0);//待新增
            if (BudgetTableSales.Rows.Count != 0)
            {
                Panel1.Visible = true;
            }
            else
            {
                Panel1.Visible = false;
                //財會測試
                Panel1.Visible = true;
            }

            //業務營收預估表判別值
            Label3.Text = userid0;
            // 財會測試使用
            Label3.Text = "%%";
        }

        //g2全選
        protected void cbSelecteds_CheckedChanged(object sender, EventArgs e)
        {
            CheckBox cbSelects = (CheckBox)sender;

            foreach (GridViewRow gridViewRow in this.GridView2.Rows)
            {
                CheckBox cbSelected = (CheckBox)gridViewRow.FindControl("cbSelected1");
                cbSelected.Checked = cbSelects.Checked;
            }
        }
        protected void cbSelecteds2_CheckedChanged(object sender, EventArgs e)
        {
            CheckBox cbSelects = (CheckBox)sender;

            foreach (GridViewRow gridViewRow in this.GridView3.Rows)
            {
                CheckBox cbSelected = (CheckBox)gridViewRow.FindControl("che");
                cbSelected.Checked = cbSelects.Checked;
            }
        }

        private bool tableCopied = false;
        private DataTable originalDataTable;
        protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
                if (!tableCopied)
                {
                    originalDataTable = ((DataRowView)e.Row.DataItem).Row.Table.Copy();
                    ViewState["originalValuesDataTable"] = originalDataTable;
                    tableCopied = true;
                }
        }

        protected void Button2_Click(object sender, EventArgs e)
        {
            originalDataTable = (DataTable)ViewState["originalValuesDataTable"];

            foreach (GridViewRow r in GridView1.Rows)
                if (IsRowModified(r)) { GridView1.UpdateRow(r.RowIndex, false); }

            // Rebind the Grid to repopulate the original values table.
            tableCopied = false;
            GridView1.DataBind();
        }
        protected bool IsRowModified(GridViewRow r)
        {
            int currentID;
            string emp_no;
            string emp_cne;
            string CUS_NO;
            string CUS_NE2;
            string PS;
            string mon1;
            string mon1gp;
            string mon2;
            string mon2gp;
            string mon3;
            string mon3gp;
            string mon4;
            string mon4gp;
            string mon5;
            string mon5gp;
            string mon6;
            string mon6gp;
            string mon7;
            string mon7gp;
            string mon8;
            string mon8gp;
            string mon9;
            string mon9gp;
            string mon10;
            string mon10gp;
            string mon11;
            string mon11gp;
            string mon12;
            string mon12gp;
            string year;



            currentID = Convert.ToInt32(GridView1.DataKeys[r.RowIndex].Value);

            emp_no = ((Label)r.FindControl("emp_no")).Text;
            emp_cne = ((Label)r.FindControl("emp_cne")).Text;
            mon1 = ((TextBox)r.FindControl("mon1")).Text;
            mon1gp = ((TextBox)r.FindControl("mon1gp")).Text;
            CUS_NO = ((Label)r.FindControl("CUS_NO")).Text;
            CUS_NE2 = ((Label)r.FindControl("CUS_NE2")).Text;
            mon2 = ((TextBox)r.FindControl("mon2")).Text;
            mon2gp = ((TextBox)r.FindControl("mon2gp")).Text;
            mon3 = ((TextBox)r.FindControl("mon3")).Text;
            mon3gp = ((TextBox)r.FindControl("mon3gp")).Text;
            mon4 = ((TextBox)r.FindControl("mon4")).Text;
            mon4gp = ((TextBox)r.FindControl("mon4gp")).Text;
            mon5 = ((TextBox)r.FindControl("mon5")).Text;
            mon5gp = ((TextBox)r.FindControl("mon5gp")).Text;
            mon6 = ((TextBox)r.FindControl("mon6")).Text;
            mon6gp = ((TextBox)r.FindControl("mon6gp")).Text;
            mon7 = ((TextBox)r.FindControl("mon7")).Text;
            mon7gp = ((TextBox)r.FindControl("mon7gp")).Text;
            mon8 = ((TextBox)r.FindControl("mon8")).Text;
            mon8gp = ((TextBox)r.FindControl("mon8gp")).Text;
            mon9 = ((TextBox)r.FindControl("mon9")).Text;
            mon9gp = ((TextBox)r.FindControl("mon9gp")).Text;
            mon10 = ((TextBox)r.FindControl("mon10")).Text;
            mon10gp = ((TextBox)r.FindControl("mon10gp")).Text;
            mon11 = ((TextBox)r.FindControl("mon11")).Text;
            mon11gp = ((TextBox)r.FindControl("mon11gp")).Text;
            mon12 = ((TextBox)r.FindControl("mon12")).Text;
            mon12gp = ((TextBox)r.FindControl("mon12gp")).Text;
            year = ((Label)r.FindControl("year")).Text;
            PS = ((TextBox)r.FindControl("PS")).Text;

            DataRow row = originalDataTable.Select(String.Format("no = {0}", currentID))[0];

            if (!emp_no.Equals(row["emp_no"].ToString())) { return true; }
            if (!emp_cne.Equals(row["emp_cne"].ToString())) { return true; }
            if (!mon1.Equals(row["mon1"].ToString())) { return true; }
            if (!mon1gp.Equals(row["mon1gp"].ToString())) { return true; }
            if (!CUS_NO.Equals(row["CUS_NO"].ToString())) { return true; }
            if (!CUS_NE2.Equals(row["CUS_NE2"].ToString())) { return true; }
            if (!mon2.Equals(row["mon2"].ToString())) { return true; }
            if (!mon2gp.Equals(row["mon2gp"].ToString())) { return true; }
            if (!mon3.Equals(row["mon3"].ToString())) { return true; }
            if (!mon3gp.Equals(row["mon3gp"].ToString())) { return true; }
            if (!mon4.Equals(row["mon4"].ToString())) { return true; }
            if (!mon4gp.Equals(row["mon4gp"].ToString())) { return true; }
            if (!mon5.Equals(row["mon5"].ToString())) { return true; }
            if (!mon5gp.Equals(row["mon5gp"].ToString())) { return true; }
            if (!mon6.Equals(row["mon6"].ToString())) { return true; }
            if (!mon6gp.Equals(row["mon6gp"].ToString())) { return true; }
            if (!mon7.Equals(row["mon7"].ToString())) { return true; }
            if (!mon7gp.Equals(row["mon7gp"].ToString())) { return true; }
            if (!mon8.Equals(row["mon8"].ToString())) { return true; }
            if (!mon8gp.Equals(row["mon8gp"].ToString())) { return true; }
            if (!mon9.Equals(row["mon9"].ToString())) { return true; }
            if (!mon9gp.Equals(row["mon9gp"].ToString())) { return true; }
            if (!mon10.Equals(row["mon10"].ToString())) { return true; }
            if (!mon10gp.Equals(row["mon10gp"].ToString())) { return true; }
            if (!mon11.Equals(row["mon11"].ToString())) { return true; }
            if (!mon11gp.Equals(row["mon11gp"].ToString())) { return true; }
            if (!mon12.Equals(row["mon12"].ToString())) { return true; }
            if (!mon12gp.Equals(row["mon12gp"].ToString())) { return true; }
            if (!year.Equals(row["year"].ToString())) { return true; }
            if (!PS.Equals(row["PS"].ToString())) { return true; }
            return false;
        }
        private bool tableCopied2 = false;
        private DataTable originalDataTable2;
        protected void GridView2_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
                if (!tableCopied2)
                {
                    originalDataTable2 = ((DataRowView)e.Row.DataItem).Row.Table.Copy();
                    ViewState["originalValuesDataTable2"] = originalDataTable2;
                    tableCopied2 = true;
                }

        }

        protected void Button3_Click(object sender, EventArgs e)
        {
            originalDataTable2 = (DataTable)ViewState["originalValuesDataTable2"];

            foreach (GridViewRow r in GridView2.Rows)
            {
                if (((CheckBox)r.FindControl("cbSelected1")).Checked)
                {
                    if (IsRowModified2(r))
                    {
                        GridView2.UpdateRow(r.RowIndex, false);
                    }
                }
                else
                {

                }

            }
            // Rebind the Grid to repopulate the original values table.
            tableCopied2 = false;
            GridView2.DataBind();

            DAL.JuicDao dao = new DAL.JuicDao("MENU");

            var dept = dao.GetBudgetEditor(Label1.Text, DateTime.Now.AddYears(1).Year.ToString(), userid0, Label5.Text, "n0");//待新增

        }
        protected bool IsRowModified2(GridViewRow r)
        {
            int currentID;
            //string emp_no;
            //string emp_cne;
            //string editdate;
            string year;
            string AccNO;
            string AccName;
            string dept_no;
            string mon01;
            string mon02;
            string mon03;
            string mon04;
            string mon05;
            string mon06;
            string mon07;
            string mon08;
            string mon09;
            string mon10;
            string mon11;
            string mon12;
            string ps;


            currentID = Convert.ToInt32(GridView2.DataKeys[r.RowIndex].Value);

            //emp_no = ((Label)r.FindControl("emp_no")).Text;
            //emp_cne = ((Label)r.FindControl("emp_cne")).Text;
            ////((Label)r.FindControl("editdate")).Text = DateTime.Now.Date.ToString("MM/dd");
            //editdate = DateTime.Now.Date.ToString("MM/dd");
            year = ((Label)r.FindControl("year")).Text;
            AccNO = ((Label)r.FindControl("AccNO")).Text;
            AccName = ((Label)r.FindControl("AccName")).Text;
            dept_no = ((Label)r.FindControl("dept_no")).Text;
            mon01 = ((TextBox)r.FindControl("mon01")).Text;
            mon02 = ((TextBox)r.FindControl("mon02")).Text;
            mon03 = ((TextBox)r.FindControl("mon03")).Text;
            mon04 = ((TextBox)r.FindControl("mon04")).Text;
            mon05 = ((TextBox)r.FindControl("mon05")).Text;
            mon06 = ((TextBox)r.FindControl("mon06")).Text;
            mon07 = ((TextBox)r.FindControl("mon07")).Text;
            mon08 = ((TextBox)r.FindControl("mon08")).Text;
            mon09 = ((TextBox)r.FindControl("mon09")).Text;
            mon10 = ((TextBox)r.FindControl("mon10")).Text;
            mon11 = ((TextBox)r.FindControl("mon11")).Text;
            mon12 = ((TextBox)r.FindControl("mon12")).Text;
            ps = ((TextBox)r.FindControl("ps")).Text;

            DataRow row = originalDataTable2.Select(String.Format("no = {0}", currentID))[0];

            //if (!emp_no.Equals(row["emp_no"].ToString())) { return true; }
            //if (!emp_cne.Equals(row["emp_cne"].ToString())) { return true; }
            //if (!editdate.Equals(row["editdate"].ToString())) { return true; }
            if (!year.Equals(row["year"].ToString())) { return true; }
            if (!AccNO.Equals(row["AccNO"].ToString())) { return true; }
            if (!AccName.Equals(row["AccName"].ToString())) { return true; }
            if (!dept_no.Equals(row["dept_no"].ToString())) { return true; }
            if (!mon01.Equals(row["mon01"].ToString())) { return true; }
            if (!mon02.Equals(row["mon02"].ToString())) { return true; }
            if (!mon03.Equals(row["mon03"].ToString())) { return true; }
            if (!mon04.Equals(row["mon04"].ToString())) { return true; }
            if (!mon05.Equals(row["mon05"].ToString())) { return true; }
            if (!mon06.Equals(row["mon06"].ToString())) { return true; }
            if (!mon07.Equals(row["mon07"].ToString())) { return true; }
            if (!mon08.Equals(row["mon08"].ToString())) { return true; }
            if (!mon09.Equals(row["mon09"].ToString())) { return true; }
            if (!mon10.Equals(row["mon10"].ToString())) { return true; }
            if (!mon11.Equals(row["mon11"].ToString())) { return true; }
            if (!mon12.Equals(row["mon12"].ToString())) { return true; }
            if (!ps.Equals(row["ps"].ToString())) { return true; }
            return false;
        }

        private bool tableCopied3 = false;
        private DataTable originalDataTable3;
        protected void GridView3_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
                if (!tableCopied3)
                {
                    originalDataTable3 = ((DataRowView)e.Row.DataItem).Row.Table.Copy();
                    ViewState["originalValuesDataTable3"] = originalDataTable3;
                    tableCopied3 = true;
                }
        }
        protected void Button4_Click(object sender, EventArgs e)
        {
            originalDataTable3 = (DataTable)ViewState["originalValuesDataTable3"];

            foreach (GridViewRow r in GridView3.Rows)
            {
                if (((CheckBox)r.FindControl("che")).Checked)
                {
                    if (IsRowModified3(r))
                    {
                        GridView3.UpdateRow(r.RowIndex, false);
                    }
                }
                else
                {

                }

            }
            // Rebind the Grid to repopulate the original values table.
            tableCopied3 = false;
            GridView3.DataBind();

            DAL.JuicDao dao = new DAL.JuicDao("MENU");

            var dept = dao.GetBudgetEditor(Label1.Text, DateTime.Now.AddYears(1).Year.ToString(), userid0, Label5.Text, Label6.Text);//待新增
        }
        protected bool IsRowModified3(GridViewRow r)
        {
            int currentID;
            //string emp_no;
            //string emp_cne;
            //string editdate;
            string year;
            string AccNO;
            string AccName;
            string dept_no;
            string mon01;
            string mon02;
            string mon03;
            string mon04;
            string mon05;
            string mon06;
            string mon07;
            string mon08;
            string mon09;
            string mon10;
            string mon11;
            string mon12;
            string ps;


            currentID = Convert.ToInt32(GridView3.DataKeys[r.RowIndex].Value);

            //emp_no = ((Label)r.FindControl("emp_no")).Text;
            //emp_cne = ((Label)r.FindControl("emp_cne")).Text;
            ////((Label)r.FindControl("editdate")).Text = DateTime.Now.Date.ToString("MM/dd");
            //editdate = DateTime.Now.Date.ToString("MM/dd");
            year = ((Label)r.FindControl("year")).Text;
            AccNO = ((Label)r.FindControl("AccNO")).Text;
            AccName = ((Label)r.FindControl("AccName")).Text;
            dept_no = ((Label)r.FindControl("dept_no")).Text;
            mon01 = ((TextBox)r.FindControl("mon01")).Text;
            mon02 = ((TextBox)r.FindControl("mon02")).Text;
            mon03 = ((TextBox)r.FindControl("mon03")).Text;
            mon04 = ((TextBox)r.FindControl("mon04")).Text;
            mon05 = ((TextBox)r.FindControl("mon05")).Text;
            mon06 = ((TextBox)r.FindControl("mon06")).Text;
            mon07 = ((TextBox)r.FindControl("mon07")).Text;
            mon08 = ((TextBox)r.FindControl("mon08")).Text;
            mon09 = ((TextBox)r.FindControl("mon09")).Text;
            mon10 = ((TextBox)r.FindControl("mon10")).Text;
            mon11 = ((TextBox)r.FindControl("mon11")).Text;
            mon12 = ((TextBox)r.FindControl("mon12")).Text;
            ps = ((TextBox)r.FindControl("ps")).Text;

            DataRow row = originalDataTable3.Select(String.Format("no = {0}", currentID))[0];

            //if (!emp_no.Equals(row["emp_no"].ToString())) { return true; }
            //if (!emp_cne.Equals(row["emp_cne"].ToString())) { return true; }
            //if (!editdate.Equals(row["editdate"].ToString())) { return true; }
            if (!year.Equals(row["year"].ToString())) { return true; }
            if (!AccNO.Equals(row["AccNO"].ToString())) { return true; }
            if (!AccName.Equals(row["AccName"].ToString())) { return true; }
            if (!dept_no.Equals(row["dept_no"].ToString())) { return true; }
            if (!mon01.Equals(row["mon01"].ToString())) { return true; }
            if (!mon02.Equals(row["mon02"].ToString())) { return true; }
            if (!mon03.Equals(row["mon03"].ToString())) { return true; }
            if (!mon04.Equals(row["mon04"].ToString())) { return true; }
            if (!mon05.Equals(row["mon05"].ToString())) { return true; }
            if (!mon06.Equals(row["mon06"].ToString())) { return true; }
            if (!mon07.Equals(row["mon07"].ToString())) { return true; }
            if (!mon08.Equals(row["mon08"].ToString())) { return true; }
            if (!mon09.Equals(row["mon09"].ToString())) { return true; }
            if (!mon10.Equals(row["mon10"].ToString())) { return true; }
            if (!mon11.Equals(row["mon11"].ToString())) { return true; }
            if (!mon12.Equals(row["mon12"].ToString())) { return true; }
            if (!ps.Equals(row["ps"].ToString())) { return true; }
            return false;
        }
    }
}