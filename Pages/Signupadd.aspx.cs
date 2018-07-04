using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace JuicERP.Pages
{
    public partial class Signupadd : System.Web.UI.Page
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
            //檢查是否有新增活動之權限
            DAL.JuicDao dao = new DAL.JuicDao("MENU");
            var tb = dao.checkcontrol(User.Identity.Name.ToString(), 4);
            //無新增活動權限 取消按鈕
            if (tb.Rows.Count == 0)
            {
                Button1.Enabled = false;
                Button1.Text = "尚未開通新增活動權限";
            }
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            //將附件上傳
            String fileNameraw = "0";
            if (FileUpload1.HasFile)
            {
                String fileName = FileUpload1.FileName;
                fileNameraw = "~/files/signup/" + FileUpload1.FileName;

                String savePath = Server.MapPath("~/files/signup/");

                String saveResult = savePath + fileName;
                //-- 重點！！必須包含 Server端的「目錄」與「檔名」，才能使用 .SaveAs()方法！
                FileUpload1.SaveAs(saveResult);


                //若要更改檔名在此更改
                //if (TextBox1.Text != "")
                //{
                //    fileName = TextBox1.Text;
                //}

            }


            int check1 = 0;
            int check2 = 0;
            //int check3 = 0;

            //此次新增投票是否開放修改參加者，多人參加和葷食素食選擇
            if (CheckBoxList1.Items[0].Selected)
            {
                check1 = 1;
            }
            if (CheckBoxList1.Items[1].Selected)
            {
                check2 = 1;
            }
            //if (CheckBoxList1.Items[2].Selected)
            //{
            //    check3 = 0;
            //}
            //額外要求資訊清單
            string list = "";

            if (CheckBoxList1.Items[1].Selected)
            {
                list += "      需求資料：";
            }
            if (CheckBoxList2.Items[0].Selected)
            {
                list += " 身分證 ";
            }
            if (CheckBoxList2.Items[1].Selected)
            {
                list += " 出生年月日 ";
            }
            if (CheckBoxList2.Items[2].Selected)
            {
                list += " 飲食狀況 ";
            }
            if (CheckBoxList2.Items[3].Selected)
            {
                list += " 是否搭乘包車 ";
            }
            string name = "";
            DAL.JuicDao dao = new DAL.JuicDao("MENU");
            
            var getuser = dao.GetUsername(User.Identity.Name.ToString());//待新增
            if (getuser.Rows.Count != 0)
            {
                name=getuser.Rows[0]["username"].ToString();

            }

            string strConn = ConfigurationManager.ConnectionStrings["MENU"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(strConn))
            {
                string strCmd = "Insert into TB_SignupList(Title,Type,Content,Startdate,Enddate,Activedate,Addons1,Addons2,Addons3,FileURL,emp_no,emp_cne)values(@Title,@Type,@Content,@Startdate,@Enddate,@Activedate,@Addons1,@Addons2,@Addons3,@FileURL,@emp_no,@emp_cne)";
                using (SqlCommand cmd = new SqlCommand(strCmd, conn))
                {
                    cmd.Parameters.AddWithValue("@Title", title.Text);
                    cmd.Parameters.AddWithValue("@Type", DropDownList1.SelectedItem.Text);
                    cmd.Parameters.AddWithValue("@Content", content.Text);
                    cmd.Parameters.AddWithValue("@Startdate", DateTime.Parse(datestart.Text));
                    cmd.Parameters.AddWithValue("@Enddate", DateTime.Parse(dateend.Text));
                    cmd.Parameters.AddWithValue("@Activedate", DateTime.Parse(TextBox3.Text));
                    cmd.Parameters.AddWithValue("@Addons1", check1);
                    cmd.Parameters.AddWithValue("@Addons2", check2);
                    cmd.Parameters.AddWithValue("@Addons3", list);
                    cmd.Parameters.AddWithValue("@FileURL", fileNameraw);
                    cmd.Parameters.AddWithValue("@emp_no", User.Identity.Name.ToString());
                    cmd.Parameters.AddWithValue("@emp_cne", name);


                    string message = "";

                    try
                    {
                        conn.Open();
                        cmd.ExecuteNonQuery();
                        message = "新增成功";

                    }
                    catch (Exception ex)
                    {
                        message = ex.Message;
                    }
                    finally
                    {
                        conn.Close();
                        string strJS = "alert('" + message + "');location.href = ('Join.aspx');";
                        Page.ClientScript.RegisterStartupScript(this.GetType(), "", strJS, true);
                    }

                }
            }
        }

        protected void CheckBoxList1_SelectedIndexChanged(object sender, EventArgs e)
        {
        
            if (CheckBoxList1.Items[1].Selected==true)
            {
               
                CheckBoxList2.Visible = true;
            }
            else if (CheckBoxList1.Items[1].Selected == false)
            {
                CheckBoxList2.Visible = false;
            }
            

        }
    }
}