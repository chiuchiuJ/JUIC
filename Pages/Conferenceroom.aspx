<%@ Page Title="" Language="C#" MasterPageFile="~/Master/JuicERP.Master" AutoEventWireup="true" CodeBehind="Conferenceroom.aspx.cs" Inherits="JuicERP.Pages.Conferenceroom" EnableEventValidation="false" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">


    <div class="col-md-2">
    </div>
    <div class="col-md-8">
        <div class="panel panel-info" style="font-family: 微軟正黑體">
            <div class="panel-heading">選擇日期並租借會議室</div>
            <div class="panel-body">
                <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                    <ContentTemplate>


                        <asp:Calendar runat="server" OnDayRender="Calendar1_DayRender" OnSelectionChanged="Calendar1_SelectionChanged" SelectedDayStyle-BorderWidth="2" SelectedDayStyle-BackColor="#3333FF" ID="Calendar1" Width="100%" BackColor="White" BorderColor="Black" Font-Names="Verdana" Font-Size="9pt" ForeColor="Black" Height="250px" NextPrevFormat="ShortMonth" BorderStyle="Solid" CellSpacing="1">
                            <DayHeaderStyle Font-Bold="True" Font-Size="8pt" ForeColor="#333333" Height="8pt" />
                            <DayStyle BackColor="#CCCCCC" />
                            <NextPrevStyle Font-Size="8pt" ForeColor="White" Font-Bold="True" />
                            <OtherMonthDayStyle ForeColor="#999999" />
                            <SelectedDayStyle BorderColor="Black" BackColor="#333399" ForeColor="Red" />
                            <TitleStyle BackColor="#333399" Font-Bold="True" Font-Size="12pt" ForeColor="White" Height="12pt" BorderStyle="Solid" />
                            <TodayDayStyle BackColor="#999999" ForeColor="#0000CC" />
                        </asp:Calendar>
                        <br />
                        <asp:Label ID="Label1" runat="server" Text="請由上方月曆選擇租借日期(未來兩周內)" Width="100%" Font-Size="X-Large" CssClass="text-center"></asp:Label>
                        <hr />

                        <asp:GridView ID="GridView3" runat="server" AutoGenerateColumns="False" BorderStyle="None" DataSourceID="SqlDataSource1" Width="100%" Font-Size="Medium" GridLines="None" OnRowDataBound="GridView3_RowDataBound" OnRowCommand="GridView3_RowCommand">
                            <Columns>
                                <asp:BoundField DataField="Roomname" HeaderText="已預約狀況" />
                                <asp:BoundField DataField="starttime" DataFormatString="{0:HHmm}" HeaderText="開始時間" />
                                <asp:BoundField DataField="endtime" DataFormatString="{0:HHmm}" HeaderText="結束時間" />
                                <asp:BoundField DataField="username" HeaderText="預約人" />
                                <asp:TemplateField HeaderText="管理功能">
                                    <ItemStyle Width="150px" />
                                    <ItemTemplate>
   
                                        <asp:Button ID="del" runat="server" Text="刪除" CommandName="del" CssClass="btn btn-success btn-xs" Visible="false" CommandArgument='<%# Eval("ID") %>' />
                                          <asp:Button ID="back" runat="server" Text="提前歸還" CommandName="back" CssClass="btn btn-danger btn-xs" Visible="false" CommandArgument='<%# Eval("ID") %>' />
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>
                        <hr />

                        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:MENU %>" SelectCommand="SELECT * FROM [TB_Conference] WHERE ([rentdate] = @rentdate) order by roomid,starttime">
                            <SelectParameters>
                                <asp:ControlParameter ControlID="Calendar1" DbType="Date" Name="rentdate" PropertyName="SelectedDate" />
                            </SelectParameters>
                        </asp:SqlDataSource>

                        <div style="text-align: center">
                            <asp:Button ID="Button2" runat="server" CssClass="btn btn-primary btn-lg" OnClick="Button2_Click" Text="預約會議室" />
                            <asp:Button ID="Button6" runat="server" CssClass="btn btn-warning btn-lg" OnClick="Button6_Click" Text="批次預約功能" />
                        </div>

                        <br />
                        <br />
                        <asp:Panel ID="Panel1" runat="server" Visible="False" Font-Size="Medium">
                            <asp:Label ID="labtime1" runat="server" Text="請選擇日期"></asp:Label>
                            <br />
                            會議室選擇<asp:DropDownList ID="DropDownList1" runat="server" DataSourceID="SqlDataSource2" DataTextField="Roomname" DataValueField="Roomid" Width="300px">
                            </asp:DropDownList>
                            <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:MENU %>" SelectCommand="SELECT * FROM [TB_ConferenceList]"></asp:SqlDataSource>
                            <br />
                            <br />
                            預約時間<asp:DropDownList ID="Drptime1" runat="server">
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

                            </asp:DropDownList>
                            <%--  <asp:TextBox ID="TextBox1" runat="server" Width="5%"></asp:TextBox>--%><asp:Label ID="Label5" runat="server" Text="時"></asp:Label>
                            <asp:DropDownList ID="Drptime2" runat="server">
                                <asp:ListItem>00</asp:ListItem>
                                <asp:ListItem>10</asp:ListItem>
                                <asp:ListItem>20</asp:ListItem>
                                <asp:ListItem>30</asp:ListItem>
                                <asp:ListItem>40</asp:ListItem>
                                <asp:ListItem>50</asp:ListItem>
                            </asp:DropDownList>
                            <%-- <asp:TextBox ID="TextBox2" runat="server" Width="5%"></asp:TextBox>--%><asp:Label ID="Label6" runat="server" Text="分"></asp:Label><br />
                            歸還時間<asp:DropDownList ID="Drptime3" runat="server">
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

                            </asp:DropDownList>
                            <%--<asp:TextBox ID="TextBox3" runat="server" Width="5%"></asp:TextBox>--%><asp:Label ID="Label7" runat="server" Text="時"></asp:Label>
                            <asp:DropDownList ID="Drptime4" runat="server">
                                <asp:ListItem>00</asp:ListItem>
                                <asp:ListItem>10</asp:ListItem>
                                <asp:ListItem>20</asp:ListItem>
                                <asp:ListItem>30</asp:ListItem>
                                <asp:ListItem>40</asp:ListItem>
                                <asp:ListItem>50</asp:ListItem>
                            </asp:DropDownList>
                            <asp:Label ID="Label34" runat="server" Text="分"></asp:Label>
                            <br />
                            <hr />
                            租借事由：<asp:TextBox ID="TextBoxwhy1" runat="server" Width="500px"></asp:TextBox>
                            <br />
                            茶水需求：<asp:DropDownList ID="Drpwater1" runat="server" Width="150px">
                                <asp:ListItem>不需要</asp:ListItem>
                                <asp:ListItem>１</asp:ListItem>
                                <asp:ListItem>２</asp:ListItem>
                                <asp:ListItem>３</asp:ListItem>
                                <asp:ListItem>４</asp:ListItem>
                                <asp:ListItem>５</asp:ListItem>
                                <asp:ListItem>６</asp:ListItem>
                                <asp:ListItem>７</asp:ListItem>
                                <asp:ListItem>８</asp:ListItem>
                                <asp:ListItem>９</asp:ListItem>
                                <asp:ListItem>１０人以上</asp:ListItem>
                            </asp:DropDownList>
                            <br />
                            預計人數：<asp:DropDownList ID="Drpman1" runat="server" Width="150px">
                                <asp:ListItem>不確定</asp:ListItem>
                                <asp:ListItem>２～５</asp:ListItem>
                                <asp:ListItem>５～９</asp:ListItem>
                                <asp:ListItem>１０人以上</asp:ListItem>
                            </asp:DropDownList>
                            <br />
                            備註事項：<asp:TextBox ID="TextBoxPS1" runat="server" Width="500px"></asp:TextBox>
                            <br />
                            <hr />
                            <br />
                            <asp:Button ID="Button1" runat="server" Text="確定預約" CssClass="btn btn-success btn-block" OnClick="Button1_Click" />

                        </asp:Panel>
                        <asp:Panel ID="Panel3" runat="server" Font-Size="Medium" Visible="False">
                            會議室選擇<asp:DropDownList ID="pzdrp1" runat="server" DataSourceID="SqlDataSource2" DataTextField="Roomname" DataValueField="Roomid" Width="300px">
                            </asp:DropDownList>
                            
                            <br />
                            預約時段：
                            <asp:DropDownList ID="pzdrp2" runat="server">
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

                            </asp:DropDownList>
                            時
                            <asp:DropDownList ID="pzdrp3" runat="server">
                                <asp:ListItem>00</asp:ListItem>
                                <asp:ListItem>10</asp:ListItem>
                                <asp:ListItem>20</asp:ListItem>
                                <asp:ListItem>30</asp:ListItem>
                                <asp:ListItem>40</asp:ListItem>
                                <asp:ListItem>50</asp:ListItem>
                            </asp:DropDownList>
                            分<br />
                            歸還時段：
                            <asp:DropDownList ID="pzdrp4" runat="server">
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

                            </asp:DropDownList>
                            時
                            <asp:DropDownList ID="pzdrp5" runat="server">
                                <asp:ListItem>00</asp:ListItem>
                                <asp:ListItem>10</asp:ListItem>
                                <asp:ListItem>20</asp:ListItem>
                                <asp:ListItem>30</asp:ListItem>
                                <asp:ListItem>40</asp:ListItem>
                                <asp:ListItem>50</asp:ListItem>
                            </asp:DropDownList>
                            分<br />
                            開始日期：
                            <asp:TextBox ID="pztex0" runat="server" TextMode="date"></asp:TextBox>(需輸入年月日YYYY/MM/DD)<br />
                            預約間隔：
                            <asp:TextBox ID="pztex1" runat="server"></asp:TextBox>天<br />
                            預約次數：
                            <asp:TextBox ID="pztex2" runat="server"></asp:TextBox>次
                            <hr />
                            租借事由：<asp:TextBox ID="pztex3" runat="server" Width="500px"></asp:TextBox>
                            <br />
                            茶水需求：<asp:DropDownList ID="pzdrp6" runat="server" Width="150px">
                                <asp:ListItem>不需要</asp:ListItem>
                                <asp:ListItem>１</asp:ListItem>
                                <asp:ListItem>２</asp:ListItem>
                                <asp:ListItem>３</asp:ListItem>
                                <asp:ListItem>４</asp:ListItem>
                                <asp:ListItem>５</asp:ListItem>
                                <asp:ListItem>６</asp:ListItem>
                                <asp:ListItem>７</asp:ListItem>
                                <asp:ListItem>８</asp:ListItem>
                                <asp:ListItem>９</asp:ListItem>
                                <asp:ListItem>１０人以上</asp:ListItem>
                            </asp:DropDownList>
                            <br />
                            預計人數：<asp:DropDownList ID="pzdrp7" runat="server" Width="150px">
                                <asp:ListItem>不確定</asp:ListItem>
                                <asp:ListItem>２～５</asp:ListItem>
                                <asp:ListItem>５～９</asp:ListItem>
                                <asp:ListItem>１０人以上</asp:ListItem>
                            </asp:DropDownList>
                            <br />
                            備註事項：<asp:TextBox ID="pztex4" runat="server" Width="500px"></asp:TextBox>
                            <br />
                            <hr />
                                                        <asp:Button ID="pzbtn" runat="server" Text="確定預約" CssClass="btn btn-success btn-block" OnClick="pzbtn_Click" />

                        
                        </asp:Panel>



                    </ContentTemplate>
                    <Triggers>
                        <asp:AsyncPostBackTrigger ControlID="Calendar1" EventName="SelectionChanged" />
                    </Triggers>
                </asp:UpdatePanel>

                <asp:Panel ID="Panel2" runat="server" Visible="False" HorizontalAlign="Center">
                    <br />
                    <asp:Label ID="Label2" runat="server" Text="管理部瀏覽表格" Width="100%" Font-Size="X-Large" CssClass="text-center"></asp:Label>
                    <br />
                    <asp:Button ID="Button5" runat="server" CssClass="btn btn-danger" OnClick="Button5_Click" Text="刪除三天前所有租借資料" />
                    <br />
                    <%--                         <asp:GridView ID="GridView1" runat="server" AllowSorting="True" AutoGenerateColumns="False" BackColor="White" BorderColor="#CCCCCC" BorderStyle="None" BorderWidth="1px" CellPadding="3" DataSourceID="SqlDataSource3" Width="100%" Font-Size="Medium">
                            <Columns>
                                <asp:CommandField ShowDeleteButton="True" ShowEditButton="True" />
                                <asp:BoundField DataField="Roomname" HeaderText="會議室" SortExpression="Roomname" />
                                <asp:BoundField DataField="starttime" DataFormatString="{0:HHmm}" HeaderText="預約開始" SortExpression="starttime" />
                                <asp:BoundField DataField="endtime" DataFormatString="{0:HHmm}" HeaderText="預約結束" SortExpression="endtime" />
                                <asp:BoundField DataField="userid" HeaderText="預約人" SortExpression="userid" />
                                <asp:BoundField DataField="purpose" HeaderText="租借事由" SortExpression="purpose" />
                                <asp:BoundField DataField="water" HeaderText="茶水需求" SortExpression="water" />
                                <asp:BoundField DataField="people" HeaderText="預約人數" SortExpression="people" />
                                <asp:BoundField DataField="PS" HeaderText="備註" SortExpression="PS" />
                            </Columns>
                            <FooterStyle BackColor="White" ForeColor="#000066" />
                            <HeaderStyle BackColor="#006699" Font-Bold="True" ForeColor="White" />
                            <PagerStyle BackColor="White" ForeColor="#000066" HorizontalAlign="Left" />
                            <RowStyle ForeColor="#000066" />
                            <SelectedRowStyle BackColor="#669999" Font-Bold="True" ForeColor="White" />
                            <SortedAscendingCellStyle BackColor="#F1F1F1" />
                            <SortedAscendingHeaderStyle BackColor="#007DBB" />
                            <SortedDescendingCellStyle BackColor="#CAC9C9" />
                            <SortedDescendingHeaderStyle BackColor="#00547E" />
                        </asp:GridView>
                            <asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:MENU %>" DeleteCommand="DELETE FROM [TB_Conference] WHERE [ID] = @ID" InsertCommand="INSERT INTO [TB_Conference] ([Roomid], [Roomname], [rentdate], [starttime], [endtime], [userid], [purpose], [water], [people], [PS]) VALUES (@Roomid, @Roomname, @rentdate, @starttime, @endtime, @userid, @purpose, @water, @people, @PS)" SelectCommand="SELECT * FROM [TB_Conference] WHERE ([rentdate] = @rentdate) ORDER BY [Roomid], [starttime]" UpdateCommand="UPDATE [TB_Conference] SET [Roomid] = @Roomid, [Roomname] = @Roomname, [rentdate] = @rentdate, [starttime] = @starttime, [endtime] = @endtime, [userid] = @userid, [purpose] = @purpose, [water] = @water, [people] = @people, [PS] = @PS WHERE [ID] = @ID">
                                <DeleteParameters>
                                    <asp:Parameter Name="ID" Type="Int32" />
                                </DeleteParameters>
                                <InsertParameters>
                                    <asp:Parameter Name="Roomid" Type="Int32" />
                                    <asp:Parameter Name="Roomname" Type="String" />
                                    <asp:Parameter DbType="Date" Name="rentdate" />
                                    <asp:Parameter Name="starttime" Type="DateTime" />
                                    <asp:Parameter Name="endtime" Type="DateTime" />
                                    <asp:Parameter Name="userid" Type="String" />
                                    <asp:Parameter Name="purpose" Type="String" />
                                    <asp:Parameter Name="water" Type="String" />
                                    <asp:Parameter Name="people" Type="String" />
                                    <asp:Parameter Name="PS" Type="String" />
                                </InsertParameters>
                                <SelectParameters>
                                    <asp:ControlParameter ControlID="Calendar1" DbType="Date" Name="rentdate" PropertyName="SelectedDate" />
                                </SelectParameters>
                                <UpdateParameters>
                                    <asp:Parameter Name="Roomid" Type="Int32" />
                                    <asp:Parameter Name="Roomname" Type="String" />
                                    <asp:Parameter DbType="Date" Name="rentdate" />
                                    <asp:Parameter Name="starttime" Type="DateTime" />
                                    <asp:Parameter Name="endtime" Type="DateTime" />
                                    <asp:Parameter Name="userid" Type="String" />
                                    <asp:Parameter Name="purpose" Type="String" />
                                    <asp:Parameter Name="water" Type="String" />
                                    <asp:Parameter Name="people" Type="String" />
                                    <asp:Parameter Name="PS" Type="String" />
                                    <asp:Parameter Name="ID" Type="Int32" />
                                </UpdateParameters>
                            </asp:SqlDataSource>--%>
                    <div align="center">
