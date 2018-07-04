<%@ Page Title="" Language="C#" MasterPageFile="~/Master/JuicERP.Master" AutoEventWireup="true" CodeBehind="Voteadd.aspx.cs" Inherits="JuicERP.Pages.Voteadd" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
                  <script>var imgDir = '<%=ResolveUrl("~/img") %>' + "/";	</script>
<script src="<%=ResolveUrl("~/js/popcalendar.js") %>" charset="UTF-8"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
        <div class="row">
  <div class="col-md-2"></div>
  <div class="col-md-8">

      <div class="list-group">

  <a  class="list-group-item active">
      <div style="text-align:center; font-family: 微軟正黑體;" >新增投票事件</div>
  </a>

          <a  class="list-group-item" style=" font-family: 微軟正黑體;">
      <asp:Label ID="Label1" runat="server" Text="投票主題" Width="20%" CssClass="text-center"></asp:Label>
      <asp:TextBox ID="title" runat="server" Width="70%"></asp:TextBox>
              </a>
           <a  class="list-group-item" style="text-align:center; font-family: 微軟正黑體;">
            <asp:Label ID="Label5" runat="server" Text="投票開始日期" Width="14%"></asp:Label>
 <%--     <asp:TextBox ID="TextBox1" runat="server" Width="35%"></asp:TextBox>--%>
<asp:TextBox ID="datestart" runat="server" Width="30%" Text="日期格式：2000/01/01"
          OnFocus="javascript:if(this.value=='日期格式：2000/01/01') {this.value=''}"
          OnBlur="javascript:if(this.value==''){this.value='日期格式：2000/01/01'}"></asp:TextBox>
<img align="middle" alt="" style="margin: 0 auto;" onclick="popUpCalendar(this, document.getElementById('<%= datestart.ClientID %>'), 'yyyy/mm/dd')" src="<%=ResolveUrl("~/img/calendar.gif") %>" />&nbsp;~

            <asp:Label ID="Label6" runat="server" Text="投票結束日期" Width="14%"></asp:Label>
<%--      <asp:TextBox ID="TextBox2" runat="server" Width="35%"></asp:TextBox>--%>
<asp:TextBox ID="dateend" runat="server" Width="30%" Text="日期格式：2000/01/01"
          OnFocus="javascript:if(this.value=='日期格式：2000/01/01') {this.value=''}"
          OnBlur="javascript:if(this.value==''){this.value='日期格式：2000/01/01'}"></asp:TextBox>
