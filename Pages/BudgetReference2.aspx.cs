using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace JuicERP.Pages
{
    public partial class BudgetReference2 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Label1.Text = User.Identity.Name.ToString();
        }

        protected void DropDownList1_SelectedIndexChanged(object sender, EventArgs e)
        {
            Label2.Text = DropDownList1.SelectedValue;
        }
    }
}