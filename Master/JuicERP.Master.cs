using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.IO;
using JuicERP.DAL;
using System.Configuration;
using System.Data.SqlClient;

namespace JuicERP.Master
{
    public partial class JuicERP : System.Web.UI.MasterPage
    {
        string guest = "guest";
        bool guestbool = false;
        protected void Page_Load(object sender, EventArgs e)
        {
            //if (HttpContext.Current.User.Identity.IsAuthenticated == false)
            //{
            //    Response.Redirect("~/Login.aspx");
            //}

            //MenuItem menuItem2 = new MenuItem
            //{


            //    Value = "123",
            //    Text = "公告",
            //    NavigateUrl = "~/Pages/JuicWMS2.aspx",

            //};
            //Menu2.Items.Clear();
            //Menu2.Items.Add(menuItem2);

            

            if (!this.IsPostBack)
            {
                JuicDao dao = new JuicDao("MENU");
                try
                {
                    var name = dao.GetUser(Page.User.Identity.Name.ToString());
                    if (name.Rows.Count > 0)
                    {
                        Label1.Text = "目前使用者:"+name.Rows[0]["username"].ToString();
                     
                    }
                    else
                    {
                        Label1.Text = "訪客可用guest/1234登入";
                    }



                    //DataTable dt = dao.GetMenus(0);
                    //以下為方便自己使用˙ˇ˙
                    if (Page.User.Identity.Name.ToString()=="04779"|| Page.User.Identity.Name.ToString() == "4779")
                    {
                        DataTable dt = dao.GetMenus(0);
                        PopulateMenu(dt, 0, null);
                    }
                    //else if(Page.User.Identity.Name.ToString() == "04761" || Page.User.Identity.Name.ToString() == "09487")
                    //{


                    //DataTable dt = dao.GetMenusbycontrol(0,Page.User.Identity.Name.ToString());
                    //PopulateMenu(dt, 0, null);
                    //}
                    else
                    {
                        //判斷ID是否存在
                        string strConn1 = ConfigurationManager.ConnectionStrings["MENU"].ConnectionString;
                        using (SqlConnection conn = new SqlConnection(strConn1))
                        {
                            String QQ = "select userid from TB_MenusControl where userid='" + Page.User.Identity.Name.ToString() + "'";

                            SqlDataAdapter da = new SqlDataAdapter(QQ, conn);
                            DataSet ds = new DataSet();
                            da.Fill(ds);
                            if (ds.Tables[0].Rows.Count != 0)
                            {
                                DataTable dt = dao.GetMenusbycontrol(0, Page.User.Identity.Name.ToString());
                                PopulateMenu(dt, 0, null);
                            }
                            else
                            {
                                guestbool = true;
                                DataTable dt = dao.GetMenusbycontrol(0, guest);
                                PopulateMenu(dt, 0, null);
                            }
                            ds.Clear();
                        }
                    }
                    
                }
                finally
                {
                    dao = null;
                }
            }
        }

        private void PopulateMenu(DataTable dt, int parentMenuId, MenuItem parentMenuItem)
        {
            JuicDao dao = new JuicDao("MENU");
            try
            {
                string currentPage = Path.GetFileName(Request.Url.AbsolutePath);
                //從資料庫加入MENU資料
                foreach (DataRow row in dt.Rows)
                {
                    MenuItem menuItem = new MenuItem
                    {
                        Value = row["MenuId"].ToString(),
                        Text = row["Title"].ToString(),
                        NavigateUrl = row["Url"].ToString(),
                        Selected = row["Url"].ToString().EndsWith(currentPage, StringComparison.CurrentCultureIgnoreCase)
                        //上述Q_Q?
                    };

                    if (row["Url"].ToString() == "#") menuItem.NavigateUrl = "";


                    if (parentMenuId == 0)
                    {
                        Menu1.Items.Add(menuItem);
                        //下述為方便自己使用
                        if (Page.User.Identity.Name.ToString() == "04779" || Page.User.Identity.Name.ToString() == "4779")
                        {
                            DataTable dtChild = dao.GetMenus(int.Parse(menuItem.Value));
                            PopulateMenu(dtChild, int.Parse(menuItem.Value), menuItem);
                        }
                        else
                        {
                            if(guestbool== true)
                            {
                                DataTable dtChild = dao.GetMenusbycontrol(int.Parse(menuItem.Value), guest);
                                PopulateMenu(dtChild, int.Parse(menuItem.Value), menuItem);
                            }
                            else
                            {
                                DataTable dtChild = dao.GetMenusbycontrol(int.Parse(menuItem.Value), Page.User.Identity.Name.ToString());
                                PopulateMenu(dtChild, int.Parse(menuItem.Value), menuItem);
                            }
                        }

                    }
                    else
                    {
                        //加入多層menu
                        parentMenuItem.ChildItems.Add(menuItem);
                    }
                }
            }



            finally
            {
                dao = null;
            }

        }
    }
}