<asp:Calendar ID="Calendar2" runat="server" BackColor="White" BorderColor="Black" DayNameFormat="Shortest" Font-Names="Times New Roman" Font-Size="10pt" ForeColor="Black" Height="85px" NextPrevFormat="FullMonth" OnSelectionChanged="Calendar2_SelectionChanged" TitleFormat="Month" Width="229px">
                        <DayHeaderStyle BackColor="#CCCCCC" Font-Bold="True" Font-Size="7pt" ForeColor="#333333" Height="10pt" />
                        <DayStyle Width="14%" />
                        <NextPrevStyle Font-Size="8pt" ForeColor="White" />
                        <OtherMonthDayStyle ForeColor="#999999" />
                        <SelectedDayStyle BackColor="#CC3333" ForeColor="White" />
                        <SelectorStyle BackColor="#CCCCCC" Font-Bold="True" Font-Names="Verdana" Font-Size="8pt" ForeColor="#333333" Width="1%" />
                        <TitleStyle BackColor="Black" Font-Bold="True" Font-Size="13pt" ForeColor="White" Height="14pt" />
                        <TodayDayStyle BackColor="#CCCC99" />
                    </asp:Calendar>
                    </div>
                    
                    <asp:Button ID="Button3" runat="server" OnClick="Button3_Click" Text="顯示全部租借狀況" CssClass="btn btn-success" />
                    <asp:Button ID="Button4" runat="server" CssClass="btn btn-primary" OnClick="Button4_Click" Text="EXCEL資料匯出" />
                    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="ID" DataSourceID="SqlDataSource3" OnRowDataBound="GridView1_RowDataBound" OnRowDeleted="GridView1_RowDeleted" OnRowUpdated="GridView1_RowUpdated" Width="100%" AllowPaging="True" AllowSorting="True" PageSize="20">
                        <Columns>
                            <asp:TemplateField HeaderText="會議室" SortExpression="Roomname">
                                <EditItemTemplate>
                                         <asp:Label ID="Label3" runat="server" Text='<%# Bind("Roomname") %>'></asp:Label>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="Label1" runat="server" Text='<%# Bind("Roomname") %>'></asp:Label>
                                    <asp:HiddenField ID="HiddenField1" runat="server" Value='<%# Bind("Roomid") %>' />
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:BoundField DataField="rentdate" DataFormatString="{0:d}" HeaderText="使用日期" SortExpression="starttime" />
                            <asp:BoundField DataField="starttime" DataFormatString="{0:HHmm}" HeaderText="預約時間" SortExpression="starttime" />
                            <asp:BoundField DataField="endtime" DataFormatString="{0:HHmm}" HeaderText="結束時間" SortExpression="endtime" />
                            <asp:TemplateField HeaderText="預約人" SortExpression="username">
                                <EditItemTemplate>
                                 <asp:Label ID="Label4" runat="server" Text='<%# Bind("username") %>'></asp:Label>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="Label2" runat="server" Text='<%# Bind("username") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:BoundField DataField="purpose" HeaderText="事由" SortExpression="purpose" />
                            <asp:BoundField DataField="water" HeaderText="茶水準備" SortExpression="water" />
                            <asp:BoundField DataField="people" HeaderText="預計人數" SortExpression="people" />
                            <asp:BoundField DataField="PS" HeaderText="備註" SortExpression="PS" />
                        </Columns>
                    </asp:GridView>
                    <asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:MENU %>" DeleteCommand="DELETE FROM [TB_Conference] WHERE [ID] = @ID" InsertCommand="INSERT INTO [TB_Conference] ([Roomid], [Roomname], [rentdate], [starttime], [endtime], [userid], [purpose], [water], [people], [PS]) VALUES (@Roomid, @Roomname, @rentdate, @starttime, @endtime, @userid, @purpose, @water, @people, @PS)" SelectCommand="SELECT * FROM [TB_Conference] WHERE ([rentdate] = @rentdate) order by Roomid,starttime" UpdateCommand="UPDATE [TB_Conference] SET  [rentdate] = @rentdate, [starttime] = @starttime, [endtime] = @endtime,  [purpose] = @purpose, [water] = @water, [people] = @people, [PS] = @PS WHERE [ID] = @ID">
                        <DeleteParameters>
                            <asp:Parameter Name="ID" Type="Int32" />
                        </DeleteParameters>
                        <InsertParameters>
                            <asp:Parameter Name="Roomid" Type="Int32" />
                            <asp:Parameter Name="Roomname" Type="String" />
                            <asp:Parameter DbType="Date" Name="rentdate" />
                            <asp:Parameter Name="starttime" Type="DateTime" />
                            <asp:Parameter Name="endtime" Type="DateTime" />
                            <asp:Parameter Name="userid" Type="String" />
                            <asp:Parameter Name="purpose" Type="String" />
                            <asp:Parameter Name="water" Type="String" />
                            <asp:Parameter Name="people" Type="String" />
                            <asp:Parameter Name="PS" Type="String" />
                        </InsertParameters>
                        <SelectParameters>
                            <asp:ControlParameter ControlID="Calendar2" DbType="Date" Name="rentdate" PropertyName="SelectedDate" />
                        </SelectParameters>
                        <UpdateParameters>
                            <asp:Parameter DbType="Date" Name="rentdate" />
                            <asp:Parameter Name="starttime" Type="DateTime" />
                            <asp:Parameter Name="endtime" Type="DateTime" />
                            <asp:Parameter Name="purpose" Type="String" />
                            <asp:Parameter Name="water" Type="String" />
                            <asp:Parameter Name="people" Type="String" />
                            <asp:Parameter Name="PS" Type="String" />
                            <asp:Parameter Name="ID" Type="Int32" />
                        </UpdateParameters>
                    </asp:SqlDataSource>
                    <asp:SqlDataSource ID="SqlDataSource4" runat="server" ConnectionString="<%$ ConnectionStrings:MENU %>" DeleteCommand="DELETE FROM [TB_Conference] WHERE [ID] = @ID" InsertCommand="INSERT INTO [TB_Conference] ([Roomid], [Roomname], [rentdate], [starttime], [endtime], [userid], [purpose], [water], [people], [PS]) VALUES (@Roomid, @Roomname, @rentdate, @starttime, @endtime, @userid, @purpose, @water, @people, @PS)" SelectCommand="SELECT * FROM [TB_Conference]  order by rentdate desc ,Roomid,starttime" UpdateCommand="UPDATE [TB_Conference] SET [Roomid] = @Roomid, [Roomname] = @Roomname, [rentdate] = @rentdate, [starttime] = @starttime, [endtime] = @endtime, [userid] = @userid, [purpose] = @purpose, [water] = @water, [people] = @people, [PS] = @PS WHERE [ID] = @ID">
                        <DeleteParameters>
                            <asp:Parameter Name="ID" Type="Int32" />
                        </DeleteParameters>
                        <InsertParameters>
                            <asp:Parameter Name="Roomid" Type="Int32" />
                            <asp:Parameter Name="Roomname" Type="String" />
                            <asp:Parameter DbType="Date" Name="rentdate" />
                            <asp:Parameter Name="starttime" Type="DateTime" />
                            <asp:Parameter Name="endtime" Type="DateTime" />
                            <asp:Parameter Name="userid" Type="String" />
                            <asp:Parameter Name="purpose" Type="String" />
                            <asp:Parameter Name="water" Type="String" />
                            <asp:Parameter Name="people" Type="String" />
                            <asp:Parameter Name="PS" Type="String" />
                        </InsertParameters>
                        <UpdateParameters>
                            <asp:Parameter Name="Roomid" Type="Int32" />
                            <asp:Parameter Name="Roomname" Type="String" />
                            <asp:Parameter DbType="Date" Name="rentdate" />
                            <asp:Parameter Name="starttime" Type="DateTime" />
                            <asp:Parameter Name="endtime" Type="DateTime" />
                            <asp:Parameter Name="userid" Type="String" />
                            <asp:Parameter Name="purpose" Type="String" />
                            <asp:Parameter Name="water" Type="String" />
                            <asp:Parameter Name="people" Type="String" />
                            <asp:Parameter Name="PS" Type="String" />
                            <asp:Parameter Name="ID" Type="Int32" />
                        </UpdateParameters>
                    </asp:SqlDataSource>
                    <asp:Label ID="checkma" runat="server" Text="Label" Visible="False"></asp:Label>
                    <br />
                </asp:Panel>
                <br />
                <br />
            </div>

        </div>



    </div>
    <div class="col-md-2">
    </div>

</asp:Content>
