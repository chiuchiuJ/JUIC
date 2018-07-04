
using NPOI.HSSF.UserModel;
using NPOI.SS.UserModel;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace JuicERP.Pages
{
    public partial class CarrentCheck : System.Web.UI.Page
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

            //檢查是否有公務車核可權限
            DAL.JuicDao dao = new DAL.JuicDao("MENU");
            var tb = dao.checkcontrol(User.Identity.Name.ToString(), 17);
            //無公務車核可權限 取消按鈕
            if (tb.Rows.Count == 0)
            {

            }


        }

        protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                int a=0;
                int.TryParse(e.Row.Cells[6].Text.Trim(), out a);
                int b=0;
                int.TryParse(e.Row.Cells[5].Text.Trim(), out b);
                int c=0;
                int.TryParse(e.Row.Cells[4].Text.Trim(), out c);

                if (a > 60)
                {

                    e.Row.Cells[6].BackColor = System.Drawing.Color.Pink;
                    e.Row.Cells[6].Font.Bold = true;

                }
                if (b < -30 || b > 30)
                {

                    e.Row.Cells[5].BackColor = System.Drawing.Color.Yellow;
                    e.Row.Cells[5].Font.Bold = true;

                }
                if (c > 72)
                {

                    e.Row.Cells[4].BackColor = System.Drawing.Color.Aquamarine;
                    e.Row.Cells[4].Font.Bold = true;

                }

                if (e.Row.Cells[7].Text.Trim() != "Y")
                {
                    e.Row.Cells[7].BackColor = System.Drawing.Color.Silver;
                }
                if (e.Row.Cells[8].Text.Trim() != "Y")
                {
                    e.Row.Cells[8].BackColor = System.Drawing.Color.Silver;
                }
                if (e.Row.Cells[9].Text.Trim() != "Y")
                {
                    e.Row.Cells[9].BackColor = System.Drawing.Color.Silver;
                }
                if (e.Row.Cells[10].Text.Trim() != "Y")
                {
                    e.Row.Cells[10].BackColor = System.Drawing.Color.Silver;
                }
            }


        }

        protected void GridView2_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                if (int.Parse(e.Row.Cells[12].Text.Trim()) > 60)
                {

                    e.Row.Cells[12].BackColor = System.Drawing.Color.Pink;
                    e.Row.Cells[12].Font.Bold = true;

                }
                if (int.Parse(e.Row.Cells[11].Text.Trim()) < -30 || int.Parse(e.Row.Cells[11].Text.Trim()) > 30)
                {

                    e.Row.Cells[11].BackColor = System.Drawing.Color.Yellow;
                    e.Row.Cells[11].Font.Bold = true;

                }
                if (int.Parse(e.Row.Cells[10].Text.Trim()) > 72)
                {

                    e.Row.Cells[10].BackColor = System.Drawing.Color.Aquamarine;
                    e.Row.Cells[10].Font.Bold = true;

                }
                if (e.Row.Cells[15].Text.Trim() != "Y")
                {
                    e.Row.Cells[15].BackColor = System.Drawing.Color.Silver;
                }
                if (e.Row.Cells[16].Text.Trim() != "Y")
                {
                    e.Row.Cells[16].BackColor = System.Drawing.Color.Silver;
                }
                if (e.Row.Cells[17].Text.Trim() != "Y")
                {
                    e.Row.Cells[17].BackColor = System.Drawing.Color.Silver;
                }
                if (e.Row.Cells[18].Text.Trim() != "Y")
                {
                    e.Row.Cells[18].BackColor = System.Drawing.Color.Silver;
                }
            }
        }

        protected void btnexcel_Click(object sender, EventArgs e)
        {
            GridView2.Visible = true;
            Response.ClearContent();
            Response.Write("<meta http-equiv=Content-Type content=text/html;charset=utf-8>");
            string excelFileName = "公務車使用狀況" + DateTime.Now.ToString("yyyyMMddHHmmss") + ".xls";
            Response.AddHeader("content-disposition", "attachment;filename=" + Server.UrlEncode(excelFileName));
            Response.ContentType = "application/excel";
            System.IO.StringWriter stringWrite = new System.IO.StringWriter();
            System.Web.UI.HtmlTextWriter htmlWrite = new HtmlTextWriter(stringWrite);
            GridView2.RenderControl(htmlWrite);
            Response.Write(stringWrite.ToString());
            Response.End();
            GridView2.Visible = false;
        }
        public override void VerifyRenderingInServerForm(Control control)
        {
            // '處理'GridView' 的控制項 'GridView' 必須置於有 runat=server 的表單標記之中   
        }
    }
}