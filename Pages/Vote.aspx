<%@ Page Title="" Language="C#" MasterPageFile="~/Master/JuicERP.Master" AutoEventWireup="true" CodeBehind="Vote.aspx.cs" Inherits="JuicERP.Pages.Vote" %>

<%@ Register Src="~/UserControls/Votego.ascx" TagPrefix="uc1" TagName="Votego" %>




<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

      <div class="col-md-2">
  </div>
    <div class="col-md-8">
    <asp:Panel ID="ModalPanel" runat="server" Visible="false">
        <uc1:Votego runat="server" id="Votego" />
</asp:Panel>

            <div class="panel panel-info">
                     <div class="panel-heading" align="center" style="font-size: x-large; color: #000000; font-weight: bold; font-family: 微軟正黑體;"> 
                                                  近期投票資訊 </div>
              <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:MENU %>" SelectCommand="SELECT * FROM [TB_Vote]"></asp:SqlDataSource>
              <asp:GridView ID="gvVote" runat="server" BorderStyle="None" CssClass="table table-hover table-striped" GridLines="Horizontal" AllowSorting="True" AutoGenerateColumns="False" AllowPaging="True" DataSourceID="SqlDataSource1" EnableModelValidation="True" OnRowCommand="gvVote_RowCommand">
                    <PagerSettings Position="TopAndBottom" />
                    <PagerStyle CssClass="pagination-ys" />
                  <Columns>
                      
                          
                      <asp:BoundField DataField="VoteHolder"  ItemStyle-Width="15%" HeaderText="發起人" ItemStyle-ForeColor="Red" >

                      <ItemStyle ForeColor="Red" Width="15%" />
                      </asp:BoundField>
                  
                      <asp:BoundField DataField="VoteTitle" HeaderText="活動主題">
                      <ItemStyle ForeColor="Blue" Width="40%" />
                      </asp:BoundField>
                  
                      <asp:BoundField DataField="VoteStart" HeaderText="投票開始日" HeaderStyle-Wrap="False"  ItemStyle-Width="15%" DataFormatString='{0:yyyy-MM-dd}'>
<HeaderStyle Wrap="False"></HeaderStyle>

<ItemStyle Width="15%"></ItemStyle>
                      </asp:BoundField>
                      <asp:BoundField DataField="VoteEnd" HeaderText="投票截止日" HeaderStyle-Wrap="False"  ItemStyle-Width="15%" DataFormatString='{0:yyyy-MM-dd}' >
<HeaderStyle Wrap="False"></HeaderStyle>

<ItemStyle Width="15%"></ItemStyle>
                      </asp:BoundField>
                  
                 <asp:TemplateField ItemStyle-Width="15%" HeaderText="詳細資訊">
                     <ItemTemplate>
                              <asp:Button ID="Button3" runat="server" Text="開始投票" CommandName="post"  CommandArgument='<%# Eval("VoteTitle")+",,"+Eval("VoteContent")+",,"+Eval("VoteStart")+",,"+Eval("VoteEnd")+",,"+Eval("Votelist1")+",,"+Eval("Votelist1set")+",,"+Eval("Votelist2")+",,"+Eval("Votelist2set")+",,"+Eval("Votelist3")+",,"+Eval("Votelist3set")+",,"+User.Identity.Name.ToString()+",,"+Eval("VoteID")+",,"+Eval("VoteHolder") %>' CssClass="btn btn-success btn-xs" Font-Size="Small" />
                     </ItemTemplate>

<ItemStyle Width="15%"></ItemStyle>
                 </asp:TemplateField>
                                        </Columns>
                  <RowStyle BackColor="#F7F7DE" Font-Size="Medium" VerticalAlign="Bottom" /> 
                  <HeaderStyle BackColor="#6B696B" Font-Bold="True" ForeColor="White" Font-Size="Medium" />

              </asp:GridView>

      </div>                </div>
            <div class="col-md-2">
  </div>


</asp:Content>
