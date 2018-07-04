using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace JuicERP.UserControls
{
    public partial class ListPicker : System.Web.UI.UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            btnExit.OnClientClick = "CloseControl(\"" + this.Parent.FindControl("ModalPanelChild").ClientID + "\"); return false;";
        }

        public void InitItems(Dictionary<string, string> listItems)
        {
            lbOrigin.Items.Clear();
            lbSource.Items.Clear();
            foreach (KeyValuePair<string, string> p in listItems)
            {
                lbOrigin.Items.Add(new ListItem(p.Key, p.Value));
                lbSource.Items.Add(new ListItem(p.Key, p.Value));
            }
            BindRightListBox();
        }
        public void InitItems(string[] listItems)
        {
            lbOrigin.Items.Clear();
            lbSource.Items.Clear();
            foreach (string s in listItems)
            {
                lbOrigin.Items.Add(new ListItem(s, s));
                lbSource.Items.Add(new ListItem(s, s));
            }
            BindRightListBox();
        }
        public void InitItems(List<string> listItems)
        {
            lbOrigin.Items.Clear();
            lbSource.Items.Clear();
            foreach (string s in listItems)
            {
                lbOrigin.Items.Add(new ListItem(s, s));
                lbSource.Items.Add(new ListItem(s, s));
            }
            BindRightListBox();
        }
        public void InitItems(ListItem[] listItems)
        {
            lbOrigin.Items.Clear();
            lbSource.Items.Clear();
            lbOrigin.Items.AddRange(listItems);
            lbSource.Items.AddRange(listItems);
            BindRightListBox();
        }
        public void InitItems(ListItemCollection listItems)
        {
            lbOrigin.Items.Clear();
            lbSource.Items.Clear();
            foreach (ListItem li in listItems)
            {
                lbOrigin.Items.Add(li);
                lbSource.Items.Add(li);
            }
            BindRightListBox();
        }
        public void InitItems(List<ListItem> listItems)
        {
            lbOrigin.Items.Clear();
            lbSource.Items.Clear();
            lbOrigin.Items.AddRange(listItems.ToArray());
            lbSource.Items.AddRange(listItems.ToArray());
            BindRightListBox();
        }
        public ListItemCollection RightItems
        {
            get
            {
                return lbDest.Items;
            }
        }
        public ListItemCollection LeftItems
        {
            get
            {
                return lbSource.Items;
            }
        }

        public void SetColumn(string colName, string postbackTextBoxName)
        {
            hfPostBackTextBoxName.Value = postbackTextBoxName;
            UpdatePanel1.Update();
        }

        protected void ibtnAddSelected_Click(object sender, ImageClickEventArgs e)
        {
            List<ListItem> leftItems = new List<ListItem>();
            foreach (ListItem li in lbSource.Items)
            {
                if (false == li.Selected) leftItems.Add(li);
            }
            lbSource.Items.Clear();
            lbSource.Items.AddRange(leftItems.ToArray());
            BindRightListBox();
        }
        protected void ibtnRemoveSelected_Click(object sender, ImageClickEventArgs e)
        {
            List<ListItem> rightItems = new List<ListItem>();

            foreach (ListItem li in lbDest.Items)
            {
                if (false == li.Selected) rightItems.Add(li);
            }
            lbSource.Items.Clear();
            foreach (ListItem li in lbOrigin.Items)
            {
                if (false == rightItems.Contains(li))
                {
                    lbSource.Items.Add(li);
                }
            }
            rightItems.Clear();
            BindRightListBox();
        }

        /// <summary>
        /// 全部加入
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void ibtnAddAll_Click(object sender, ImageClickEventArgs e)
        {
            // 通通加到右側的 ListBox
            lbSource.Items.Clear();
            BindRightListBox();
        }
        /// <summary>
        /// 全部移除
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void ibtnRemoveAll_Click(object sender, ImageClickEventArgs e)
        {
            // 通通加到左側的listBox
            lbSource.Items.Clear();
            foreach (ListItem li in lbOrigin.Items)
            {
                lbSource.Items.Add(li);
            }
            BindRightListBox();
        }

        private void BindRightListBox()
        {
            lbDest.Items.Clear();
            foreach (ListItem li in lbOrigin.Items)
            {
                if (false == lbSource.Items.Contains(li))
                    lbDest.Items.Add(li);
            }
        }

        protected void btnImportValues_Click(object sender, EventArgs e)
        {
            List<string> values = new List<string>();
            foreach (ListItem li in this.RightItems)
            {
                values.Add(li.Text);
            }
            string value = String.Join(";", values.ToArray());

            (this.Parent.FindControl("ModalPanel").FindControl("QueryWindow") as QueryWindow).SetTextBoxValue(hfPostBackTextBoxName.Value, value);
            UpdatePanel1.CloseControl(this.Parent.FindControl("ModalPanelChild").ClientID);
        }
    }
}