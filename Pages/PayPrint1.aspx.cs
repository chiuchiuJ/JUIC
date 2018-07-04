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
    public partial class PayPrint1 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            //string strConn = ConfigurationManager.ConnectionStrings["MENU"].ConnectionString;

            //using (SqlConnection conn = new SqlConnection(strConn))
            //{
            //    //獲取最新NO
            //    string strCmdNO = "SELECT top 1 NO FROM TB_MISservice ORDER BY NO DESC";
            //    SqlDataAdapter da = new SqlDataAdapter(strCmdNO, conn);
            //    DataSet ds = new DataSet();
            //    da.Fill(ds);
            //    int newno = 0;
            //    if (ds.Tables[0].Rows.Count != 0)
            //    {
            //        newno = int.Parse(ds.Tables[0].Rows[0][0].ToString());
            //        newno++;
            //    }
            //}
            string ID = Request.QueryString["pid"].ToString();
            JuicDao dao = new JuicDao("MENU");
            //取得單身資料
            var PayDetail = dao.GetPayDetail(ID);
            string comment = "";
            string dept = "";
            if (PayDetail.Rows.Count == 1)
            {
                dept = PayDetail.Rows[0]["dept_cne"].ToString();
                comment = PayDetail.Rows[0]["comment"].ToString();
            }
            else if (PayDetail.Rows.Count > 1)
            {

                for (int i = 0; i < PayDetail.Rows.Count; i++)
                {
                    dept += (i + 1).ToString() + "." + PayDetail.Rows[i]["dept_cne"].ToString() + " ";
                    comment += (i + 1).ToString() + "." + PayDetail.Rows[i]["comment"].ToString() + " " + decimal.Parse(PayDetail.Rows[i]["payment"].ToString()).ToString("N0") + "元； ";

                }
                //if (PayDetail.Rows.Count > 0)
                //{
                //    dept += "1."+PayDetail.Rows[0]["dept_cne"].ToString()+" ";
                //    comment += "1."+PayDetail.Rows[0]["comment"].ToString()+" "+ int.Parse(PayDetail.Rows[0]["payment"].ToString()).ToString("N0")+"元； ";
                //}
                //if (PayDetail.Rows.Count > 1)
                //{
                //    dept += "1." + PayDetail.Rows[0]["dept_cne"].ToString() + " ";
                //    comment += "1." + PayDetail.Rows[0]["comment"].ToString() + " " + int.Parse(PayDetail.Rows[0]["payment"].ToString()).ToString("N0") + "元； ";
                //}

                //if (PayDetail.Rows.Count > 2)
                //{
                //    labpaydept3.Text = PayDetail.Rows[2]["dept_cne"].ToString();
                //    labpay3.Text = PayDetail.Rows[2]["comment"].ToString();
                //    labpayment3.Text = int.Parse(PayDetail.Rows[2]["payment"].ToString()).ToString("N0");
                //}
                //if (PayDetail.Rows.Count > 3)
                //{
                //    labpaydept4.Text = PayDetail.Rows[3]["dept_cne"].ToString();
                //    labpay4.Text = PayDetail.Rows[3]["comment"].ToString();
                //    labpayment4.Text = int.Parse(PayDetail.Rows[3]["payment"].ToString()).ToString("N0");
                //}
                //if (PayDetail.Rows.Count > 4)
                //{
                //    labpaydept5.Text = PayDetail.Rows[4]["dept_cne"].ToString();
                //    labpay5.Text = PayDetail.Rows[4]["comment"].ToString();
                //    labpayment5.Text = int.Parse(PayDetail.Rows[4]["payment"].ToString()).ToString("N0");
                //}
                //if (PayDetail.Rows.Count > 5)
                //{
                //    labpaydept6.Text = PayDetail.Rows[5]["dept_cne"].ToString();
                //    labpay6.Text = PayDetail.Rows[5]["comment"].ToString();
                //    labpayment6.Text = int.Parse(PayDetail.Rows[5]["payment"].ToString()).ToString("N0");
                //}
                //if (PayDetail.Rows.Count > 6)
                //{
                //    labpaydept7.Text = PayDetail.Rows[6]["dept_cne"].ToString();
                //    labpay7.Text = PayDetail.Rows[6]["comment"].ToString();
                //    labpayment7.Text = int.Parse(PayDetail.Rows[6]["payment"].ToString()).ToString("N0");
                //}
                //if (PayDetail.Rows.Count > 7)
                //{
                //    labpaydept8.Text = PayDetail.Rows[7]["dept_cne"].ToString();
                //    labpay8.Text = PayDetail.Rows[7]["comment"].ToString();
                //    labpayment8.Text = int.Parse(PayDetail.Rows[7]["payment"].ToString()).ToString("N0");
                //}
                //if (PayDetail.Rows.Count > 8)
                //{
                //    labpaydept9.Text = PayDetail.Rows[8]["dept_cne"].ToString();
                //    labpay9.Text = PayDetail.Rows[8]["comment"].ToString();
                //    labpayment9.Text = int.Parse(PayDetail.Rows[8]["payment"].ToString()).ToString("N0");
                //}
                //if (PayDetail.Rows.Count > 9)
                //{
                //    labpaydept10.Text = PayDetail.Rows[9]["dept_cne"].ToString();
                //    labpay10.Text = PayDetail.Rows[9]["comment"].ToString();
                //    labpayment10.Text = int.Parse(PayDetail.Rows[9]["payment"].ToString()).ToString("N0");
                //}
            }

            DateTime date = DateTime.Parse(DetailsView1.Rows[1].Cells[1].Text);
            Label1.Text = date.Year.ToString() + "年" + date.Month.ToString() + "月" + date.Day.ToString() + "日";
            if (DetailsView1.Rows[5].Cells[1].Text == "a1")
            {
                Label2.Text = "副總經理(處級)(決)：　　　　　　部級主管(審)：　　　　　　　申請人：　　　　　　　";
            }
            else if (DetailsView1.Rows[5].Cells[1].Text == "a2")
            {
                Label2.Text = "副總經理(決)：　　　　處級主管：　　　　部級主管(審)：　　　　申請人：　　　　　　";
            }
            comment = comment.Replace("\r\n", "<br>&nbsp;");
            Label4.Text = comment;/* DetailsView1.Rows[4].Cells[1].Text;*/
            Label5.Text = dept;/*DetailsView1.Rows[8].Cells[1].Text;*/
            Label6.Text = DetailsView1.Rows[3].Cells[1].Text;
        }
    }
}