using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace JuicERP.UserControls
{
    public partial class Alert : System.Web.UI.UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        public void SetDbName(string dbName)
        {
            hfDbName.Value = dbName;
        }
    }
}