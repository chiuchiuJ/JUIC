using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Data.SqlClient;
using System.Collections;

namespace JuicERP.DAL
{
    public class JuicDao
    {
        private string connStr = "";
        private static int timeOutSec = 7200;


        private JuicDao()
        {

        }

        public JuicDao(string dbName)
        {
            this.connStr = System.Web.Configuration.WebConfigurationManager.ConnectionStrings[dbName].ConnectionString;
        }

        //獲得確認權限功能
        public DataTable checkcontrol(string userid, int ActNO)
        {
            string sql = "SELECT userid, ActNO FROM TB_UserActControl WHERE userid = @userid and ActNO=@ActNO";
            List<SqlParameter> paras = new List<SqlParameter>();
            paras.Add(new SqlParameter("userid", userid));
            paras.Add(new SqlParameter("ActNO", ActNO));
            return SqlSelect(sql, paras);
        }
        //取得員工個人資訊
        public DataTable getpay11info(string emp_no)
        {
            string sql = @"SELECT * FROM pay11 WHERE emp_no = @emp_no
                           union all
                           SELECT * FROM jutw.dbo.pay11 WHERE emp_no =@emp_no ";
            List<SqlParameter> paras = new List<SqlParameter>();
            paras.Add(new SqlParameter("emp_no", emp_no));
   
            return SqlSelect(sql, paras);
        }
        //備份三天前的所有會議室租借資料
        public DataTable BackupConferenceRent(DateTime endtime)
        {
            string sql = "INSERT  into TB_ConferenceDelData select * from [TB_Conference]  where endtime<@endtime";
            List<SqlParameter> paras = new List<SqlParameter>();
            paras.Add(new SqlParameter("endtime", endtime));

            return SqlSelect(sql, paras);
        }
        //刪除三天前的所有會議室租借資料
        public DataTable DeleteConferenceRent(DateTime endtime)
        {
            string sql = "Delete TB_Conference where endtime<@endtime";
            List<SqlParameter> paras = new List<SqlParameter>();
            paras.Add(new SqlParameter("endtime", endtime));

            return SqlSelect(sql, paras);
        }
        public DataTable GetMenus(int parentMenuId)
        {
            string sql = "SELECT [MenuId], [Title], [Description], [Url] FROM TB_Menus WHERE ParentMenuId = @ParentMenuId order by MenuId";
            List<SqlParameter> paras = new List<SqlParameter>();
            paras.Add(new SqlParameter("ParentMenuId", parentMenuId));
            return SqlSelect(sql, paras);
        }

        public DataTable GetMenusbycontrol(int parentMenuId, string userid)
        {


            string sql = "SELECT [MenuId], [Title], [Description], [Url] FROM chuckMenuControl WHERE ParentMenuId = @ParentMenuId and userid=@userid order by MenuId";
            List<SqlParameter> paras = new List<SqlParameter>();
            paras.Add(new SqlParameter("ParentMenuId", parentMenuId));
            paras.Add(new SqlParameter("userid", userid));
            return SqlSelect(sql, paras);
        }

