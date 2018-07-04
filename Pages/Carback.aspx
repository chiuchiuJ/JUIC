<%@ Page Title="" Language="C#" MasterPageFile="~/Master/JuicERP.Master" AutoEventWireup="true" CodeBehind="Carback.aspx.cs" Inherits="JuicERP.Pages.Carback" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script>var imgDir = '<%=ResolveUrl("~/img") %>' + "/";	</script>
    <script src="<%=ResolveUrl("~/js/popcalendar.js") %>" charset="UTF-8"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="col-md-2">
    </div>
    <div class="col-md-8" style="font-family: 微軟正黑體">
        <h3>預約資料一覽</h3>
        <asp:DetailsView ID="DetailsView1" runat="server" Height="70px" Width="100%" AutoGenerateRows="False" CellPadding="4" DataKeyNames="id" DataSourceID="SqlDataSource1" ForeColor="#333333" GridLines="None">
            <AlternatingRowStyle BackColor="White" />
            <CommandRowStyle BackColor="#FFFFC0" Font-Bold="True" />
            <FieldHeaderStyle BackColor="#FFFF99" Font-Bold="True" />
            <Fields>
                <asp:BoundField DataField="car_name" HeaderText="車牌號碼" SortExpression="car_name" />
                <asp:BoundField DataField="emp_cne" HeaderText="申請人" SortExpression="emp_cne" />
                <asp:BoundField DataField="username" HeaderText="使用者(駕駛)" SortExpression="username" />
                <asp:BoundField DataField="applydate" HeaderText="申請日期" SortExpression="applydate" />
                <asp:BoundField DataField="startrent" HeaderText="預約出發時間" SortExpression="startrent" />
                <asp:BoundField DataField="endrent" HeaderText="預約結束時間" SortExpression="endrent" />
                <asp:BoundField DataField="destination" HeaderText="目的地" SortExpression="destination" />
                <asp:BoundField DataField="PS" HeaderText="租借備註" SortExpression="PS" />
            </Fields>
            <FooterStyle BackColor="#990000" Font-Bold="True" ForeColor="White" />
            <HeaderStyle BackColor="#990000" Font-Bold="True" ForeColor="White" />
            <PagerStyle BackColor="#FFCC66" ForeColor="#333333" HorizontalAlign="Center" />
            <RowStyle BackColor="#FFFBD6" ForeColor="#333333" />
        </asp:DetailsView>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:MENU %>" SelectCommand="SELECT * FROM [TB_Carrentdata] WHERE ([id] = @id)">
            <SelectParameters>
                <asp:QueryStringParameter Name="id" QueryStringField="pid" Type="Int32" />
            </SelectParameters>
        </asp:SqlDataSource>
        <br />
        <hr />
        <br />
        實際出發時間：<asp:TextBox ID="datestart" runat="server" Width="30%"
            OnFocus="javascript:if(this.value=='日期格式：2000/01/01') {this.value=''}"
            OnBlur="javascript:if(this.value==''){this.value='日期格式：2000/01/01'}"></asp:TextBox>
        <img align="middle" alt="" style="margin: 0 auto;" onclick="popUpCalendar(this, document.getElementById('<%= datestart.ClientID %>'), 'yyyy/mm/dd')" src="<%=ResolveUrl("~/img/calendar.gif") %>" __designer:mapid="6c1" />
        <asp:DropDownList ID="DropDownList2" runat="server">
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
        <%--  <asp:TextBox ID="TextBox1" runat="server" Width="5%"></asp:TextBox>--%><asp:Label ID="Label5" runat="server" Text="時"></asp:Label>
        <asp:DropDownList ID="DropDownList3" runat="server">
            <asp:ListItem>00</asp:ListItem>
            <asp:ListItem>10</asp:ListItem>
            <asp:ListItem>20</asp:ListItem>
            <asp:ListItem>30</asp:ListItem>
            <asp:ListItem>40</asp:ListItem>
            <asp:ListItem>50</asp:ListItem>
        </asp:DropDownList>
        <%-- <asp:TextBox ID="TextBox2" runat="server" Width="5%"></asp:TextBox>--%><asp:Label ID="Label6" runat="server" Text="分"></asp:Label>
        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="datestart" ErrorMessage="請選擇日期"></asp:RequiredFieldValidator>
        <br />
        實際歸還時間：<asp:TextBox ID="dateend" runat="server" Width="30%"
            OnFocus="javascript:if(this.value=='日期格式：2000/01/01') {this.value=''}"
            OnBlur="javascript:if(this.value==''){this.value='日期格式：2000/01/01'}"></asp:TextBox>
        <img align="middle" alt="" style="margin: 0 auto;" onclick="popUpCalendar(this, document.getElementById('<%= dateend.ClientID %>'), 'yyyy/mm/dd')" src="<%=ResolveUrl("~/img/calendar.gif") %>" __designer:mapid="6e9" />
        <asp:DropDownList ID="DropDownList4" runat="server">
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
        <%--<asp:TextBox ID="TextBox3" runat="server" Width="5%"></asp:TextBox>--%><asp:Label ID="Label7" runat="server" Text="時"></asp:Label>
        <asp:DropDownList ID="DropDownList5" runat="server">
            <asp:ListItem>00</asp:ListItem>
            <asp:ListItem>10</asp:ListItem>
            <asp:ListItem>20</asp:ListItem>
            <asp:ListItem>30</asp:ListItem>
            <asp:ListItem>40</asp:ListItem>
            <asp:ListItem>50</asp:ListItem>
        </asp:DropDownList>
        <%-- <asp:TextBox ID="TextBox4" runat="server" Width="5%"></asp:TextBox>--%><asp:Label ID="Label8" runat="server" Text="分"></asp:Label>
        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="dateend" ErrorMessage="請選擇日期"></asp:RequiredFieldValidator>
        <br />
        (日期格式：2000/01/31)<br />
        出發前里程數：<asp:TextBox ID="TextBox1" runat="server"></asp:TextBox>
        <asp:Label ID="Label9" runat="server" ForeColor="#FF3300"></asp:Label>
        <asp:RangeValidator ID="RangeValidator1" runat="server" ControlToValidate="TextBox1" ErrorMessage="請輸入數字" MaximumValue="200000" MinimumValue="0" Type="Integer"></asp:RangeValidator>
        <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="TextBox1" ErrorMessage="此欄不可空白"></asp:RequiredFieldValidator>
        <br />
        歸還時里程數：<asp:TextBox ID="TextBox2" runat="server"></asp:TextBox>
        <asp:RangeValidator ID="RangeValidator2" runat="server" ControlToValidate="TextBox2" ErrorMessage="請輸入數字" MaximumValue="200000" MinimumValue="0" Type="Integer"></asp:RangeValidator>
        <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="TextBox2" ErrorMessage="此欄不可空白"></asp:RequiredFieldValidator>
        <hr />

        加油費用：<asp:TextBox ID="TextBox3" runat="server" TextMode="Number"></asp:TextBox>
        <asp:RangeValidator ID="RangeValidator3" runat="server" ControlToValidate="TextBox3" ErrorMessage="請輸入數字" MaximumValue="10000" MinimumValue="0" Type="Integer"></asp:RangeValidator>
        <br />
        歸還備註：<asp:TextBox ID="TextBox4" runat="server"></asp:TextBox>
        <br />
        車子檢查作業：<br />
        <%--        <asp:CheckBox ID="CheckBox1" runat="server" Text="腳煞車確實踩至定位" /><br />
        <asp:CheckBox ID="CheckBox2" runat="server" Text="座椅復原至原位" /><br />
        <asp:CheckBox ID="CheckBox3" runat="server" Text="垃圾、廣告文宣帶下車丟棄" /><br />
        <asp:CheckBox ID="CheckBox4" runat="server" Text="檢查車身是否有損傷" />
        <br />--%>
        <asp:CheckBoxList ID="CheckBoxList1" runat="server" DataSourceID="SqlDataSource2" DataTextField="Checkitem" DataValueField="Checkitem">
        </asp:CheckBoxList>
        <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:MENU %>" SelectCommand="SELECT [id], [Checkitem] FROM [TB_Carcheck]"></asp:SqlDataSource>
        <br />
        <asp:Button ID="Button1" runat="server" CssClass="btn btn-success" OnClick="Button1_Click" Text="送出" Width="100%" />
    </div>
    <div class="col-md-2">
    </div>
</asp:Content>
