<%@ Page Title="" Language="C#" MasterPageFile="~/Master/JuicERP.Master" AutoEventWireup="true" CodeBehind="VoteResult.aspx.cs" Inherits="JuicERP.Pages.VoteResult" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
            <link href="../css/bootstrap-select.css" rel="stylesheet" />
    <link href="../css/bootstrap-select.min.css" rel="stylesheet" />
    <script src="../js/bootstrap-select.js" type="text/javascript"></script>
    <script src="//ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

            <div class="row">
  <div class="col-md-2"></div>
  <div class="col-md-8" style="font-family: 微軟正黑體">
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:MENU %>" SelectCommand="  SELECT  a.VoteNumber,a.VoteItemno,b.VoteItem,count(a.VoteItemno) as'result',cast(count(a.VoteItemno)as float)/(select count(VoteItemno)  from TB_VoteResultList  where VoteNumber='1'and VoteID=@VoteID) as 'percent'
  FROM TB_VoteResultList a, TB_VoteList b
  where a.VoteID=b.VoteID and a.VoteID=@VoteID and a.VoteNumber=b.VoteNumber and a.VoteNumber='1' and a.VoteItemno=b.VoteItemno
  group by a.VoteNumber,a.VoteItemno,b.VoteItem">
        <SelectParameters>
            <asp:ControlParameter ControlID="DropDownList1" Name="VoteID" PropertyName="SelectedValue" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>


    <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:MENU %>" SelectCommand="  SELECT  a.VoteNumber,a.VoteItemno,b.VoteItem,count(a.VoteItemno) as'result',cast(count(a.VoteItemno)as float)/(select count(VoteItemno)  from TB_VoteResultList  where VoteNumber='2'and VoteID=@VoteID) as 'percent'
  FROM TB_VoteResultList a, TB_VoteList b
  where a.VoteID=b.VoteID and a.VoteID=@VoteID and a.VoteNumber=b.VoteNumber and a.VoteNumber='2' and a.VoteItemno=b.VoteItemno
  group by a.VoteNumber,a.VoteItemno,b.VoteItem">
        <SelectParameters>
            <asp:ControlParameter ControlID="DropDownList1" Name="VoteID" PropertyName="SelectedValue" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>


    <asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:MENU %>" SelectCommand="  SELECT  a.VoteNumber,a.VoteItemno,b.VoteItem,count(a.VoteItemno) as'result',cast(count(a.VoteItemno)as float)/(select count(VoteItemno)  from TB_VoteResultList  where VoteNumber='3'and VoteID=@VoteID) as 'percent'
  FROM TB_VoteResultList a, TB_VoteList b
  where a.VoteID=b.VoteID and a.VoteID=@VoteID and a.VoteNumber=b.VoteNumber and a.VoteNumber='3' and a.VoteItemno=b.VoteItemno
  group by a.VoteNumber,a.VoteItemno,b.VoteItem">
        <SelectParameters>
            <asp:ControlParameter ControlID="DropDownList1" Name="VoteID" PropertyName="SelectedValue" Type="Int32" DefaultValue="0" />
        </SelectParameters>
    </asp:SqlDataSource>
      <asp:SqlDataSource ID="SqlDataSource4" runat="server" ConnectionString="<%$ ConnectionStrings:MENU %>" SelectCommand="SELECT [VoteID], [VoteTitle] FROM [TB_Vote]"></asp:SqlDataSource>
      <asp:SqlDataSource ID="SqlDataSource5" runat="server" ConnectionString="<%$ ConnectionStrings:MENU %>" SelectCommand="  select VoteCHN
  from [dbo].[TB_VoteList]
  where VoteID=@VoteID
  Group by VoteCHN,VoteNumber
  order by VoteNumber">
          <SelectParameters>
              <asp:ControlParameter ControlID="DropDownList1" Name="VoteID" PropertyName="SelectedValue" />
          </SelectParameters>
      </asp:SqlDataSource>

      <div align="center"  style="font-size: medium">請選擇要查詢的活動</div>
      <asp:DropDownList ID="DropDownList1" runat="server" AutoPostBack="True" DataSourceID="SqlDataSource4" DataTextField="VoteTitle" DataValueField="VoteID"  CssClass="selectpicker" data-width="100%" data-style="btn-warning" OnSelectedIndexChanged="DropDownList1_SelectedIndexChanged" AppendDataBoundItems="True">
          <asp:ListItem Value="0">請選擇</asp:ListItem>
      </asp:DropDownList>