        public DataTable GetWHQ(string jVendors, string jWareHouses, string jOutDateStart, string jOutDateEnd, int jDelayDateStart, int jDelayDateEnd, string jProdID, string jVProdID, string jSPEC)
        {
            string sql = "select * from VW_WHQ where 1 = 1 ";
            string cond = "";
            List<SqlParameter> paras = new List<SqlParameter>();
            if (false == string.IsNullOrEmpty(jVendors))
            {
                var vendors = jVendors.Split(';');
                cond += " and JVendor in ('' ";
                for (int i = 0; i < vendors.Length; i++)
                {
                    cond += ",@JVendor" + i;
                    paras.Add(new SqlParameter("JVendor" + i, vendors[i]));
                }
                cond += ")";
            }
            if (false == string.IsNullOrEmpty(jWareHouses))
            {
                var wareHouses = jWareHouses.Split(';');
                cond += " and JWareHouse in ('' ";
                for (int i = 0; i < wareHouses.Length; i++)
                {
                    cond += ",@JWareHouse" + i;
                    paras.Add(new SqlParameter("JWareHouse" + i, wareHouses[i]));
                }
                cond += ")";
            }
            if (false == string.IsNullOrEmpty(jOutDateStart) || false == string.IsNullOrEmpty(jOutDateEnd))
            {
                if (string.IsNullOrEmpty(jOutDateEnd))
                {
                    cond += " and JOutDate = @JOutDate ";
                    paras.Add(new SqlParameter("JOutDate", jOutDateStart));
                }
                else if (string.IsNullOrEmpty(jOutDateStart))
                {
                    cond += " and JOutDate = @JOutDate ";
                    paras.Add(new SqlParameter("JOutDate", jOutDateEnd));
                }
                else
                {
                    cond += " and JOutDate between @JOutDateStart and @JOutDateEnd ";
                    paras.Add(new SqlParameter("JOutDateStart", jOutDateStart));
                    paras.Add(new SqlParameter("JOutDateEnd", jOutDateEnd));
                }
            }
            if (jDelayDateStart > 0 || jDelayDateEnd > 0)
            {
                if (jDelayDateEnd == 0)
                {
                    cond += " and JDelayDate >= @JDelayDate ";
                    paras.Add(new SqlParameter("JDelayDate", jDelayDateStart));
                }
                else if (jDelayDateStart == 0)
                {
                    cond += " and JDelayDate <= @JDelayDate ";
                    paras.Add(new SqlParameter("JDelayDate", jDelayDateEnd));
                }
                else
                {
                    cond += " and JDelayDate between @JDelayDateStart and @JDelayDateEnd ";
                    paras.Add(new SqlParameter("JDelayDateStart", jDelayDateStart));
                    paras.Add(new SqlParameter("JDelayDateEnd", jDelayDateEnd));
                }
            }
            if (false == string.IsNullOrEmpty(jProdID))
            {
                cond += " and JProdID like @JProdID ";
                paras.Add(new SqlParameter("JProdID", "%" + jProdID + "%"));

            }
            if (false == string.IsNullOrEmpty(jVProdID))
            {
                cond += " and JVProdID like @JVProdID ";
                paras.Add(new SqlParameter("JVProdID", "%" + jVProdID + "%"));
            }
            if (false == string.IsNullOrEmpty(jSPEC))
            {
                cond += " and JSPEC like @JSPEC ";
                paras.Add(new SqlParameter("JSPEC", "%" + jSPEC + "%"));
            }

            return SqlSelect(sql + cond, paras);
        }

        //新增insert公告

        //public DataTable InsertAnn(DateTime postdate, string title, string dept, string author, string content, string pdfurl)
        //{
        //    string sql = "Insert into TB_AnnounceBeta(postdate,title,dept,author,content,pdfurl)values(@postdate,@title,@dept,@author,@content,@pdfurl)";
        //    string cond = "";
        //    List<SqlParameter> paras = new List<SqlParameter>();

        //    paras.Add(new SqlParameter("postdate", postdate));
        //    paras.Add(new SqlParameter("title", title));
        //    paras.Add(new SqlParameter("dept", dept));
        //    paras.Add(new SqlParameter("author", author));
        //    paras.Add(new SqlParameter("content", content));
        //    paras.Add(new SqlParameter("pdfurl", pdfurl));

        //    return SqlSelect(sql + cond, paras);
        //} 不太會寫ˊˋ

        public DataTable GetANN(string dept, string postdate, string title, string content, string author, string pdfurl)
        {
            string sql = "select * from TB_AnnounceBeta where 1 = 1 ";
            string cond = "";
            List<SqlParameter> paras = new List<SqlParameter>();

            return SqlSelect(sql + cond, paras);
        }

        public DataTable GetBIR(DateTime eventday)
        {
            string sql = "select top(1) CONVERT(varchar(12) , eventdate, 111 ) as eventdate,content,PS from TB_Birthdayevent where datediff(month,eventdate,@eventday)=0 order by ID desc";
            string cond = "";
            List<SqlParameter> paras = new List<SqlParameter>();
            paras.Add(new SqlParameter("eventday", eventday));
            return SqlSelect(sql + cond, paras);
        }

