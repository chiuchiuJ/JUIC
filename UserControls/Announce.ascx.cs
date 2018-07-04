using JuicERP.DAL;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace JuicERP.UserControls
{
    public partial class Announce : System.Web.UI.UserControl
    {
        protected void Page_Load(object sender, EventArgs e)//替BUTTON註冊關閉MODAL的功能
        {
            btnExit.OnClientClick = "CloseControl(\"" + this.Parent.FindControl("ModalPanel").ClientID + "\");  return false;";
        }

        public void SetDbName(string dbName)
        {
            Annname.Value = dbName;
        }
        public void gettitle(string title) //獲取母網頁傳出的文字資訊
        {
            Label1.Text = title;
        }
        public void getcontent(string content)//獲取母網頁傳出的文字資訊
        {
            //TextBox1.Text = content;

            if (content == "")
            {
                TextBox1.Text = "GG";
            }

            else
            {
                TextBox1.Text = content;
            }

            //TableCell cell1 = new TableCell();
            //cell1.Text = TextBox1.Text;
            //Table1.Rows[0].Cells.Add(cell1);
        }
        public void getpostdate(string postdate) //獲取母網頁傳出的時間資訊
        {
            DateTime starttime = DateTime.Parse(postdate);
            Label2.Text = "公告日期：" + starttime.ToString("yyyy/MM/dd");

            //Label2.Text = "公告日期："+postdate.Substring(0,10);
        }
        public void getdept(string dept)//獲取母網頁傳出的文字資訊
        {
            Label3.Text = "公告部門：" + dept;
        }
        public void getauthor(string author)//獲取母網頁傳出的文字資訊
        {
            Label4.Text = "作　　者：" + author;
            //獲取母網頁傳出的文字資訊

        }
        public void getattachment(string attachment)//獲取母網頁傳出的文字資訊
        {
            JuicDao dao = new JuicDao("MENU");
            //刪除資料夾內檔案
            var MISupload = dao.GetANNupload(attachment);
            if (MISupload.Rows.Count > 0)
            {
                if (MISupload.Rows[0]["pdfurl"].ToString() != "")
                {
                    string p_FilePath = MISupload.Rows[0]["pdfurl"].ToString();
                    HyperLink1.Visible = true;
                    HyperLink1.NavigateUrl = p_FilePath;
                }
                else
                {
                    HyperLink1.Visible = false;
                }

            }
            //獲取母網頁傳出的文字資訊

        }
    }
}