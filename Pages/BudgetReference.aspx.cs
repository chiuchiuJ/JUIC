using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace JuicERP.Pages
{
    public partial class BudgetReference : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Label4.Text = User.Identity.Name.ToString();
        }

        protected void DropDownList1_SelectedIndexChanged(object sender, EventArgs e)
        {
            Label2.Text = DropDownList1.SelectedValue;
            label3.Text = DropDownList1.SelectedItem.Text+" 預算實支比";
        }


    }
}