        public DataTable GetUsername(string userID)
        {
            string sql = "SELECT username FROM Bas03 WHERE UserID = @UserID";
            List<SqlParameter> paras = new List<SqlParameter>();
            paras.Add(new SqlParameter("UserID", userID));
            return SqlSelect(sql, paras);
        }
        public DataTable SignupTotalDetailid(string eventID,string emp_no)
        {
            string sql = "select id from TB_SignupTotal where eventID =@eventID and emp_no='@emp_no";
            List<SqlParameter> paras = new List<SqlParameter>();
            paras.Add(new SqlParameter("eventID", eventID));
            paras.Add(new SqlParameter("emp_no", emp_no));
            return SqlSelect(sql, paras);
        }
        public DataTable RemoveSignup(string id,string emp_no,string Totalid)
        {
            string sql = "delete TB_SignupList where id =@id; delete TB_SignupTotal where eventID = @id and emp_no = @emp_no; delete TB_SignupTotalDetail where[SignupTotalid] = @Totalid";
            List<SqlParameter> paras = new List<SqlParameter>();
            paras.Add(new SqlParameter("id", id));
            paras.Add(new SqlParameter("emp_no", emp_no));
            paras.Add(new SqlParameter("Totalid", Totalid));
            return SqlSelect(sql, paras);
        }
        //取得活動報名的序號，以輸入詳細人數資訊
        public DataTable GetSingupTotalid(string eventID, string emp_no)
        {
            string sql = "SELECT [ID] FROM TB_SignupTotal WHERE eventID=@eventID and emp_no = @emp_no";
            List<SqlParameter> paras = new List<SqlParameter>();
            paras.Add(new SqlParameter("eventID", eventID));
            paras.Add(new SqlParameter("emp_no", emp_no));
            return SqlSelect(sql, paras);
        }
        public DataTable GetAllJVendors()
        {
            string sql = "select distinct JVendor from VW_WHQ order by JVendor ";
            return SqlSelect(sql);
        }

        //CHUCK測試
        public DataTable GetAllcomCustomer()
        {
            string sql = "select FullName from comCustomer order by ID ";
            return SqlSelect(sql);
        }

        public DataTable GetAllJWareHouses()
        {
            string sql = "select distinct JWareHouse from VW_WHQ order by JWareHouse ";
            return SqlSelect(sql);
        }

        public DataTable GetUser(string userID)
        {
            string sql = "SELECT * FROM Bas03 WHERE UserID = @UserID";
            List<SqlParameter> paras = new List<SqlParameter>();
            paras.Add(new SqlParameter("UserID", userID));
            return SqlSelect(sql, paras);
        }
        //輸入表單辦法更新資料
        public DataTable InsertAnnFormInfo(string content,string date,string number,string version)
        {
            string sql = "insert into TB_AnnFormInfo (content,postdate,number,version) values (@content,@postdate,@number,@version)";
            List<SqlParameter> paras = new List<SqlParameter>();
            paras.Add(new SqlParameter("content", content));
            paras.Add(new SqlParameter("postdate", DateTime.Parse(date)));
            paras.Add(new SqlParameter("number", number));
            paras.Add(new SqlParameter("version", version));
            return SqlSelect(sql, paras);
        }
        //刪除表單辦法更新資料
        public DataTable DelAnnFormInfo(string ID)
        {
            string sql = "Delete TB_AnnFormInfo where ID=@ID";
            List<SqlParameter> paras = new List<SqlParameter>();
            paras.Add(new SqlParameter("ID", ID));
            return SqlSelect(sql, paras);
        }

        //會議室功能
        //使用者刪除錯誤的租借紀錄
        public DataTable conferdel(string ID)
        {
            string sql = "delete TB_Conference where ID=@ID";
            List<SqlParameter> paras = new List<SqlParameter>();
            paras.Add(new SqlParameter("ID", ID));
            return SqlSelect(sql, paras);
        }
        //提前歸還
        public DataTable conferback(string ID)
        {
            string sql = "update TB_Conference set endtime=@endtime where ID=@ID";
            List<SqlParameter> paras = new List<SqlParameter>();
            string datetime = DateTime.Now.ToString("yyyy/MM/dd HH:mm:ss");
            
            paras.Add(new SqlParameter("ID", ID));
            paras.Add(new SqlParameter("endtime", datetime));
            return SqlSelect(sql, paras);
        }