<%--      不刷新設定--%>
          <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional">
               <ContentTemplate>

      <br />
          <br />
      <div class="panel panel-success">
  <div class="panel-heading">
    <h2 class="panel-title" style="text-align: center;">
        <asp:Label ID="Labeltitle1" runat="server" Text="Title" Font-Size="Medium" Font-Names="微軟正黑體" Visible="False"></asp:Label></h2>
  </div>
  <div class="panel-body">
    <asp:GridView ID="GridView1" runat="server" AllowSorting="True" AutoGenerateColumns="False" DataSourceID="SqlDataSource1" EnableModelValidation="True" CssClass="table table-hover table-striped" Font-Names="微軟正黑體" Visible="False">
          <PagerSettings Position="TopAndBottom" />
           <PagerStyle CssClass="pagination-ys" />
        <Columns>
            <asp:BoundField DataField="VoteItemno" HeaderText="選項編號" SortExpression="VoteItemno" ItemStyle-Width="20%" />
            <asp:BoundField DataField="VoteItem" HeaderText="選項名稱" SortExpression="VoteItem" ItemStyle-Width="40%"/>
            <asp:BoundField DataField="result" HeaderText="得票數" SortExpression="result" ReadOnly="True" ItemStyle-Width="20%"/>
            <asp:BoundField DataField="percent" HeaderText="得票率" ReadOnly="True" SortExpression="percent" DataFormatString="{0:P0}" ItemStyle-Width="20%"/>
        </Columns>
    </asp:GridView>
      </div>
              </div>
            <div class="panel panel-primary">
  <div class="panel-heading">
    <h2 class="panel-title" style="text-align: center;">
        <asp:Label ID="Labeltitle2" runat="server" Text="Title" Font-Size="Medium" Font-Names="微軟正黑體" Visible="False"></asp:Label></h2>
  </div>
  <div class="panel-body">
    <asp:GridView ID="GridView2" runat="server" AllowSorting="True" AutoGenerateColumns="False" DataSourceID="SqlDataSource2" EnableModelValidation="True" CssClass="table table-hover table-striped" Font-Names="微軟正黑體" Visible="False">
          <PagerSettings Position="TopAndBottom" />
           <PagerStyle CssClass="pagination-ys" />
        <Columns>
            <asp:BoundField DataField="VoteItemno" HeaderText="選項編號" SortExpression="VoteItemno" ItemStyle-Width="20%"/>
            <asp:BoundField DataField="VoteItem" HeaderText="選項名稱" SortExpression="VoteItem" ItemStyle-Width="40%"/>
            <asp:BoundField DataField="result" HeaderText="得票數" SortExpression="result" ReadOnly="True" ItemStyle-Width="20%"/>
            <asp:BoundField DataField="percent" HeaderText="得票率" ReadOnly="True" SortExpression="percent" DataFormatString="{0:P0}" ItemStyle-Width="20%"/>
        </Columns>
    </asp:GridView>
      </div>
              </div>
            <div class="panel panel-danger">
  <div class="panel-heading">
    <h2 class="panel-title" style="text-align: center;">
        <asp:Label ID="Labeltitle3" runat="server" Text="Title" Font-Size="Medium" Font-Names="微軟正黑體" Visible="False"></asp:Label></h2>
  </div>
  <div class="panel-body">
    <asp:GridView ID="GridView3" runat="server" AllowSorting="True" AutoGenerateColumns="False" DataSourceID="SqlDataSource3" EnableModelValidation="True" CssClass="table table-hover table-striped" Font-Names="微軟正黑體" Visible="False">
          <PagerSettings Position="TopAndBottom" />
           <PagerStyle CssClass="pagination-ys" />
        <Columns>
            <asp:BoundField DataField="VoteItemno" HeaderText="選項編號" SortExpression="VoteItemno" ItemStyle-Width="20%"/>
            <asp:BoundField DataField="VoteItem" HeaderText="選項名稱" SortExpression="VoteItem" ItemStyle-Width="40%"/>
            <asp:BoundField DataField="result" HeaderText="得票數" SortExpression="result" ReadOnly="True" ItemStyle-Width="20%"/>
            <asp:BoundField DataField="percent" HeaderText="得票率" ReadOnly="True" SortExpression="percent" DataFormatString="{0:P0}" ItemStyle-Width="20%"/>
        </Columns>
    </asp:GridView>
      </div>
              </div>
                                                  </ContentTemplate>
                  <Triggers>
                      <asp:AsyncPostBackTrigger ControlID="DropDownList1" EventName="SelectedIndexChanged" />
                  </Triggers>
        </asp:UpdatePanel>
  <div class="col-md-2"></div>
</div></div>

</asp:Content>
