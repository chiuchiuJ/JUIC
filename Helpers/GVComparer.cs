using System;
using System.Collections.Generic;
using System.Reflection;

public class GVComparer<T> : IComparer<T>
{
    public enum SortOrder { Ascending, Descending };

    #region public properties
    /// <summary>
    /// Column Name(public property of the class) to be sorted.
    /// </summary>
    private string _sortColumn;
    public string SortColumn
    {
        get { return _sortColumn; }
    }

    private SortOrder _sortingOrder;
    public SortOrder SortingOrder
    {
        get { return _sortingOrder; }
    }
    #endregion

    #region Constructors
    public GVComparer(string sortColumn, SortOrder sortingOrder)
    {
        this._sortColumn = sortColumn;
        this._sortingOrder = sortingOrder;
    }

    public GVComparer(string sortExpression)
    {
        string[] sortExprArray = sortExpression.Split(" ".ToCharArray());
        string sortColumn = sortExprArray[0];
        SortOrder sortingOrder;
        sortingOrder = SortOrder.Ascending;
        if (sortExprArray.Length > 1)
        {
            if (sortExprArray[1].ToUpper() == "DESC")
            {
                sortingOrder = SortOrder.Descending;
            }
        }

        this._sortColumn = sortColumn;
        this._sortingOrder = sortingOrder;
    }
    #endregion

    /// <summary>
    /// Compare two objects of the same class, 
    /// based on the value of a given property
    /// </summary>
    /// <param name="x">First Object</param>
    /// <param name="y">Second Object</param>
    /// <returns>int</returns>
    public int Compare(T x, T y)
    {
        // User reflection to get the property
        PropertyInfo propertyInfo = typeof(T).GetProperty(_sortColumn);

        if (null == x && null == y) { return 0; }
        if (null == x)
        { return 1; }
        if (null == y)
        { return -1; }

        // Cast the property to IComparable, so we can use the built-in compare.
        IComparable obj1 = (IComparable)propertyInfo.GetValue(x, null);
        IComparable obj2 = (IComparable)propertyInfo.GetValue(y, null);

        // Order depends on Asc vs Desc.
        if (null == obj1 && null == obj2)
        { return 0; }

        if (_sortingOrder == SortOrder.Ascending)
        {
            if (null == obj1)
            { return 1; }
            return (obj1.CompareTo(obj2));
        }
        else
        {
            if (null == obj2)
            { return -1; }
            return (obj2.CompareTo(obj1));
        }
    }
}