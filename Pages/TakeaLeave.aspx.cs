﻿using System;
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
    public partial class TakeaLeave : System.Web.UI.Page
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
            string strConn = ConfigurationManager.ConnectionStrings["MENU"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(strConn))
            {
                String QQ = "select username from bas03 where userid='" + User.Identity.Name.ToString() + "'";

                SqlDataAdapter da = new SqlDataAdapter(QQ, conn);
                DataSet ds = new DataSet();
                da.Fill(ds);
                if (Label2.Text == "")
                {
                    Label2.Text = ds.Tables[0].Rows[0][0].ToString();
                    //因Label1.Text的值是SqlDataSource1的參考值，會直接影響搜尋結果
                }
            }

            //檢查是否有查詢所有人之權限
            DAL.JuicDao dao = new DAL.JuicDao("MENU");
            var tb = dao.checkcontrol(User.Identity.Name.ToString(), 3);
            //有查詢所有人權限，取消後續判斷式
            if (tb.Rows.Count > 0)
            {
                return;
            }

            //檢查是否有查詢下層之權限
            var tb2 = dao.checkcontrol(User.Identity.Name.ToString(), 15);

            //有查詢下層權限，更改按鈕名稱
            if (tb2.Rows.Count > 0)
            {
                Button2.Text = "查詢下層員工(中文姓名)";
                return;
            }
            //無查詢下層權限，隱藏其他按鈕
            else
            {
                Button1.Visible = false;
                Button2.Visible = false;
                TextBox1.Visible = false;
            }

        }

        protected void Button2_Click(object sender, EventArgs e)
        {
            //Label2.Text = TextBox1.Text;

            //檢查是否有查詢所有人之權限
            DAL.JuicDao dao = new DAL.JuicDao("MENU");
            var tb = dao.checkcontrol(User.Identity.Name.ToString(), 3);
            //有查詢所有人權限，取消後續判斷式
            if (tb.Rows.Count > 0)
            {
                Label2.Text = TextBox1.Text;//因Label1.Text的值是SqlDataSource1的參考值，會直接影響搜尋結果
                return;
            }

            ////檢查是否有查詢下層之權限
            //var tb2 = dao.checkcontrol(User.Identity.Name.ToString(), 15);

            ////有查詢下層權限，以部門別和公司階級做判斷查詢
            //if (tb.Rows.Count > 0)
            //{

            string strConn1 = ConfigurationManager.ConnectionStrings["MENU"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(strConn1))
            {
                String QQ = "SELECT a.department,a.level,b.department,b.level from TB_Level a,TB_Level b where a.userid='" + User.Identity.Name.ToString() + "' and b.username='" + TextBox1.Text + "'";

                SqlDataAdapter da = new SqlDataAdapter(QQ, conn);
                DataSet ds = new DataSet();
                da.Fill(ds);
                //姓名輸入錯誤或公司無此人
                if (ds.Tables[0].Rows.Count == 0)
                {
                    string strJS = "alert('無法找到該姓名');";
                    Page.ClientScript.RegisterStartupScript(this.GetType(), "", strJS, true);
                    return;
                }
                //管理部人員可查詢其他部門請假狀況(不可查詢職等較高者)
                if (ds.Tables[0].Rows[0][0].ToString().Trim() == "管理部")
                {
                    int a, b;
                    a = int.Parse(ds.Tables[0].Rows[0][1].ToString().Trim());
                    b = int.Parse(ds.Tables[0].Rows[0][3].ToString().Trim());
                    if (a > b)
                    {
                        Label2.Text = TextBox1.Text;//因Label1.Text的值是SqlDataSource1的參考值，會直接影響搜尋結果
                    }
                    else
                    {
                        string strJS = "alert('權限不足無法查詢');";
                        Page.ClientScript.RegisterStartupScript(this.GetType(), "", strJS, true);
                    }

                }
                //僅同部門可查詢同部門請假狀況(依照職等區分)
                else if (ds.Tables[0].Rows[0][0].ToString().Trim() == ds.Tables[0].Rows[0][2].ToString().Trim())
                {
                    int a, b;
                    a = int.Parse(ds.Tables[0].Rows[0][1].ToString().Trim());
                    b = int.Parse(ds.Tables[0].Rows[0][3].ToString().Trim());
                    if (a > b)
                    {
                        Label2.Text = TextBox1.Text;//因Label1.Text的值是SqlDataSource1的參考值，會直接影響搜尋結果
                    }
                    else
                    {
                        string strJS = "alert('權限不足無法查詢');";
                        Page.ClientScript.RegisterStartupScript(this.GetType(), "", strJS, true);
                    }
                }
                else
                {
                    string strJS = "alert('你無法查詢其他部門人員資料');";
                    Page.ClientScript.RegisterStartupScript(this.GetType(), "", strJS, true);
                }
                ds.Clear();
            }

            //}
            ////無查詢下層權限，僅可查詢自己 隱藏按鈕
            //else
            //{
            //    Button1.Visible = false;
            //    Button2.Visible = false;
            //    TextBox1.Visible = false;
            //}


        }
    }
}