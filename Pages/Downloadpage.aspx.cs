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
    public partial class Downloadpage : System.Web.UI.Page
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
            //Panel2.Visible = false;
            //Panel3.Visible = false;
            //Panel4.Visible = false;
            //Panel5.Visible = false;

            Label4.Text = User.Identity.Name.ToString();
            if (!IsPostBack)
            {
                Panel2.Visible = false;
                Panel3.Visible = false;
                Panel4.Visible = false;
                Panel5.Visible = false;

                DAL.JuicDao dao = new DAL.JuicDao("MENU");
                var tb = dao.checkcontrol(User.Identity.Name.ToString(), 19);
                //無上傳檔案權限，隱藏功能
                if (tb.Rows.Count == 0)
                {
                    Panel1.Visible = false;
                }
                Label4.Text = User.Identity.Name.ToString();
                var tb2 = dao.checkcontrol(User.Identity.Name.ToString(), 21);
                //無上傳檔案權限，隱藏功能
                if (tb2.Rows.Count == 0)
                {
                    Button2.Visible = false;
                }
                var tb3 = dao.checkcontrol(User.Identity.Name.ToString(), 22);
                //無上傳檔案權限，隱藏功能
                if (tb3.Rows.Count == 0)
                {
                    //DropDownList1.Items.Remove(DropDownList1.Items.FindByText("檔案程式"));
                    //DropDownList1.Items.Remove(DropDownList1.Items.FindByText("文件資料"));
                    DropDownList1.Items.Remove(DropDownList1.Items.FindByValue("file"));
                    DropDownList1.Items.Remove(DropDownList1.Items.FindByValue("data"));
                }

                string[] ext = { ".pdf", ".doc", ".docx", ".xls", ".xlsx", ".mp3", ".mp4", ".jpg", ".pptx", ".ppt" };
                //foreach (string fname in System.IO.Directory.GetFileSystemEntries(@"\\Dell-db\\管理"))
                string[] fnameraw = System.IO.Directory.GetFileSystemEntries(@"\\Dell-db\\管理");
                List<string> fname = new List<string>();

                foreach (string test in fnameraw)
                {
                    if (ext.Contains(System.IO.Path.GetExtension(test).Trim()) || System.IO.Path.GetExtension(test) == "")
                        fname.Add(test);
                }


                for (int i0 = 0; i0 < fname.Count; i0++)
                {

                    if (ext.Contains(System.IO.Path.GetExtension(fname[i0]).Trim()))
                    {
                        TreeView1.Nodes.Add(new TreeNode(System.IO.Path.GetFileName(fname[i0]), "0", null, "~/manage/" + System.IO.Path.GetFileName(fname[i0]), "_blank"));
                    }
                    else if (System.IO.Path.GetExtension(fname[i0]) == "")
                    {
                        TreeView1.Nodes.Add(new TreeNode(System.IO.Path.GetFileName(fname[i0]), System.IO.Path.GetFullPath(fname[i0])));
                    }



                    if (System.IO.Path.GetExtension(fname[i0]) == "")
                    {
                        string[] fname1raw = System.IO.Directory.GetFileSystemEntries(@"\\Dell-db\\管理\\" + System.IO.Path.GetFileName(fname[i0]));
                        //foreach (string fname1 in System.IO.Directory.GetFileSystemEntries(@"\\Dell-db\\管理\\" + System.IO.Path.GetFileName(fname[i0])))
                        List<string> fname1 = new List<string>();

                        foreach (string test1 in fname1raw)
                        {
                            if (ext.Contains(System.IO.Path.GetExtension(test1).Trim()) || System.IO.Path.GetExtension(test1) == "")
                                fname1.Add(test1);
                        }

                        for (int i1 = 0; i1 < fname1.Count; i1++)
                        {
                            if (ext.Contains(System.IO.Path.GetExtension(fname1[i1]).Trim()))
                            {
                                TreeView1.Nodes[i0].ChildNodes.Add(new TreeNode(System.IO.Path.GetFileName(fname1[i1]), "0", null, "~/manage/" + System.IO.Path.GetFileName(fname[i0]) + "/" + System.IO.Path.GetFileName(fname1[i1]), "_blank"));
                            }
                            else if (System.IO.Path.GetExtension(fname1[i1]) == "")
                            {
                                TreeView1.Nodes[i0].ChildNodes.Add(new TreeNode(System.IO.Path.GetFileName(fname1[i1]), (System.IO.Path.GetFullPath(fname1[i1]))));
                            }




                            if (System.IO.Path.GetExtension(fname1[i1]) == "")
                            {
                                string[] fname2raw = System.IO.Directory.GetFileSystemEntries(@"\\Dell-db\\管理\\" + System.IO.Path.GetFileName(fname[i0]) + "\\" + System.IO.Path.GetFileName(fname1[i1]));
                                List<string> fname2 = new List<string>();

                                foreach (string test2 in fname2raw)
                                {
                                    if (ext.Contains(System.IO.Path.GetExtension(test2).Trim()) || System.IO.Path.GetExtension(test2) == "")
                                        fname2.Add(test2);
                                }
                                for (int i2 = 0; i2 < fname2.Count; i2++)
                                {
                                    if (ext.Contains(System.IO.Path.GetExtension(fname2[i2]).Trim()))
                                    {
                                        TreeView1.Nodes[i0].ChildNodes[i1].ChildNodes.Add(new TreeNode(System.IO.Path.GetFileName(fname2[i2]), "0", null, "~/manage/" + System.IO.Path.GetFileName(fname[i0]) + "/" + System.IO.Path.GetFileName(fname1[i1]) + "/" + System.IO.Path.GetFileName(fname2[i2]), "_blank"));
                                    }
                                    else if (System.IO.Path.GetExtension(fname2[i2]) == "")
                                    {
                                        TreeView1.Nodes[i0].ChildNodes[i1].ChildNodes.Add(new TreeNode(System.IO.Path.GetFileName(fname2[i2]), System.IO.Path.GetFullPath(fname2[i2])));
                                    }
                                    if (System.IO.Path.GetExtension(fname2[i2]) == "")
                                    {
                                        string[] fname3raw = System.IO.Directory.GetFileSystemEntries(@"\\Dell-db\\管理\\" + System.IO.Path.GetFileName(fname[i0]) + "\\" + System.IO.Path.GetFileName(fname1[i1]) + "\\" + System.IO.Path.GetFileName(fname2[i2]));
                                        List<string> fname3 = new List<string>();

                                        foreach (string test3 in fname3raw)
                                        {
                                            if (ext.Contains(System.IO.Path.GetExtension(test3).Trim()) || System.IO.Path.GetExtension(test3) == "")
                                                fname3.Add(test3);
                                        }
                                        for (int i3 = 0; i3 < fname3.Count; i3++)
                                        {
                                            if (ext.Contains(System.IO.Path.GetExtension(fname3[i3]).Trim()))
                                            {
                                                TreeView1.Nodes[i0].ChildNodes[i1].ChildNodes[i2].ChildNodes.Add(new TreeNode(System.IO.Path.GetFileName(fname3[i3]), "0", null, "~/manage/" + System.IO.Path.GetFileName(fname[i0]) + "/" + System.IO.Path.GetFileName(fname1[i1]) + "/" + System.IO.Path.GetFileName(fname2[i2]) + "/" + System.IO.Path.GetFileName(fname3[i3]), "_blank"));
                                            }

                                            else if (System.IO.Path.GetExtension(fname3[i3]) == "")
                                            {
                                                TreeView1.Nodes[i0].ChildNodes[i1].ChildNodes[i2].ChildNodes.Add(new TreeNode(System.IO.Path.GetFileName(fname3[i3]), System.IO.Path.GetFullPath(fname3[i3])));
                                            }

                                        }

                                    }


                                }
                            }
                        }




                    }
                }




                //Label1.Text += fname + ",<br>";
                //Label1.Text += "路徑完整名稱 : " + System.IO.Path.GetFullPath(fname) + ",<br>";
                //Label1.Text += "路徑根目錄 : " + System.IO.Path.GetPathRoot(fname) + ",<br>";
                //Label1.Text += "路徑目錄資訊 : " + System.IO.Path.GetDirectoryName(fname) + ",<br>";
                //Label1.Text += "路徑檔案完整名稱 : " + System.IO.Path.GetFileName(fname) + ",<br>";
                //Label1.Text += "路徑檔案名稱 : " + System.IO.Path.GetFileNameWithoutExtension(fname) + ",<br>";
                //Label1.Text += "路徑檔案副檔名 : " + System.IO.Path.GetExtension(fname) + ",<br>";
            }

            //foreach (string fname in System.IO.Directory.GetFileSystemEntries(@"\\Dell-db\\管理\\公告\\2016"))
            //{
            //    Label1.Text += fname + ",<br>";
            //    Label1.Text += "路徑完整名稱 : " + System.IO.Path.GetFullPath(fname) + ",<br>";
            //    Label1.Text += "路徑根目錄 : " + System.IO.Path.GetPathRoot(fname) + ",<br>";
            //    Label1.Text += "路徑目錄資訊 : " + System.IO.Path.GetDirectoryName(fname) + ",<br>";
            //    Label1.Text += "路徑檔案完整名稱 : " + System.IO.Path.GetFileName(fname) + ",<br>";
            //    Label1.Text += "路徑檔案名稱 : " + System.IO.Path.GetFileNameWithoutExtension(fname) + ",<br>";
            //    Label1.Text += "路徑檔案副檔名 : " + System.IO.Path.GetExtension(fname) + ",<br>";
            //}

            //TreeView1.Nodes.Add(new TreeNode("QQ", "6"));
            //for (int i = 1; i <= 10; i++)
            //{
            //    TreeView1.Nodes[1].ChildNodes.Add(new TreeNode("QQ", i.ToString()));
            //    TreeView1.Nodes[1].ChildNodes[0].ChildNodes.Add(new TreeNode("QQ", i.ToString()));
            //}

        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            if (Button1.Text == "dell-管理/全展開")
            {
                TreeView1.ExpandAll();
                Button1.Text = "dell-管理/全收合";
            }
            else if (Button1.Text == "dell-管理/全收合")
            {
                TreeView1.CollapseAll();
                Button1.Text = "dell-管理/全展開";
            }
        }

        protected void Button2_Click(object sender, EventArgs e)
        {

            List<string> datebase1 = new List<string>();
            List<string> datebase2 = new List<string>();
            List<string> datebase3 = new List<string>();

            string[] ext = { ".pdf", ".doc", ".docx", ".xls", ".xlsx", ".mp3", ".mp4", ".jpg", ".pptx", ".ppt" };

            string[] fnameraw = System.IO.Directory.GetFileSystemEntries(@"\\Dell-db\\管理");
            List<string> fname = new List<string>();

            foreach (string test in fnameraw)
            {
                if (ext.Contains(System.IO.Path.GetExtension(test).Trim()) || System.IO.Path.GetExtension(test) == "")
                    fname.Add(test);
            }


            for (int i0 = 0; i0 < fname.Count; i0++)
            {

                if (ext.Contains(System.IO.Path.GetExtension(fname[i0]).Trim()))
                {
                    datebase1.Add(System.IO.Path.GetDirectoryName(fname[i0]));
                    datebase2.Add(System.IO.Path.GetFileName(fname[i0]));
                    datebase3.Add("~/manage/" + System.IO.Path.GetFileName(fname[i0]));
                }
                else if (System.IO.Path.GetExtension(fname[i0]) == "")
                {

                }



                if (System.IO.Path.GetExtension(fname[i0]) == "")
                {
                    string[] fname1raw = System.IO.Directory.GetFileSystemEntries(@"\\Dell-db\\管理\\" + System.IO.Path.GetFileName(fname[i0]));
                    //foreach (string fname1 in System.IO.Directory.GetFileSystemEntries(@"\\Dell-db\\管理\\" + System.IO.Path.GetFileName(fname[i0])))
                    List<string> fname1 = new List<string>();

                    foreach (string test1 in fname1raw)
                    {
                        if (ext.Contains(System.IO.Path.GetExtension(test1).Trim()) || System.IO.Path.GetExtension(test1) == "")
                            fname1.Add(test1);
                    }

                    for (int i1 = 0; i1 < fname1.Count; i1++)
                    {
                        if (ext.Contains(System.IO.Path.GetExtension(fname1[i1]).Trim()))
                        {
                            datebase1.Add(System.IO.Path.GetDirectoryName(fname1[i1]));
                            datebase2.Add(System.IO.Path.GetFileName(fname1[i1]));
                            datebase3.Add("~/manage/" + System.IO.Path.GetFileName(fname[i0]) + "/" + System.IO.Path.GetFileName(fname1[i1]));
                        }
                        else if (System.IO.Path.GetExtension(fname1[i1]) == "")
                        {

                        }




                        if (System.IO.Path.GetExtension(fname1[i1]) == "")
                        {
                            string[] fname2raw = System.IO.Directory.GetFileSystemEntries(@"\\Dell-db\\管理\\" + System.IO.Path.GetFileName(fname[i0]) + "\\" + System.IO.Path.GetFileName(fname1[i1]));
                            List<string> fname2 = new List<string>();

                            foreach (string test2 in fname2raw)
                            {
                                if (ext.Contains(System.IO.Path.GetExtension(test2).Trim()) || System.IO.Path.GetExtension(test2) == "")
                                    fname2.Add(test2);
                            }
                            for (int i2 = 0; i2 < fname2.Count; i2++)
                            {
                                if (ext.Contains(System.IO.Path.GetExtension(fname2[i2]).Trim()))
                                {
                                    datebase1.Add(System.IO.Path.GetDirectoryName(fname2[i2]));
                                    datebase2.Add(System.IO.Path.GetFileName(fname2[i2]));
                                    datebase3.Add("~/manage/" + System.IO.Path.GetFileName(fname[i0]) + "/" + System.IO.Path.GetFileName(fname1[i1]) + "/" + System.IO.Path.GetFileName(fname2[i2]));
                                }
                                else if (System.IO.Path.GetExtension(fname2[i2]) == "")
                                {

                                }
                                if (System.IO.Path.GetExtension(fname2[i2]) == "")
                                {
                                    string[] fname3raw = System.IO.Directory.GetFileSystemEntries(@"\\Dell-db\\管理\\" + System.IO.Path.GetFileName(fname[i0]) + "\\" + System.IO.Path.GetFileName(fname1[i1]) + "\\" + System.IO.Path.GetFileName(fname2[i2]));
                                    List<string> fname3 = new List<string>();

                                    foreach (string test3 in fname3raw)
                                    {
                                        if (ext.Contains(System.IO.Path.GetExtension(test3).Trim()) || System.IO.Path.GetExtension(test3) == "")
                                            fname3.Add(test3);
                                    }
                                    for (int i3 = 0; i3 < fname3.Count; i3++)
                                    {
                                        if (ext.Contains(System.IO.Path.GetExtension(fname3[i3]).Trim()))
                                        {
                                            datebase1.Add(System.IO.Path.GetDirectoryName(fname3[i3]));
                                            datebase2.Add(System.IO.Path.GetFileName(fname3[i3]));
                                            datebase3.Add("~/manage/" + System.IO.Path.GetFileName(fname[i0]) + "/" + System.IO.Path.GetFileName(fname1[i1]) + "/" + System.IO.Path.GetFileName(fname2[i2]) + "/" + System.IO.Path.GetFileName(fname3[i3]));
                                        }

                                        else if (System.IO.Path.GetExtension(fname3[i3]) == "")
                                        {

                                        }

                                    }

                                }


                            }
                        }
                    }




                }
            }

            string strConn = ConfigurationManager.ConnectionStrings["MENU"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(strConn))
            {
                string strCmd0 = "DELETE FROM TB_Downloadpage";
                {
                    using (SqlCommand cmd = new SqlCommand(strCmd0, conn))
                    {
                        //cmd.Parameters.AddWithValue("@url", datebase3[i]);
                        conn.Open();
                        cmd.ExecuteNonQuery();
                        conn.Close();
                    }
                }

                for (int i = 0; i < datebase1.Count; i++)
                {

                    //string strCmd0 = "DELETE FROM TB_Downloadpage WHERE url = @url ";
                    //{
                    //    using (SqlCommand cmd = new SqlCommand(strCmd0, conn))
                    //    {
                    //        cmd.Parameters.AddWithValue("@url", datebase3[i]);
                    //        conn.Open();
                    //        cmd.ExecuteNonQuery();
                    //        conn.Close();
                    //    }
                    //}

                    string strCmd = "Insert into TB_Downloadpage(parenturl,filename,url)values(@parenturl,@filename,@url)";
                    using (SqlCommand cmd = new SqlCommand(strCmd, conn))
                    {
                        cmd.Parameters.AddWithValue("@parenturl", datebase1[i]);
                        cmd.Parameters.AddWithValue("@filename", datebase2[i]);
                        cmd.Parameters.AddWithValue("@url", datebase3[i]);

                        string message = "";

                        try
                        {
                            conn.Open();
                            cmd.ExecuteNonQuery();
                            message = "更新資料成功";

                        }
                        catch (Exception ex)
                        {
                            message = ex.Message;
                        }
                        finally
                        {
                            conn.Close();
                            string strJS = "alert('" + message + "');location.href = ('Downloadpage.aspx');";
                            Page.ClientScript.RegisterStartupScript(this.GetType(), "", strJS, true);
                        }


                    }
                }
            }
            for (int i = 0; i < datebase1.Count; i++)
            {
                Label3.Text += datebase1[i] + datebase2[i] + "<br>";
            }


        }



        protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "join")
            {
                string parenturl = e.CommandArgument.ToString().Split(new string[] { ",," }, StringSplitOptions.RemoveEmptyEntries)[0].Trim();
                parenturl.Split(new string[] { "管理" }, StringSplitOptions.RemoveEmptyEntries)[1].Trim();

                Label3.Text += e.CommandArgument.ToString().Split(new string[] { ",," }, StringSplitOptions.RemoveEmptyEntries)[1].Trim();
                Label3.Text += e.CommandArgument.ToString().Split(new string[] { ",," }, StringSplitOptions.RemoveEmptyEntries)[2].Trim();

                string strConn = ConfigurationManager.ConnectionStrings["MENU"].ConnectionString;
                using (SqlConnection conn = new SqlConnection(strConn))
                {


                    string strCmd = "Insert into TB_Downloaduser(userid,parenturl,filename,url,joindate,class)values(@userid,@parenturl,@filename,@url,@joindate,@class)";
                    using (SqlCommand cmd = new SqlCommand(strCmd, conn))
                    {
                        cmd.Parameters.AddWithValue("@userid", User.Identity.Name.ToString());
                        cmd.Parameters.AddWithValue("@parenturl", parenturl.Split(new string[] { "管理" }, StringSplitOptions.RemoveEmptyEntries)[1].Trim());
                        cmd.Parameters.AddWithValue("@filename", e.CommandArgument.ToString().Split(new string[] { ",," }, StringSplitOptions.RemoveEmptyEntries)[1].Trim());
                        cmd.Parameters.AddWithValue("@url", e.CommandArgument.ToString().Split(new string[] { ",," }, StringSplitOptions.RemoveEmptyEntries)[2].Trim());
                        cmd.Parameters.AddWithValue("@joindate", DateTime.Now);
                        cmd.Parameters.AddWithValue("@class", "manage");

                        string message = "";

                        try
                        {
                            conn.Open();
                            cmd.ExecuteNonQuery();
                            message = "加入成功";

                        }
                        catch (Exception ex)
                        {
                            message = ex.Message;
                        }
                        finally
                        {
                            conn.Close();
                            string strJS = "alert('" + message + "');";
                            Page.ClientScript.RegisterStartupScript(this.GetType(), "", strJS, true);
                            GridView1.DataSourceID = "SqlDataSource1";
                        }


                    }
                }

            }
        }

        protected void GridView2_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "remove")
            {

                string strConn = ConfigurationManager.ConnectionStrings["MENU"].ConnectionString;
                using (SqlConnection conn = new SqlConnection(strConn))
                {

                    string strCmd = "DELETE FROM TB_Downloaduser where id='" + e.CommandArgument.ToString() + "'";
                    using (SqlCommand cmd = new SqlCommand(strCmd, conn))
                    {

                        string message = "";

                        try
                        {
                            conn.Open();
                            cmd.ExecuteNonQuery();
                            message = "移除成功";

                        }
                        catch (Exception ex)
                        {
                            message = ex.Message;
                        }
                        finally
                        {
                            conn.Close();
                            string strJS = "alert('" + message + "');";
                            Page.ClientScript.RegisterStartupScript(this.GetType(), "", strJS, true);
                            GridView2.DataSourceID = "SqlDataSource2";
                        }


                    }
                }

            }
        }

        protected void GridView3_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "join")
            {


                Label3.Text += e.CommandArgument.ToString().Split(new string[] { ",," }, StringSplitOptions.RemoveEmptyEntries)[0].Trim();
                Label3.Text += e.CommandArgument.ToString().Split(new string[] { ",," }, StringSplitOptions.RemoveEmptyEntries)[1].Trim();

                string strConn = ConfigurationManager.ConnectionStrings["MENU"].ConnectionString;
                using (SqlConnection conn = new SqlConnection(strConn))
                {


                    string strCmd = "Insert into TB_Downloaduser(userid,filename,url,joindate,class)values(@userid,@filename,@url,@joindate,@class)";
                    using (SqlCommand cmd = new SqlCommand(strCmd, conn))
                    {
                        cmd.Parameters.AddWithValue("@userid", User.Identity.Name.ToString());
                        cmd.Parameters.AddWithValue("@filename", e.CommandArgument.ToString().Split(new string[] { ",," }, StringSplitOptions.RemoveEmptyEntries)[0].Trim());
                        cmd.Parameters.AddWithValue("@url", e.CommandArgument.ToString().Split(new string[] { ",," }, StringSplitOptions.RemoveEmptyEntries)[1].Trim());
                        cmd.Parameters.AddWithValue("@joindate", DateTime.Now);
                        cmd.Parameters.AddWithValue("@class", e.CommandArgument.ToString().Split(new string[] { ",," }, StringSplitOptions.RemoveEmptyEntries)[2].Trim());

                        string message = "";

                        try
                        {
                            conn.Open();
                            cmd.ExecuteNonQuery();
                            message = "加入成功";

                        }
                        catch (Exception ex)
                        {
                            message = ex.Message;
                        }
                        finally
                        {
                            conn.Close();
                            string strJS = "alert('" + message + "');";
                            Page.ClientScript.RegisterStartupScript(this.GetType(), "", strJS, true);
                            GridView3.DataSourceID = "SqlDataSource3";
                        }


                    }
                }

            }
        }

        protected void Button3_Click(object sender, EventArgs e)
        {
            if (FileUpload1.HasFile)
            {
                String fileName = FileUpload1.FileName;
                String fileNameraw = FileUpload1.FileName;

                String savePath = Server.MapPath("~/files/");

                String saveResult = savePath + fileName;
                //-- 重點！！必須包含 Server端的「目錄」與「檔名」，才能使用 .SaveAs()方法！
                FileUpload1.SaveAs(saveResult);


                //若要更改檔名在此更改
                if (TextBox1.Text != "")
                {
                    fileName = TextBox1.Text;
                }


                string strConn = ConfigurationManager.ConnectionStrings["MENU"].ConnectionString;
                using (SqlConnection conn = new SqlConnection(strConn))
                {
                    string strCmd = "Insert into TB_Download(class,filename,explanation,url,date,emp_no)values(@class,@filename,@explanation,@url,@date,@emp_no)";
                    using (SqlCommand cmd = new SqlCommand(strCmd, conn))
                    {
                        cmd.Parameters.AddWithValue("@class", DropDownList1.SelectedValue);
                        cmd.Parameters.AddWithValue("@filename", fileName);
                        cmd.Parameters.AddWithValue("@explanation", TextBox2.Text);
                        cmd.Parameters.AddWithValue("@url", "~/files/" + fileNameraw);
                        cmd.Parameters.AddWithValue("@date", DateTime.Now);
                        cmd.Parameters.AddWithValue("@emp_no", User.Identity.Name.ToString());

                        string message = "";

                        try
                        {
                            conn.Open();
                            cmd.ExecuteNonQuery();
                            message = "檔案上傳成功";

                        }
                        catch (Exception ex)
                        {
                            message = ex.Message;
                            string strJS = "alert('" + message + "');location.href = ('Downloadpage.aspx');";
                            Page.ClientScript.RegisterStartupScript(this.GetType(), "", strJS, true);
                        }
                        finally
                        {
                            conn.Close();
                            string strJS = "alert('" + message + "');location.href = ('Downloadpage.aspx');";
                            Page.ClientScript.RegisterStartupScript(this.GetType(), "", strJS, true);
                        }
                    }
                }
            }
            else
            {
                string message = "請選擇要上傳的檔案";
                string strJS = "alert('" + message + "');location.href = ('Download.aspx');";
                Page.ClientScript.RegisterStartupScript(this.GetType(), "", strJS, true);
            }
        }
        protected void CheckBox1_CheckedChanged(object sender, EventArgs e)
        {
            if (CheckBox1.Checked)
            {
                TextBox2.Visible = true;
            }
            else
            {
                TextBox2.Visible = false;
            }
        }

        protected void GridView4_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            string p_FilePath = e.CommandArgument.ToString();
            System.IO.File.Delete(System.Web.Hosting.HostingEnvironment.MapPath(p_FilePath));

            if (e.CommandName == "remove")
            {

                string strConn = ConfigurationManager.ConnectionStrings["MENU"].ConnectionString;
                using (SqlConnection conn = new SqlConnection(strConn))
                {

                    string strCmd = "DELETE FROM TB_Download where url='" + e.CommandArgument.ToString() + "'";
                    string strCmd2 = "DELETE FROM TB_Downloaduser where url='" + e.CommandArgument.ToString() + "'";
                    using (SqlCommand cmd = new SqlCommand(strCmd2, conn))
                    {
                        conn.Open();
                        cmd.ExecuteNonQuery();
                        conn.Close();
                    }
                    using (SqlCommand cmd = new SqlCommand(strCmd, conn))
                    {

                        string message = "";

                        try
                        {
                            conn.Open();
                            cmd.ExecuteNonQuery();
                            message = "移除成功";

                        }
                        catch (Exception ex)
                        {
                            message = ex.Message;
                        }
                        finally
                        {
                            conn.Close();
                            string strJS = "alert('" + message + "');";
                            Page.ClientScript.RegisterStartupScript(this.GetType(), "", strJS, true);
                        }

                        DAL.JuicDao dao = new DAL.JuicDao("MENU");
                        var tb = dao.checkcontrol(User.Identity.Name.ToString(), 20);
                        //無上傳檔案權限，隱藏功能
                        if (tb.Rows.Count == 0)
                        {
                            GridView4.DataSourceID = "SqlDataSource4";
                            Label5.Text = "您的權限僅能刪除自己上傳的檔案";

                        }
                        else
                        {
                            GridView4.DataSourceID = "SqlDataSource5";
                            Label5.Text = "您的權限可以刪除所有已上傳檔案";
                        }



                    }
                }

            }
        }

        protected void TreeView1_SelectedNodeChanged(object sender, EventArgs e)
        {
            Panel2.Visible = false;
            Panel3.Visible = false;
            Panel4.Visible = false;
            Panel5.Visible = false;
            Panel2.Visible = true;
        }
        protected void TreeView2_SelectedNodeChanged(object sender, EventArgs e)
        {
            Panel2.Visible = false;
            Panel3.Visible = false;
            Panel4.Visible = false;
            Panel5.Visible = false;
            Panel3.Visible = true;
        }

        protected void TreeView3_SelectedNodeChanged(object sender, EventArgs e)
        {
            Panel2.Visible = false;
            Panel3.Visible = false;
            Panel4.Visible = false;
            Panel5.Visible = false;
            Panel4.Visible = true;
        }

        protected void Button4_Click(object sender, EventArgs e)
        {
            Panel2.Visible = false;
            Panel3.Visible = false;
            Panel4.Visible = false;
            Panel5.Visible = false;
            Panel5.Visible = true; ;

            DAL.JuicDao dao = new DAL.JuicDao("MENU");
            var tb = dao.checkcontrol(User.Identity.Name.ToString(), 20);
            //無上傳檔案權限，隱藏功能
            if (tb.Rows.Count == 0)
            {

                Label5.Text = "您的權限僅能刪除自己上傳的檔案";

            }
            else
            {
                GridView4.DataSourceID = "SqlDataSource5";
                Label5.Text = "您的權限可以刪除所有已上傳檔案";
            }


        }
    }

}
