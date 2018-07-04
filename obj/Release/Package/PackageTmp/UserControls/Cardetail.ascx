<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Cardetail.ascx.cs" Inherits="JuicERP.UserControls.Cardetail" %>

              <div class="panel panel-warning">
      <div class="panel-heading">輸入資料</div>
      <div class="panel-body"> 

          <asp:Label ID="Label1" runat="server" Text="" Visible="false"></asp:Label>
                <asp:Label ID="Label2" runat="server" Text="" Visible="false"></asp:Label>
          車號：<asp:TextBox ID="TextBox0" runat="server"></asp:TextBox>
使用者：<asp:TextBox ID="TextBox1" runat="server"></asp:TextBox>
部門：<asp:TextBox ID="TextBox2" runat="server"></asp:TextBox>
<hr />
 實際租借時間：
<asp:TextBox ID="datestart" runat="server" Width="30%" Text="日期格式：2000/01/01"
          OnFocus="javascript:if(this.value=='日期格式：2000/01/01') {this.value=''}"
          OnBlur="javascript:if(this.value==''){this.value='日期格式：2000/01/01'}"></asp:TextBox>
<img align="middle" alt="" style="margin: 0 auto;" onclick="popUpCalendar(this, document.getElementById('<%= datestart.ClientID %>'), 'yyyy/mm/dd')" src="<%=ResolveUrl("~/img/calendar.gif") %>" />
   <asp:DropDownList ID="DropDownList1" runat="server" Width="10%">
                  <asp:ListItem>0</asp:ListItem>
                  <asp:ListItem>1</asp:ListItem>
                  <asp:ListItem>2</asp:ListItem>
                  <asp:ListItem>3</asp:ListItem>
                  <asp:ListItem>4</asp:ListItem>
                  <asp:ListItem>5</asp:ListItem>
                  <asp:ListItem>6</asp:ListItem>
                  <asp:ListItem>7</asp:ListItem>
                  <asp:ListItem>8</asp:ListItem>
                  <asp:ListItem>9</asp:ListItem>
                  <asp:ListItem>10</asp:ListItem>
                  <asp:ListItem>11</asp:ListItem>
                  <asp:ListItem>12</asp:ListItem>
                  <asp:ListItem>13</asp:ListItem>
                  <asp:ListItem>14</asp:ListItem>
                  <asp:ListItem>15</asp:ListItem>
                  <asp:ListItem>16</asp:ListItem>
                  <asp:ListItem>17</asp:ListItem>
                  <asp:ListItem>18</asp:ListItem>
                  <asp:ListItem>19</asp:ListItem>
                  <asp:ListItem>20</asp:ListItem>
                  <asp:ListItem>21</asp:ListItem>
                  <asp:ListItem>22</asp:ListItem>
                  <asp:ListItem>23</asp:ListItem>
      
                            </asp:DropDownList>
<%--<asp:TextBox ID="TextBox4" runat="server"></asp:TextBox>--%>時
<asp:TextBox ID="TextBox5" runat="server"></asp:TextBox>分
 <br />實際歸還時間：
              <asp:TextBox ID="dateend" runat="server" Width="30%" Text="日期格式：2000/01/01"
          OnFocus="javascript:if(this.value=='日期格式：2000/01/01') {this.value=''}"
          OnBlur="javascript:if(this.value==''){this.value='日期格式：2000/01/01'}"></asp:TextBox>
<img align="middle" alt="" style="margin: 0 auto;" onclick="popUpCalendar(this, document.getElementById('<%= dateend.ClientID %>'), 'yyyy/mm/dd')" src="<%=ResolveUrl("~/img/calendar.gif") %>" />
    <asp:DropDownList ID="DropDownList2" runat="server" Width="10%">
                  <asp:ListItem>0</asp:ListItem>
                  <asp:ListItem>1</asp:ListItem>
                  <asp:ListItem>2</asp:ListItem>
                  <asp:ListItem>3</asp:ListItem>
                  <asp:ListItem>4</asp:ListItem>
                  <asp:ListItem>5</asp:ListItem>
                  <asp:ListItem>6</asp:ListItem>
                  <asp:ListItem>7</asp:ListItem>
                  <asp:ListItem>8</asp:ListItem>
                  <asp:ListItem>9</asp:ListItem>
                  <asp:ListItem>10</asp:ListItem>
                  <asp:ListItem>11</asp:ListItem>
                  <asp:ListItem>12</asp:ListItem>
                  <asp:ListItem>13</asp:ListItem>
                  <asp:ListItem>14</asp:ListItem>
                  <asp:ListItem>15</asp:ListItem>
                  <asp:ListItem>16</asp:ListItem>
                  <asp:ListItem>17</asp:ListItem>
                  <asp:ListItem>18</asp:ListItem>
                  <asp:ListItem>19</asp:ListItem>
                  <asp:ListItem>20</asp:ListItem>
                  <asp:ListItem>21</asp:ListItem>
                  <asp:ListItem>22</asp:ListItem>
                  <asp:ListItem>23</asp:ListItem>
      
                            </asp:DropDownList>
<%-- <asp:TextBox ID="TextBox6" runat="server"></asp:TextBox>--%>時
 <asp:TextBox ID="TextBox7" runat="server"></asp:TextBox>分
<hr />
出發前里程數：<asp:TextBox ID="TextBox8" runat="server"></asp:TextBox>
返回時里程數：<asp:TextBox ID="TextBox9" runat="server"></asp:TextBox>
<hr />
加油金額(有加再填)：<asp:TextBox ID="TextBox3" runat="server" Text="0"></asp:TextBox><br>
備註：<br>
<asp:TextBox ID="TextBox10" runat="server" TextMode="MultiLine" Rows="3" Width="100%"></asp:TextBox>

<asp:Button ID="Button1" runat="server" Text="送出資料" CssClass="btn btn-success btn-block" OnClick="Button1_Click" />
<asp:Button ID="Button2" runat="server" Text="取消" CssClass="btn btn-danger btn-block" OnClick="Button2_Click" />
                </div></div>