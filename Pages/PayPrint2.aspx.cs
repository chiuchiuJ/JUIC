using JuicERP.DAL;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace JuicERP.Pages
{
    public partial class PayPrint2 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string ID = Request.QueryString["pid"].ToString();
            JuicDao dao = new JuicDao("MENU");
            //取得單身資料

            //取得單頭資料
            var Payhead = dao.GetPayhead(ID);

            DateTime date = DateTime.Parse(Payhead.Rows[0]["createdate"].ToString());
            Label1.Text = date.Year.ToString() + "年" + date.Month.ToString() + "月" + date.Day.ToString() + "日";

            Label3.Text = Payhead.Rows[0]["target"].ToString();
            Label22.Text = Payhead.Rows[0]["targetbank"].ToString() + "   (" + Payhead.Rows[0]["swiftcode"].ToString() + Payhead.Rows[0]["bas2001"].ToString() + ") " + Payhead.Rows[0]["ac_no"].ToString();

            //以NTD判斷是否金額需顯示小數點後兩位
            if (Payhead.Rows[0]["curr_k"].ToString().Trim() == "NTD")
            {
                Label25.Text = decimal.Parse(Payhead.Rows[0]["payment"].ToString()).ToString("N0");
            }
            else
            {
                Label25.Text = decimal.Parse(Payhead.Rows[0]["payment"].ToString()).ToString("N2");
            }




            Label20.Text = Payhead.Rows[0]["PS"].ToString();
            if (Payhead.Rows[0]["formtype"].ToString().Trim() == "請款單(非月結)")
            {
                Label26.Text = "非月結單";
            }
            else if (Payhead.Rows[0]["formtype"].ToString().Trim() == "請款單(月結)")
            {
                Label26.Text = "月結單";
            }
            Label27.Text = "項目：" + Payhead.Rows[0]["paytype"].ToString();

            //追加匯費備註
            //if (Payhead.Rows[0]["payexchange"].ToString().Trim() == "外加")
            //{
            //    Label20b.Text = "匯費:" + Payhead.Rows[0]["paycharge"].ToString();
            //}
            //追加幣別備註
            Label20a.Text = "幣別:" + Payhead.Rows[0]["curr_k"].ToString();

            Label19.Text = DateTime.Parse(Payhead.Rows[0]["paydate"].ToString()).ToShortDateString();


            Label23.Text = Payhead.Rows[0]["paymethod"].ToString();
            //判斷匯費是外加還是內涵
            Label24.Text = Payhead.Rows[0]["payexchange"].ToString();
            //1070704;04794; 修改若無匯款費用 不顯示
            if (Payhead.Rows[0]["payexchange"].ToString().Trim() == "外加" && decimal.Parse(Payhead.Rows[0]["paycharge"].ToString())!=0)
            {
                labpay11.Text = "&nbsp;" + "匯款費用";
                labpayment11.Text = Payhead.Rows[0]["paycharge"].ToString() + "&nbsp;" ;
            }

            //取得請款細項
            var PayDetail = dao.GetPayDetail(ID);

            //判斷是否是總經理室請款特別條款1
            string bossmethod = "0";
            if (Payhead.Rows[0]["paytype"].ToString().Trim() == "員工報支" || Payhead.Rows[0]["paytype"].ToString().Trim() == "旅費報銷" || Payhead.Rows[0]["paytype"].ToString().Trim() == "交際費")
            {
                bossmethod = "1";
            }

            string user = Request.QueryString["user"].ToString();
            var userid = User.Identity.Name.ToString();
            string spmethod = "";
            /*20180504;jesse;新增特殊需求(kelly) 
            1.支付種類項目:一般費用報支
            2.支付對象:個人  湯董或是蕭副總
            3.知識平台登入者為kelly 或是marina
             */
            if (userid == "04753" || userid == "04787")
            {
                if (Payhead.Rows[0]["paytype"].ToString().Trim() == "一般費用報支(含預付/暫付)" && (Payhead.Rows[0]["target"].ToString().Trim() == "湯慧芳" || Payhead.Rows[0]["target"].ToString().Trim() == "蕭慶明"))
                {
                    spmethod = "1";
                }

            }

            if (PayDetail.Rows.Count > 0)
            {
                //判斷是否為總經理室請款特別條款2
                for (int i = 0; i < PayDetail.Rows.Count; i++)
                {
                    if (PayDetail.Rows[i]["dept_no"].ToString().Trim() == "T1010" && bossmethod == "1")
                    {
                        bossmethod = "2";
                    }
                }

                //如果是台幣則不顯示小數點後兩位
                if (Payhead.Rows[0]["curr_k"].ToString().Trim() == "NTD")
                {
                    if (PayDetail.Rows.Count > 0)
                    {
                        labpaydept1.Text = PayDetail.Rows[0]["dept_cne"].ToString();
                        labpay1.Text = "&nbsp;" + PayDetail.Rows[0]["comment"].ToString();
                        labpayment1.Text = decimal.Parse(PayDetail.Rows[0]["payment"].ToString()).ToString("N0") + "&nbsp;";
                    }
                    if (PayDetail.Rows.Count > 1)
                    {
                        labpaydept2.Text = PayDetail.Rows[1]["dept_cne"].ToString();
                        labpay2.Text = "&nbsp;" + PayDetail.Rows[1]["comment"].ToString();
                        labpayment2.Text = decimal.Parse(PayDetail.Rows[1]["payment"].ToString()).ToString("N0") + "&nbsp;";
                    }

                    if (PayDetail.Rows.Count > 2)
                    {
                        labpaydept3.Text = PayDetail.Rows[2]["dept_cne"].ToString();
                        labpay3.Text = "&nbsp;" + PayDetail.Rows[2]["comment"].ToString();
                        labpayment3.Text = decimal.Parse(PayDetail.Rows[2]["payment"].ToString()).ToString("N0") + "&nbsp;";
                    }
                    if (PayDetail.Rows.Count > 3)
                    {
                        labpaydept4.Text = PayDetail.Rows[3]["dept_cne"].ToString();
                        labpay4.Text = "&nbsp;" + PayDetail.Rows[3]["comment"].ToString();
                        labpayment4.Text = decimal.Parse(PayDetail.Rows[3]["payment"].ToString()).ToString("N0") + "&nbsp;";
                    }
                    if (PayDetail.Rows.Count > 4)
                    {
                        labpaydept5.Text = PayDetail.Rows[4]["dept_cne"].ToString();
                        labpay5.Text = "&nbsp;" + PayDetail.Rows[4]["comment"].ToString();
                        labpayment5.Text = decimal.Parse(PayDetail.Rows[4]["payment"].ToString()).ToString("N0") + "&nbsp;";
                    }
                    if (PayDetail.Rows.Count > 5)
                    {
                        labpaydept6.Text = PayDetail.Rows[5]["dept_cne"].ToString();
                        labpay6.Text = "&nbsp;" + PayDetail.Rows[5]["comment"].ToString();
                        labpayment6.Text = decimal.Parse(PayDetail.Rows[5]["payment"].ToString()).ToString("N0") + "&nbsp;";
                    }
                    if (PayDetail.Rows.Count > 6)
                    {
                        labpaydept7.Text = PayDetail.Rows[6]["dept_cne"].ToString();
                        labpay7.Text = "&nbsp;" + PayDetail.Rows[6]["comment"].ToString();
                        labpayment7.Text = decimal.Parse(PayDetail.Rows[6]["payment"].ToString()).ToString("N0") + "&nbsp;";
                    }
                    if (PayDetail.Rows.Count > 7)
                    {
                        labpaydept8.Text = PayDetail.Rows[7]["dept_cne"].ToString();
                        labpay8.Text = "&nbsp;" + PayDetail.Rows[7]["comment"].ToString();
                        labpayment8.Text = decimal.Parse(PayDetail.Rows[7]["payment"].ToString()).ToString("N0") + "&nbsp;";
                    }
                    if (PayDetail.Rows.Count > 8)
                    {
                        labpaydept9.Text = PayDetail.Rows[8]["dept_cne"].ToString();
                        labpay9.Text = "&nbsp;" + PayDetail.Rows[8]["comment"].ToString();
                        labpayment9.Text = decimal.Parse(PayDetail.Rows[8]["payment"].ToString()).ToString("N0") + "&nbsp;";
                    }
                    if (PayDetail.Rows.Count > 9)
                    {
                        labpaydept10.Text = PayDetail.Rows[9]["dept_cne"].ToString();
                        labpay10.Text = "&nbsp;" + PayDetail.Rows[9]["comment"].ToString();
                        labpayment10.Text = decimal.Parse(PayDetail.Rows[9]["payment"].ToString()).ToString("N0") + "&nbsp;";
                    }
                }
                else
                {
                    if (PayDetail.Rows.Count > 0)
                    {
                        labpaydept1.Text = PayDetail.Rows[0]["dept_cne"].ToString();
                        labpay1.Text = "&nbsp;" + PayDetail.Rows[0]["comment"].ToString();
                        labpayment1.Text = decimal.Parse(PayDetail.Rows[0]["payment"].ToString()).ToString("N2") + "&nbsp;";
                    }
                    if (PayDetail.Rows.Count > 1)
                    {
                        labpaydept2.Text = PayDetail.Rows[1]["dept_cne"].ToString();
                        labpay2.Text = "&nbsp;" + PayDetail.Rows[1]["comment"].ToString();
                        labpayment2.Text = decimal.Parse(PayDetail.Rows[1]["payment"].ToString()).ToString("N2") + "&nbsp;";
                    }

                    if (PayDetail.Rows.Count > 2)
                    {
                        labpaydept3.Text = PayDetail.Rows[2]["dept_cne"].ToString();
                        labpay3.Text = "&nbsp;" + PayDetail.Rows[2]["comment"].ToString();
                        labpayment3.Text = decimal.Parse(PayDetail.Rows[2]["payment"].ToString()).ToString("N2") + "&nbsp;";
                    }
                    if (PayDetail.Rows.Count > 3)
                    {
                        labpaydept4.Text = PayDetail.Rows[3]["dept_cne"].ToString();
                        labpay4.Text = "&nbsp;" + PayDetail.Rows[3]["comment"].ToString();
                        labpayment4.Text = decimal.Parse(PayDetail.Rows[3]["payment"].ToString()).ToString("N2") + "&nbsp;";
                    }
                    if (PayDetail.Rows.Count > 4)
                    {
                        labpaydept5.Text = PayDetail.Rows[4]["dept_cne"].ToString();
                        labpay5.Text = "&nbsp;" + PayDetail.Rows[4]["comment"].ToString();
                        labpayment5.Text = decimal.Parse(PayDetail.Rows[4]["payment"].ToString()).ToString("N2") + "&nbsp;";
                    }
                    if (PayDetail.Rows.Count > 5)
                    {
                        labpaydept6.Text = PayDetail.Rows[5]["dept_cne"].ToString();
                        labpay6.Text = "&nbsp;" + PayDetail.Rows[5]["comment"].ToString();
                        labpayment6.Text = decimal.Parse(PayDetail.Rows[5]["payment"].ToString()).ToString("N2") + "&nbsp;";
                    }
                    if (PayDetail.Rows.Count > 6)
                    {
                        labpaydept7.Text = PayDetail.Rows[6]["dept_cne"].ToString();
                        labpay7.Text = "&nbsp;" + PayDetail.Rows[6]["comment"].ToString();
                        labpayment7.Text = decimal.Parse(PayDetail.Rows[6]["payment"].ToString()).ToString("N2") + "&nbsp;";
                    }
                    if (PayDetail.Rows.Count > 7)
                    {
                        labpaydept8.Text = PayDetail.Rows[7]["dept_cne"].ToString();
                        labpay8.Text = "&nbsp;" + PayDetail.Rows[7]["comment"].ToString();
                        labpayment8.Text = decimal.Parse(PayDetail.Rows[7]["payment"].ToString()).ToString("N2") + "&nbsp;";
                    }
                    if (PayDetail.Rows.Count > 8)
                    {
                        labpaydept9.Text = PayDetail.Rows[8]["dept_cne"].ToString();
                        labpay9.Text = "&nbsp;" + PayDetail.Rows[8]["comment"].ToString();
                        labpayment9.Text = decimal.Parse(PayDetail.Rows[8]["payment"].ToString()).ToString("N2") + "&nbsp;";
                    }
                    if (PayDetail.Rows.Count > 9)
                    {
                        labpaydept10.Text = PayDetail.Rows[9]["dept_cne"].ToString();
                        labpay10.Text = "&nbsp;" + PayDetail.Rows[9]["comment"].ToString();
                        labpayment10.Text = decimal.Parse(PayDetail.Rows[9]["payment"].ToString()).ToString("N2") + "&nbsp;";
                    }
                }

            }

            if (user == "戴上智")
            {
                if (Payhead.Rows[0]["signtype"].ToString() == "b1")
                {
                    Label21.Text = "董事長(決)：　　　　　　　　　　　　部級主管：　　　　　　　　　　　　申請人：＿＿＿＿＿＿＿＿";
                }
                else if (Payhead.Rows[0]["signtype"].ToString() == "b2")
                {
                    Label21.Text = "董事長(決)：　　　　　　　　處級主管：　　　　　　　部級主管：　　　　　　　申請人：＿＿＿＿＿＿";
                }
                else if (Payhead.Rows[0]["signtype"].ToString() == "b3")
                {
                    Label21.Text = "董事長(決)：　　　　　總經理：　　　　　處級主管：　　　　　部級主管：　　　　　申請人：＿＿＿＿";
                }
                else if (Payhead.Rows[0]["signtype"].ToString() == "b4")
                {
                    Label21.Text = "董事長(決)：　　　　　　　　　　　　部級主管：　　　　　　　　　　　　申請人：＿＿＿＿＿＿＿＿";
                }
                else if (Payhead.Rows[0]["signtype"].ToString() == "b5")
                {
                    Label21.Text = "董事長(決)：　　　　　　　　處級主管：　　　　　　　部級主管：　　　　　　　申請人：＿＿＿＿＿＿";
                }
                else if (Payhead.Rows[0]["signtype"].ToString() == "b6")
                {
                    Label21.Text = "董事長(決)：　　　　　總經理：　　　　　處級主管：　　　　　部級主管：　　　　　申請人：＿＿＿＿";
                }
                else if (Payhead.Rows[0]["signtype"].ToString() == "b7")
                {
                    Label21.Text = "董事長(決)：　　　　　　　　　　　　部級主管：　　　　　　　　　　　　申請人：＿＿＿＿＿＿＿＿";
                }
                else if (Payhead.Rows[0]["signtype"].ToString() == "b8")
                {
                    Label21.Text = "董事長(決)：　　　　　　　　處級主管：　　　　　　　部級主管：　　　　　　　申請人：＿＿＿＿＿＿";
                }
                else if (Payhead.Rows[0]["signtype"].ToString() == "b9")
                {
                    Label21.Text = "董事長(決)：　　　　　總經理：　　　　　處級主管：　　　　　部級主管：　　　　　申請人：　　　　";
                }
                else if (Payhead.Rows[0]["signtype"].ToString() == "b10")
                {
                    Label21.Text = "董事長(決)：　　　　　　　　處級主管：　　　　　　　部級主管：　　　　　　　申請人：　　　　　　";
                }
                else if (Payhead.Rows[0]["signtype"].ToString() == "b11")
                {
                    Label21.Text = "董事長(決)　　　　　　　　　　　　　　　　　　　　　申請人：　　　　　　　　　　　　　　　　　　";
                }
            }
            else if (bossmethod == "2")
            {
                Label21.Text = "董事長(決)：　　　　　　　　　　　　總經理：　　　　　　　　　　　　　申請人：　　　　　　　　";
            }
            else if (spmethod == "1")
            {
                Label21.Text = "董事長(決)　　　　　　　　　　　　　　　　　　　　　申請人：　　　　　　　　　　　　　　　　　　";
            }
            else
            {
                //20180514;04794;管理部要求就核決權限有總經理的都加上副總經理
                if (Payhead.Rows[0]["signtype"].ToString() == "b1")
                {
                    Label21.Text = "處級主管(決)：　　　　　　　　　　　　部級主管：　　　　　　　　　　　　申請人：　　　　　　　　";
                }
                else if (Payhead.Rows[0]["signtype"].ToString() == "b2")
                {
                    //Label21.Text = @"總經理(決)：　　　　　　　副總經理：　　　　　　　處級主管：　　　　　　　部級主管：　　　　　　<br><br>
　　　　　　　　　　　　　　　　　　　　//　　　　　　　　　　　　　　　　　申請人：　　　　　　　";
                    Label21.Text = "總經理(決)：　　　　　副總經理：　　　　　處級主管：　　　　　部級主管：　　　　　申請人：　　　　<br><br>";
                }
                else if (Payhead.Rows[0]["signtype"].ToString() == "b3")
                {
                    //Label21.Text = @"董事長(決)：　　　　　　　總經理：　　　　　　　副總經理：　　　　　　　處級主管：　　　　　　<br ><br>
                    //　　　　　　　　　　　　　　　　　　　　　　部級主管：　　　　　　　申請人：　　　　　";
                    Label21.Text = "董事長(決)：　　 　總經理：　　　 副總經理：　　 　處級主管：　 　　部級主管：　　 　申請人：　　　 <br><br>";

                }
                else if (Payhead.Rows[0]["signtype"].ToString() == "b4")
                {
                    Label21.Text = "處級主管(決)：　　　　　　　　　　　　部級主管：　　　　　　　　　　　　申請人：　　　　　　　　";
                }
                else if (Payhead.Rows[0]["signtype"].ToString() == "b5")
                {
                    Label21.Text = "總經理(決)：　　　　　副總經理：　　　　　處級主管：　　　　　部級主管：　　　　　申請人：　　　　<br><br>";
                }
                else if (Payhead.Rows[0]["signtype"].ToString() == "b6")
                {
                    Label21.Text = "總經理(決)：　　　　　副總經理：　　　　　處級主管：　　　　　部級主管：　　　　　申請人：　　　　<br><br>";
                }
                else if (Payhead.Rows[0]["signtype"].ToString() == "b7")
                {
                    Label21.Text = "處級主管(決)：　　　　　　　　　　　　部級主管：　　　　　　　　　　　　申請人：　　　　　　　　";
                }
                else if (Payhead.Rows[0]["signtype"].ToString() == "b8")
                {
                    Label21.Text = "總經理(決)：　　　　　副總經理：　　　　　處級主管：　　　　　部級主管：　　　　　申請人：　　　　<br><br>";
                }
                else if (Payhead.Rows[0]["signtype"].ToString() == "b9")
                {
                    Label21.Text = "董事長(決)：　　 　總經理：　　　 副總經理：　　 　處級主管：　 　　部級主管：　　 　申請人：　　　 <br><br>";
                }
                else if (Payhead.Rows[0]["signtype"].ToString() == "b10")
                {
                    Label21.Text = "處級主管(決)：　　　　　　　　　　　　部級主管：　　　　　　　　　　　　申請人：　　　　　　　　";
                }
                else if (Payhead.Rows[0]["signtype"].ToString() == "b11")
                {
                    Label21.Text = "部級主管(決)：　　　　　　　　　　　　　　　　　　　　　申請人：　　　　　　　　　　　　  　　　";
                }
            }

        }
    }
}