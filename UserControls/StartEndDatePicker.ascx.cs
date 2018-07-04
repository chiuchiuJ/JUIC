using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace JuicERP.UserControls
{
    public partial class StartEndDatePicker : System.Web.UI.UserControl
    {
        /// <summary>
        /// 起始日期(設定值
        /// </summary>
        public Nullable<DateTime> StartDate
        {
            get
            {
                try
                {
                    if (txtStartDate.Text.Trim().Length <= 0) return null;
                    return getWestDate(txtStartDate.Text.Trim());
                }
                catch
                {
                    lblDateMsg.Text = "起始日期格式不正確";
                    return null;
                }
            }
            set
            {
                if (false == value.HasValue)
                {
                    txtStartDate.Text = "";
                }
                else
                {
                    //txtEndDate.Text = toROCDate(value.Value, "/");
                    txtEndDate.Text = toWestDate(value.Value, "/");
                }
            }
        }

        /// <summary>
        /// 訖止日期
        /// </summary>
        public Nullable<DateTime> EndDate
        {
            get
            {
                try
                {
                    if (txtEndDate.Text.Trim().Length <= 0) return null;
                    return getWestDate(txtEndDate.Text.Trim());
                }
                catch
                {
                    lblDateMsg.Text = "訖止日期格式不正確";
                    return null;
                }
            }
            set
            {
                if (false == value.HasValue)
                {
                    txtEndDate.Text = "";
                }
                else
                {
                    //txtEndDate.Text = toROCDate(value.Value, "/");
                    txtEndDate.Text = toWestDate(value.Value, "/");
                }
            }
        }


        /// <summary>
        /// 傳回起始日期
        /// </summary>
        /// <param name="NullValue">當起始日期欄位為空值時以此值為預設值</param>
        /// <returns></returns>
        public DateTime getStartDate(DateTime NullValue)
        {
            if (txtStartDate.Text.Trim().Length <= 0) return NullValue;
            return getWestDate(txtStartDate.Text.Trim());
        }

        /// <summary>
        /// 傳回訖止日期
        /// </summary>
        /// <param name="IfNull">當訖止日期欄位為空值時以此值為預設值</param>
        /// <returns></returns>
        public DateTime getEndDate(DateTime IfNull)
        {
            if (txtEndDate.Text.Trim().Length <= 0) return IfNull;
            return getWestDate(txtEndDate.Text.Trim());
        }

        private DateTime getWestDate(string DateStr)
        {
            string[] ymd = DateStr.Split('/');
            if (ymd.Length >= 3)
            {
                //return new DateTime(int.Parse(ymd[0]) + 1911, int.Parse(ymd[1]), int.Parse(ymd[2]));
                return new DateTime(int.Parse(ymd[0]), int.Parse(ymd[1]), int.Parse(ymd[2]));
            }
            else
            {
                if (DateStr.Length == 6)
                {
                    return new DateTime(int.Parse(DateStr.Substring(0, 2)),
                        int.Parse(DateStr.Substring(2, 2)), int.Parse(DateStr.Substring(4, 2)));
                    //return new DateTime(int.Parse(DateStr.Substring(0, 2)) + 1911,
                    //    int.Parse(DateStr.Substring(2, 2)), int.Parse(DateStr.Substring(4, 2)));
                }
                else // length == 7
                {
                    //return new DateTime(int.Parse(DateStr.Substring(0, 3)) + 1911,
                    //    int.Parse(DateStr.Substring(3, 2)), int.Parse(DateStr.Substring(5, 2)));
                    return new DateTime(int.Parse(DateStr.Substring(0, 3)),
                        int.Parse(DateStr.Substring(3, 2)), int.Parse(DateStr.Substring(5, 2)));
                }
            }
        }

        private string toWestDate(DateTime WestDate, string Seprator)
        {
            return WestDate.Year.ToString().PadLeft(4, '0') + Seprator + WestDate.Month.ToString().PadLeft(2, '0') + Seprator + WestDate.Day.ToString().PadLeft(2, '0');
        }

        /// <summary>
        /// 西元轉民國年字串
        /// </summary>
        /// <param name="WestDate"></param>
        /// <param name="Seprator"></param>
        /// <returns></returns>
        private string toROCDate(DateTime WestDate, string Seprator)
        {
            int Year = WestDate.Year;
            if (Year > 1911) Year -= 1911; // 大於 1911 判斷為西元
            return Year.ToString().PadLeft(3, '0') + Seprator + WestDate.Month.ToString().PadLeft(2, '0') + Seprator + WestDate.Day.ToString().PadLeft(2, '0');
        }
    }
}