        //PAY取得供應商付款資料及月結資訊
        public DataTable GetPayData(string SUP_NO)
        {
            string sql = "SELECT  *  FROM chuck11paysupplier WHERE SUP_NO = @SUP_NO";
            List<SqlParameter> paras = new List<SqlParameter>();
            paras.Add(new SqlParameter("SUP_NO", SUP_NO));
            return SqlSelect(sql, paras);
        }
        //PAY取得供應商銀行資料
        public DataTable GetPaybank(string ID)
        {
            string sql = "SELECT  *  FROM buy38 WHERE sup_no = @ID and conf_c='Y'";
            List<SqlParameter> paras = new List<SqlParameter>();
            paras.Add(new SqlParameter("ID", ID));
            return SqlSelect(sql, paras);
        }
        public DataTable GetPaybank2(string ac_no)
        {
            string sql = "SELECT  *  FROM buy38 WHERE ac_no = @ac_no";
            List<SqlParameter> paras = new List<SqlParameter>();
            paras.Add(new SqlParameter("ac_no", ac_no));
            return SqlSelect(sql, paras);
        }
        //buy38有加一個欄位是確認碼
        //conf_c
        //要抓CONF_C = 'Y'
        //才是財務核可過的銀行資料
        ////PAY取得供應商付款資料及月結資訊結束
        public DataTable GetExchangeRate(string CURR_K)
        {
            string sql = "SELECT BAS3201 FROM BAS32 WHERE CURR_K = @CURR_K   order by S_D desc";
            List<SqlParameter> paras = new List<SqlParameter>();
            paras.Add(new SqlParameter("CURR_K", CURR_K));
            return SqlSelect(sql, paras);
        }
        //取得零用金預支表資料
        public DataTable GetPayallowance(string id)
        {
            string sql = "SELECT  *  FROM TB_Payallowance WHERE id = @id";
            List<SqlParameter> paras = new List<SqlParameter>();
            paras.Add(new SqlParameter("id", id));
            return SqlSelect(sql, paras);
        }
        //取得公務車前一使用者的里程數
        public DataTable GetCarkm(string car_name)
        {
            string sql = "select * from TB_Carrentdata where car_name=@car_name and backYN='Y' order by endrent desc";
            List<SqlParameter> paras = new List<SqlParameter>();
            paras.Add(new SqlParameter("car_name", car_name));
            return SqlSelect(sql, paras);
        }
        public DataTable GetDept(string emp_no)
        {
            string sql = "SELECT * FROM chuck06 WHERE emp_no = @emp_no";
            List<SqlParameter> paras = new List<SqlParameter>();
            paras.Add(new SqlParameter("emp_no", emp_no));
            return SqlSelect(sql, paras);
        }
        //預算依照部門取得單別
        public DataTable GetDeptType(string dept_no)
        {
            string sql = "SELECT * FROM TB_BudgetDeptToType WHERE dept_no = @dept_no";
            List<SqlParameter> paras = new List<SqlParameter>();
            paras.Add(new SqlParameter("dept_no", dept_no));
            return SqlSelect(sql, paras);
        }
        //預算新增編輯者
        public DataTable GetBudgetEditor(string dept_no, string year, string emp_no, string emp_cne, string TypeWrt)
        {
            string sql = "Insert into TB_BudgetTableEditor (dept_no,year,emp_no,emp_cne,TypeWrt) values (@dept_no,@year,@emp_no,@emp_cne,@TypeWrt)";
            List<SqlParameter> paras = new List<SqlParameter>();
            paras.Add(new SqlParameter("dept_no", dept_no));
            paras.Add(new SqlParameter("year", year));
            paras.Add(new SqlParameter("emp_no", emp_no));
            paras.Add(new SqlParameter("emp_cne", emp_cne));
            paras.Add(new SqlParameter("TypeWrt", TypeWrt));
            return SqlSelect(sql, paras);
        }
        //依照TB_BudgetLevel，判斷特殊預算誰可填入(人事、財務ETC)
        public DataTable GetBudgetLevel0(string emp_no)
        {
            string sql = "SELECT * FROM TB_BudgetLevel WHERE emp_no = @emp_no and TypeWrt='n0'";
            List<SqlParameter> paras = new List<SqlParameter>();
            paras.Add(new SqlParameter("emp_no", emp_no));
            return SqlSelect(sql, paras);
        }
        public DataTable GetBudgetLevelforprint(string emp_no,string emp_dept)
        {
            string sql = "SELECT * FROM TB_BudgetLevel WHERE emp_no = @emp_no and emp_dept = @emp_dept and TypeWrt='n0'";
            List<SqlParameter> paras = new List<SqlParameter>();
            paras.Add(new SqlParameter("emp_no", emp_no));
            paras.Add(new SqlParameter("emp_dept", emp_dept));
            return SqlSelect(sql, paras);
        }
        public DataTable GetBudgetLevelalljuic(string emp_no)
        {
            //string sql = "SELECT * FROM TB_BudgetLevel WHERE emp_no = @emp_no and TypeWrt<>'n0'";
            string sql = "SELECT * FROM TB_BudgetLevel WHERE emp_no = @emp_no and emp_dept='ALL' and ps='JUIC'";
            List<SqlParameter> paras = new List<SqlParameter>();
            paras.Add(new SqlParameter("emp_no", emp_no));
            return SqlSelect(sql, paras);
        }
        public DataTable GetBudgetLevelalljutw(string emp_no)
        {
            //string sql = "SELECT * FROM TB_BudgetLevel WHERE emp_no = @emp_no and TypeWrt<>'n0'";
            string sql = "SELECT * FROM TB_BudgetLevel WHERE emp_no = @emp_no and emp_dept='ALL' and ps='JUTW'";
            List<SqlParameter> paras = new List<SqlParameter>();
            paras.Add(new SqlParameter("emp_no", emp_no));
            return SqlSelect(sql, paras);
        }
        public DataTable GetBudgetLevelALL(string emp_no)
        {
            string sql = "SELECT * FROM TB_BudgetLevel WHERE emp_no = @emp_no";
            List<SqlParameter> paras = new List<SqlParameter>();
            paras.Add(new SqlParameter("emp_no", emp_no));
            return SqlSelect(sql, paras);
        }
        public DataTable GetBudgetLevelsa(string emp_no)
        {
            string sql = "SELECT * FROM TB_BudgetLevel WHERE emp_no = @emp_no and TypeWrt='sa'";
            List<SqlParameter> paras = new List<SqlParameter>();
            paras.Add(new SqlParameter("emp_no", emp_no));
            return SqlSelect(sql, paras);
        }
        public DataTable BudgetTableSales(string emp_no)
        {
            string sql = "SELECT emp_cne FROM TB_BudgetTableSales WHERE emp_no = @emp_no";
            List<SqlParameter> paras = new List<SqlParameter>();
            paras.Add(new SqlParameter("emp_no", emp_no));
            return SqlSelect(sql, paras);
        }
        //將各部門各類別資料可編寫者匯入資料庫TB_BudgetLevel
        public DataTable InsertBudgetLevel(string emp_no, string emp_cne, string emp_dept, string emp_deptCh, string TypeWrt, string TypeWrtCh)
        {
            string sql = "INSERT INTO TB_BudgetLevel (emp_no,emp_cne,emp_dept,emp_deptCh,TypeWrt,TypeWrtCh) VALUES (@emp_no,@emp_cne,@emp_dept,@emp_deptCh,@TypeWrt,@TypeWrtCh)";
            List<SqlParameter> paras = new List<SqlParameter>();
            paras.Add(new SqlParameter("emp_no", emp_no));
            paras.Add(new SqlParameter("emp_cne", emp_cne));
            paras.Add(new SqlParameter("emp_dept", emp_dept));
            paras.Add(new SqlParameter("emp_deptCh", emp_deptCh));
            paras.Add(new SqlParameter("TypeWrt", TypeWrt));
            paras.Add(new SqlParameter("TypeWrtCh", TypeWrtCh));

            return SqlSelect(sql, paras);
        }
        public DataTable InsertBudgetLevel2(string emp_no, string emp_cne, string emp_dept, string emp_deptCh, string TypeWrt, string TypeWrtCh, string ps)
        {
            string sql = "INSERT INTO TB_BudgetLevel (emp_no,emp_cne,emp_dept,emp_deptCh,TypeWrt,TypeWrtCh,ps) VALUES (@emp_no,@emp_cne,@emp_dept,@emp_deptCh,@TypeWrt,@TypeWrtCh,@ps)";
            List<SqlParameter> paras = new List<SqlParameter>();
            paras.Add(new SqlParameter("emp_no", emp_no));
            paras.Add(new SqlParameter("emp_cne", emp_cne));
            paras.Add(new SqlParameter("emp_dept", emp_dept));
            paras.Add(new SqlParameter("emp_deptCh", emp_deptCh));
            paras.Add(new SqlParameter("TypeWrt", TypeWrt));
            paras.Add(new SqlParameter("TypeWrtCh", TypeWrtCh));
            paras.Add(new SqlParameter("ps", ps));
            return SqlSelect(sql, paras);
        }
        //PAY取得請款單單身資料
        public DataTable GetPayDetail(string ID)
        {
            //string sql = "SELECT  *  FROM TB_Paymentdetail WHERE paymentid = @ID order by id";
            string sql = "SELECT  id,paymentid,dept_no,replace(dept_cne,'其他','') as 'dept_cne',comment,payment FROM TB_Paymentdetail WHERE paymentid = @ID order by id";
            List<SqlParameter> paras = new List<SqlParameter>();
            paras.Add(new SqlParameter("ID", ID));
            return SqlSelect(sql, paras);
        }
        //PAY取得匯費
        public DataTable GetPayCharge(string charge, string currency)
        {
            string sql = "SELECT  *  FROM TB_Paysendcharge WHERE @charge<=level and currency=@currency ";
            List<SqlParameter> paras = new List<SqlParameter>();
            paras.Add(new SqlParameter("charge", charge));
            paras.Add(new SqlParameter("currency", currency));
            return SqlSelect(sql, paras);
        }
        public DataTable GetPayCharge2(string currency)
        {
            string sql = "SELECT  *  FROM TB_Paysendcharge WHERE currency=@currency ";
            List<SqlParameter> paras = new List<SqlParameter>();

            paras.Add(new SqlParameter("currency", currency));
            return SqlSelect(sql, paras);
        }
        public DataTable GetPayhead(string ID)
        {
            string sql = "SELECT  *  FROM TB_Payment WHERE id = @ID order by id";
            List<SqlParameter> paras = new List<SqlParameter>();
            paras.Add(new SqlParameter("ID", ID));
            return SqlSelect(sql, paras);
        }

