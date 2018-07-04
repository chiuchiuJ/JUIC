using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace JuicERP.Pages
{
    public partial class Signupresult : System.Web.UI.Page
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
            Label1.Text = User.Identity.Name.ToString();
        }
        private bool tableCopied = false;
        private DataTable originalDataTable;
        protected void GridView3_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
                if (!tableCopied)
                {
                    originalDataTable = ((DataRowView)e.Row.DataItem).Row.Table.Copy();
                    ViewState["originalValuesDataTable"] = originalDataTable;
                    tableCopied = true;
                }
        }
        protected void Button1_Click(object sender, EventArgs e)
        {
            originalDataTable = (DataTable)ViewState["originalValuesDataTable"];

            foreach (GridViewRow r in GridView3.Rows)
                if (IsRowModified(r)) { GridView3.UpdateRow(r.RowIndex, false); }

            // Rebind the Grid to repopulate the original values table.
            tableCopied = false;
            GridView3.DataBind();
            Label2.Text = "更新成功";
        }
        protected bool IsRowModified(GridViewRow r)
        {
            int ID;
            //int SignupTotalid;
            string Name;
            string IDnumber;
            string Birthday;
            string Old;
            string Who;
            string Bigbus;
            string Eat;
            string PS;


            ID = Convert.ToInt32(GridView3.DataKeys[r.RowIndex].Value);
            //SignupTotalid = int.Parse(((Label)r.FindControl("SignupTotalid")).Text);
            Name = ((TextBox)r.FindControl("Name")).Text;
            IDnumber = ((TextBox)r.FindControl("IDnumber")).Text;
            Birthday = ((TextBox)r.FindControl("Birthday")).Text;
            Old = ((TextBox)r.FindControl("Old")).Text;
            Who = ((TextBox)r.FindControl("Who")).Text;
            Bigbus = ((TextBox)r.FindControl("Bigbus")).Text;
            Eat = ((TextBox)r.FindControl("Eat")).Text;
            PS = ((TextBox)r.FindControl("PS")).Text;


            DataRow row = originalDataTable.Select(String.Format("ID = {0}", ID))[0];

            //if (!SignupTotalid.Equals(row["SignupTotalid"].ToString())) { return true; }
            if (!Name.Equals(row["Name"].ToString())) { return true; }
            if (!IDnumber.Equals(row["IDnumber"].ToString())) { return true; }
            if (!Birthday.Equals(row["Birthday"].ToString())) { return true; }
            if (!Old.Equals(row["Old"].ToString())) { return true; }
            if (!Who.Equals(row["Who"].ToString())) { return true; }
            if (!Bigbus.Equals(row["Bigbus"].ToString())) { return true; }
            if (!Eat.Equals(row["Eat"].ToString())) { return true; }
            if (!PS.Equals(row["PS"].ToString())) { return true; }


            return false;
        }

        protected void DropDownList2_SelectedIndexChanged(object sender, EventArgs e)
        {
            Button1.Visible = true;
        }

        protected void GridView2_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            int i = 0;
            foreach (GridViewRow gvr in GridView2.Rows)
            {
                i = int.Parse(gvr.Cells[3].Text.Trim());
            }
            if (e.Row.RowType == DataControlRowType.Footer)
            {
                e.Row.Cells[1].Text = "合計";
                e.Row.Cells[3].Text = i.ToString();
            }
        }
    }
}