using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;

public class GVSortHelper : IDisposable
{
    private System.Web.UI.StateBag _viewState;
    private string _gvId = String.Empty;

    /// <summary>
    /// 初始化排序功能
    /// </summary>
    /// <param name="viewState">用來存放排序條件的 viewState </param>
    public GVSortHelper(System.Web.UI.StateBag viewState)
    {
        this._viewState = viewState;
    }

    public GVSortHelper(System.Web.UI.StateBag viewState, string gridviewID)
    {
        this._viewState = viewState;
        this._gvId = gridviewID;
    }

    /// <summary>
    /// 將排序字串(欄位)存在ViewState中
    /// </summary>
    private string sortColumn
    {
        get
        {
            if (null != this._viewState["GVSortHelper_SortColumn" + this._gvId])
                return this._viewState["GVSortHelper_SortColumn" + this._gvId].ToString();
            else
                return String.Empty;
        }

        set
        {
            this._viewState["GVSortHelper_SortColumn" + this._gvId] = value;
        }
    }

    /// <summary>
    /// 將排序字串(方向)存在ViewState中
    /// </summary>
    private string sortDirection
    {
        get
        {
            if (null != this._viewState["GVSortHelper_SortDirection" + this._gvId])
                return this._viewState["GVSortHelper_SortDirection" + this._gvId].ToString();
            else
                return String.Empty;
        }

        set
        {
            this._viewState["GVSortHelper_SortDirection" + this._gvId] = value;
        }
    }

    public string GetSortColumn { get { return sortColumn; } }
    public string GetSortDirection { get { return sortDirection; } }

    /// <summary>
    /// 設定要排序的欄位
    /// </summary>
    /// <param name="columnName">欄位名稱</param>
    public void SetSortExpression(string columnName)
    {
        if (String.IsNullOrEmpty(sortColumn)) // 無排序
        {
            sortColumn = columnName;
            sortDirection = "DESC";
        }
        else if (0 != String.Compare(sortColumn, columnName, true)) // 換排序欄位
        {
            sortColumn = columnName;
            sortDirection = "DESC";
        }
        else // 換排序的順序(ASC -> DESC or DESC -> ASC)
        {
            if (sortDirection.Equals("DESC"))
                sortDirection = "ASC";
            else
                sortDirection = "DESC";
        }

    }

    /// <summary>
    /// 執行排序功能
    /// </summary>
    /// <typeparam name="T"></typeparam>
    /// <param name="myList"></param>
    public void SortGV<T>(List<T> myList)
    {
        string sortExpression = (sortColumn + " " + sortDirection).Trim();
        if (false == string.IsNullOrEmpty(sortExpression))
        {
            GVComparer<T> myComparer = new GVComparer<T>(sortExpression);
            myList.Sort(myComparer);
        }
    }

    public void SortGV(DataTable tb)
    {
        string sortExpression = (sortColumn + " " + sortDirection).Trim();
        tb.DefaultView.Sort = sortExpression;
    }
    public void SortGV(DataSet ds)
    {
        string sortExpression = (sortColumn + " " + sortDirection).Trim();
        ds.Tables[0].DefaultView.Sort = sortExpression;
    }

    //private System.Web.UI.StateBag viewState
    //{
    //    get
    //    {
    //        System.Web.UI.StateBag returnValue = null;
    //        if (PreviousPage != null)
    //        {
    //            Object objPreviousPage = (Object)PreviousPage;
    //            MethodInfo objMethod = objPreviousPage.GetType().GetMethod
    //                    ("ReturnViewState");
    //            return (StateBag)objMethod.Invoke(objPreviousPage, null);
    //        }
    //        return returnValue;
    //    }
    //}

    public string GetPageType(System.Web.UI.Page page)
    {
        return page.GetType().ToString();
    }

    public void Dispose() // 只是為了能用 using 語法實作 dispose
    {
        this._viewState = null;
    }
}