        public DataTable GetUserdata(string ID)
        {
            string sql = "SELECT  *  FROM pay11 WHERE emp_no = @ID ";
            List<SqlParameter> paras = new List<SqlParameter>();
            paras.Add(new SqlParameter("ID", ID));
            return SqlSelect(sql, paras);
        }
        //確認是否有待修改的個人資料變更
        public DataTable CheckUserdata(string ID)
        {
            string sql = "SELECT  id  FROM TB_Userdata WHERE emp_no = @ID and hrcheck='N'";
            List<SqlParameter> paras = new List<SqlParameter>();
            paras.Add(new SqlParameter("ID", ID));
            return SqlSelect(sql, paras);
        }
        public DataTable DeleteUserdata(string ID)
        {
            string sql = "delete TB_Userdata WHERE emp_no = @ID and hrcheck='N'";
            List<SqlParameter> paras = new List<SqlParameter>();
            paras.Add(new SqlParameter("ID", ID));
            return SqlSelect(sql, paras);
        }
        public DataTable InsertUserdata(string emp_no, string tel1, string addr1,  string mtel, string attn, string rela, string rela_addr, string rela_tel,string hrcheck)
        {
            string sql = "INSERT INTO [dbo].[TB_Userdata] ([emp_no],[tel1],[addr1],[mtel],[attn],[rela],[rela_addr],[rela_tel],[hrcheck]) VALUES (@emp_no,  @tel1,  @addr1, @mtel,  @attn, @rela,  @rela_addr,  @rela_tel, @hrcheck)";
            List<SqlParameter> paras = new List<SqlParameter>();
            paras.Add(new SqlParameter("emp_no", emp_no));
            paras.Add(new SqlParameter("tel1", tel1));
            paras.Add(new SqlParameter("addr1", addr1));
            //paras.Add(new SqlParameter("addr2", addr2));
            paras.Add(new SqlParameter("mtel", mtel));
            paras.Add(new SqlParameter("attn", attn));
            paras.Add(new SqlParameter("rela", rela));
            paras.Add(new SqlParameter("rela_addr", rela_addr));
            paras.Add(new SqlParameter("rela_tel", rela_tel));
            paras.Add(new SqlParameter("hrcheck", hrcheck));
            return SqlSelect(sql, paras);
        }
        public DataTable UserdataCheckYN()
        {
            string sql = " select id from TB_Userdata where hrcheck = 'N'";
            List<SqlParameter> paras = new List<SqlParameter>();
            //paras.Add(new SqlParameter("emp_no", emp_no));
            return SqlSelect(sql, paras);
        }
        //將申請修改的個人資料匯入pay11
        public DataTable UpdateUserdata(string emp_no)
        {
            string sql = "  UPDATE a SET a.[tel1] = b.[tel1],a.[mtel]=b.[mtel],a.[addr1]=b.[addr1],a.[attn]=b.[attn],a.[rela]=b.[rela],a.[rela_addr]=b.[rela_addr]  ,a.[rela_tel]=b.[rela_tel] FROM pay11 a, TB_Userdata b WHERE (a.emp_no = b.emp_no) and (b.emp_no=@emp_no) and (b.hrcheck = 'N')";
            List<SqlParameter> paras = new List<SqlParameter>();
            paras.Add(new SqlParameter("emp_no", emp_no));
            return SqlSelect(sql, paras);
        }
        //修改完pay11後將TB_Userdata的hrcheck改成確認者員工編號
        public DataTable Userdataeditor(string editor_no, string emp_no)
        {
            string sql = "  UPDATE TB_Userdata SET hrcheck=@editor_no WHERE (emp_no=@emp_no) and (hrcheck = 'N')";
            List<SqlParameter> paras = new List<SqlParameter>();
            paras.Add(new SqlParameter("editor_no", editor_no));
            paras.Add(new SqlParameter("emp_no", emp_no));
            return SqlSelect(sql, paras);
        }
        //管理單位退件
        //修改完pay11後將TB_Userdata的hrcheck改成確認者員工編號
        public DataTable BkUserdata(string hrbkcomment, string emp_no)
        {
            string sql = "  UPDATE TB_Userdata SET hrcheck='B',hrbkcomment=@hrbkcomment WHERE (emp_no=@emp_no) and (hrcheck = 'N')";
            List<SqlParameter> paras = new List<SqlParameter>();
            paras.Add(new SqlParameter("hrbkcomment", hrbkcomment));
            paras.Add(new SqlParameter("emp_no", emp_no));
            return SqlSelect(sql, paras);
        }
        //如有退件取得退件理由
        public DataTable Bkcomment(string emp_no)
        {
            string sql = "  select hrbkcomment from TB_Userdata where emp_no=@emp_no order by id desc";
            List<SqlParameter> paras = new List<SqlParameter>();
            paras.Add(new SqlParameter("emp_no", emp_no));
            return SqlSelect(sql, paras);
        }
        //misserviceupload取得圖片路徑
        //public DataTable GetMISupload(string NO)
        //{
        //    string sql = "SELECT  upload  FROM TB_MISservice WHERE NO = @NO";
        //    List<SqlParameter> paras = new List<SqlParameter>();
        //    paras.Add(new SqlParameter("NO", NO));
        //    return SqlSelect(sql, paras);
        //}