<img align="middle" alt="" style="margin: 0 auto;" onclick="popUpCalendar(this, document.getElementById('<%= dateend.ClientID %>'), 'yyyy/mm/dd')" src="<%=ResolveUrl("~/img/calendar.gif") %>" />
                </a>
          <a  class="list-group-item" style=" font-family: 微軟正黑體;">
            <asp:Label ID="Label10" runat="server" Text="投票說明" Width="20%" CssClass="text-center"></asp:Label>
      <asp:TextBox ID="content" runat="server" Width="70%" TextMode="MultiLine" Rows="8"></asp:TextBox>
  </a>
          <a  class="list-group-item" style=" font-family: 微軟正黑體;">
      <asp:CheckBoxList ID="CheckBoxList1" runat="server" RepeatColumns="4" CssClass="text-center" Font-Size="Large" Width="100%" AutoPostBack="True" OnSelectedIndexChanged="CheckBoxList1_SelectedIndexChanged">
          <asp:ListItem Selected="True" Enabled="False" Value="1">開放投票項目1</asp:ListItem>
          <asp:ListItem Value="2">開放投票項目2</asp:ListItem>
          <asp:ListItem Value="3">開放投票項目3</asp:ListItem>
      </asp:CheckBoxList>
  </a>

                    <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional">
               <ContentTemplate>



                <asp:Panel ID="Panel1" runat="server" Visible="true">
              <a  class="list-group-item" style=" font-family: 微軟正黑體;">         
       <asp:Label ID="Label2" runat="server" Text="投票項目1標題" Width="20%" CssClass="text-center"></asp:Label>
      <asp:TextBox ID="TextBox1" runat="server" Width="70%" Text="請輸入選項標題"></asp:TextBox>
                  <br /><br />
                  <asp:Label ID="Label7" runat="server" Text="請選擇輸入選項數(最多8個)" Width="50%" CssClass="text-right"></asp:Label>
                  <asp:DropDownList ID="DropDownList1" runat="server" OnSelectedIndexChanged="DropDownList1_SelectedIndexChanged" CssClass="text-center" Width="100px" AutoPostBack="True">
                      <asp:ListItem Text="0" Value="0" Selected="True"></asp:ListItem>
                      <asp:ListItem Text="1" Value="1"></asp:ListItem>
                      <asp:ListItem Text="2" Value="2"></asp:ListItem>
                      <asp:ListItem Text="3" Value="3"></asp:ListItem>
                      <asp:ListItem Text="4" Value="4"></asp:ListItem>
                      <asp:ListItem Text="5" Value="5"></asp:ListItem>
                      <asp:ListItem Text="6" Value="6"></asp:ListItem>
                      <asp:ListItem Text="7" Value="7"></asp:ListItem>
                      <asp:ListItem Text="8" Value="8"></asp:ListItem>
                  </asp:DropDownList>

                 <%-- <asp:TextBox ID="TextBox4" runat="server" CssClass="text-center"></asp:TextBox>
                  <asp:Button ID="Button1" runat="server" Text="開始輸入選項" OnClick="Button1_Click" />--%>
                  <br />
                   <asp:CheckBox ID="CheckBox1" runat="server" Text="開放多選" Width="100%" CssClass="text-center" ForeColor="#0000CC"/>

                  <asp:Label ID="votelistname11" runat="server" Text="選項1" CssClass="text-right" Width="23%" Visible="False"></asp:Label>
                  <asp:TextBox ID="votelist11" runat="server" Width="60%" Visible="False"></asp:TextBox>
                  <asp:Label ID="votelistname12" runat="server" Text="選項2" CssClass="text-right" Width="23%" Visible="False"></asp:Label>           
                  <asp:TextBox ID="votelist12" runat="server" Width="60%" Visible="False"></asp:TextBox>
                  <asp:Label ID="votelistname13" runat="server" Text="選項3" CssClass="text-right" Width="23%" Visible="False"></asp:Label>
                  <asp:TextBox ID="votelist13" runat="server" Width="60%" Visible="False"></asp:TextBox>
                  <asp:Label ID="votelistname14" runat="server" Text="選項4" CssClass="text-right" Width="23%" Visible="False"></asp:Label>
                  <asp:TextBox ID="votelist14" runat="server" Width="60%" Visible="False"></asp:TextBox>
                  <br />
                  <asp:Label ID="votelistname15" runat="server" Text="選項5" CssClass="text-right" Width="23%" Visible="False"></asp:Label>
                  <asp:TextBox ID="votelist15" runat="server" Width="60%" Visible="False"></asp:TextBox>
                  <asp:Label ID="votelistname16" runat="server" Text="選項6" CssClass="text-right" Width="23%" Visible="False"></asp:Label>
                  <asp:TextBox ID="votelist16" runat="server" Width="60%" Visible="False"></asp:TextBox>
                  <asp:Label ID="votelistname17" runat="server" Text="選項7" CssClass="text-right" Width="23%" Visible="False"></asp:Label>
                  <asp:TextBox ID="votelist17" runat="server" Width="60%" Visible="False"></asp:TextBox>
                  <asp:Label ID="votelistname18" runat="server" Text="選項8" CssClass="text-right" Width="23%" Visible="False"></asp:Label>
                  <asp:TextBox ID="votelist18" runat="server" Width="60%" Visible="False"></asp:TextBox>
              </a>  
                </asp:Panel>
                          <asp:Panel ID="Panel2" runat="server" Visible="false">
              <a  class="list-group-item" style=" font-family: 微軟正黑體;">         
       <asp:Label ID="Label3" runat="server" Text="投票項目2標題" Width="20%" CssClass="text-center"></asp:Label>
      <asp:TextBox ID="TextBox2" runat="server" Width="70%" Text="請輸入選項標題"></asp:TextBox>
                   <br /><br />
                  <asp:Label ID="Label8" runat="server" Text="請選擇輸入選項數(最多8個)" Width="50%" CssClass="text-right"></asp:Label>
                  <asp:DropDownList ID="DropDownList2" runat="server"  CssClass="text-center" Width="100px" AutoPostBack="True" OnSelectedIndexChanged="DropDownList2_SelectedIndexChanged">
                      <asp:ListItem Text="0" Value="0" Selected="True"></asp:ListItem>
                      <asp:ListItem Text="1" Value="1"></asp:ListItem>
                      <asp:ListItem Text="2" Value="2"></asp:ListItem>
                      <asp:ListItem Text="3" Value="3"></asp:ListItem>
                      <asp:ListItem Text="4" Value="4"></asp:ListItem>
                      <asp:ListItem Text="5" Value="5"></asp:ListItem>
                      <asp:ListItem Text="6" Value="6"></asp:ListItem>
                      <asp:ListItem Text="7" Value="7"></asp:ListItem>
                      <asp:ListItem Text="8" Value="8"></asp:ListItem>
                  </asp:DropDownList>

            
                  <br />
                   <asp:CheckBox ID="CheckBox2" runat="server" Text="開放多選" Width="100%" CssClass="text-center" ForeColor="#0000CC"/>

                  <asp:Label ID="votelistname21" runat="server" Text="選項1" CssClass="text-right" Width="23%" Visible="False"></asp:Label>
                  <asp:TextBox ID="votelist21" runat="server" Width="60%" Visible="False"></asp:TextBox>
                  <asp:Label ID="votelistname22" runat="server" Text="選項2" CssClass="text-right" Width="23%" Visible="False"></asp:Label>           
                  <asp:TextBox ID="votelist22" runat="server" Width="60%" Visible="False"></asp:TextBox>
                  <asp:Label ID="votelistname23" runat="server" Text="選項3" CssClass="text-right" Width="23%" Visible="False"></asp:Label>
                  <asp:TextBox ID="votelist23" runat="server" Width="60%" Visible="False"></asp:TextBox>
                  <asp:Label ID="votelistname24" runat="server" Text="選項4" CssClass="text-right" Width="23%" Visible="False"></asp:Label>
                  <asp:TextBox ID="votelist24" runat="server" Width="60%" Visible="False"></asp:TextBox>
                  <br />
                  <asp:Label ID="votelistname25" runat="server" Text="選項5" CssClass="text-right" Width="23%" Visible="False"></asp:Label>
                  <asp:TextBox ID="votelist25" runat="server" Width="60%" Visible="False"></asp:TextBox>
                  <asp:Label ID="votelistname26" runat="server" Text="選項6" CssClass="text-right" Width="23%" Visible="False"></asp:Label>
                  <asp:TextBox ID="votelist26" runat="server" Width="60%" Visible="False"></asp:TextBox>
                  <asp:Label ID="votelistname27" runat="server" Text="選項7" CssClass="text-right" Width="23%" Visible="False"></asp:Label>
                  <asp:TextBox ID="votelist27" runat="server" Width="60%" Visible="False"></asp:TextBox>
                  <asp:Label ID="votelistname28" runat="server" Text="選項8" CssClass="text-right" Width="23%" Visible="False"></asp:Label>
                  <asp:TextBox ID="votelist28" runat="server" Width="60%" Visible="False"></asp:TextBox>                             
              </a>
                </asp:Panel>
                          <asp:Panel ID="Panel3" runat="server" Visible="false">
              <a  class="list-group-item" style=" font-family: 微軟正黑體;">         
       <asp:Label ID="Label4" runat="server" Text="投票項目3標題" Width="20%" CssClass="text-center"></asp:Label>
      <asp:TextBox ID="TextBox3" runat="server" Width="70%" Text="請輸入選項標題"></asp:TextBox>      
                  <br /><br />
                  <asp:Label ID="Label9" runat="server" Text="請選擇輸入選項數(最多8個)" Width="50%" CssClass="text-right"></asp:Label>
                  <asp:DropDownList ID="DropDownList3" runat="server"  CssClass="text-center" Width="100px" AutoPostBack="True" OnSelectedIndexChanged="DropDownList3_SelectedIndexChanged">
                      <asp:ListItem Text="0" Value="0" Selected="True"></asp:ListItem>
                      <asp:ListItem Text="1" Value="1"></asp:ListItem>
                      <asp:ListItem Text="2" Value="2"></asp:ListItem>
                      <asp:ListItem Text="3" Value="3"></asp:ListItem>
                      <asp:ListItem Text="4" Value="4"></asp:ListItem>
                      <asp:ListItem Text="5" Value="5"></asp:ListItem>
                      <asp:ListItem Text="6" Value="6"></asp:ListItem>
                      <asp:ListItem Text="7" Value="7"></asp:ListItem>
                      <asp:ListItem Text="8" Value="8"></asp:ListItem>
                  </asp:DropDownList>

            
                  <br />
                   <asp:CheckBox ID="CheckBox3" runat="server" Text="開放多選" Width="100%" CssClass="text-center" ForeColor="#0000CC"/>

                  <asp:Label ID="votelistname31" runat="server" Text="選項1" CssClass="text-right" Width="23%" Visible="False"></asp:Label>
                  <asp:TextBox ID="votelist31" runat="server" Width="60%" Visible="False"></asp:TextBox>
                  <asp:Label ID="votelistname32" runat="server" Text="選項2" CssClass="text-right" Width="23%" Visible="False"></asp:Label>           
                  <asp:TextBox ID="votelist32" runat="server" Width="60%" Visible="False"></asp:TextBox>
                  <asp:Label ID="votelistname33" runat="server" Text="選項3" CssClass="text-right" Width="23%" Visible="False"></asp:Label>
                  <asp:TextBox ID="votelist33" runat="server" Width="60%" Visible="False"></asp:TextBox>
                  <asp:Label ID="votelistname34" runat="server" Text="選項4" CssClass="text-right" Width="23%" Visible="False"></asp:Label>
                  <asp:TextBox ID="votelist34" runat="server" Width="60%" Visible="False"></asp:TextBox>
                  <br />
                  <asp:Label ID="votelistname35" runat="server" Text="選項5" CssClass="text-right" Width="23%" Visible="False"></asp:Label>
                  <asp:TextBox ID="votelist35" runat="server" Width="60%" Visible="False"></asp:TextBox>
                  <asp:Label ID="votelistname36" runat="server" Text="選項6" CssClass="text-right" Width="23%" Visible="False"></asp:Label>
                  <asp:TextBox ID="votelist36" runat="server" Width="60%" Visible="False"></asp:TextBox>
                  <asp:Label ID="votelistname37" runat="server" Text="選項7" CssClass="text-right" Width="23%" Visible="False"></asp:Label>
                  <asp:TextBox ID="votelist37" runat="server" Width="60%" Visible="False"></asp:TextBox>
                  <asp:Label ID="votelistname38" runat="server" Text="選項8" CssClass="text-right" Width="23%" Visible="False"></asp:Label>
                  <asp:TextBox ID="votelist38" runat="server" Width="60%" Visible="False"></asp:TextBox>                                                    
              </a>
                </asp:Panel>

                                                                     </ContentTemplate>
                  <Triggers>
                      <asp:AsyncPostBackTrigger ControlID="CheckBoxList1" EventName="SelectedIndexChanged" />
                  </Triggers>
        </asp:UpdatePanel>

            <a style="align-items:center">
        <asp:Button ID="Button1" runat="server" Text="送出" CssClass="btn btn-success" Width="100%" OnClick="Button1_Click"  />
    </a>
          </div>
        </div>
  <div class="col-md-2"></div>
</div>
</asp:Content>
