using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using NPOI.HSSF.UserModel;
using NPOI.SS.UserModel;
using System.IO;

namespace JuicERP.Pages
{
    public partial class JuicWMS : System.Web.UI.Page
    {
        private DataTable _result
        {
            get
            {
                if (Session["_juicwmsresult"] == null)
                    Session["_juicwmsresult"] = new DataTable();
                return (DataTable)Session["_juicwmsresult"];
            }
            set
            {
                Session["_juicwmsresult"] = value;
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                this._result = null;
            }

            //檢查是否有查詢庫存權限
            DAL.JuicDao dao = new DAL.JuicDao("MENU");
            var tb = dao.checkcontrol(User.Identity.Name.ToString(), 11);
            //無查詢庫存權限 取消按鈕 
            if (tb.Rows.Count == 0)
            {
                Button1.Enabled = false;
                txtExportExcel.Enabled = false;
                Button1.Text = "未擁有查詢庫存權限";

            }
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            //Control ctl = LoadControl("~/UserControls/QueryWindow.ascx");
            //ctl.ID = new Guid().ToString();
            //ModalPanel.Controls.Add(ctl);
            ShowModalControl();
        }

        public void ShowModalControl()
        {
            QueryWindow.SetDbName(rblCompany.SelectedItem.Value);
            QueryWindow.ClearInput();
            this.ShowControl(ModalPanel.ClientID, rblCompany.SelectedItem.Text + "查詢");
            //如何控制使用者控制介面的格式
            //久威國際查詢這個字串事傳到哪裡去呢
        }

        public void GetData(string dbName, string jVendors, string jWareHouses, string jOutDateStart, string jOutDateEnd, int jDelayDateStart, int jDelayDateEnd, string jProdID, string jVProdID, string jSPEC)
        {
            DAL.JuicDao dao = new DAL.JuicDao(dbName);
            try
            {
                this._result = dao.GetWHQ(jVendors, jWareHouses, jOutDateStart, jOutDateEnd, jDelayDateStart, jDelayDateEnd, jProdID, jVProdID, jSPEC);
                lblQueryCond.Text = "";
                if (false == string.IsNullOrEmpty(jVendors)) lblQueryCond.Text += "<br />" + "廠商別：" + jVendors;
                if (false == string.IsNullOrEmpty(jWareHouses)) lblQueryCond.Text += "<br />" + "倉庫別：" + jWareHouses;
                if (false == string.IsNullOrEmpty(jOutDateStart) || false == string.IsNullOrEmpty(jOutDateEnd)) lblQueryCond.Text += "<br />" + "最近銷貨日：" + jOutDateStart + "～" + jOutDateEnd;
                if (jDelayDateStart > 0 || jDelayDateEnd > 0) lblQueryCond.Text += "<br />" + "呆滯日：" + jDelayDateStart + "～" + jDelayDateEnd;
                if (false == string.IsNullOrEmpty(jProdID)) lblQueryCond.Text += "<br />" + "品號：" + jProdID;
                if (false == string.IsNullOrEmpty(jVProdID)) lblQueryCond.Text += "<br />" + "廠商品號：" + jVProdID;
                if (false == string.IsNullOrEmpty(jSPEC)) lblQueryCond.Text += "<br />" + "品名規格：" + jSPEC;
                gvWHQ.PageIndex = 0;
                BindData();
                MessageBox1.ShowRecordCount(gvWHQ);
            }
            finally
            {
                dao = null;
            }
        }

        protected void BindData(string sortExpression = "")
        {
            if (false == String.IsNullOrEmpty(sortExpression))
            {
                using (GVSortHelper gs = new GVSortHelper(ViewState, gvWHQ.ID))
                {
                    gs.SetSortExpression(sortExpression);
                    gs.SortGV(this._result);
                    //如何繫結資料Q_Q
                }
            }
            gvWHQ.DataSource = this._result;
            gvWHQ.DataBind();
        }

        protected void gvWHQ_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvWHQ.PageIndex = e.NewPageIndex;
            BindData();
        }

        protected void gvWHQ_Sorting(object sender, GridViewSortEventArgs e)
        {
            BindData(e.SortExpression);
        }

        protected void txtExportExcel_Click(object sender, EventArgs e)
        {
            HSSFWorkbook wb = new HSSFWorkbook();
            ISheet sheet = wb.CreateSheet("WHQ");
            IRow row;
            ICell cell;
            row = sheet.CreateRow(0);
            int colIdx = 0;
            foreach (DataColumn dataCol in this._result.Columns)
            {
                cell = row.CreateCell(colIdx);
                cell.SetCellValue(GetColName(dataCol));
                colIdx++;
            }

            int rowIdx = 1;
            foreach (DataRow dataRow in this._result.Rows)
            {
                row = sheet.CreateRow(rowIdx);
                rowIdx++;
                colIdx = 0;
                foreach (DataColumn dataCol in this._result.Columns)
                {
                    cell = row.CreateCell(colIdx);
                    cell.SetCellValue(Convert.ToString(dataRow[colIdx]));
                    colIdx++;
                }
            }

            using (MemoryStream ms = new MemoryStream())
            {
                wb.Write(ms);
                ResponseFile(ms.GetBuffer(), "WHQ_" + DateTime.Now.ToString("yyyyMMddHHmmss") + ".xls", "application/vnd.ms-excel");
            }

        }

        public static void ResponseFile(byte[] fileContent, string fileName, string contentType)
        {
            HttpContext.Current.Response.Clear();
            HttpContext.Current.Response.ContentType = contentType;
            HttpContext.Current.Response.AddHeader("Content-Length", fileContent.Length.ToString());
            if (HttpContext.Current.Request.ServerVariables["http_user_agent"].ToLower().IndexOf("firefox") == -1)
                HttpContext.Current.Response.AddHeader("Content-Disposition", string.Format("attachment;filename={0}", System.Web.HttpUtility.UrlEncode(fileName)));
            else
                HttpContext.Current.Response.AddHeader("Content-Disposition", string.Format("attachment;filename={0}", fileName));
            HttpContext.Current.Response.BinaryWrite(fileContent);
            HttpContext.Current.Response.Flush(); // Sends all currently buffered output to the client.
            HttpContext.Current.Response.SuppressContent = true;  // Gets or sets a value indicating whether to send HTTP content to the client.
            HttpContext.Current.ApplicationInstance.CompleteRequest(); // Causes ASP.NET to bypass all events and filtering in the HTTP pipeline chain of execution and directly execute the EndRequest event.
        }

        private string GetColName(DataColumn col)
        {
            switch (col.ColumnName)
            {
                case "JClass": return "商品類別";
                case "JProdID": return "品號";
                case "JVProdID": return "廠商品號";
                case "JSPEC": return "品名規格";
                case "JLastQuan": return "庫存數量";
                case "JUnit": return "單位";
                case "JSCost": return "現行單價";
                case "JCost": return "現行成本";
                case "JWareHouse": return "倉庫別";
                case "JVendor": return "廠商別";
                case "JOutDate": return "最近銷貨日";
                case "JInDate": return "最近進貨/入庫日";
                case "JDelayDate": return "呆滯日";
                case "JYearMonth": return "成本年月";
                default: return col.ColumnName;
            }
        }
    }
}