        //public DataTable DeleteMISupload(string NO)
        //{
        //    string sql = "UPDATE TB_MISservice SET upload='' WHERE NO = @NO";
        //    List<SqlParameter> paras = new List<SqlParameter>();
        //    paras.Add(new SqlParameter("NO", NO));
        //    return SqlSelect(sql, paras);
        //}
        //public DataTable GetMISupload(string misid)
        //{
        //    string sql = "SELECT  url  FROM TB_MISserviceupload WHERE misid = @misid";
        //    List<SqlParameter> paras = new List<SqlParameter>();
        //    paras.Add(new SqlParameter("misid", misid));
        //    return SqlSelect(sql, paras);
        //}

        public DataTable DeleteMISupload(string url)
        {
            string sql = "DELETE TB_MISserviceupload WHERE url = @url";
            List<SqlParameter> paras = new List<SqlParameter>();
            paras.Add(new SqlParameter("url", url));
            return SqlSelect(sql, paras);
        }
        //刪除會議室租借記錄
        public DataTable DeleteConferenceroom(string ID)
        {
            string sql = "DELETE TB_Conference WHERE ID = @ID";
            List<SqlParameter> paras = new List<SqlParameter>();
            paras.Add(new SqlParameter("ID", ID));
            return SqlSelect(sql, paras);
        }
        //刪除公務車租借記錄
        public DataTable DeleteCarrent(string id)
        {
            string sql = "DELETE TB_Carrentdata WHERE id = @id";
            List<SqlParameter> paras = new List<SqlParameter>();
            paras.Add(new SqlParameter("id", id));
            return SqlSelect(sql, paras);
        }
        //公告取得路徑與刪除公告
        public DataTable GetANNupload(string ID)
        {
            string sql = "SELECT  pdfurl  FROM TB_AnnounceBeta WHERE ID = @ID";
            List<SqlParameter> paras = new List<SqlParameter>();
            paras.Add(new SqlParameter("ID", ID));
            return SqlSelect(sql, paras);
        }
        public DataTable DeleteANN(string ID)
        {
            string sql = "DELETE TB_AnnounceBeta  WHERE ID = @ID";
            List<SqlParameter> paras = new List<SqlParameter>();
            paras.Add(new SqlParameter("ID", ID));
            return SqlSelect(sql, paras);
        }

