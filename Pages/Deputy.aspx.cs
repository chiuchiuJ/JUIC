using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.MobileControls;
using System.Web.UI.WebControls;

namespace JuicERP.Pages
{
    public partial class Deputy : System.Web.UI.Page
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
                // 属性設置方法
                //this.GridView1.Attributes.Add("SortExpression", "DEPA_NE1");
                //this.GridView1.Attributes.Add("SortDirection", "ASC");
                Session["sorted"] = "False";
                GVgetData();
                Label1.Text = User.Identity.Name.ToString();
            }
            //-------------------------------------------------------------------------------------

            //檢查是否有新增及修改代理人權限
            DAL.JuicDao dao = new DAL.JuicDao("MENU");
            var tb2 = dao.checkcontrol(User.Identity.Name.ToString(), 29);
            //無新增及修改代理人權限 取消按鈕
            if (tb2.Rows.Count == 0)
            {
                Button2.Enabled = false;
                Button2.Text = "您不能新增代理人員名單";
                manage.Text = "false";
            }
        }

        private DataSet getData()

        {

            String connectString = System.Web.Configuration.WebConfigurationManager.ConnectionStrings["MENU"].ConnectionString;
            SqlConnection cn = new SqlConnection(connectString);
            this.Gridview_sort();
            string orderstring = "";
            using (SqlConnection conn = new SqlConnection(connectString))
            {
                string strCmdNO = "SELECT orderstring FROM TB_Orderstring where tablename='TB_deputy'";
                SqlDataAdapter da1 = new SqlDataAdapter(strCmdNO, conn);
                DataSet ds1 = new DataSet();
                da1.Fill(ds1);

                if (ds1.Tables[0].Rows.Count != 0)
                {
                    orderstring = (ds1.Tables[0].Rows[0][0].ToString());
                }
            }

            string sortExpression = (string)Session["NowSE"];
            SortDirection sortDirection;
            if (string.IsNullOrEmpty(sortExpression))
            {
                sortDirection = SortDirection.Ascending;
            }
            else
            {
                sortDirection = Session["NowSD"] != null ? (SortDirection)Session["NowSD"] : SortDirection.Ascending;
            }

            String selectString = @"SELECT A.data2 ,
	                                    coalesce((select DISTINCT DEPA_NE1 FROM JUIC.DBO.BAS30 WHERE DEPA_NO=A.DATA2),
                                                (select DISTINCT DEPA_NE1 FROM JUTW.DBO.BAS30 WHERE DEPA_NO=A.DATA2),'') DEPA_NE1,
	                                    rtrim(A.[emp_no]) emp_no ,rtrim(A.[empname]) empname ,
	                                    rtrim([emp_no1]) emp_no1 ,rtrim([empname1]) empname1,rtrim([emp_no2]) emp_no2,
	                                    rtrim([empname2]) empname2,A.data1 
	                                FROM [TB_deputy] A LEFT JOIN [TB_Deputyorder] B on A.emp_no=B.emp_no
                                    WHERE (A.[empname] LIKE '%' + @empname + '%') ";
            if (sortExpression == "data2" || string.IsNullOrEmpty(sortExpression))
            {
                selectString += @" ORDER BY charindex(right(rtrim(depa_no),4), '"
                                      + orderstring +
                                      "') ";
                //因此段排序較特殊特別處理
                if (sortDirection == SortDirection.Descending)
                {
                    selectString += " desc ";
                }

                selectString += " ,sequence ";

            }
            else if (sortExpression == "empname")
            {
                selectString += @" ORDER BY empname ";
            }
            else
            {
                selectString += @" ORDER BY emp_no ";
            }
            if (sortDirection == SortDirection.Descending)
            {
                selectString += " desc ";
            }


            SqlCommand cmd = new SqlCommand(selectString, cn);
            if (TextBox1.Text.Trim() == "")
            {
                cmd.Parameters.AddWithValue("@empname", "_");
            }

            else
            {
                cmd.Parameters.AddWithValue("@empname", TextBox1.Text.Trim());
            }

            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataSet ds = new DataSet();
            cn.Open();
            da.Fill(ds);
            cn.Close();
            return ds;

        }

        private void GVgetData()
        {
            DataTable dtBind = getData().Tables[0];
            GridView1.DataSource = dtBind;
            GridView1.DataBind();
        }

        //點擊編輯按鈕
        protected void GridView1_RowEditing(object sender, GridViewEditEventArgs e)
        {
            Button2.Visible = false;
            GridView1.EditIndex = e.NewEditIndex;
            GVgetData();

            DataSet ds = getData();
            DropDownList list1;
            var i = GridView1.EditIndex;
            DataRowView mydrv = ds.Tables[0].DefaultView[i];

            for (int j = 1; j <= 2; j++)
            {
                list1 = (DropDownList)GridView1.Rows[i].FindControl("DropDownList" + j.ToString().Trim());
                list1.DataSource = ddlbind();
                list1.DataBind();
                if (mydrv["emp_no" + j.ToString()].ToString().Trim() == "")
                {
                    list1.Items.Insert(0, "請選擇");
                    list1.SelectedValue = "0";
                }
                else
                {
                    if (j == 2) list1.Items.Insert(0, "請選擇");
                    list1.SelectedValue = Convert.ToString(mydrv["emp_no" + j.ToString()]).Trim();
                }

                ListItem removeItem = list1.Items.FindByValue(GridView1.Rows[i].Cells[0].Text.ToString().Trim());
                list1.Items.Remove(removeItem);
            }
            //}
        }

        //點擊取消按鈕
        protected void GridView1_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            GridView1.EditIndex = -1;
            GVgetData();
            Button2.Visible = true;
        }

        //點擊更新按鈕

        protected void GridView1_RowUpdating(object sender, GridViewUpdateEventArgs e)

        {
            String connectString = System.Web.Configuration.WebConfigurationManager.ConnectionStrings["MENU"].ConnectionString;

            string empno1 = ((DropDownList)GridView1.Rows[e.RowIndex].FindControl("DropDownList1")).SelectedValue.Trim();
            string empname1 = ((DropDownList)GridView1.Rows[e.RowIndex].FindControl("DropDownList1")).SelectedItem.Text.Trim();
            string empno2 = ((DropDownList)GridView1.Rows[e.RowIndex].FindControl("DropDownList2")).SelectedValue.Trim();
            string empname2 = ((DropDownList)GridView1.Rows[e.RowIndex].FindControl("DropDownList2")).SelectedItem.Text.Trim();
            string data1 = ((System.Web.UI.WebControls.TextBox)GridView1.Rows[e.RowIndex].FindControl("TextBox3")).Text;
            string data2 = "";

            using (SqlConnection conn = new SqlConnection(connectString))
            {
                string strCmdNO = @"SELECT depa_no FROM juic.dbo.pay11 WHERE emp_no=@emp_no
                                    union
                                    SELECT depa_no FROM jutw.dbo.pay11 WHERE emp_no=@emp_no";
                SqlCommand cmd1 = new SqlCommand(strCmdNO, conn);
                cmd1.Parameters.Add("@emp_no", SqlDbType.NChar);
                cmd1.Parameters["@emp_no"].Value = GridView1.Rows[e.RowIndex].Cells[0].Text.Trim();
                SqlDataAdapter da1 = new SqlDataAdapter(cmd1);
                DataSet ds1 = new DataSet();
                da1.Fill(ds1);
                if (ds1.Tables[0].Rows.Count != 0)
                {
                    data2 = (ds1.Tables[0].Rows[0][0].ToString());
                }
            }

            //針對未選擇下拉選項判斷
            empno1 = empno1 == "請選擇" ? "" : empno1;
            empname1 = empname1 == "請選擇" ? "" : empname1;
            empno2 = empno2 == "請選擇" ? "" : empno2;
            empname2 = empname2 == "請選擇" ? "" : empname2;

            String sqlstr = @"UPDATE TB_deputy SET
                                 emp_no1=@emp_no1,
                                 empname1=@empname1,
                                 emp_no2=@emp_no2, 
                                 empname2=@empname2,
                                 data1=@data1,
                                 data2=@data2,
                                 editdatetime=GETDATE(),
                                 edituser=@edituser
                              WHERE emp_no=@emp_no";
            SqlConnection cn = new SqlConnection(connectString);
            SqlCommand cmd = new SqlCommand(sqlstr, cn);
            cmd.Parameters.Add("@emp_no", SqlDbType.NChar);
            cmd.Parameters.Add("@emp_no1", SqlDbType.NChar);
            cmd.Parameters.Add("@empname1", SqlDbType.NChar);
            cmd.Parameters.Add("@emp_no2", SqlDbType.NChar);
            cmd.Parameters.Add("@empname2", SqlDbType.NChar);
            cmd.Parameters.Add("@data1", SqlDbType.NChar);
            cmd.Parameters.Add("@data2", SqlDbType.NChar);
            cmd.Parameters.Add("@edituser", SqlDbType.NChar);
            cmd.Parameters["@emp_no"].Value = GridView1.Rows[e.RowIndex].Cells[0].Text.Trim();
            cmd.Parameters["@emp_no1"].Value = empno1;
            cmd.Parameters["@empname1"].Value = empname1;
            cmd.Parameters["@emp_no2"].Value = empno2;
            cmd.Parameters["@empname2"].Value = empname2;
            cmd.Parameters["@data1"].Value = data1;
            cmd.Parameters["@data2"].Value = data2.Trim();
            cmd.Parameters["@edituser"].Value = Label1.Text;
            cn.Open();
            cmd.ExecuteNonQuery();
            cn.Close();
            GridView1.EditIndex = -1;
            GVgetData();
            Button2.Visible = true;
            fv_Insert2.Visible = false;
        }

        //點擊刪除按鈕
        protected void GridView1_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            String connectString = System.Web.Configuration.WebConfigurationManager.ConnectionStrings["MENU"].ConnectionString;
            String sqlstr = "DELETE FROM TB_deputy WHERE emp_no=@emp_no";
            SqlConnection cn = new SqlConnection(connectString);
            SqlCommand cmd = new SqlCommand(sqlstr, cn);
            cmd.Parameters.Add("@emp_no", SqlDbType.NChar);
            cmd.Parameters["@emp_no"].Value = GridView1.Rows[e.RowIndex].Cells[0].Text.Trim();
            cn.Open();
            cmd.ExecuteNonQuery();

            sqlstr = "DELETE FROM TB_DeputyOrder WHERE emp_no=@emp_no";
            cmd = new SqlCommand(sqlstr, cn);
            cmd.Parameters.AddWithValue("@emp_no", GridView1.Rows[e.RowIndex].Cells[0].Text.Trim());
            cmd.ExecuteNonQuery();

            cn.Close();
            GVgetData();
            Button2.Visible = true;
            fv_Insert2.Visible = false;
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            GVgetData();
        }

        public SqlDataReader ddlbind()
        {
            String connectString = System.Web.Configuration.WebConfigurationManager.ConnectionStrings["MENU"].ConnectionString;
            SqlConnection cn = new SqlConnection(connectString);
            string sqlstr = @"select rtrim(emp_no) emp_no,rtrim(emp_cne) emp_cne from [juic].dbo.pay11 where c01='1' 
                              union
                              select rtrim(emp_no) emp_no,rtrim(emp_cne) emp_cne from[jutw].dbo.pay11 where c01= '1'
                              order by emp_no";
            SqlCommand sqlcom = new SqlCommand(sqlstr, cn);
            cn.Open();
            return sqlcom.ExecuteReader();
        }
        //新增資料按鈕
        protected void Button2_Click(object sender, EventArgs e)
        {
            GridView1.Visible = false;
            fv_Insert2.Visible = true;//顯示GV底下的FV
            Button2.Visible = false;
            System.Web.UI.WebControls.Label Label2 = ((System.Web.UI.WebControls.Label)fv_Insert2.FindControl("Label2"));
            Label2.Text = "";
        }
        protected void Button3_Click(object sender, EventArgs e)
        {
            if (Verifydata())
            {
                String connectString = System.Web.Configuration.WebConfigurationManager.ConnectionStrings["MENU"].ConnectionString;
                String sqlstr;
                SqlConnection cn = new SqlConnection(connectString);

                string data2 = "";

                using (SqlConnection conn = new SqlConnection(connectString))
                {
                    string strCmdNO = @"SELECT depa_no FROM juic.dbo.pay11 WHERE emp_no=@emp_no
                                    union
                                    SELECT depa_no FROM jutw.dbo.pay11 WHERE emp_no=@emp_no";
                    SqlCommand cmd1 = new SqlCommand(strCmdNO, conn);
                    cmd1.Parameters.Add("@emp_no", SqlDbType.NChar);
                    cmd1.Parameters["@emp_no"].Value = ((DropDownList)fv_Insert2.FindControl("DropDownList7")).SelectedValue.Trim();
                    SqlDataAdapter da1 = new SqlDataAdapter(cmd1);
                    DataSet ds1 = new DataSet();
                    da1.Fill(ds1);
                    if (ds1.Tables[0].Rows.Count != 0)
                    {
                        data2 = (ds1.Tables[0].Rows[0][0].ToString());
                    }
                }

                //寫入TABLE TB_deputy
                sqlstr = @"INSERT INTO [TB_deputy] (emp_no,empname,emp_no1,empname1,emp_no2,empname2,data1,data2,creuser,credatetime,editdatetime,edituser)  
                                values 
                              (@emp_no,@empname,@emp_no1,@empname1,@emp_no2,@empname2,@data1,@data2,@creuser,GETDATE(),GETDATE(),@edituser)		";
                SqlCommand cmd = new SqlCommand(sqlstr, cn);
                cmd.Parameters.Add("@emp_no", SqlDbType.NChar);
                cmd.Parameters.Add("@empname", SqlDbType.NChar);
                cmd.Parameters.Add("@emp_no1", SqlDbType.NChar);
                cmd.Parameters.Add("@empname1", SqlDbType.NChar);
                cmd.Parameters.Add("@emp_no2", SqlDbType.NChar);
                cmd.Parameters.Add("@empname2", SqlDbType.NChar);
                cmd.Parameters.Add("@data1", SqlDbType.NChar);
                cmd.Parameters.Add("@data2", SqlDbType.NChar);
                cmd.Parameters.Add("@creuser", SqlDbType.NChar);
                cmd.Parameters.Add("@edituser", SqlDbType.NChar);
                cmd.Parameters["@emp_no"].Value = ((DropDownList)fv_Insert2.FindControl("DropDownList7")).SelectedValue.Trim();
                cmd.Parameters["@empname"].Value = ((DropDownList)fv_Insert2.FindControl("DropDownList7")).SelectedItem.Text.Trim();
                cmd.Parameters["@emp_no1"].Value = ((DropDownList)fv_Insert2.FindControl("DropDownList8")).SelectedValue.Trim();
                cmd.Parameters["@empname1"].Value = ((DropDownList)fv_Insert2.FindControl("DropDownList8")).SelectedItem.Text.Trim();
                cmd.Parameters["@emp_no2"].Value = ((DropDownList)fv_Insert2.FindControl("DropDownList9")).SelectedValue.Trim();
                cmd.Parameters["@empname2"].Value = ((DropDownList)fv_Insert2.FindControl("DropDownList9")).SelectedItem.Text.Trim();
                cmd.Parameters["@data1"].Value = ((System.Web.UI.WebControls.TextBox)fv_Insert2.FindControl("TextBox2")).Text;
                cmd.Parameters["@data2"].Value = data2.Trim();
                cmd.Parameters["@creuser"].Value = Label1.Text.Trim();
                cmd.Parameters["@edituser"].Value = Label1.Text.Trim();
                cn.Open();
                cmd.ExecuteNonQuery();
                
                //TB_Deputyorder取得同單位最後一個排序
                int sequence = 0;
                using (SqlConnection conn = new SqlConnection(connectString))
                {
                    string strCmdNO = @"SELECT max(sequence)
	                                    FROM  TB_Deputyorder 
	                                    WHERE right(rtrim(depa_no),4)=@depa_no";
                    SqlCommand cmd1 = new SqlCommand(strCmdNO, conn);
                    cmd1.Parameters.AddWithValue("@depa_no", data2.Trim().Substring(1,4));
                    SqlDataAdapter da1 = new SqlDataAdapter(cmd1);
                    DataSet ds1 = new DataSet();
                    da1.Fill(ds1);
                    if (ds1.Tables[0].Rows.Count != 0)
                    {
                        sequence = Convert.ToInt16(ds1.Tables[0].Rows[0][0]);
                        sequence= sequence + 1;
                    }
                }

                //寫入TABLE TB_DeputyOrder
                sqlstr = @"INSERT INTO TB_DeputyOrder 
                                (depa_no,emp_no,empname,sequence,credatetime,creuser) 
                              values 
                                (@depa_no,@emp_no,@empname,@sequence,getdate(),@creuser)";
                cmd = new SqlCommand(sqlstr, cn);
                cmd.Parameters.AddWithValue("emp_no", ((DropDownList)fv_Insert2.FindControl("DropDownList7")).SelectedValue.Trim());
                cmd.Parameters.AddWithValue("depa_no", data2.Trim());
                cmd.Parameters.AddWithValue("empname", ((DropDownList)fv_Insert2.FindControl("DropDownList7")).SelectedItem.Text.Trim());
                cmd.Parameters.AddWithValue("sequence", sequence);
                cmd.Parameters.AddWithValue("creuser", Label1.Text.Trim());
                cmd.ExecuteNonQuery();
                cn.Close(); 

                GVgetData();

                Button2.Visible = true;
                fv_Insert2.Visible = false;
                GridView1.Visible = true;
                string strJS = "alert('新增成功');location.href = ('Deputy.aspx');";
                Page.ClientScript.RegisterStartupScript(this.GetType(), "", strJS, true);
            }
            else
            {
                Button Button3 = ((Button)fv_Insert2.FindControl("Button3"));
                Button3.Attributes.Add("onClientClick=", "return false");
                fv_Insert2.Visible = true;
                Button2.Visible = false;
            }
        }

        //取消按鈕
        protected void Button4_Click(object sender, EventArgs e)
        {
            GridView1.Visible = true;
            Button2.Visible = true;
            fv_Insert2.Visible = false;
            System.Web.UI.WebControls.Label Label2 = ((System.Web.UI.WebControls.Label)fv_Insert2.FindControl("Label2"));
            Label2.Text = "";
            DropDownList DropDownList7 = ((DropDownList)fv_Insert2.FindControl("DropDownList7"));
            DropDownList DropDownList8 = ((DropDownList)fv_Insert2.FindControl("DropDownList8"));
            DropDownList DropDownList9 = ((DropDownList)fv_Insert2.FindControl("DropDownList9"));
            DropDownList7.SelectedValue = "";
            DropDownList8.SelectedValue = "";
            DropDownList9.SelectedValue = "";
        }
        protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            //檢查是否有新增及修改代理人權限
            DAL.JuicDao dao = new DAL.JuicDao("MENU");
            var tb2 = dao.checkcontrol(User.Identity.Name.ToString(), 29);
            //無新增及修改代理人權限 取消按鈕
            if (tb2.Rows.Count == 0)
            {
                Button2.Enabled = false;
                Button2.Text = "您不能新增代理人員名單";
                manage.Text = "false";
            }
            if (e.Row.RowType == DataControlRowType.DataRow)
            {  //-- 當 GridView呈現「每一列」資料列（記錄）的時候，才會執行這裡！
               //-- 所以這裡就像迴圈一樣，會反覆執行喔！！

                e.Row.Cells[0].Attributes.Add("class", "text"); //指定欄位為文字樣式
                e.Row.Cells[3].Attributes.Add("class", "text");
                e.Row.Cells[5].Attributes.Add("class", "text");
                if (manage.Text == "true")
                {
                    Button btn = (Button)e.Row.FindControl("edit_btn");
                    Button btn2 = (Button)e.Row.FindControl("delete_btn");
                    if (btn != null) { btn.Visible = true; }
                    if (btn2 != null) { btn2.Visible = true; }

                }
            }
        }
        //匯出EXCEL
        protected void Button5_Click(object sender, EventArgs e)
        {
            string filename = "職務代理人";
            string strfileext = ".xls";
            StringWriter tw = new StringWriter();
            HtmlTextWriter hw = new HtmlTextWriter(tw);
            HttpContext.Current.Response.ContentType = "application/vnd.ms-excel";
            HttpContext.Current.Response.AppendHeader("Content-Disposition", "attachment; filename=" + filename + strfileext);
            HttpContext.Current.Response.Write("<meta http-equiv=Content-Type content=text/html;charset=utf-8>");
            string style = "<style> .text { mso-number-format:\\@; } </style> ";
            //先把分頁關掉
            GridView1.AllowPaging = false;
            GVgetData();
            GridView1.Columns[8].Visible = false;
            //Get the HTML for the control.
            GridView1.RenderControl(hw);
            HttpContext.Current.Response.Write(style);
            HttpContext.Current.Response.Write(tw.ToString());
            HttpContext.Current.Response.End();

            GridView1.AllowPaging = true;
            GVgetData();
        }
        //必須覆寫 Page.VerifyRenderingInServerForm　
        public override void VerifyRenderingInServerForm(Control control)
        {
        }
        public bool Verifydata()
        {
            String connectString = System.Web.Configuration.WebConfigurationManager.ConnectionStrings["MENU"].ConnectionString;
            string empname = ((DropDownList)fv_Insert2.FindControl("DropDownList7")).SelectedItem.Text;
            string empname1 = ((DropDownList)fv_Insert2.FindControl("DropDownList8")).SelectedItem.Text;
            string empname2 = ((DropDownList)fv_Insert2.FindControl("DropDownList9")).SelectedItem.Text;
            System.Web.UI.WebControls.Label Label2 = ((System.Web.UI.WebControls.Label)fv_Insert2.FindControl("Label2"));
            //輸入檢查
            if (empname.Trim() == empname1.Trim() || empname == empname2.Trim())
            {
                string strJS = "alert('代理人不可為自己');";
                Page.ClientScript.RegisterStartupScript(this.GetType(), "", strJS, true);
                Label2.Text = "代理人不可為自己";
                return false;
            }
            else if (empname1.Trim() == empname2.Trim())
            {
                string strJS = "alert('第一代理人與第二代理人不可重複');";
                Page.ClientScript.RegisterStartupScript(this.GetType(), "", strJS, true);
                Label2.Text = "第一代理人與第二代理人不可重複";
                return false;
            }
            if (empname.Trim() == "請選擇")
            {
                string strJS = "alert('請選擇員工姓名');";
                Page.ClientScript.RegisterStartupScript(this.GetType(), "", strJS, true);
                Label2.Text = "請選擇員工姓名";
                return false;
            }
            else if (empname1.Trim() == "請選擇")
            {
                string strJS = "alert('請選擇第一代理人');";
                Page.ClientScript.RegisterStartupScript(this.GetType(), "", strJS, true);
                Label2.Text = "請選擇第一代理人";
                return false;
            }

            //檢查是否可以新增
            String sqlstr = @"SELECT 'Y' FROM [TB_deputy]		
                              WHERE 
                              emp_no=@emp_no ";
            SqlConnection cn = new SqlConnection(connectString);
            SqlCommand cmd = new SqlCommand(sqlstr, cn);
            cmd.Parameters.AddWithValue("@emp_no", ((DropDownList)fv_Insert2.FindControl("DropDownList7")).SelectedValue);
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataSet ds = new DataSet();
            da.Fill(ds);
            if (ds.Tables[0].Rows.Count != 0)
            {
                string strJS = "alert('此員工" + empname + "已有代理人資料請查明');";
                Page.ClientScript.RegisterStartupScript(this.GetType(), "", strJS, true);
                Label2.Text = "此員工" + empname + "已有代理人資料請查明";
                return false;
            }
            Label2.Text = "";
            return true;
        }

        private void Gridview_sort()
        {
            if (string.IsNullOrEmpty((string)Session["NowSE"]))
            {
                //預設排序方式為部門單位
                Session["NowSE"] = "data2";
            }
            string NowSE = Request.QueryString["sort"];

            //string NowSE = ViewState["NowSE"] != null ? ViewState["NowSE"].ToString() : string.Empty;
            //SortDirection NowSD = ViewState["NowSD"] != null ? (SortDirection)ViewState["NowSD"] : SortDirection.Descending;
            SortDirection NowSD = Session["NowSD"] != null ? (SortDirection)Session["NowSD"] : SortDirection.Ascending;
            //if (string.IsNullOrEmpty(NowSE))
            //{
            //    NowSE = string.Empty;
            //    NowSD = SortDirection.Ascending;

            //}
            //else
            //{
            //    if (NowSD == SortDirection.Ascending)
            //    {
            //        NowSD = SortDirection.Descending;
            //    }
            //    else
            //    {
            //        NowSD = SortDirection.Ascending;
            //    }
            //}

            //以Session["sorted"] 判斷是否為重新讀取 
            if (!string.IsNullOrEmpty(NowSE) && (string)Session["sorted"] == "False")
            {
                //若非換欄點選排序 則只更動順序，若有換欄則都為順序排列
                if (NowSE == (string)Session["NowSE"])
                {
                    if (NowSD == SortDirection.Ascending)
                    {
                        NowSD = SortDirection.Descending;
                        Session["sorted"] = "True";
                    }
                    else if (NowSD == SortDirection.Descending)
                    {
                        NowSD = SortDirection.Ascending;
                        Session["sorted"] = "True";
                    }
                }
                else
                {
                    NowSD = SortDirection.Ascending;
                    Session["sorted"] = "True";
                }
            }

            Session["NowSE"] = NowSE;
            Session["NowSD"] = NowSD;
        }
        //protected void GridView1_Sorting(object sender, GridViewSortEventArgs e)
        //{
        //    string NowSE = ViewState["NowSE"] != null ? ViewState["NowSE"].ToString() : string.Empty;
        //    SortDirection NowSD = ViewState["NowSD"] != null ? (SortDirection)ViewState["NowSD"] : SortDirection.Ascending;
        //    if (string.IsNullOrEmpty(NowSE))
        //    {
        //            NowSE = e.SortExpression;
        //            NowSD = SortDirection.Ascending;
        //    }
        //    if (NowSE != e.SortExpression)
        //    {
        //        NowSE = e.SortExpression;
        //        NowSD = SortDirection.Ascending;
        //    }
        //    else
        //    {
        //        if (NowSD==SortDirection.Ascending)
        //        {
        //            NowSD = SortDirection.Descending;
        //        }
        //        else
        //        {
        //            NowSD = SortDirection.Ascending;
        //        }
        //    }
        //    ViewState["NowSE"] = NowSE;
        //    ViewState["NowSD"] = NowSD;
        //    this.GVgetData();
        //}

        protected void GridView1_RowCreated(object sender, GridViewRowEventArgs e)
        {
            switch (e.Row.RowType)
            {
                case DataControlRowType.Header:

                    TableCellCollection oldCell = e.Row.Cells;
                    oldCell.Clear();//將原有的表頭格式移除

                    //產生多重表列的第一列
                    GridViewRow headRow = new GridViewRow(0, 0, DataControlRowType.Header, DataControlRowState.Insert);

                    //第一欄
                    TableCell head2Cell = new TableCell();
                    head2Cell.Text = "員工編號";
                    head2Cell.Attributes.Add("bgcolor", "#1C5E55");
                    head2Cell.HorizontalAlign = HorizontalAlign.Center;
                    head2Cell.RowSpan = 2;//所跨的欄數

                    HyperLink link = new HyperLink();
                    link.Text = "員工編號";
                    link.NavigateUrl = "Deputy.aspx?sort=emp_no";
                    head2Cell.Controls.Add(link);

                    headRow.Cells.Add(head2Cell);//新增自製的儲存格

                    //第二欄
                    head2Cell = new TableCell();
                    head2Cell.Text = "部門單位";
                    head2Cell.Attributes.Add("bgcolor", "#1C5E55");
                    head2Cell.RowSpan = 2;//所跨的欄數
                    //head2Cell.ColumnSpan = 8;//所跨的欄數
                    head2Cell.HorizontalAlign = HorizontalAlign.Center;

                    HyperLink link1 = new HyperLink();
                    link1.Text = "部門單位";
                    link1.NavigateUrl = "Deputy.aspx?sort=data2";
                    head2Cell.Controls.Add(link1);

                    headRow.Cells.Add(head2Cell);//新增自製的儲存格

                    //第三欄
                    head2Cell = new TableCell();
                    head2Cell.Text = "員工姓名";
                    head2Cell.RowSpan = 2;//所跨的欄數
                    head2Cell.Attributes.Add("bgcolor", "#1C5E55");
                    head2Cell.HorizontalAlign = HorizontalAlign.Center;

                    HyperLink link2 = new HyperLink();
                    link2.Text = "員工姓名";
                    link2.NavigateUrl = "Deputy.aspx?sort=empname";
                    head2Cell.Controls.Add(link2);

                    headRow.Cells.Add(head2Cell);//新增自製的儲存格

                    //第四欄
                    head2Cell = new TableCell();
                    head2Cell.Text = "第一代理人";
                    head2Cell.Attributes.Add("bgcolor", "#1C5E55");
                    head2Cell.ColumnSpan = 2;//所跨的欄數
                    head2Cell.HorizontalAlign = HorizontalAlign.Center;
                    headRow.Cells.Add(head2Cell);//新增自製的儲存格

                    //第五欄
                    head2Cell = new TableCell();
                    head2Cell.Text = "第二代理人";
                    head2Cell.Attributes.Add("bgcolor", "#1C5E55");
                    head2Cell.ColumnSpan = 2;//所跨的欄數
                    head2Cell.HorizontalAlign = HorizontalAlign.Center;
                    headRow.Cells.Add(head2Cell);//新增自製的儲存格

                    //第六欄
                    head2Cell = new TableCell();
                    head2Cell.Text = "備註";
                    head2Cell.Attributes.Add("bgcolor", "#1C5E55");
                    head2Cell.RowSpan = 2;//所跨的欄數
                    head2Cell.HorizontalAlign = HorizontalAlign.Center;
                    headRow.Cells.Add(head2Cell);//新增自製的儲存格

                    //第七欄
                    head2Cell = new TableCell();
                    head2Cell.Text = "管理";
                    head2Cell.Attributes.Add("bgcolor", "#1C5E55");
                    head2Cell.RowSpan = 2;//所跨的欄數
                    head2Cell.HorizontalAlign = HorizontalAlign.Center;
                    headRow.Cells.Add(head2Cell);//新增自製的儲存格

                    //將自製的資料列新增上去
                    GridView1.Controls[0].Controls.Add(headRow);

                    //產生多重表列的第二列
                    headRow = new GridViewRow(0, 0, DataControlRowType.Header, DataControlRowState.Insert);

                    //用法都與第一列相同
                    head2Cell = new TableCell();
                    head2Cell.Text = "員工編號";
                    head2Cell.Attributes.Add("bgcolor", "#1C5E55");
                    headRow.Cells.Add(head2Cell);

                    head2Cell = new TableCell();
                    head2Cell.Text = "員工姓名";
                    head2Cell.Attributes.Add("bgcolor", "#1C5E55");
                    headRow.Cells.Add(head2Cell);

                    head2Cell = new TableCell();
                    head2Cell.Text = "員工編號";
                    head2Cell.Attributes.Add("bgcolor", "#1C5E55");
                    headRow.Cells.Add(head2Cell);

                    head2Cell = new TableCell();
                    head2Cell.Text = "員工姓名";
                    head2Cell.Attributes.Add("bgcolor", "#1C5E55");
                    headRow.Cells.Add(head2Cell);

                    GridView1.Controls[0].Controls.Add(headRow);

                    break;
            }
        }
    }
}