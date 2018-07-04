<%@ Page Title="" Language="C#" MasterPageFile="~/Master/JuicERP.Master" AutoEventWireup="true" CodeBehind="Carrent.aspx.cs" Inherits="JuicERP.Pages.Carrent" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script>var imgDir = '<%=ResolveUrl("~/img") %>' + "/";	</script>
    <script src="<%=ResolveUrl("~/js/popcalendar.js") %>" charset="UTF-8"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="col-md-2">
    </div>
    <div class="col-md-8">

        <div class="panel panel-info" style="font-family: 微軟正黑體">
            <div class="panel-heading">選擇日期並查看三日內租借狀況</div>
            <div class="panel-body">
                <asp:Label ID="usname" runat="server" Text="" Visible="False"></asp:Label>
                <asp:Label ID="manage" runat="server" Text="false" Visible="False"></asp:Label>
                <asp:Calendar runat="server" OnDayRender="Calendar1_DayRender" OnSelectionChanged="Calendar1_SelectionChanged" SelectedDayStyle-BorderWidth="2" SelectedDayStyle-BackColor="#3333FF" ID="Calendar1" Width="100%" BackColor="White" BorderColor="Black" Font-Names="Times New Roman" Font-Size="10pt" ForeColor="Black" Height="220px" NextPrevFormat="FullMonth">
                    <DayHeaderStyle BackColor="#CCCCCC" Font-Bold="True" Font-Size="7pt" ForeColor="#333333" Height="10pt" HorizontalAlign="Justify" />
                    <DayStyle Width="14%" />
                    <NextPrevStyle Font-Size="8pt" ForeColor="White" />
                    <OtherMonthDayStyle ForeColor="Silver" />
                    <SelectedDayStyle BorderColor="Black" BackColor="#CC3333" />
                    <SelectorStyle BackColor="#CCCCCC" Font-Bold="True" Font-Names="Verdana" Font-Size="8pt" ForeColor="#333333" Width="1%" />
                    <TitleStyle BackColor="Black" Font-Bold="True" Font-Size="13pt" ForeColor="White" Height="14pt" />
                    <TodayDayStyle BorderColor="Black" BackColor="#CCCC99" />
                </asp:Calendar>
                正在查詢<asp:Label ID="Label1" runat="server" Text="[未選日期]"></asp:Label>
                到<asp:Label ID="Label2" runat="server" Text="[未選日期]"></asp:Label>
                的車輛使用狀況<asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:MENU %>" DeleteCommand="DELETE FROM [TB_Carrentdata] WHERE [id] = @id" InsertCommand="INSERT INTO [TB_Carrentdata] ([car_no], [car_name], [emp_no], [emp_cne], [username], [applydate], [startrent], [endrent], [startrent2], [endrent2], [destination], [gotoYN], [backYN], [gasoline1], [gasoline2], [Fuelcosts], [PS], [PS2]) VALUES (@car_no, @car_name, @emp_no, @emp_cne, @username, @applydate, @startrent, @endrent, @startrent2, @endrent2, @destination, @gotoYN, @backYN, @gasoline1, @gasoline2, @Fuelcosts, @PS, @PS2)" SelectCommand="SELECT * FROM [TB_Carrentdata] WHERE ((startrent BETWEEN @startrent AND @endrent) OR (@startrent BETWEEN startrent AND endrent)) order by car_no ,startrent" UpdateCommand="UPDATE [TB_Carrentdata] SET [car_no] = @car_no, [car_name] = @car_name, [emp_no] = @emp_no, [emp_cne] = @emp_cne, [username] = @username, [applydate] = @applydate, [startrent] = @startrent, [endrent] = @endrent, [startrent2] = @startrent2, [endrent2] = @endrent2, [destination] = @destination, [gotoYN] = @gotoYN, [backYN] = @backYN, [gasoline1] = @gasoline1, [gasoline2] = @gasoline2, [Fuelcosts] = @Fuelcosts, [PS] = @PS, [PS2] = @PS2 WHERE [id] = @id">
                    <DeleteParameters>
                        <asp:Parameter Name="id" Type="Int32" />
                    </DeleteParameters>
                    <InsertParameters>
                        <asp:Parameter Name="car_no" Type="Int32" />
                        <asp:Parameter Name="car_name" Type="String" />
                        <asp:Parameter Name="emp_no" Type="String" />
                        <asp:Parameter Name="emp_cne" Type="String" />
                        <asp:Parameter Name="username" Type="String" />
                        <asp:Parameter Name="applydate" Type="DateTime" />
                        <asp:Parameter Name="startrent" Type="DateTime" />
                        <asp:Parameter Name="endrent" Type="DateTime" />
                        <asp:Parameter Name="startrent2" Type="DateTime" />
                        <asp:Parameter Name="endrent2" Type="DateTime" />
                        <asp:Parameter Name="destination" Type="String" />
                        <asp:Parameter Name="gotoYN" Type="String" />
                        <asp:Parameter Name="backYN" Type="String" />
                        <asp:Parameter Name="gasoline1" Type="String" />
                        <asp:Parameter Name="gasoline2" Type="String" />
                        <asp:Parameter Name="Fuelcosts" Type="String" />
                        <asp:Parameter Name="PS" Type="String" />
                        <asp:Parameter Name="PS2" Type="String" />
                    </InsertParameters>
                    <SelectParameters>
                        <asp:ControlParameter ControlID="Label1" Name="startrent" PropertyName="Text" Type="DateTime" />
                        <asp:ControlParameter ControlID="Label2" Name="endrent" PropertyName="Text" />
                    </SelectParameters>
                    <UpdateParameters>
                        <asp:Parameter Name="car_no" Type="Int32" />
                        <asp:Parameter Name="car_name" Type="String" />
                        <asp:Parameter Name="emp_no" Type="String" />
                        <asp:Parameter Name="emp_cne" Type="String" />
                        <asp:Parameter Name="username" Type="String" />
                        <asp:Parameter Name="applydate" Type="DateTime" />
                        <asp:Parameter Name="startrent" Type="DateTime" />
                        <asp:Parameter Name="endrent" Type="DateTime" />
                        <asp:Parameter Name="startrent2" Type="DateTime" />
                        <asp:Parameter Name="endrent2" Type="DateTime" />
                        <asp:Parameter Name="destination" Type="String" />
                        <asp:Parameter Name="gotoYN" Type="String" />
                        <asp:Parameter Name="backYN" Type="String" />
                        <asp:Parameter Name="gasoline1" Type="String" />
                        <asp:Parameter Name="gasoline2" Type="String" />
                        <asp:Parameter Name="Fuelcosts" Type="String" />
                        <asp:Parameter Name="PS" Type="String" />
                        <asp:Parameter Name="PS2" Type="String" />
                        <asp:Parameter Name="id" Type="Int32" />
                    </UpdateParameters>
                </asp:SqlDataSource>
                <div align="center">
                    <asp:Label ID="Label3" runat="server" Text="車輛使用中" BackColor="Pink"></asp:Label>

                    <asp:Label ID="Label4" runat="server" Text="已歸還" BackColor="PaleGreen"></asp:Label>

                    <asp:Label ID="Label10" runat="server" Text="車輛已預約但尚未出發" BackColor="Silver"></asp:Label>

                </div>
                <asp:GridView ID="GridView1" runat="server" AllowPaging="True" AutoGenerateColumns="False" DataSourceID="SqlDataSource3" PageSize="6" CssClass="table table-hover" GridLines="Horizontal" OnRowDataBound="GridView1_RowDataBound" AllowSorting="True" OnRowCommand="GridView1_RowCommand">
                    <PagerSettings Position="TopAndBottom" />
                    <PagerStyle CssClass="pagination-ys" />
                    <Columns>

                        <asp:BoundField DataField="car_name" HeaderText="車名" SortExpression="car_name" />
                        <asp:BoundField DataField="emp_cne" HeaderText="預約人" SortExpression="emp_cne" />
                        <asp:BoundField DataField="username" HeaderText="使用者" SortExpression="user" />
                        <asp:BoundField DataField="startrent" DataFormatString="{0:yyyy/MM/dd HH:mm}" HeaderText="預約開始時間" SortExpression="startrent" />
                        <asp:BoundField DataField="endrent" DataFormatString="{0:yyyy/MM/dd HH:mm}" HeaderText="預定歸還時間" SortExpression="endrent" />
                        <asp:BoundField DataField="gotoYN" HeaderText="出發" SortExpression="check" />

                        <asp:BoundField DataField="backYN" HeaderText="歸還" SortExpression="backYN" />

                        <asp:TemplateField HeaderText="管理">
                            <ItemTemplate>
                                <asp:Button ID="remove" runat="server" Text="取消" CommandName="remove" CssClass="btn btn-danger btn-xs" Visible="false" CommandArgument='<%# Eval("id") %>' />
                                <asp:Button ID="go" runat="server" Text="確認出發" CommandName="go" CssClass="btn btn-primary btn-xs" Visible="false" CommandArgument='<%# Eval("id") %>' />
                                <asp:Button ID="checkback" runat="server" Text="確認歸還" CommandName="checkback" CssClass="btn btn-warning btn-xs" Visible="false" CommandArgument='<%# Eval("id") %>' />
                                <asp:Button ID="back" runat="server" Text="歸還資料" CommandName="back" CssClass="btn  btn-xs" Visible="false" CommandArgument='<%# Eval("id") %>' />
                                <asp:Button ID="manage" runat="server" Text="管理" CommandName="manage" CssClass="btn btn-success btn-xs" Visible="false" CommandArgument='<%# Eval("id") %>' />

                            </ItemTemplate>
                        </asp:TemplateField>

                    </Columns>
                </asp:GridView>



                <asp:Button ID="Button1" runat="server" Text="我要預約公務車" CssClass="btn btn-default btn-lg" OnClick="Button1_Click" />
                <asp:Panel ID="Panel1" runat="server" Visible="false">
                    <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Always">
                        <ContentTemplate>
                            目前使用中公務車：<asp:Label ID="Label9" runat="server" Text="無" ForeColor="Red"></asp:Label><br />
                            <hr />
                            預約時間<br />
                            <asp:TextBox ID="datestart" runat="server" Width="30%" Text="日期格式：2000/01/01"
                                OnFocus="javascript:if(this.value=='日期格式：2000/01/01') {this.value=''}"
                                OnBlur="javascript:if(this.value==''){this.value='日期格式：2000/01/01'}"></asp:TextBox>
                            <img align="middle" alt="" style="margin: 0 auto;" onclick="popUpCalendar(this, document.getElementById('<%= datestart.ClientID %>'), 'yyyy/mm/dd')" src="<%=ResolveUrl("~/img/calendar.gif") %>" />
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
                            <%-- <asp:TextBox ID="TextBox2" runat="server" Width="5%"></asp:TextBox>--%><asp:Label ID="Label6" runat="server" Text="分"></asp:Label><br />
                            歸還時間<br />
                            <asp:TextBox ID="dateend" runat="server" Width="30%" Text="日期格式：2000/01/01"
                                OnFocus="javascript:if(this.value=='日期格式：2000/01/01') {this.value=''}"
                                OnBlur="javascript:if(this.value==''){this.value='日期格式：2000/01/01'}"></asp:TextBox>
                            <img align="middle" alt="" style="margin: 0 auto;" onclick="popUpCalendar(this, document.getElementById('<%= dateend.ClientID %>'), 'yyyy/mm/dd')" src="<%=ResolveUrl("~/img/calendar.gif") %>" />
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
                            <hr />
                            選擇車子：<asp:DropDownList ID="DropDownList1" runat="server" DataSourceID="SqlDataSource2" DataTextField="car_name" DataValueField="car_no"></asp:DropDownList>
                            <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:MENU %>" SelectCommand="SELECT * FROM [TB_Carlist] WHERE ([useYN] = @useYN)">
                                <SelectParameters>
                                    <asp:Parameter DefaultValue="Y" Name="useYN" Type="String" />
                                </SelectParameters>
                            </asp:SqlDataSource>

                            <hr />
                            使用人：<asp:TextBox ID="TextBox1" runat="server"></asp:TextBox>(請輸入正確的使用人中文姓名，若為空白將自動填入申請人)<br />
                            目的地：<asp:TextBox ID="TextBox2" runat="server"></asp:TextBox>
                            <br />
                            備註欄：<asp:TextBox ID="TextBox3" runat="server"></asp:TextBox>

                            <hr />
                        </ContentTemplate>
                    </asp:UpdatePanel>
                    <asp:Button ID="Button2" runat="server" Text="確定預約" CssClass="btn btn-success btn-block" OnClick="Button2_Click" />
                </asp:Panel>


            </div>

        </div>


    </div>
    <div class="col-md-2">
    </div>
</asp:Content>
