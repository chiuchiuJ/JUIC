using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Reflection;

namespace JuicERP.UserControls
{
    public partial class MessageBox : System.Web.UI.UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        public string ErrorMessage
        {
            get
            {
                return lblErrorMessage.Text;
            }
            set
            {
                value = value.Trim();
                if (String.IsNullOrEmpty(value))
                {
                    lblHint.Visible = false;
                    //lblMessage.Visible = false;
                    //lblMessage.Text = "";

                    lblMessage.Visible = false;
                    lblMessage.Text = "";
                }
                else
                {
                    lblHint.Visible = true;
                    //lblMessage.Visible = true;
                    //lblMessage.Text = value;

                    lblErrorMessage.Visible = true;
                    lblErrorMessage.Text = value;
                }

            }
        }

        public string Message
        {
            get
            {
                return lblMessage.Text;
            }
            set
            {
                value = value.Trim();
                if (String.IsNullOrEmpty(value))
                {
                    lblHint.Visible = false;
                    lblMessage.Visible = false;
                    lblMessage.Text = "";
                }
                else
                {
                    lblHint.Visible = true;
                    lblMessage.Visible = true;
                    lblMessage.Text = value;
                }

            }
        }

        public void ShowRecordCount(int TotalCount, int thisPage, int TotalPages)
        {
            lblCount.Visible = true;
            lblCount.Text = "共" + TotalCount.ToString() + "筆";
            lblPage.Visible = true;
            lblPage.Text = "(第" + thisPage.ToString() + "頁/共" + TotalPages.ToString() + "頁)";
        }

        public void ShowRecordCount(GridView bindGV)
        {
            lblCount.Visible = true;
            lblCount.Text = "共" + RecordsCount(bindGV.DataSource).ToString() + "筆";
            lblPage.Visible = true;
            lblPage.Text = "(第" + (bindGV.PageIndex + 1).ToString() + "頁/共" + bindGV.PageCount.ToString() + "頁)";
        }

        private int RecordsCount(object o)
        {
            try
            {
                if (o is DataSet)
                {
                    return ((DataSet)o).Tables[0].Rows.Count;
                }
                else if (o is DataTable)
                {
                    return ((DataTable)o).Rows.Count;
                }

                return (int)(o.GetType().GetProperty("Count").GetValue(o, null));
            }
            catch
            {
                return -1;
            }
        }
    }
}