        //輸入表單辦法更新資料
        public DataTable InsertWelfare(string postdate, string title, string content, string dept, string author)
        {
            string sql = @"insert into TB_PersonalWelfareContent  (postdate,title,content,dept,author) 
                           values (@postdate,@title,@content,@dept,@author)";
            List<SqlParameter> paras = new List<SqlParameter>();
            paras.Add(new SqlParameter("title", title));
            paras.Add(new SqlParameter("postdate", DateTime.Parse(postdate)));
            paras.Add(new SqlParameter("content", content));
            paras.Add(new SqlParameter("dept", dept));
            paras.Add(new SqlParameter("author", author));
            return SqlSelect(sql, paras);
        }

        private SqlConnection CreateConn()
        {
            return new SqlConnection(this.connStr);
        }

        public DataTable SqlSelect(string Sql)
        {
            DataTable dt = new DataTable();

            using (SqlConnection sqlConnection = CreateConn())
            {
                using (SqlDataAdapter sqlDataAdapter = new SqlDataAdapter())
                {
                    try
                    {
                        sqlDataAdapter.SelectCommand = new SqlCommand(Sql, sqlConnection);

                        sqlDataAdapter.SelectCommand.CommandTimeout = timeOutSec;
                        sqlDataAdapter.Fill(dt);
                    }
                    finally
                    {
                        sqlDataAdapter.Dispose();
                        sqlConnection.Close();
                        sqlConnection.Dispose();
                    }
                }
            }
            return dt;
        }

        private DataTable SqlSelect(string Sql, List<SqlParameter> Parameters)
        {

            int i = 0;
            DataTable dt = new DataTable();

            using (SqlConnection sqlConnection = CreateConn())
            {
                using (SqlDataAdapter sqlDataAdapter = new SqlDataAdapter())
                {
                    if (Parameters == null)
                    {
                        Parameters = new List<SqlParameter>();
                    }
                    try
                    {
                        sqlDataAdapter.SelectCommand = new SqlCommand(Sql, sqlConnection);
                        //用法
                        sqlDataAdapter.SelectCommand.Parameters.AddRange(Parameters.ToArray());
                        sqlDataAdapter.SelectCommand.CommandTimeout = timeOutSec;
                        //
                        sqlDataAdapter.Fill(dt);
                    }
                    finally
                    {
                        sqlDataAdapter.SelectCommand.Parameters.Clear();
                        sqlDataAdapter.Dispose();
                        sqlConnection.Close();
                        sqlConnection.Dispose();
                    }
                }
            }
            return dt;
            //dt值是如何回到資料驗證?
        }
    }
}