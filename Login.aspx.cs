using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace JuicERP
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void Login1_Authenticate(object sender, AuthenticateEventArgs e)
        {
            bool authenticated = CheckLogin(Login1.UserName.Trim(), Login1.Password.Trim());
            if (authenticated)
            {
                e.Authenticated = true;
            }
            else
            {
                Login1.FailureText = "登入失敗!";
            }


        }



        private bool CheckLogin(string userID, string password)
        {
            JuicERP.DAL.JuicDao dao = new DAL.JuicDao("MENU");
            try
            {
                var tb = dao.GetUser(userID);
                if (tb.Rows.Count > 0)
                {
                    return Decrypt(Convert.ToString(tb.Rows[0]["Password"]).Trim()) == password;
                }
                else
                {
                    return false;
                }
            }
            finally
            {
                dao = null;
            }

        }

        int[] p = { 173, 31, 59, 53, 227, 11, 301, 403, 143 };
        int[] s = { 5, 7, 11, 53, 59, 59, 61, 67, 71 };
        int counts = 9;
        int cjh = 259;
        private string Encrypt(string plainText)
        {
            DateTime now = DateTime.Now;
            int key = (now.Minute * now.Second) % counts;
            string k0 = key.ToString();
            int ste = (now.Minute * now.Second) % 5;
            string s0 = ste.ToString();
            string encryptText = "";
            foreach (char c in plainText)
            {
                int v = (int)c;
                v = ModOfPower(v, p[key], cjh);
                encryptText += v.ToString().Length.ToString() + v.ToString();
                key = (key + ste) % counts;
            }
            return k0 + s0 + encryptText;
        }

        private string Decrypt(string encodedText)
        {
            int k0 = encodedText[0] - '0';
            int s0 = encodedText[1] - '0';
            int key = k0;
            int ste = s0;
            string encryptText = encodedText.Substring(2);
            string plainText = "";
            int cIdx = 0;
            while (cIdx < encryptText.Length - 1)
            {
                int chrLength = encryptText[cIdx] - '0';
                cIdx++;
                int v = Convert.ToInt32(encryptText.Substring(cIdx, chrLength));
                cIdx += chrLength;
                v = ModOfPower(v, s[key], cjh);
                plainText += (char)v;
                key = (key + ste) % counts;
            }
            return plainText;
        }

        private int ModOfPower(int x, int pow, int mod)
        {
            int value = 1;
            for (int i = 0; i < pow; i++)
            {
                value = (value * x) % mod;
            }
            return value;
        }
    }
}
