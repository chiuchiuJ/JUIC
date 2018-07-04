using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace JuicERP.Pages
{
    public partial class Vote : System.Web.UI.Page
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
        }

        protected void gvVote_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "post")
            {

                ModalPanel.Visible = true;

                Votego.getVoteTitle(e.CommandArgument.ToString().Split(new string[] { ",," }, StringSplitOptions.RemoveEmptyEntries)[0].Trim());
                Votego.getVoteContent(e.CommandArgument.ToString().Split(new string[] { ",," }, StringSplitOptions.RemoveEmptyEntries)[1].Trim());
                //Votego.getVoteStart(e.CommandArgument.ToString().Split(new string[] { ",," }, StringSplitOptions.RemoveEmptyEntries)[2].Trim());
                //Votego.getVoteEnd(e.CommandArgument.ToString().Split(new string[] { ",," }, StringSplitOptions.RemoveEmptyEntries)[3].Trim());
                Votego.getVoteStartEnd(e.CommandArgument.ToString().Split(new string[] { ",," }, StringSplitOptions.RemoveEmptyEntries)[2].Trim(), e.CommandArgument.ToString().Split(new string[] { ",," }, StringSplitOptions.RemoveEmptyEntries)[3].Trim());
                Votego.getVotelist1(e.CommandArgument.ToString().Split(new string[] { ",," }, StringSplitOptions.RemoveEmptyEntries)[4].Trim());
                Votego.getVotelist1set(e.CommandArgument.ToString().Split(new string[] { ",," }, StringSplitOptions.RemoveEmptyEntries)[5].Trim(), e.CommandArgument.ToString().Split(new string[] { ",," }, StringSplitOptions.RemoveEmptyEntries)[11].Trim());
                Votego.getVotelist2(e.CommandArgument.ToString().Split(new string[] { ",," }, StringSplitOptions.RemoveEmptyEntries)[6].Trim());
                Votego.getVotelist2set(e.CommandArgument.ToString().Split(new string[] { ",," }, StringSplitOptions.RemoveEmptyEntries)[7].Trim(), e.CommandArgument.ToString().Split(new string[] { ",," }, StringSplitOptions.RemoveEmptyEntries)[11].Trim());
                Votego.getVotelist3(e.CommandArgument.ToString().Split(new string[] { ",," }, StringSplitOptions.RemoveEmptyEntries)[8].Trim());
                Votego.getVotelist3set(e.CommandArgument.ToString().Split(new string[] { ",," }, StringSplitOptions.RemoveEmptyEntries)[9].Trim(), e.CommandArgument.ToString().Split(new string[] { ",," }, StringSplitOptions.RemoveEmptyEntries)[11].Trim());
                Votego.getUserID(e.CommandArgument.ToString().Split(new string[] { ",," }, StringSplitOptions.RemoveEmptyEntries)[10].Trim());
                Votego.getVoteID(e.CommandArgument.ToString().Split(new string[] { ",," }, StringSplitOptions.RemoveEmptyEntries)[11].Trim());
                Votego.getVoteHolder(e.CommandArgument.ToString().Split(new string[] { ",," }, StringSplitOptions.RemoveEmptyEntries)[12].Trim());
            }
        }
    }
}