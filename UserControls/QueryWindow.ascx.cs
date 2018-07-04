using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

namespace JuicERP.UserControls
{
    public partial class QueryWindow : System.Web.UI.UserControl
    {

        protected void Page_Load(object sender, EventArgs e)
        {
            btnExit.OnClientClick = "CloseControl(\"" + this.Parent.FindControl("ModalPanel").ClientID + "\");  return false;";
        }

        public void SetDbName(string dbName)
        {
            hfDbName.Value = dbName;
        }

        public void ClearInput()
        {
            this.txtJVendor.Text = "";
            this.txtJVProdID.Text = "";
            this.txtJWareHouse.Text = "";
            this.txtJSPEC.Text = "";
            this.txtJProdID.Text = "";
            this.txtJDelayDateStart.Text = "";
            this.txtJDelayDateEnd.Text = "";
            this.sdpJOutDate.StartDate = null;
            this.sdpJOutDate.EndDate = null;
        }

        public void SetTextBoxValue(string ctlName, string value)
        {
            (this.FindControl(ctlName) as TextBox).Text = value;
            UpdatePanel1.Update();
        }

        protected void btnMultiVendor_Click(object sender, EventArgs e)
        {
            DAL.JuicDao dao = new DAL.JuicDao(hfDbName.Value);
            try
            {
                string[] venders = dao.GetAllJVendors().AsEnumerable().Select(row => Convert.ToString(row["JVendor"])).ToArray();
                (this.Parent.FindControl("ModalPanelChild").FindControl("ListPicker") as ListPicker).SetColumn("廠商別", "txtJVendor");
                (this.Parent.FindControl("ModalPanelChild").FindControl("ListPicker") as ListPicker).InitItems(venders);
                UpdatePanel1.ShowControl(this.Parent.FindControl("ModalPanelChild").ClientID, "廠商別多筆選擇");
            }
            finally
            {
                dao = null;
            }
        }

        protected void btnMultiWareHouse_Click(object sender, EventArgs e)
        {
            DAL.JuicDao dao = new DAL.JuicDao(hfDbName.Value);
            try
            {
                string[] venders = dao.GetAllJWareHouses().AsEnumerable().Select(row => Convert.ToString(row["JWareHouse"])).ToArray();
                (this.Parent.FindControl("ModalPanelChild").FindControl("ListPicker") as ListPicker).SetColumn("倉庫別", "txtJWareHouse");
                (this.Parent.FindControl("ModalPanelChild").FindControl("ListPicker") as ListPicker).InitItems(venders);
                UpdatePanel1.ShowControl(this.Parent.FindControl("ModalPanelChild").ClientID, "倉庫別多筆選擇");
            }
            finally
            {
                dao = null;
            }
        }

        protected void btnQuery_Click(object sender, EventArgs e)
        {
            string jVendors = "";
            string jWareHouses = "";
            string jOutDateStart = "";
            string jOutDateEnd = "";
            int jDelayDateStart = 0;
            int jDelayDateEnd = 0;
            string jProdID = "";
            string jVProdID = "";
            string jSPEC = "";
            jVendors = txtJVendor.Text.Trim();
            jWareHouses = txtJWareHouse.Text.Trim();
            if (sdpJOutDate.StartDate.HasValue) jOutDateStart = sdpJOutDate.StartDate.Value.ToString("yyyyMMdd");
            if (sdpJOutDate.EndDate.HasValue) jOutDateEnd = sdpJOutDate.EndDate.Value.ToString("yyyyMMdd");
            int.TryParse(txtJDelayDateStart.Text.Trim(), out jDelayDateStart);
            int.TryParse(txtJDelayDateEnd.Text.Trim(), out jDelayDateEnd);
            jProdID = txtJProdID.Text.Trim();
            jVProdID = txtJVProdID.Text.Trim();
            jSPEC = txtJSPEC.Text.Trim();

            ((JuicERP.Pages.JuicWMS)(this.Page)).GetData(hfDbName.Value, jVendors, jWareHouses, jOutDateStart, jOutDateEnd, jDelayDateStart, jDelayDateEnd, jProdID, jVProdID, jSPEC);
        }
    }
}