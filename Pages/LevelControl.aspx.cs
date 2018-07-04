using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace JuicERP.Pages
{
    public partial class LevelControl : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {            //登入檢查
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
            Button2.Click += new EventHandler(DropDownList1_SelectedIndexChanged);

            //檢查是否有設定員工權限之權限
            DAL.JuicDao dao = new DAL.JuicDao("MENU");
            var tb = dao.checkcontrol(User.Identity.Name.ToString(),8);
            if (tb.Rows.Count==0)
            {
                CheckBoxList1.Enabled = false;
                CheckBoxList2.Enabled = false;
                CheckBoxList3.Enabled = false;
                Button1.Visible = false;
            }
            //檢查是否有查看員工權限之權限
            var tb2 = dao.checkcontrol(User.Identity.Name.ToString(), 9);
            if (tb2.Rows.Count == 0)
            {
                DropDownList1.Enabled = false;
            }

        }

        protected void DropDownList1_SelectedIndexChanged(object sender, EventArgs e)
        {
            //使所有CHECKBOX選項回到初始狀態
            foreach (ListItem item in CheckBoxList1.Items)
            {
                item.Selected = false;
            }
            foreach (ListItem item in CheckBoxList2.Items)
            {
                item.Selected = false;
            }
            foreach (ListItem item in CheckBoxList3.Items)
            {
                item.Selected = false;
            }

            List<int> index = new List<int> ();
            //從資料庫中讀取MENU設定，並繫結至CHECKBOXLLIST內
            string strConn = ConfigurationManager.ConnectionStrings["MENU"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(strConn))
            {
                String QQ = "select userid,MenuId from TB_MenusControl where userid='" + DropDownList1.SelectedValue.ToString() + "' order by MenuId";

                SqlDataAdapter da = new SqlDataAdapter(QQ, conn);
                DataSet ds = new DataSet();
                da.Fill(ds);
                if (ds.Tables[0].Rows.Count!=0)
                {
                    for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
                    {
                        index.Add(int.Parse(ds.Tables[0].Rows[i][1].ToString()));
                    }
                }

            }

            foreach (ListItem item in CheckBoxList1.Items)
            {
                if(index.Contains(int.Parse(item.Value)))
                {
                    item.Selected = true;
                }

            }
            foreach (ListItem item in CheckBoxList2.Items)
            {
                if (index.Contains(int.Parse(item.Value)))
                {
                    item.Selected = true;
                }
            }

            List<int> index2 = new List<int>();

            //從資料庫中讀取功能權限設定，並繫結至CHECKBOXLLIST內

            using (SqlConnection conn = new SqlConnection(strConn))
            {
                String QQ = "select userid,ActNO from TB_UserActControl where userid='" + DropDownList1.SelectedValue.ToString() + "' order by ActNO";

                SqlDataAdapter da = new SqlDataAdapter(QQ, conn);
                DataSet ds = new DataSet();
                da.Fill(ds);
                if (ds.Tables[0].Rows.Count != 0)
                {
                    for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
                    {
                        index2.Add(int.Parse(ds.Tables[0].Rows[i][1].ToString()));
                    }
                }

            }

            foreach (ListItem item in CheckBoxList3.Items)
            {
                if (index2.Contains(int.Parse(item.Value)))
                {
                    item.Selected = true;
                }

            }

        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            //將設定好的MENU和功能權限更改資料庫

            //MENU設定之LIST
            List<int> inputmenu = new List<int>();
            foreach(ListItem item in CheckBoxList1.Items)
            {
                if(item.Selected)
                {
                    inputmenu.Add(int.Parse(item.Value));
                }
            }
            foreach (ListItem item in CheckBoxList2.Items)
            {
                if (item.Selected)
                {
                    inputmenu.Add(int.Parse(item.Value));
                }
            }
            //功能權限設定之LIST
            List<int> inputcontrol = new List<int>();
            foreach (ListItem item in CheckBoxList3.Items)
            {
                if (item.Selected)
                {
                    inputcontrol.Add(int.Parse(item.Value));
                }
            }
            //獲得被選取的使用者ID
            string who = DropDownList1.SelectedValue.Trim();

            //刪除該使用者之所有權限
            string strConn = ConfigurationManager.ConnectionStrings["MENU"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(strConn))
            {
                string strCmd = "DELETE FROM TB_MenusControl WHERE userid = @userid; ";
                using (SqlCommand cmd = new SqlCommand(strCmd, conn))
                {
                    cmd.Parameters.AddWithValue("@userid", who);
                    conn.Open();
                    cmd.ExecuteNonQuery();
                    conn.Close();
                }
            }

            using (SqlConnection conn = new SqlConnection(strConn))
            {
                string strCmd = "DELETE FROM TB_UserActControl WHERE userid = @userid; ";
                using (SqlCommand cmd = new SqlCommand(strCmd, conn))
                {
                    cmd.Parameters.AddWithValue("@userid", who);
                    conn.Open();
                    cmd.ExecuteNonQuery();
                    conn.Close();
                }
            }
            //重新輸入該使用者之所有權限
            for (int i = 0; i < inputcontrol.Count; i++)
            {
                using (SqlConnection conn = new SqlConnection(strConn))
                {
                    string strCmd = "Insert into TB_UserActControl(userid,ActNO)values(@userid,@ActNO)";
                    using (SqlCommand cmd = new SqlCommand(strCmd, conn))
                    {
                        cmd.Parameters.AddWithValue("@userid", who);
                        cmd.Parameters.AddWithValue("@ActNO", inputcontrol[i]);


                        string message = "";

                        try
                        {
                            conn.Open();
                            cmd.ExecuteNonQuery();
                            message = "修改權限成功";

                        }
                        catch (Exception ex)
                        {
                            message = ex.Message;

                        }
                        finally
                        {
                            conn.Close();
                        }
                    }
                }
            }

            for (int i = 0; i < inputmenu.Count; i++)
            {
                using (SqlConnection conn = new SqlConnection(strConn))
                {
                    string strCmd = "Insert into TB_MenusControl(userid,MenuId)values(@userid,@MenuId)";
                    using (SqlCommand cmd = new SqlCommand(strCmd, conn))
                    {
                        cmd.Parameters.AddWithValue("@userid", who);
                        cmd.Parameters.AddWithValue("@MenuId", inputmenu[i]);


                        string message = "";

                        try
                        {
                            conn.Open();
                            cmd.ExecuteNonQuery();
                            message = "修改權限成功";

                        }
                        catch (Exception ex)
                        {
                            message = ex.Message;
                            
                        }
                        finally
                        {
                            conn.Close();
                            string strJS = "alert('" + message + "');location.href = ('LevelControl.aspx');";
                            Page.ClientScript.RegisterStartupScript(this.GetType(), "", strJS, true);
                        }
                    }
                }
            }
        }

        protected void Button2_Click(object sender, EventArgs e)
        {
         //查看自己權限 並觸發dropdownlist事件(已從pageload設定)
         foreach(ListItem item in DropDownList1.Items)
            {
                item.Selected = false;
                if (item.Value.Trim()==User.Identity.Name.ToString())
                {
                    item.Selected = true;
                }
            }
        }
    }
}