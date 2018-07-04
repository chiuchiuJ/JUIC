using JuicERP.DAL;
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
    public partial class Pay : System.Web.UI.Page
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
                DB4Init();
                DB2Init();
            }
            Labuserid.Text = User.Identity.Name.ToString();
        }

        protected void RadioButtonList1_SelectedIndexChanged(object sender, EventArgs e)
        {
            //20171026追加零用金預支
            if (RadioButtonList1.SelectedValue == "0")
            {
                Panel0.Visible = true;
                Panel1.Visible = false;
                Panel2.Visible = false;
                Panel3.Visible = false;
            }
            else if (RadioButtonList1.SelectedValue == "1")
            {
                Panel0.Visible = false;
                Panel1.Visible = true;
                Panel2.Visible = false;
                Panel3.Visible = false;
            }
            else if (RadioButtonList1.SelectedValue == "2")
            {
                Panel0.Visible = false;
                Panel1.Visible = false;
                Panel2.Visible = true;
                Panel3.Visible = false;
                if (Label11.Text == "")
                {
                    Label11.Text = "NTD";
                }
            }
            else if (RadioButtonList1.SelectedValue == "3")
            {
                Panel0.Visible = false;
                Panel1.Visible = false;
                Panel2.Visible = false;
                Panel3.Visible = true;
            }

        }
        //零用金送出並列印表單
        protected void Button1_Click(object sender, EventArgs e)
        {
            DropDownList[] dept = { pay3drop21, pay3drop22, pay3drop23, pay3drop24, pay3drop25, pay3drop26, pay3drop27, pay3drop28, pay3drop29, pay3drop30 };
            TextBox[] pay1 = { pay3text43, pay3text45, pay3text47, pay3text49, pay3text51, pay3text53, pay3text55, pay3text57, pay3text59, pay3text61 };
            TextBox[] pay2 = { pay3text44, pay3text46, pay3text48, pay3text50, pay3text52, pay3text54, pay3text56, pay3text58, pay3text60, pay3text62 }; //put all into this array
            //匯整金額
            decimal pay = 0;
            if (CheckBox1.Checked)
            {
                for (int i = 0; i < pay2.Length; i++)
                {
                    if (pay2[i].Text != "" && pay2[i].Text != "0")
                    {
                        pay += decimal.Parse(pay2[i].Text);
                    }
                }

            }
            else
            {
                pay = decimal.Parse(pay1text2.Text);
            }
            //判斷金額權限
            string signtype = "none";
            if (pay <= 5000)
            {
                signtype = "a1";
            }
            else if (pay > 5000 && pay <= 10000)
            {
                signtype = "a2";
            }
            else
            {
                string strJS = "alert('金額大於一萬，請重新輸入');location.href = ('Pay.aspx');";
                Page.ClientScript.RegisterStartupScript(this.GetType(), "", strJS, true);
                return;
            }
            string strConn = ConfigurationManager.ConnectionStrings["MENU"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(strConn))
            {
                //獲取最新id
                string strCmdNO = "SELECT top 1 id FROM TB_Payment ORDER BY id DESC";
                SqlDataAdapter da = new SqlDataAdapter(strCmdNO, conn);
                DataSet ds = new DataSet();
                da.Fill(ds);
                int newno = 0;
                if (ds.Tables[0].Rows.Count != 0)
                {
                    newno = int.Parse(ds.Tables[0].Rows[0][0].ToString());
                    newno++;
                }
                string strCmd = "Insert into TB_Payment(id,date,formtype,paytype,payment,paymentdetail,paydate,emp_no,emp_cne,department,signtype)values(@id,@date,@formtype,@paytype,@payment,@paymentdetail,@paydate,@emp_no,@emp_cne,@department,@signtype)";
                string strCmd2 = "Insert into TB_Paymentdetail(paymentid,dept_no,dept_cne,comment,payment)values(@paymentid,@dept_no,@dept_cne,@comment,@payment)";
                //多項目申請
                if (CheckBox1.Checked)
                {


                    using (SqlCommand cmd = new SqlCommand(strCmd, conn))
                    {
                        cmd.Parameters.AddWithValue("@id", newno);
                        cmd.Parameters.AddWithValue("@date", DateTime.Now);
                        cmd.Parameters.AddWithValue("@formtype", RadioButtonList1.SelectedItem.Text);
                        cmd.Parameters.AddWithValue("@paytype", RadioButtonList1.SelectedItem.Text);
                        cmd.Parameters.AddWithValue("@payment", pay);
                        cmd.Parameters.AddWithValue("@paymentdetail", "");
                        cmd.Parameters.AddWithValue("@paydate", DateTime.Now.AddDays(2));
                        cmd.Parameters.AddWithValue("@emp_no", User.Identity.Name.ToString());
                        cmd.Parameters.AddWithValue("@emp_cne", GridView1.Rows[0].Cells[1].Text);
                        cmd.Parameters.AddWithValue("@department", GridView1.Rows[0].Cells[2].Text);
                        cmd.Parameters.AddWithValue("@signtype", signtype);

                        string message = "";

                        try
                        {
                            conn.Open();
                            cmd.ExecuteNonQuery();
                            message = "申請成功";

                        }
                        catch (Exception ex)
                        {
                            message = ex.Message;

                        }
                        finally
                        {
                            conn.Close();
                            string strJS = "alert('" + message + "');location.href = ('PayPrint1.aspx?pid=" + newno + "');";
                            Page.ClientScript.RegisterStartupScript(this.GetType(), "", strJS, true);

                        }


                    }
                    for (int i = 0; i < pay2.Length; i++)
                    {
                        if (dept[i].SelectedValue == "0" && pay1[i].Text == "" && pay2[i].Text == "")
                        {
                            //不匯入資料庫
                        }
                        else
                        {
                            using (SqlCommand cmd = new SqlCommand(strCmd2, conn))
                            {
                                cmd.Parameters.AddWithValue("@paymentid", newno);
                                cmd.Parameters.AddWithValue("@dept_no", dept[i].SelectedValue);
                                cmd.Parameters.AddWithValue("@dept_cne", dept[i].SelectedItem.Text);
                                cmd.Parameters.AddWithValue("@comment", pay1[i].Text);
                                cmd.Parameters.AddWithValue("@payment", pay2[i].Text);

                                string message = "";

                                try
                                {
                                    conn.Open();
                                    cmd.ExecuteNonQuery();

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
                }

                else
                {



                    using (SqlCommand cmd = new SqlCommand(strCmd, conn))
                    {
                        cmd.Parameters.AddWithValue("@id", newno);
                        cmd.Parameters.AddWithValue("@date", DateTime.Now);
                        cmd.Parameters.AddWithValue("@formtype", RadioButtonList1.SelectedItem.Text);
                        cmd.Parameters.AddWithValue("@paytype", RadioButtonList1.SelectedItem.Text);
                        cmd.Parameters.AddWithValue("@payment", pay);
                        cmd.Parameters.AddWithValue("@paymentdetail", "");
                        cmd.Parameters.AddWithValue("@paydate", DateTime.Now.AddDays(2));
                        cmd.Parameters.AddWithValue("@emp_no", User.Identity.Name.ToString());
                        cmd.Parameters.AddWithValue("@emp_cne", GridView1.Rows[0].Cells[1].Text);
                        cmd.Parameters.AddWithValue("@department", GridView1.Rows[0].Cells[2].Text);
                        cmd.Parameters.AddWithValue("@signtype", signtype);

                        string message = "";

                        try
                        {
                            conn.Open();
                            cmd.ExecuteNonQuery();
                            message = "申請成功";

                        }
                        catch (Exception ex)
                        {
                            message = ex.Message;
                        }
                        finally
                        {
                            conn.Close();
                            string strJS = "alert('" + message + "');location.href = ('PayPrint1.aspx?pid=" + newno + "');";
                            Page.ClientScript.RegisterStartupScript(this.GetType(), "", strJS, true);

                        }


                    }
                    using (SqlCommand cmd = new SqlCommand(strCmd2, conn))
                    {
                        cmd.Parameters.AddWithValue("@paymentid", newno);
                        cmd.Parameters.AddWithValue("@dept_no", pay3drop31.SelectedValue);
                        cmd.Parameters.AddWithValue("@dept_cne", pay3drop31.SelectedItem.Text);
                        cmd.Parameters.AddWithValue("@comment", pay1text1.Text);
                        cmd.Parameters.AddWithValue("@payment", pay1text2.Text);

                        string message = "";

                        try
                        {
                            conn.Open();
                            cmd.ExecuteNonQuery();

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



            //int pay = int.Parse(pay1text2.Text);
            //string signtype = "none";
            //if (pay <= 5000)
            //{
            //    signtype = "a1";
            //}
            //else if (pay > 5000)
            //{
            //    signtype = "a2";
            //}
            //string strConn = ConfigurationManager.ConnectionStrings["MENU"].ConnectionString;

            //using (SqlConnection conn = new SqlConnection(strConn))
            //{
            //    //獲取最新id
            //    string strCmdNO = "SELECT top 1 id FROM TB_Payment ORDER BY id DESC";
            //    SqlDataAdapter da = new SqlDataAdapter(strCmdNO, conn);
            //    DataSet ds = new DataSet();
            //    da.Fill(ds);
            //    int newno = 0;
            //    if (ds.Tables[0].Rows.Count != 0)
            //    {
            //        newno = int.Parse(ds.Tables[0].Rows[0][0].ToString());
            //        newno++;
            //    }

            //    string strCmd = "Insert into TB_Payment(id,date,formtype,payment,paymentdetail,emp_no,emp_cne,department,signtype)values(@id,@date,@formtype,@payment,@paymentdetail,@emp_no,@emp_cne,@department,@signtype)";
            //    using (SqlCommand cmd = new SqlCommand(strCmd, conn))
            //    {
            //        cmd.Parameters.AddWithValue("@id", newno);
            //        cmd.Parameters.AddWithValue("@date", DateTime.Now);
            //        cmd.Parameters.AddWithValue("@formtype", RadioButtonList1.SelectedItem.Text);
            //        cmd.Parameters.AddWithValue("@payment", int.Parse(pay1text2.Text));
            //        cmd.Parameters.AddWithValue("@paymentdetail", pay1text1.Text);
            //        cmd.Parameters.AddWithValue("@emp_no", User.Identity.Name.ToString());
            //        cmd.Parameters.AddWithValue("@emp_cne", GridView1.Rows[0].Cells[1].Text);
            //        cmd.Parameters.AddWithValue("@department", GridView1.Rows[0].Cells[2].Text);
            //        cmd.Parameters.AddWithValue("@signtype", signtype);

            //        string message = "";

            //        try
            //        {
            //            conn.Open();
            //            cmd.ExecuteNonQuery();
            //            message = "申請成功";

            //        }
            //        catch (Exception ex)
            //        {
            //            message = ex.Message;
            //        }
            //        finally
            //        {
            //            conn.Close();
            //            string strJS = "alert('" + message + "');location.href = ('PayPrint1.aspx?pid=" + newno + "');";
            //            Page.ClientScript.RegisterStartupScript(this.GetType(), "", strJS, true);

            //        }


            //    }
            //}
        }
        //請款單(非月結) 送出並列印表單
        protected void Button2_Click(object sender, EventArgs e)
        {

            if (DropDownList5.SelectedValue.Substring(0, 1) != "G")
            {

                //判斷哪些廠商不需確認銀行資料

                if (DropDownList5.SelectedValue.Trim() != "A151" && DropDownList5.SelectedValue.Trim() != "A159" && DropDownList5.SelectedValue.Trim() != "A155")
                {
                    if (Label13.Text == "" && RadioButtonList2.SelectedValue == "匯款" && RadioButtonList7.SelectedValue == "1")
                    {
                        string strJS = "alert('請確認ERP已建銀行資料且已核可')";
                        Page.ClientScript.RegisterStartupScript(this.GetType(), "", strJS, true);
                        return;
                    }
                }
            }


            string strConn = ConfigurationManager.ConnectionStrings["MENU"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(strConn))
            {
                //獲取最新id
                string strCmdNO = "SELECT top 1 id FROM TB_Payment ORDER BY id DESC";
                SqlDataAdapter da = new SqlDataAdapter(strCmdNO, conn);
                DataSet ds = new DataSet();
                da.Fill(ds);
                int newno = 0;
                if (ds.Tables[0].Rows.Count != 0)
                {
                    newno = int.Parse(ds.Tables[0].Rows[0][0].ToString());
                    newno++;
                }
                //獲取申請日期
                DateTime signdate = DateTime.Now;
                if (pay2text3.Text != "")
                {
                    if (pay2text3.Text.Length == 8)//輸入數字8碼自動轉換為日期
                    {
                        signdate = DateTime.ParseExact(pay2text3.Text, "yyyyMMdd", null);
                    }
                    else
                    {
                        signdate = DateTime.Parse(pay2text3.Text);
                    }

                }
                //獲取總金額
                decimal totalmoney = 0;
                if (pay3text24.Text != "" && pay3text24.Text != "0")
                {
                    totalmoney += decimal.Parse(pay3text24.Text);
                }
                if (pay3text26.Text != "" && pay3text26.Text != "0")
                {
                    totalmoney += decimal.Parse(pay3text26.Text);
                }
                if (pay3text28.Text != "" && pay3text28.Text != "0")
                {
                    totalmoney += decimal.Parse(pay3text28.Text);
                }
                if (pay3text30.Text != "" && pay3text30.Text != "0")
                {
                    totalmoney += decimal.Parse(pay3text30.Text);
                }
                if (pay3text32.Text != "" && pay3text32.Text != "0")
                {
                    totalmoney += decimal.Parse(pay3text32.Text);
                }
                if (pay3text34.Text != "" && pay3text34.Text != "0")
                {
                    totalmoney += decimal.Parse(pay3text34.Text);
                }
                if (pay3text36.Text != "" && pay3text36.Text != "0")
                {
                    totalmoney += decimal.Parse(pay3text36.Text);
                }
                if (pay3text38.Text != "" && pay3text38.Text != "0")
                {
                    totalmoney += decimal.Parse(pay3text38.Text);
                }
                if (pay3text40.Text != "" && pay3text40.Text != "0")
                {
                    totalmoney += decimal.Parse(pay3text40.Text);
                }
                if (pay3text42.Text != "" && pay3text42.Text != "0")
                {
                    totalmoney += decimal.Parse(pay3text42.Text);
                }
                //判斷簽核標準
                string signtype = "none";
                //將總金額作備份
                decimal totalmoneybk = totalmoney;
                //將總金額乘以匯率做為簽核判斷依據
                if (Label11.Text == "NTD" || Label11.Text == "")
                {
                    //如果是台幣或沒資料不進行作業
                }
                else
                {
                    //外幣幣別取得匯率
                    DAL.JuicDao dao = new DAL.JuicDao("MENU");
                    var ExchangeRate = dao.GetExchangeRate(Label11.Text);
                    decimal rate = decimal.Parse(ExchangeRate.Rows[0]["BAS3201"].ToString());
                    totalmoney = totalmoney * rate;
                }

                //判斷核決權限
                //一般費用報支(含預付/暫付)
                if (DropDownList1.SelectedValue == "0")
                {
                    if (totalmoney <= 3000)
                    {
                        signtype = "b1";
                    }
                    else if (totalmoney > 3000 && totalmoney <= 10000)
                    {
                        signtype = "b2";
                    }
                    else if (totalmoney > 10000)
                    {
                        signtype = "b3";
                    }
                }
                //員工報支
                else if (DropDownList1.SelectedValue == "1")
                {
                    if (totalmoney <= 10000)
                    {
                        signtype = "b4";
                    }
                    else if (totalmoney > 10000 && totalmoney <= 30000)
                    {
                        signtype = "b5";
                    }
                    else if (totalmoney > 30000)
                    {
                        signtype = "b6";
                    }
                }
                //交際費
                else if (DropDownList1.SelectedValue == "2")
                {
                    if (totalmoney <= 10000)
                    {
                        signtype = "b7";
                    }
                    else if (totalmoney > 10000 && totalmoney <= 30000)
                    {
                        signtype = "b8";
                    }
                    else if (totalmoney > 30000)
                    {
                        signtype = "b9";
                    }
                }
                //請採購(單筆)
                else if (DropDownList1.SelectedValue == "3")
                {
                    if (totalmoney <= 10000)
                    {
                        signtype = "b7";
                    }
                    else if (totalmoney > 10000 && totalmoney <= 30000)
                    {
                        signtype = "b8";
                    }
                    else if (totalmoney > 30000)
                    {
                        signtype = "b9";
                    }
                }
                //旅費權限未畫分
                else if (DropDownList1.SelectedValue == "4")
                {
                    signtype = "b8";
                }
                //定期費用報支
                else if (DropDownList1.SelectedValue == "5")
                {
                    signtype = "b11";
                }
                //資材採購(原材料+訂單)
                else if (DropDownList1.SelectedValue == "6")
                {
                    if (totalmoney <= 500000)
                    {
                        signtype = "b11";
                    }
                    else if (totalmoney > 500000 && totalmoney <= 1000000)
                    {
                        signtype = "b1";
                    }
                    else if (totalmoney > 1000000)
                    {
                        signtype = "b2";
                    }
                }
                //資材採購(原材料+無訂單)
                else if (DropDownList1.SelectedValue == "7")
                {
                    signtype = "b3";
                }
                //雜項購置及修繕工程
                else if (DropDownList1.SelectedValue == "8")
                {
                    if (totalmoney <= 10000)
                    {
                        signtype = "b1";
                    }
                    else if (totalmoney > 10000 && totalmoney <= 30000)
                    {
                        signtype = "b2";
                    }
                    else if (totalmoney > 30000)
                    {
                        signtype = "b3";
                    }
                }
                //資訊設備採購
                else if (DropDownList1.SelectedValue == "9")
                {
                    if (totalmoney <= 10000)
                    {
                        signtype = "b1";
                    }
                    else if (totalmoney > 10000 && totalmoney <= 30000)
                    {
                        signtype = "b2";
                    }
                    else if (totalmoney > 30000)
                    {
                        signtype = "b3";
                    }
                }
                //薪酬費用(人事)
                else if (DropDownList1.SelectedValue == "10")
                {
                    signtype = "b3";
                }
                //外包加工
                else if (DropDownList1.SelectedValue == "11")
                {
                    if (totalmoney <= 100000)
                    {
                        signtype = "b2";
                    }
                    else if (totalmoney > 100000)
                    {
                        signtype = "b3";
                    }
                }
                //核決權限判斷完成，將金額回歸原始金額
                totalmoney = totalmoneybk;

                //決定匯費級距並取得匯費
                int sendcharge = 0;
                if (RadioButtonList3.SelectedItem.Text == "外加" && RadioButtonList2.SelectedValue== "匯款")
                {
                    JuicDao dao = new JuicDao("MENU");
                    string currency = Label11.Text.Trim();
                    if (currency == "")
                    { currency = "NTD"; }
                    //幣別為新台幣依照金額決定匯費
                    if (currency == "NTD")
                    {
                        var PayCharge = dao.GetPayCharge(totalmoney.ToString(), currency);
                        sendcharge = int.Parse(PayCharge.Rows[0]["charge"].ToString());
                        totalmoney += sendcharge;
                    }
                    //幣別為美金固定為10
                    else if (currency == "USD")
                    {
                        var PayCharge2 = dao.GetPayCharge2(currency);
                        sendcharge = int.Parse(PayCharge2.Rows[0]["charge"].ToString());
                        totalmoney += sendcharge;
                    }
                    // 幣別為其他暫定為0
                    else
                    {
                        sendcharge = 0;
                        totalmoney += sendcharge;
                    }

                }




                //決定付款日期，現階段判別為下週四付款
                DateTime paydate = DateTime.Now;
                if (pay2text3.Text == "")
                {
                    int day = (int)paydate.DayOfWeek; //取得今天週幾(週一為1)
                    day = 4 - day;//取得今天到周四還需幾天
                    day = day + 7;    //將日期延至下週
                    paydate = paydate.AddDays(day);  //取得下週四日期
                }
                else
                {
                    //若有輸入日期以輸入日期為主
                    if (pay2text3.Text.Length == 8)//輸入數字8碼自動轉換為日期
                    {
                        paydate = DateTime.ParseExact(pay2text3.Text, "yyyyMMdd", null);
                    }
                    else
                    {
                        paydate = DateTime.Parse(pay2text3.Text);
                    }

                    //paydate = DateTime.Parse(pay2text3.Text);
                }
                //取得支付對項
                string target = "";
                if (RadioButtonList7.SelectedValue == "0")
                {
                    target = pay2text1.Text;
                }
                else if (RadioButtonList7.SelectedValue == "1")
                {
                    target = DropDownList5.SelectedItem.Text;
                }
                else if (RadioButtonList7.SelectedValue == "2")
                {
                    target = pay2text1.Text;
                }

                //paydetail(僅線資料庫記錄、未呈現再表單)
                //string detail = pay2text6.Text + "/" + pay2text8.Text + "/" + pay2text10.Text + "/" + pay2text12.Text + "/" + pay2text14.Text + "/" + pay2text16.Text;

                //***********************************************************************************
                //判斷付款日是否遇假日順延或提前  --modify by Arno  20170830
                DateTime newdate = paydate;
                string supid = DropDownList5.SelectedItem.Value.Trim();
                newdate = newpaydate(supid, newdate, strConn);


                //
                //***********************************************************************************

                string strCmd, strCmd2;

                strCmd = "Insert into TB_Payment(id,date,formtype,payment,paymentdetail,emp_no,emp_cne,department,signtype,paytype,paymethod,paydate,payexchange,paycharge,PS,target,targetbank,nextmonth,curr_k,swiftcode,bas2001,ac_no,acne,acct_type,paydateRAW)values(@id,@date,@formtype,@payment,@paymentdetail,@emp_no,@emp_cne,@department,@signtype,@paytype,@paymethod,@paydate,@payexchange,@paycharge,@PS,@target,@targetbank,@nextmonth,@curr_k,@swiftcode,@bas2001,@ac_no,@acne,@acct_type,@paydateRAW)";
                strCmd2 = "Insert into TB_Paymentdetail(paymentid,dept_no,dept_cne,comment,payment)values(@paymentid,@dept_no,@dept_cne,@comment,@payment)";
                //將所有單身金額textbox值輸入到資料庫
                DropDownList[] dept = { pay3drop11, pay3drop12, pay3drop13, pay3drop14, pay3drop15, pay3drop16, pay3drop17, pay3drop18, pay3drop19, pay3drop20 };
                TextBox[] pay = { pay3text23, pay3text25, pay3text27, pay3text29, pay3text31, pay3text33, pay3text35, pay3text37, pay3text39, pay3text41 };
                TextBox[] pay2 = { pay3text24, pay3text26, pay3text28, pay3text30, pay3text32, pay3text34, pay3text36, pay3text38, pay3text40, pay3text42 }; //put all into this array




                using (SqlCommand cmd = new SqlCommand(strCmd, conn))
                {
                    cmd.Parameters.AddWithValue("@id", newno);
                    cmd.Parameters.AddWithValue("@date", signdate);
                    cmd.Parameters.AddWithValue("@formtype", RadioButtonList1.SelectedItem.Text);
                    cmd.Parameters.AddWithValue("@payment", totalmoney);
                    cmd.Parameters.AddWithValue("@paymentdetail", "");
                    cmd.Parameters.AddWithValue("@emp_no", User.Identity.Name.ToString());
                    cmd.Parameters.AddWithValue("@emp_cne", GridView1.Rows[0].Cells[1].Text);
                    cmd.Parameters.AddWithValue("@department", GridView1.Rows[0].Cells[2].Text);
                    cmd.Parameters.AddWithValue("@signtype", signtype);
                    cmd.Parameters.AddWithValue("@paytype", DropDownList1.SelectedItem.Text);
                    cmd.Parameters.AddWithValue("@paymethod", RadioButtonList2.SelectedItem.Text);
                    cmd.Parameters.AddWithValue("@payexchange", RadioButtonList3.SelectedItem.Text);
                    cmd.Parameters.AddWithValue("@paycharge", sendcharge);
                    cmd.Parameters.AddWithValue("@paydate", newdate);
                    cmd.Parameters.AddWithValue("@paydateRAW", paydate);
                    cmd.Parameters.AddWithValue("@PS", pay2text4.Text);
                    cmd.Parameters.AddWithValue("@target", target);
                    //cmd.Parameters.AddWithValue("@targetbank", DropDownList4.SelectedItem.Text);
                    cmd.Parameters.AddWithValue("@targetbank", pay2text2.Text);
                    cmd.Parameters.AddWithValue("@nextmonth", "");
                    cmd.Parameters.AddWithValue("@curr_k", Label11.Text);
                    cmd.Parameters.AddWithValue("@swiftcode", Label12.Text);
                    cmd.Parameters.AddWithValue("@bas2001", Label12b.Text);
                    cmd.Parameters.AddWithValue("@ac_no", Label13.Text);
                    cmd.Parameters.AddWithValue("@acne", Label14.Text);
                    cmd.Parameters.AddWithValue("@acct_type", Label15.Text);


                    string message = "";

                    try
                    {
                        conn.Open();
                        cmd.ExecuteNonQuery();
                        message = "申請成功";

                    }
                    catch (Exception ex)
                    {
                        message = ex.Message;
                    }
                    finally
                    {
                        conn.Close();
                        string strJS = "alert('" + message + "');location.href = ('PayPrint2.aspx?pid=" + newno + "&user=" + GridView1.Rows[0].Cells[1].Text + "');";
                        Page.ClientScript.RegisterStartupScript(this.GetType(), "", strJS, true);

                    }


                }
                for (int i = 0; i < pay2.Length; i++)
                {
                    if (dept[i].SelectedValue == "0" && pay[i].Text == "" && pay2[i].Text == "")
                    {
                        //不匯入資料庫
                    }
                    else
                    {
                        using (SqlCommand cmd = new SqlCommand(strCmd2, conn))
                        {
                            cmd.Parameters.AddWithValue("@paymentid", newno);
                            cmd.Parameters.AddWithValue("@dept_no", dept[i].SelectedValue);
                            cmd.Parameters.AddWithValue("@dept_cne", dept[i].SelectedItem.Text);
                            cmd.Parameters.AddWithValue("@comment", pay[i].Text);
                            cmd.Parameters.AddWithValue("@payment", pay2[i].Text);

                            string message = "";

                            try
                            {
                                conn.Open();
                                cmd.ExecuteNonQuery();

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

                //string strCmd = "Insert into TB_Payment(id,date,formtype,payment,paymentdetail,emp_no,emp_cne,department,signtype,paytype,paymethod,payexchange,PS,pay1,pay1amount,pay2,pay2amount,pay3,pay3amount,pay4,pay4amount,pay5,pay5amount,pay6,pay6amount,target,targetbank)values(@id,@date,@formtype,@payment,@paymentdetail,@emp_no,@emp_cne,@department,@signtype,@paytype,@paymethod,@payexchange,@PS,@pay1,@pay1amount,@pay2,@pay2amount,@pay3,@pay3amount,@pay4,@pay4amount,@pay5,@pay5amount,@pay6,@pay6amount,@target,@targetbank)";
                //using (SqlCommand cmd = new SqlCommand(strCmd, conn))
                //{
                //    cmd.Parameters.AddWithValue("@id", newno);
                //    cmd.Parameters.AddWithValue("@date", signdate);
                //    cmd.Parameters.AddWithValue("@formtype", RadioButtonList1.SelectedItem.Text);
                //    cmd.Parameters.AddWithValue("@payment", totalmoney);
                //    cmd.Parameters.AddWithValue("@paymentdetail", "");
                //    cmd.Parameters.AddWithValue("@emp_no", User.Identity.Name.ToString());
                //    cmd.Parameters.AddWithValue("@emp_cne", GridView1.Rows[0].Cells[1].Text);
                //    cmd.Parameters.AddWithValue("@department", GridView1.Rows[0].Cells[2].Text);
                //    cmd.Parameters.AddWithValue("@signtype", signtype);

                //    cmd.Parameters.AddWithValue("@paytype", DropDownList1.SelectedItem.Text);
                //    cmd.Parameters.AddWithValue("@paymethod", RadioButtonList2.SelectedItem.Text);
                //    cmd.Parameters.AddWithValue("@payexchange", RadioButtonList3.SelectedItem.Text);
                //    //cmd.Parameters.AddWithValue("@paydate", null);
                //    cmd.Parameters.AddWithValue("@PS", pay2text4.Text);
                //    cmd.Parameters.AddWithValue("@pay1", pay2text5.Text);
                //    cmd.Parameters.AddWithValue("@pay1amount", pay2text6.Text);
                //    cmd.Parameters.AddWithValue("@pay2", pay2text7.Text);
                //    cmd.Parameters.AddWithValue("@pay2amount", pay2text8.Text);
                //    cmd.Parameters.AddWithValue("@pay3", pay2text9.Text);
                //    cmd.Parameters.AddWithValue("@pay3amount", pay2text10.Text);
                //    cmd.Parameters.AddWithValue("@pay4", pay2text11.Text);
                //    cmd.Parameters.AddWithValue("@pay4amount", pay2text12.Text);
                //    cmd.Parameters.AddWithValue("@pay5", pay2text13.Text);
                //    cmd.Parameters.AddWithValue("@pay5amount", pay2text14.Text);
                //    cmd.Parameters.AddWithValue("@pay6", pay2text15.Text);
                //    cmd.Parameters.AddWithValue("@pay6amount", pay2text16.Text);

                //    cmd.Parameters.AddWithValue("@target", pay2text1.Text);
                //    cmd.Parameters.AddWithValue("@targetbank", pay2text2.Text);
                //    string message = "";

                //    try
                //    {
                //        conn.Open();
                //        cmd.ExecuteNonQuery();
                //        message = "申請成功";

                //    }
                //    catch (Exception ex)
                //    {
                //        message = ex.Message;
                //    }
                //    finally
                //    {
                //        conn.Close();
                //        string strJS = "alert('" + message + "');location.href = ('PayPrint2.aspx?pid=" + newno + "');";
                //        Page.ClientScript.RegisterStartupScript(this.GetType(), "", strJS, true);

                //    }


                //}
            }
        }
        //支付對象
        protected void DropDownList3_SelectedIndexChanged(object sender, EventArgs e)
        {
            string SUP_NO = DropDownList3.SelectedValue.ToString();

            JuicDao dao = new JuicDao("MENU");
            var Paydata = dao.GetPayData(SUP_NO);
            if (Paydata.Rows.Count > 0)
            {
                Label3.Text = Paydata.Rows[0]["pay_ne2"].ToString();
                monthdata1.Text = Paydata.Rows[0]["PAY_F"].ToString(); //是否月結，月結=2
                monthdata2.Text = Paydata.Rows[0]["MM1"].ToString(); //月結+N個月
                monthdata3.Text = Paydata.Rows[0]["D11"].ToString(); //結帳日
                monthdata4.Text = Paydata.Rows[0]["D21"].ToString(); //付款日期
            }
            pay3textbank.Text = "";
            Label6.Text = "";
            Label7.Text = "";
            Label7b.Text = "";
            Label8.Text = "";
            Label9.Text = "";
            Label10.Text = "";

            var Paybank = dao.GetPaybank(SUP_NO);
            if (Paybank.Rows.Count > 0)
            {
                //若銀行只有一間，顯示銀行資料
                if (Paybank.Rows.Count == 1)
                {
                    //Label5.Text = "幣別：" + Paybank.Rows[0]["curr_k"].ToString() + ",金融機構代號：" + Paybank.Rows[0]["swiftcode"].ToString() + Paybank.Rows[0]["bas2001"].ToString() + ",帳號：" + Paybank.Rows[0]["ac_no"].ToString() + ",戶名：" + Paybank.Rows[0]["acne"].ToString() + ",收費別：" + Paybank.Rows[0]["acct_type"].ToString();
                    pay3textbank.Text = Paybank.Rows[0]["b_ne"].ToString().Trim();
                    Label6.Text = Paybank.Rows[0]["curr_k"].ToString();
                    Label7.Text = Paybank.Rows[0]["swiftcode"].ToString();
                    Label7b.Text = Paybank.Rows[0]["bas2001"].ToString();
                    Label8.Text = Paybank.Rows[0]["ac_no"].ToString();
                    Label9.Text = Paybank.Rows[0]["acne"].ToString();
                    Label10.Text = Paybank.Rows[0]["acct_type"].ToString();
                    pay3textbank.Visible = true;
                    pay3drpbank.Visible = false;
                }
                //若銀行大於一間，出現下拉式選單讓使用者選銀行
                else if (Paybank.Rows.Count > 1)
                {
                    pay3textbank.Text = "";
                    Label6.Text = "";
                    Label7.Text = "";
                    Label7b.Text = "";
                    Label8.Text = "";
                    Label9.Text = "";
                    Label10.Text = "";
                    pay3textbank.Visible = false;
                    pay3drpbank.Visible = true;
                    Label17.Text = DropDownList3.SelectedValue.ToString().Trim();
                }
            }



        }
        
        protected void Button3_Click(object sender, EventArgs e)
        {
            string strConn = ConfigurationManager.ConnectionStrings["MENU"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(strConn))
            {
                //獲取最新id
                string strCmdNO = "SELECT top 1 id FROM TB_Payment ORDER BY id DESC";
                SqlDataAdapter da = new SqlDataAdapter(strCmdNO, conn);
                DataSet ds = new DataSet();
                da.Fill(ds);
                int newno = 0;
                if (ds.Tables[0].Rows.Count != 0)
                {
                    newno = int.Parse(ds.Tables[0].Rows[0][0].ToString());
                    newno++;
                }
                //獲取申請日期
                DateTime signdate = DateTime.Now;
                if (pay3text1.Text != "")
                {
                    signdate = DateTime.Parse(pay3text1.Text);
                }
                //獲取總金額
                decimal totalmoney = 0;
                if (pay3text4.Text != "" && pay3text4.Text != "0")
                {
                    totalmoney += decimal.Parse(pay3text4.Text);
                }
                if (pay3text6.Text != "" && pay3text6.Text != "0")
                {
                    totalmoney += decimal.Parse(pay3text6.Text);
                }
                if (pay3text8.Text != "" && pay3text8.Text != "0")
                {
                    totalmoney += decimal.Parse(pay3text8.Text);
                }
                if (pay3text10.Text != "" && pay3text10.Text != "0")
                {
                    totalmoney += decimal.Parse(pay3text10.Text);
                }
                if (pay3text12.Text != "" && pay3text12.Text != "0")
                {
                    totalmoney += decimal.Parse(pay3text12.Text);
                }
                if (pay3text14.Text != "" && pay3text14.Text != "0")
                {
                    totalmoney += decimal.Parse(pay3text14.Text);
                }
                //判斷簽核標準
                string signtype = "none";

                if (totalmoney <= 3000)
                {
                    signtype = "b1";
                }
                else if (totalmoney > 3000 && totalmoney <= 10000)
                {
                    signtype = "b2";
                }
                else if (totalmoney > 10000)
                {
                    signtype = "b3";
                }
                //重要  判斷付款日期============================
                DateTime basedate = DateTime.Now;
                if (pay3text1.Text != "")
                {
                    basedate = DateTime.Parse(pay3text1.Text);
                }
                //系統判斷是否當月結(目前不採用)
                //判斷是否在月結日期之前
                //if (basedate.Day <= int.Parse(monthdata3.Text))
                //{

                //}
                ////判斷是否在月結日期之後
                //else if (basedate.Day > int.Parse(monthdata3.Text))
                //{

                //}
                //人工判斷是否當月結(目前採用)
                if (RadioButtonList6.SelectedItem.Text == "當月結")
                {
                    basedate = basedate.AddMonths(1);
                    //獨立討論先計算月底付款的情況
                    if (int.Parse(monthdata4.Text) == -1)
                    {
                        //30天情況
                        if (int.Parse(monthdata2.Text) == 30)
                        {
                            basedate = basedate.AddMonths(1).AddDays(-1 * (basedate.Day));
                        }
                        //60天情況
                        if (int.Parse(monthdata2.Text) == 60)
                        {
                            basedate = basedate.AddMonths(2).AddDays(-1 * (basedate.Day));
                        }
                        //90天情況
                        if (int.Parse(monthdata2.Text) == 90)
                        {
                            basedate = basedate.AddMonths(3).AddDays(-1 * (basedate.Day));
                        }
                        //120天情況
                        if (int.Parse(monthdata2.Text) == 120)
                        {
                            basedate = basedate.AddMonths(4).AddDays(-1 * (basedate.Day));
                        }
                    }
                    //互抵，LC
                    //if (int.Parse(monthdata4.Text) == -3)
                    //{

                    //}
                    //非月底結，固定或變動
                    else
                    {
                        int day1 = 1 - basedate.Date.Day;
                        basedate = basedate.AddDays(day1);
                        //月結N天
                        basedate = basedate.AddDays(int.Parse(monthdata2.Text));
                        //若有固定結帳日
                        if (int.Parse(monthdata4.Text) > 0)
                        {
                            int day2 = int.Parse(monthdata4.Text) - basedate.Date.Day;
                            basedate = basedate.AddDays(day2);
                        }
                        //變動結帳日
                        else if (int.Parse(monthdata4.Text) == 0)
                        {
                            //不變
                        }
                    }

                }
                else if (RadioButtonList6.SelectedItem.Text == "次月結")
                {
                    basedate = basedate.AddMonths(2);
                    //獨立討論先計算月底付款的情況
                    if (int.Parse(monthdata4.Text) == -1)
                    {
                        //30天情況
                        if (int.Parse(monthdata2.Text) == 30)
                        {
                            basedate = basedate.AddMonths(1).AddDays(-1 * (basedate.Day));
                        }
                        //60天情況
                        if (int.Parse(monthdata2.Text) == 60)
                        {
                            basedate = basedate.AddMonths(2).AddDays(-1 * (basedate.Day));
                        }
                        //90天情況
                        if (int.Parse(monthdata2.Text) == 90)
                        {
                            basedate = basedate.AddMonths(3).AddDays(-1 * (basedate.Day));
                        }
                        //120天情況
                        if (int.Parse(monthdata2.Text) == 120)
                        {
                            basedate = basedate.AddMonths(4).AddDays(-1 * (basedate.Day));
                        }
                    }
                    else
                    {
                        int day1 = 1 - basedate.Date.Day;
                        basedate = basedate.AddDays(day1);
                        //月結N天
                        basedate = basedate.AddDays(int.Parse(monthdata2.Text));
                        //若有固定結帳日
                        if (int.Parse(monthdata4.Text) > 0)
                        {
                            int day2 = int.Parse(monthdata4.Text) - basedate.Date.Day;
                            basedate = basedate.AddDays(day2);
                        }
                        //變動結帳日
                        else if (int.Parse(monthdata4.Text) == 0)
                        {
                            //不變
                        }
                    }

                }




                //paydetail(僅線資料庫記錄、未呈現再表單)
                //string detail = pay2text6.Text + "/" + pay2text8.Text + "/" + pay2text10.Text + "/" + pay2text12.Text + "/" + pay2text14.Text + "/" + pay2text16.Text;
                string strCmd;
                //若為LC等(資料庫TB_PaySupplierData的paydate=-3，則不帶入日期)
                if (int.Parse(monthdata4.Text) == -3)
                {
                    strCmd = "Insert into TB_Payment(id,date,formtype,payment,paymentdetail,emp_no,emp_cne,department,signtype,paytype,paymethod,payexchange,PS,pay1,pay1amount,pay2,pay2amount,pay3,pay3amount,pay4,pay4amount,pay5,pay5amount,pay6,pay6amount,target,targetbank,nextmonth)values(@id,@date,@formtype,@payment,@paymentdetail,@emp_no,@emp_cne,@department,@signtype,@paytype,@paymethod,@payexchange,@PS,@pay1,@pay1amount,@pay2,@pay2amount,@pay3,@pay3amount,@pay4,@pay4amount,@pay5,@pay5amount,@pay6,@pay6amount,@target,@targetbank,@nextmonth)";
                }
                else
                {
                    strCmd = "Insert into TB_Payment(id,date,formtype,payment,paymentdetail,emp_no,emp_cne,department,signtype,paytype,paymethod,payexchange,PS,pay1,pay1amount,pay2,pay2amount,pay3,pay3amount,pay4,pay4amount,pay5,pay5amount,pay6,pay6amount,target,targetbank,nextmonth,paydate)values(@id,@date,@formtype,@payment,@paymentdetail,@emp_no,@emp_cne,@department,@signtype,@paytype,@paymethod,@payexchange,@PS,@pay1,@pay1amount,@pay2,@pay2amount,@pay3,@pay3amount,@pay4,@pay4amount,@pay5,@pay5amount,@pay6,@pay6amount,@target,@targetbank,@nextmonth,@paydate)";
                }

                using (SqlCommand cmd = new SqlCommand(strCmd, conn))
                {
                    cmd.Parameters.AddWithValue("@id", newno);
                    cmd.Parameters.AddWithValue("@date", signdate);
                    cmd.Parameters.AddWithValue("@formtype", RadioButtonList1.SelectedItem.Text);
                    cmd.Parameters.AddWithValue("@payment", totalmoney);
                    cmd.Parameters.AddWithValue("@paymentdetail", "");
                    cmd.Parameters.AddWithValue("@emp_no", User.Identity.Name.ToString());
                    cmd.Parameters.AddWithValue("@emp_cne", GridView1.Rows[0].Cells[1].Text);
                    cmd.Parameters.AddWithValue("@department", GridView1.Rows[0].Cells[2].Text);
                    cmd.Parameters.AddWithValue("@signtype", signtype);

                    cmd.Parameters.AddWithValue("@paytype", DropDownList2.SelectedItem.Text);
                    cmd.Parameters.AddWithValue("@paymethod", RadioButtonList4.SelectedItem.Text);
                    cmd.Parameters.AddWithValue("@payexchange", RadioButtonList5.SelectedItem.Text);

                    cmd.Parameters.AddWithValue("@PS", pay2text2.Text);
                    cmd.Parameters.AddWithValue("@pay1", pay3text3.Text);
                    cmd.Parameters.AddWithValue("@pay1amount", pay3text4.Text);
                    cmd.Parameters.AddWithValue("@pay2", pay3text5.Text);
                    cmd.Parameters.AddWithValue("@pay2amount", pay3text6.Text);
                    cmd.Parameters.AddWithValue("@pay3", pay3text7.Text);
                    cmd.Parameters.AddWithValue("@pay3amount", pay3text8.Text);
                    cmd.Parameters.AddWithValue("@pay4", pay3text9.Text);
                    cmd.Parameters.AddWithValue("@pay4amount", pay3text10.Text);
                    cmd.Parameters.AddWithValue("@pay5", pay3text11.Text);
                    cmd.Parameters.AddWithValue("@pay5amount", pay3text12.Text);
                    cmd.Parameters.AddWithValue("@pay6", pay3text13.Text);
                    cmd.Parameters.AddWithValue("@pay6amount", pay3text14.Text);
                    cmd.Parameters.AddWithValue("@target", DropDownList3.SelectedItem.Text);
                    cmd.Parameters.AddWithValue("@targetbank", DropDownList4.SelectedItem.Text);
                    cmd.Parameters.AddWithValue("@nextmonth", RadioButtonList6.SelectedItem.Text);
                    //若為LC等(資料庫TB_PaySupplierData的paydate=-3，則不帶入日期)
                    if (int.Parse(monthdata4.Text) == -3)
                    {
                        //cmd.Parameters.AddWithValue("@paydate", "");
                    }
                    else
                    {
                        cmd.Parameters.AddWithValue("@paydate", basedate);
                    }

                    string message = "";

                    try
                    {
                        conn.Open();
                        cmd.ExecuteNonQuery();
                        message = "申請成功";

                    }
                    catch (Exception ex)
                    {
                        message = ex.Message;
                    }
                    finally
                    {
                        conn.Close();
                        string strJS = "alert('" + message + "');location.href = ('PayPrint2.aspx?pid=" + newno + "&user=" + GridView1.Rows[0].Cells[1].Text + "');";
                        Page.ClientScript.RegisterStartupScript(this.GetType(), "", strJS, true);

                    }


                }
            }
        }

        protected void Button4_Click(object sender, EventArgs e)
        {
            string strConn = ConfigurationManager.ConnectionStrings["MENU"].ConnectionString;

            //重要  判斷付款日期============================
            DateTime basedate = DateTime.Now;
            if (pay3text1.Text != "")
            {
                if (pay3text1.Text.Length == 8)//輸入數字8碼自動轉換為日期
                {
                    basedate = DateTime.ParseExact(pay3text1.Text, "yyyyMMdd", null);
                }
                else
                {
                    basedate = DateTime.Parse(pay3text1.Text);
                }

            }
            //系統判斷是否當月結(目前採用)
            //判斷是否在月結日期之前
            if (basedate.Day <= int.Parse(monthdata3.Text))
            {

            }
            //判斷是否在月結日期之後
            else if (basedate.Day > int.Parse(monthdata3.Text))
            {
                basedate = basedate.AddMonths(1);
            }
            //人工判斷是否當月結(目前採用)
            //if (RadioButtonList6.SelectedItem.Text == "當月結")
            //{

            //}
            //else if (RadioButtonList6.SelectedItem.Text == "次月結")
            //{
            //    basedate = basedate.AddMonths(1);
            //}
            int plusmonth = int.Parse(monthdata2.Text);
            //獨立討論先計算月底付款的情況
            if (monthdata4.Text.Trim() == "31")
            {

                //基礎日期加兩個月後，的上個月月底為付款日
                basedate = basedate.AddMonths(plusmonth + 1).AddDays(-1 * (basedate.Day));

            }
            //非月底付款狀況，大部分為5,10,15號
            else
            {
                int day1 = 1 - basedate.Date.Day;
                basedate = basedate.AddDays(day1);
                //月結N天
                basedate = basedate.AddMonths(plusmonth);
                //有固定付款日

                int day2 = int.Parse(monthdata4.Text) - basedate.Date.Day;
                basedate = basedate.AddDays(day2);

            }


            //***********************************************************************************
            //判斷付款日是否遇假日順延或提前  --modify by Arno  20170830
            DateTime newdate = basedate;
            string supid = DropDownList3.SelectedItem.Value.Trim();
            newdate = newpaydate(supid, newdate, strConn);


            //
            //***********************************************************************************

            Label4.Text = newdate.ToShortDateString();
        }
        //請款單(月結)  送出並列印表單
        protected void Button5_Click(object sender, EventArgs e)
        {
            if (Label8.Text == "" && RadioButtonList4.SelectedValue == "匯款")
            {
                string strJS = "alert('請確認ERP已建銀行資料且已核可')";
                Page.ClientScript.RegisterStartupScript(this.GetType(), "", strJS, true);
                return;
            }

            string strConn = ConfigurationManager.ConnectionStrings["MENU"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(strConn))
            {
                //獲取最新id
                string strCmdNO = "SELECT top 1 id FROM TB_Payment ORDER BY id DESC";
                SqlDataAdapter da = new SqlDataAdapter(strCmdNO, conn);
                DataSet ds = new DataSet();
                da.Fill(ds);
                int newno = 0;
                if (ds.Tables[0].Rows.Count != 0)
                {
                    newno = int.Parse(ds.Tables[0].Rows[0][0].ToString());
                    newno++;
                }
                //獲取申請日期
                DateTime signdate = DateTime.Now;
                if (pay3text1.Text != "")
                {
                    if (pay3text1.Text.Length == 8) //輸入數字8碼自動轉換為日期

                    {
                        DateTime.ParseExact(pay3text1.Text, "yyyyMMdd", null);
                    }
                    else
                    {
                        signdate = DateTime.Parse(pay3text1.Text);
                    }

                }

                //獲取總金額
                decimal totalmoney = 0;
                if (pay3text4.Text != "" && pay3text4.Text != "0")
                {
                    totalmoney += decimal.Parse(pay3text4.Text);
                }
                if (pay3text6.Text != "" && pay3text6.Text != "0")
                {
                    totalmoney += decimal.Parse(pay3text6.Text);
                }
                if (pay3text8.Text != "" && pay3text8.Text != "0")
                {
                    totalmoney += decimal.Parse(pay3text8.Text);
                }
                if (pay3text10.Text != "" && pay3text10.Text != "0")
                {
                    totalmoney += decimal.Parse(pay3text10.Text);
                }
                if (pay3text12.Text != "" && pay3text12.Text != "0")
                {
                    totalmoney += decimal.Parse(pay3text12.Text);
                }
                if (pay3text14.Text != "" && pay3text14.Text != "0")
                {
                    totalmoney += decimal.Parse(pay3text14.Text);
                }
                if (pay3text16.Text != "" && pay3text16.Text != "0")
                {
                    totalmoney += decimal.Parse(pay3text16.Text);
                }
                if (pay3text18.Text != "" && pay3text18.Text != "0")
                {
                    totalmoney += decimal.Parse(pay3text18.Text);
                }
                if (pay3text20.Text != "" && pay3text20.Text != "0")
                {
                    totalmoney += decimal.Parse(pay3text20.Text);
                }
                if (pay3text22.Text != "" && pay3text22.Text != "0")
                {
                    totalmoney += decimal.Parse(pay3text22.Text);
                }


                //判斷簽核標準
                string signtype = "none";
                decimal totalmoneybk = totalmoney;
                //將總金額乘以匯率做為簽核判斷依據
                if (Label6.Text == "NTD" || Label6.Text == "")
                {
                    //如果是台幣或沒資料不進行作業
                }
                else
                {
                    //外幣幣別取得匯率
                    DAL.JuicDao dao = new DAL.JuicDao("MENU");
                    var ExchangeRate = dao.GetExchangeRate(Label6.Text);
                    decimal rate = decimal.Parse(ExchangeRate.Rows[0]["BAS3201"].ToString());
                    totalmoney = totalmoney * rate;
                }
                //一般費用報支(含預付/暫付)
                if (DropDownList2.SelectedValue == "0")
                {
                    if (totalmoney <= 3000)
                    {
                        signtype = "b1";
                    }
                    else if (totalmoney > 3000 && totalmoney <= 10000)
                    {
                        signtype = "b2";
                    }
                    else if (totalmoney > 10000)
                    {
                        signtype = "b3";
                    }
                }
                //交際費、請採購(單筆)
                else if (DropDownList2.SelectedValue == "1")
                {
                    if (totalmoney <= 10000)
                    {
                        signtype = "b1";
                    }
                    else if (totalmoney > 10000 && totalmoney <= 30000)
                    {
                        signtype = "b2";
                    }
                    else if (totalmoney > 30000)
                    {
                        signtype = "b3";
                    }
                }
                //資材採購(原材料+訂單)
                else if (DropDownList2.SelectedValue == "2")
                {
                    if (totalmoney <= 500000)
                    {
                        signtype = "b11";
                    }
                    else if (totalmoney > 500000 && totalmoney <= 1000000)
                    {
                        signtype = "b1";
                    }
                    else if (totalmoney > 1000000)
                    {
                        signtype = "b2";
                    }
                }
                //資材採購(原材料+無訂單)
                else if (DropDownList2.SelectedValue == "3")
                {
                    signtype = "b3";
                }
                //雜項購置及修繕工程
                else if (DropDownList2.SelectedValue == "4")
                {
                    if (totalmoney <= 10000)
                    {
                        signtype = "b1";
                    }
                    else if (totalmoney > 10000 && totalmoney <= 30000)
                    {
                        signtype = "b2";
                    }
                    else if (totalmoney > 30000)
                    {
                        signtype = "b3";
                    }
                }
                //資訊設備採購
                else if (DropDownList2.SelectedValue == "5")
                {
                    if (totalmoney <= 10000)
                    {
                        signtype = "b1";
                    }
                    else if (totalmoney > 10000 && totalmoney <= 30000)
                    {
                        signtype = "b2";
                    }
                    else if (totalmoney > 30000)
                    {
                        signtype = "b3";
                    }
                }
                //外包加工
                else if (DropDownList2.SelectedValue == "6")
                {
                    if (totalmoney <= 100000)
                    {
                        signtype = "b2";
                    }
                    else if (totalmoney > 100000)
                    {
                        signtype = "b3";
                    }
                }
                //定期性費用
                else if (DropDownList2.SelectedValue == "7")
                {

                    signtype = "b11";


                }
                //將請款單金額回歸原始
                totalmoney = totalmoneybk;


                //決定匯費級距並取得匯費
                int sendcharge = 0;
                if (RadioButtonList5.SelectedItem.Text == "外加" && RadioButtonList4.SelectedValue == "匯款")
                {
                    JuicDao dao = new JuicDao("MENU");
                    string currency = Label6.Text.Trim();
                    if (currency == "")
                    { currency = "NTD"; }
                    //幣別為新台幣依照金額決定匯費
                    if (currency == "NTD")
                    {
                        var PayCharge = dao.GetPayCharge(totalmoney.ToString(), currency);
                        sendcharge = int.Parse(PayCharge.Rows[0]["charge"].ToString());
                        totalmoney += sendcharge;
                    }
                    //幣別為美金固定為10
                    else if (currency == "USD")
                    {
                        var PayCharge2 = dao.GetPayCharge2(currency);
                        sendcharge = int.Parse(PayCharge2.Rows[0]["charge"].ToString());
                        totalmoney += sendcharge;
                    }
                    // 幣別為其他暫定為0
                    else
                    {
                        sendcharge = 0;
                        totalmoney += sendcharge;
                    }
                }


                //重要  判斷付款日期============================
                DateTime basedate = DateTime.Now;
                if (pay3text1.Text != "")
                {
                    if (pay3text1.Text.Length == 8)//輸入數字8碼自動轉換為日期
                    {
                        basedate = DateTime.ParseExact(pay3text1.Text, "yyyyMMdd", null);
                    }
                    else
                    {
                        basedate = DateTime.Parse(pay3text1.Text);
                    }

                }
                //系統判斷是否當月結(目前採用)
                //判斷是否在月結日期之前
                if (basedate.Day <= int.Parse(monthdata3.Text))
                {

                }
                //判斷是否在月結日期之後
                else if (basedate.Day > int.Parse(monthdata3.Text))
                {
                    basedate = basedate.AddMonths(1);
                }
                //人工判斷是否當月結(目前不採用)
                //if (RadioButtonList6.SelectedItem.Text == "當月結")
                //{

                //}
                //else if (RadioButtonList6.SelectedItem.Text == "次月結")
                //{
                //    basedate = basedate.AddMonths(1);
                //}
                int plusmonth = int.Parse(monthdata2.Text);
                //獨立討論先計算月底付款的情況
                if (monthdata4.Text.Trim() == "31")
                {

                    //基礎日期加兩個月後，的上個月月底為付款日
                    basedate = basedate.AddMonths(plusmonth + 1).AddDays(-1 * (basedate.Day));

                }
                //非月底付款狀況，大部分為5,10,15號
                else
                {
                    int day1 = 1 - basedate.Date.Day;
                    basedate = basedate.AddDays(day1);
                    //月結N天
                    basedate = basedate.AddMonths(plusmonth);
                    //有固定付款日

                    int day2 = int.Parse(monthdata4.Text) - basedate.Date.Day;
                    basedate = basedate.AddDays(day2);


                    //int day1 = 1 - basedate.Date.Day;
                    //basedate = basedate.AddDays(day1);
                    ////月結N天
                    //basedate = basedate.AddDays(int.Parse(monthdata2.Text));
                    ////若有固定結帳日
                    //if (int.Parse(monthdata4.Text) > 0)
                    //{
                    //    int day2 = int.Parse(monthdata4.Text) - basedate.Date.Day;
                    //    basedate = basedate.AddDays(day2);
                    //}
                    ////變動結帳日
                    //else if (int.Parse(monthdata4.Text) == 0)
                    //{
                    //    //不變
                    //}
                }
                //***********************************************************************************
                //判斷付款日是否遇假日順延或提前
                //DateTime newdate = basedate;
                //string supid = DropDownList3.SelectedItem.Value;


                //***********************************************************************************
                //判斷付款日是否遇假日順延或提前  --modify by Arno  20170830
                DateTime newdate = basedate;
                string supid = DropDownList3.SelectedItem.Value.Trim();
                newdate = newpaydate(supid, newdate, strConn);


                //
                //***********************************************************************************
                //paydetail(僅線資料庫記錄、未呈現再表單)
                //string detail = pay2text6.Text + "/" + pay2text8.Text + "/" + pay2text10.Text + "/" + pay2text12.Text + "/" + pay2text14.Text + "/" + pay2text16.Text;
                string strCmd, strCmd2;

                strCmd = "Insert into TB_Payment(id,date,formtype,payment,paymentdetail,emp_no,emp_cne,department,signtype,paytype,paymethod,paydate,payexchange,paycharge,PS,target,targetbank,nextmonth,curr_k,swiftcode,bas2001,ac_no,acne,acct_type,PAY_NO,paydateRAW)values(@id,@date,@formtype,@payment,@paymentdetail,@emp_no,@emp_cne,@department,@signtype,@paytype,@paymethod,@paydate,@payexchange,@paycharge,@PS,@target,@targetbank,@nextmonth,@curr_k,@swiftcode,@bas2001,@ac_no,@acne,@acct_type,@PAY_NO,@paydateRAW)";
                strCmd2 = "Insert into TB_Paymentdetail(paymentid,dept_no,dept_cne,comment,payment)values(@paymentid,@dept_no,@dept_cne,@comment,@payment)";
                //將所有單身金額textbox值輸入到資料庫
                DropDownList[] dept = { pay3drop1, pay3drop2, pay3drop3, pay3drop4, pay3drop5, pay3drop6, pay3drop7, pay3drop8, pay3drop9, pay3drop10 };
                TextBox[] pay = { pay3text3, pay3text5, pay3text7, pay3text9, pay3text11, pay3text13, pay3text15, pay3text17, pay3text19, pay3text21 };
                TextBox[] pay2 = { pay3text4, pay3text6, pay3text8, pay3text10, pay3text12, pay3text14, pay3text16, pay3text18, pay3text20, pay3text22 }; //put all into this array




                using (SqlCommand cmd = new SqlCommand(strCmd, conn))
                {
                    cmd.Parameters.AddWithValue("@id", newno);
                    cmd.Parameters.AddWithValue("@date", signdate);
                    cmd.Parameters.AddWithValue("@formtype", RadioButtonList1.SelectedItem.Text);
                    cmd.Parameters.AddWithValue("@payment", totalmoney);
                    cmd.Parameters.AddWithValue("@paymentdetail", "");
                    cmd.Parameters.AddWithValue("@emp_no", User.Identity.Name.ToString());
                    cmd.Parameters.AddWithValue("@emp_cne", GridView1.Rows[0].Cells[1].Text);
                    cmd.Parameters.AddWithValue("@department", GridView1.Rows[0].Cells[2].Text);
                    cmd.Parameters.AddWithValue("@signtype", signtype);
                    cmd.Parameters.AddWithValue("@paytype", DropDownList2.SelectedItem.Text);
                    cmd.Parameters.AddWithValue("@paymethod", RadioButtonList4.SelectedItem.Text);
                    cmd.Parameters.AddWithValue("@payexchange", RadioButtonList5.SelectedItem.Text);
                    cmd.Parameters.AddWithValue("@paycharge", sendcharge);
                    cmd.Parameters.AddWithValue("@paydateRAW", basedate);
                    cmd.Parameters.AddWithValue("@paydate", newdate);
                    cmd.Parameters.AddWithValue("@PS", pay3text2.Text);
                    cmd.Parameters.AddWithValue("@target", DropDownList3.SelectedItem.Text);
                    //cmd.Parameters.AddWithValue("@targetbank", DropDownList4.SelectedItem.Text);
                    cmd.Parameters.AddWithValue("@targetbank", pay3textbank.Text);
                    cmd.Parameters.AddWithValue("@nextmonth", RadioButtonList6.SelectedItem.Text);
                    cmd.Parameters.AddWithValue("@curr_k", Label6.Text);
                    cmd.Parameters.AddWithValue("@swiftcode", Label7.Text);
                    cmd.Parameters.AddWithValue("@bas2001", Label7b.Text);
                    cmd.Parameters.AddWithValue("@ac_no", Label8.Text);
                    cmd.Parameters.AddWithValue("@acne", Label9.Text);
                    cmd.Parameters.AddWithValue("@acct_type", Label10.Text);
                    cmd.Parameters.AddWithValue("@PAY_NO", DropDownList3.SelectedItem.Value);

                    string message = "";

                    try
                    {
                        conn.Open();
                        cmd.ExecuteNonQuery();
                        message = "申請成功";

                    }
                    catch (Exception ex)
                    {
                        message = ex.Message;
                    }
                    finally
                    {
                        conn.Close();
                        string strJS = "alert('" + message + "');location.href = ('PayPrint2.aspx?pid=" + newno + "&user=" + GridView1.Rows[0].Cells[1].Text + "');";
                        Page.ClientScript.RegisterStartupScript(this.GetType(), "", strJS, true);

                    }


                }
                for (int i = 0; i < pay2.Length; i++)
                {
                    if (dept[i].SelectedValue == "0" && pay[i].Text == "" && pay2[i].Text == "")
                    {
                        //不匯入資料庫
                    }
                    else
                    {
                        using (SqlCommand cmd = new SqlCommand(strCmd2, conn))
                        {
                            cmd.Parameters.AddWithValue("@paymentid", newno);
                            cmd.Parameters.AddWithValue("@dept_no", dept[i].SelectedValue);
                            cmd.Parameters.AddWithValue("@dept_cne", dept[i].SelectedItem.Text);
                            cmd.Parameters.AddWithValue("@comment", pay[i].Text);
                            cmd.Parameters.AddWithValue("@payment", pay2[i].Text);

                            string message = "";

                            try
                            {
                                conn.Open();
                                cmd.ExecuteNonQuery();

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
            }
        }

        //add by arno 20170828

        //add end


        protected void RadioButtonList7_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (RadioButtonList7.SelectedValue == "1")
            {
                DropDownList5.Visible = true;
                pay2text1.Visible = false;
                pay2text2.Text = "";
                Label11.Text = "";
                TextBox2.Visible = true;            //廠商快搜值
                DropDownList6.Visible = false;
            }
            else
            {
                DropDownList5.Visible = false;
                pay2text1.Visible = true;
                Label18.Text = "";

                DropDownList6.Visible = true;
                pay2text2.Text = "";
                if (Label11.Text == "")
                {
                    Label11.Text = "NTD";
                }

                Label12.Text = "";
                Label12b.Text = "";
                Label13.Text = "";
                Label14.Text = "";
                Label15.Text = "";
                pay2drp2.Visible = false;
                pay2text2.Visible = true;
                TextBox2.Visible = false;            //廠商快搜值
                //Label16.Text = DropDownList5.SelectedValue.ToString().Trim();


            }
        }

        protected void DropDownList5_SelectedIndexChanged(object sender, EventArgs e)
        {
            string ID = DropDownList5.SelectedValue.ToString();
            JuicDao dao = new JuicDao("MENU");
            var Paydata = dao.GetPayData(ID);
            if (Paydata.Rows.Count > 0)
            {
                Label18.Text = Paydata.Rows[0]["pay_ne2"].ToString(); //廠商付款條件敘述
                if (Paydata.Rows[0]["PAY_NO"].ToString() == "030C")
                {
                    string message = "貨到付款30日，請使用者務必輸入付款日期！！";
                    string strJS = "alert('" + message + "');";
                    Page.ClientScript.RegisterStartupScript(this.GetType(), "", strJS, true);
                }
            }

            pay2text2.Text = "";
            Label11.Text = "";
            Label12.Text = "";
            Label12b.Text = "";
            Label13.Text = "";
            Label14.Text = "";
            Label15.Text = "";

            var Paybank = dao.GetPaybank(ID);
            if (Paybank.Rows.Count > 0)
            {
                if (Paybank.Rows.Count == 1)
                //Label5.Text = "幣別：" + Paybank.Rows[0]["curr_k"].ToString() + ",金融機構代號：" + Paybank.Rows[0]["swiftcode"].ToString() + Paybank.Rows[0]["bas2001"].ToString() + ",帳號：" + Paybank.Rows[0]["ac_no"].ToString() + ",戶名：" + Paybank.Rows[0]["acne"].ToString() + ",收費別：" + Paybank.Rows[0]["acct_type"].ToString();
                {
                    pay2text2.Text = Paybank.Rows[0]["b_ne"].ToString().Trim();
                    Label11.Text = Paybank.Rows[0]["curr_k"].ToString();
                    Label12.Text = Paybank.Rows[0]["swiftcode"].ToString();
                    Label12b.Text = Paybank.Rows[0]["bas2001"].ToString();
                    Label13.Text = Paybank.Rows[0]["ac_no"].ToString();
                    Label14.Text = Paybank.Rows[0]["acne"].ToString();
                    Label15.Text = Paybank.Rows[0]["acct_type"].ToString();
                    pay2drp2.Visible = false;
                    pay2text2.Visible = true;
                }
                else if (Paybank.Rows.Count > 1)
                {
                    pay2text2.Text = "";
                    Label11.Text = "";
                    Label12.Text = "";
                    Label12b.Text = "";
                    Label13.Text = "";
                    Label14.Text = "";
                    Label15.Text = "";
                    pay2drp2.Visible = true;
                    pay2text2.Visible = false;
                    Label16.Text = DropDownList5.SelectedValue.ToString().Trim();
                }

            }


        }

        protected void CheckBox1_CheckedChanged(object sender, EventArgs e)
        {
            if (CheckBox1.Checked)
            {
                Panel4.Visible = true;
                Panel5.Visible = false;
            }
            else
            {
                Panel4.Visible = false;
                Panel5.Visible = true;
            }
        }

        protected void pay2drp2_SelectedIndexChanged(object sender, EventArgs e)
        {
            string ac_no = pay2drp2.SelectedValue.ToString();
            JuicDao dao = new JuicDao("MENU");
            var Paybank = dao.GetPaybank2(ac_no);
            if (Paybank.Rows.Count > 0)
            {
                if (Paybank.Rows.Count == 1)
                //Label5.Text = "幣別：" + Paybank.Rows[0]["curr_k"].ToString() + ",金融機構代號：" + Paybank.Rows[0]["swiftcode"].ToString() + Paybank.Rows[0]["bas2001"].ToString() + ",帳號：" + Paybank.Rows[0]["ac_no"].ToString() + ",戶名：" + Paybank.Rows[0]["acne"].ToString() + ",收費別：" + Paybank.Rows[0]["acct_type"].ToString();
                {
                    pay2text2.Text = Paybank.Rows[0]["b_ne"].ToString().Trim();
                    Label11.Text = Paybank.Rows[0]["curr_k"].ToString();
                    Label12.Text = Paybank.Rows[0]["swiftcode"].ToString();
                    Label12b.Text = Paybank.Rows[0]["bas2001"].ToString();
                    Label13.Text = Paybank.Rows[0]["ac_no"].ToString();
                    Label14.Text = Paybank.Rows[0]["acne"].ToString();
                    Label15.Text = Paybank.Rows[0]["acct_type"].ToString();
                }
            }
            else
            {
                pay2text2.Text = "";
                Label11.Text = "";
                Label12.Text = "";
                Label12b.Text = "";
                Label13.Text = "";
                Label14.Text = "";
                Label15.Text = "";
            }
        }

        protected void pay3drpbank_SelectedIndexChanged(object sender, EventArgs e)
        {
            string ac_no = pay3drpbank.SelectedValue.ToString();

            JuicDao dao = new JuicDao("MENU");

            var Paybank = dao.GetPaybank2(ac_no);
            if (Paybank.Rows.Count > 0)
            {
                if (Paybank.Rows.Count == 1)
                {
                    //Label5.Text = "幣別：" + Paybank.Rows[0]["curr_k"].ToString() + ",金融機構代號：" + Paybank.Rows[0]["swiftcode"].ToString() + Paybank.Rows[0]["bas2001"].ToString() + ",帳號：" + Paybank.Rows[0]["ac_no"].ToString() + ",戶名：" + Paybank.Rows[0]["acne"].ToString() + ",收費別：" + Paybank.Rows[0]["acct_type"].ToString();
                    pay3textbank.Text = Paybank.Rows[0]["b_ne"].ToString().Trim();
                    Label6.Text = Paybank.Rows[0]["curr_k"].ToString();
                    Label7.Text = Paybank.Rows[0]["swiftcode"].ToString();
                    Label7b.Text = Paybank.Rows[0]["bas2001"].ToString();
                    Label8.Text = Paybank.Rows[0]["ac_no"].ToString();
                    Label9.Text = Paybank.Rows[0]["acne"].ToString();
                    Label10.Text = Paybank.Rows[0]["acct_type"].ToString();
                }
            }
            else
            {
                pay3textbank.Text = "";
                Label6.Text = "";
                Label7.Text = "";
                Label7b.Text = "";
                Label8.Text = "";
                Label9.Text = "";
                Label10.Text = "";
            }
        }

        private DateTime newpaydate(string supid, DateTime newdate, string connstr)
        {
            using (SqlConnection payconn = new SqlConnection(connstr))
            {
                string Paycmd = "select d" + newdate.ToString("dd") + " from pay25 where yymm='" + newdate.ToString("yyyyMM") + "' and gpkd='0101'";
                SqlDataAdapter payda = new SqlDataAdapter(Paycmd, payconn);
                DataSet payds = new DataSet();
                payda.Fill(payds);
                if (payds.Tables[0].Rows.Count != 0)
                {
                    switch (payds.Tables[0].Rows[0][0].ToString())
                    {
                        case "1":
                            return newdate;
                            break;
                        case "0":
                        case "8":
                        case "9":
                            switch (supid)
                            {
                                case "S043":
                                case "S064":
                                    payconn.Close();
                                    return newpaydate(supid, newdate.AddDays(-1), connstr);
                                    break;
                                default:
                                    payconn.Close();
                                    return newpaydate(supid, newdate.AddDays(1), connstr);
                                    break;
                            }
                        default:
                            return newdate;
                            break;
                    }
                }
            }
            return newdate;
        }

        protected void DropDownList1_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

        protected void RadioButtonList2_SelectedIndexChanged(object sender, EventArgs e)
        {
            pay2text2.Text = "";
            Label11.Text = "";
            Label12.Text = "";
            Label12b.Text = "";
            Label13.Text = "";
            Label14.Text = "";
            Label15.Text = "";
            if (RadioButtonList2.SelectedValue != "匯款")
            {
                Panel6.Visible = false;
            }
            else
            {
                Panel6.Visible = true;
            }
        }

        protected void RadioButtonList4_SelectedIndexChanged(object sender, EventArgs e)
        {
            pay3textbank.Text = "";
            Label6.Text = "";
            Label7.Text = "";
            Label7b.Text = "";
            Label8.Text = "";
            Label9.Text = "";
            Label10.Text = "";
            if (RadioButtonList4.SelectedValue != "匯款")
            {
                Panel7.Visible = false;
            }
            else
            {
                Panel7.Visible = true;
            }

        }

        protected void DropDownList6_SelectedIndexChanged(object sender, EventArgs e)
        {
            Label11.Text = DropDownList6.SelectedValue;
        }

        protected void TextBox1_TextChanged(object sender, EventArgs e)
        {
            string ID = TextBox1.Text;
            JuicDao dao = new JuicDao("MENU");
            var Paydata = dao.GetPayData(ID);
            if (Paydata.Rows.Count > 0)
            {
                Label18.Text = Paydata.Rows[0]["pay_ne2"].ToString(); //廠商付款條件敘述
                if (Paydata.Rows[0]["PAY_NO"].ToString() == "030C")
                {
                    string message = "貨到付款30日，請使用者務必輸入付款日期！！";
                    string strJS = "alert('" + message + "');";
                    Page.ClientScript.RegisterStartupScript(this.GetType(), "", strJS, true);
                }
            }

            pay2text2.Text = "";
            Label11.Text = "";
            Label12.Text = "";
            Label12b.Text = "";
            Label13.Text = "";
            Label14.Text = "";
            Label15.Text = "";

            var Paybank = dao.GetPaybank(ID);
            if (Paybank.Rows.Count > 0)
            {
                if (Paybank.Rows.Count == 1)
                //Label5.Text = "幣別：" + Paybank.Rows[0]["curr_k"].ToString() + ",金融機構代號：" + Paybank.Rows[0]["swiftcode"].ToString() + Paybank.Rows[0]["bas2001"].ToString() + ",帳號：" + Paybank.Rows[0]["ac_no"].ToString() + ",戶名：" + Paybank.Rows[0]["acne"].ToString() + ",收費別：" + Paybank.Rows[0]["acct_type"].ToString();
                {
                    pay2text2.Text = Paybank.Rows[0]["b_ne"].ToString().Trim();
                    Label11.Text = Paybank.Rows[0]["curr_k"].ToString();
                    Label12.Text = Paybank.Rows[0]["swiftcode"].ToString();
                    Label12b.Text = Paybank.Rows[0]["bas2001"].ToString();
                    Label13.Text = Paybank.Rows[0]["ac_no"].ToString();
                    Label14.Text = Paybank.Rows[0]["acne"].ToString();
                    Label15.Text = Paybank.Rows[0]["acct_type"].ToString();
                    pay2drp2.Visible = false;
                    pay2text2.Visible = true;
                }
                else if (Paybank.Rows.Count > 1)
                {
                    pay2text2.Text = "";
                    Label11.Text = "";
                    Label12.Text = "";
                    Label12b.Text = "";
                    Label13.Text = "";
                    Label14.Text = "";
                    Label15.Text = "";
                    pay2drp2.Visible = true;
                    pay2text2.Visible = false;
                    Label16.Text = DropDownList5.SelectedValue.ToString().Trim();
                }

            }
        }

        protected void Button6_Click(object sender, EventArgs e)
        {
            string strConn = ConfigurationManager.ConnectionStrings["MENU"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(strConn))
            {
                //獲取最新id
                string strCmdNO = "SELECT top 1 id FROM TB_Payallowance ORDER BY id DESC";
                SqlDataAdapter da = new SqlDataAdapter(strCmdNO, conn);
                DataSet ds = new DataSet();
                da.Fill(ds);
                int newno = 0;
                if (ds.Tables[0].Rows.Count != 0)
                {
                    newno = int.Parse(ds.Tables[0].Rows[0][0].ToString());
                    newno++;
                }
                string strCmd = "Insert into TB_Payallowance(id,dept_no,dept_cne,userid,username,payeeid,payeename,money,comment)values(@id,@dept_no,@dept_cne,@userid,@username,@payeeid,@payeename,@money,@comment)";

                int money = -1;
                int.TryParse(TextBoxlend1.Text, out money);
                if (money > 50000)
                {
                    Page.ClientScript.RegisterStartupScript(this.GetType(), "", "alert('金額不可超過五萬');", true);
                }
                else if (money <= 0)
                {
                    Page.ClientScript.RegisterStartupScript(this.GetType(), "", "alert('請輸入1~50000正整數');", true);
                    return;
                }


                using (SqlCommand cmd = new SqlCommand(strCmd, conn))
                {
                    cmd.Parameters.AddWithValue("@id", newno);
                    cmd.Parameters.AddWithValue("@dept_no", DropDownListlend1.SelectedValue);
                    cmd.Parameters.AddWithValue("@dept_cne", DropDownListlend1.SelectedItem.Text);
                    cmd.Parameters.AddWithValue("@userid", User.Identity.Name.ToString());
                    cmd.Parameters.AddWithValue("@username", GridView1.Rows[0].Cells[1].Text);
                    cmd.Parameters.AddWithValue("@payeeid", DropDownListlend2.SelectedValue);
                    cmd.Parameters.AddWithValue("@payeename", DropDownListlend2.SelectedItem.Text);
                    cmd.Parameters.AddWithValue("@money", money);
                    cmd.Parameters.AddWithValue("@comment", TextBoxlend2.Text);


                    string message = "";

                    try
                    {
                        conn.Open();
                        cmd.ExecuteNonQuery();
                        message = "申請成功";

                    }
                    catch (Exception ex)
                    {
                        message = ex.Message;

                    }
                    finally
                    {
                        conn.Close();
                        string strJS = "alert('" + message + "');location.href = ('PayPrint0.aspx?pid=" + newno + "');";
                        Page.ClientScript.RegisterStartupScript(this.GetType(), "", strJS, true);

                    }

                }

            }
        }

        protected void TextBox2_TextChanged(object sender, EventArgs e)
        {
            DB4Init();
        }
        protected void DB4Init()
        {
            DropDownList5.Items.Clear();      // 清除內容
            SqlDataSource4.SelectParameters.Clear();
            string SQLstr = " WHERE 1=1 and [PAY_F] <> 2";
            if (TextBox2.Text != "")
            {
                SQLstr = SQLstr + " AND ([SUP_NE2] LIKE '%' + @SUP_NE2 + '%')";
                //== 重點在此：參數必須寫在IF判別式這裡，不能一起寫在後面。==
                SqlDataSource4.SelectParameters.Add("SUP_NE2", TextBox2.Text);

            }
            SqlDataSource4.SelectCommand = @"SELECT [SUP_NO], (rtrim([SUP_NO])+' '+[SUP_NE2]) as [SUP_NE2]  
                                             FROM [chuck11paysupplier] "
                                            + SQLstr +
                                            "order by [SUP_NO]";

            DropDownList5.DataSourceID = "SqlDataSource4";
            DropDownList5.DataTextField = "SUP_NE2";
            DropDownList5.DataValueField = "SUP_NO";
            DropDownList5.DataBind();
            DropDownList5.Items.Add(new ListItem("請選擇", "0"));
            DropDownList5.SelectedValue = "0";
        }

        protected void DB2Init()
        {
            DropDownList3.Items.Clear();      // 清除內容
            SqlDataSource2.SelectParameters.Clear();
            string SQLstr = " WHERE 1=1 and [PAY_F] = 2";
            if (TextBox3.Text != "")
            {
                SQLstr = SQLstr + " AND ([SUP_NE2] LIKE '%' + @SUP_NE2 + '%')";
                //== 重點在此：參數必須寫在IF判別式這裡，不能一起寫在後面。==
                SqlDataSource2.SelectParameters.Add("SUP_NE2", TextBox3.Text);

            }
            SqlDataSource2.SelectCommand = @"SELECT [SUP_NO], (rtrim([SUP_NO])+' '+[SUP_NE2]) as [SUP_NE2]  
                                             FROM [chuck11paysupplier] "
                                            + SQLstr +
                                            "order by [SUP_NO]";

            DropDownList3.DataSourceID = "SqlDataSource2";
            DropDownList3.DataTextField = "SUP_NE2";
            DropDownList3.DataValueField = "SUP_NO";
            DropDownList3.DataBind();
            DropDownList3.Items.Add(new ListItem("請選擇", "0"));
            DropDownList3.SelectedValue = "0";
        }

        protected void TextBox3_TextChanged(object sender, EventArgs e)
        {
            DB2Init();
        }

        protected void SqlDataSource3_Selecting(object sender, SqlDataSourceSelectingEventArgs e)
        {
            string strConn = ConfigurationManager.ConnectionStrings["MENU"].ConnectionString;
            string orderstring = "";
            using (SqlConnection conn = new SqlConnection(strConn))
            {
                string strCmdNO = "SELECT orderstring FROM TB_Orderstring where tablename='TB_PayDeptList'";
                SqlDataAdapter da = new SqlDataAdapter(strCmdNO, conn);
                DataSet ds = new DataSet();
                da.Fill(ds);
                
                if (ds.Tables[0].Rows.Count != 0)
                {
                    orderstring = (ds.Tables[0].Rows[0][0].ToString());
                }
            }
            e.Command.CommandText = @"SELECT [DEPA_NE2], [DEPA_NO] 
                                    FROM [TB_PayDeptList] 
                                    order by 
                                    charindex(rtrim(DEPA_NO),'"
                                    + orderstring +
                                    "')";
        }
    }
}
