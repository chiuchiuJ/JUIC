<%@ Page Title="" Language="C#" MasterPageFile="~/Master/JuicERP.Master" AutoEventWireup="true" CodeBehind="Download.aspx.cs" Inherits="JuicERP.Pages.Download" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">
.fileUpload {   
    position: relative;   
    overflow: hidden;   
    margin: 10px;   
}   
.fileUpload input.upload {   
    position: absolute;   
    top: 0;   
    right: 0;   
    margin: 0;   
    padding: 0;   
    font-size: 20px;   
    cursor: pointer;   
    opacity: 0;   
    filter: alpha(opacity=0);   
}  
    </style>
   <%--     <title>无标题页</title>
    <script language="javascript" type="text/javascript">
    function change()
    {
        var   filename=event.srcElement.value;   
         
        var el=event.srcElement;
            el.id='fileID'; 
        
             
            document.getElementById('showSpan').innerHTML=document.getElementById('showSpan').innerHTML+filename+'<br />';
            document.getElementById('fileID').outerHTML=document.getElementById('fileID').outerHTML;//.value='';
 
            alert('檔案選擇成功!!!');
           
    }
    </script>--%>
 <%--   <script language="javascript" type="text/javascript">
        function validateFile(value) {
            var path = value;
            var startIndex = path.lastIndexOf("\\");
            var lastIndex = path.lastIndexOf(".");

            document.getElementById('ctl00_ContentPlaceHolder1_Label1').value = path.substring(startIndex + 1, lastIndex);
        }
    </script>--%>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:MENU %>" SelectCommand="SELECT * FROM [TB_Downloadlist] where class='ann' order by 'date' desc"></asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:MENU %>" SelectCommand="SELECT * FROM [TB_Downloadlist] where class='form' order by 'date' desc"></asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:MENU %>" SelectCommand="SELECT * FROM [TB_Downloadlist] where class='file' order by 'date' desc"></asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSource4" runat="server" ConnectionString="<%$ ConnectionStrings:MENU %>" SelectCommand="SELECT * FROM [TB_Downloadlist] where class='else' order by 'date' desc"></asp:SqlDataSource>
        <div class="col-md-2">
  </div>
  <div class="col-md-8">
      <asp:Panel ID="Panel1" runat="server" Font-Names="微軟正黑體">
                <div class="fileUpload btn btn-warning">  
    <span>選擇上傳檔案(上限10mb)</span>  
    <asp:FileUpload ID="FileUpload1" runat="server"  Font-Names="微軟正黑體" EnableTheming="True" CssClass="upload" onchange=" document.getElementById('div1').innerHTML ='從'+this.value+'上傳檔案'"/>
    </div> 
    <div id="div1" style="font-size: medium; color: #000080"></div>
          <asp:Label ID="Label1" runat="server" Text="自訂檔案名稱(可空白)"></asp:Label>
          <asp:TextBox ID="TextBox1" runat="server"></asp:TextBox>
    <asp:Label ID="Labelclass" runat="server" Text="檔案分類"></asp:Label>

                    <asp:DropDownList ID="DropDownList1" runat="server">
        <asp:ListItem Value="ann">公司公告</asp:ListItem>
        <asp:ListItem Value="form">常用表單</asp:ListItem>
        <asp:ListItem Value="file">檔案程式</asp:ListItem>
        <asp:ListItem Value="else">其他文件</asp:ListItem>

          </asp:DropDownList>

          <br />
          <asp:UpdatePanel ID="UpdatePanel1" runat="server"><ContentTemplate>
          <asp:CheckBox ID="CheckBox1" runat="server" Text="新增檔案說明" AutoPostBack="True" OnCheckedChanged="CheckBox1_CheckedChanged" />
         <asp:TextBox ID="TextBox2" runat="server"  TextMode="MultiLine" Width="100%"  AutoPostBack="False" Height="100%" Rows="5" Font-Names="微軟正黑體" Visible="False"></asp:TextBox>
      </ContentTemplate></asp:UpdatePanel>    
          <asp:Button ID="Button1" runat="server" Text="上傳" OnClick="Button1_Click" CssClass="btn btn-success" Width="100%" />
      </asp:Panel>

    <%--  <asp:TextBox ID="TextBox3" runat="server"  TextMode="MultiLine" Width="100%"  AutoPostBack="False" Height="100%" Rows="3" Font-Names="微軟正黑體" Visible="False" ReadOnly="True" BorderStyle="None"></asp:TextBox>
  --%>    <br />

          <div class="panel panel-warning">
      <div class="panel-heading" style="font-family: 微軟正黑體">公司重要公告下載</div>
      <div class="panel-body">
<asp:GridView ID="GridView0" runat="server" BorderStyle="None" GridLines="None" AllowSorting="True" AutoGenerateColumns="False" AllowPaging="True"  DataSourceID="SqlDataSource1" EnableModelValidation="True" Font-Names="微軟正黑體" ShowHeader="False" Width="100%" OnRowCommand="GridView0_RowCommand">
                    <PagerSettings Position="TopAndBottom" />
<%--                    <PagerStyle CssClass="pagination-ys" />--%>
                  <Columns>
                     
                           <asp:BoundField DataField="filename" HeaderText="filename" HeaderStyle-Wrap="False"  ItemStyle-Width="30%" SortExpression="filename" >
<HeaderStyle Wrap="False"></HeaderStyle>


                      </asp:BoundField>
                       <asp:TemplateField HeaderText="檔案下載" ItemStyle-Width="30%"><ItemTemplate>
                          <div style="text-align:center">
                          <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl='<%# Eval("url")%>'>
                              <asp:Image ID="Image1" runat="server" ImageUrl="~/img/downloadimg.png" /></asp:HyperLink>
                            <asp:Button ID="Button3" runat="server" Text="檔案說明" CommandName="post"  CommandArgument='<%# Eval("explanation") %>' CssClass="btn btn-warning btn-sm" />
                          <asp:Button ID="Button2" runat="server" Text="檔案刪除" CommandName="del"  CommandArgument='<%# Eval("url") %>' CssClass="btn btn-danger btn-sm" />            
                          </div>
                                         </ItemTemplate>
                                                 </asp:TemplateField>

                                                       </Columns>
                  <RowStyle Font-Size="Larger" VerticalAlign="Bottom" /> 
                  <HeaderStyle BackColor="#6B696B" Font-Bold="True" ForeColor="White" Font-Size="Medium" />

              </asp:GridView>
      </div>
    </div>
    
                <div class="panel panel-danger">
      <div class="panel-heading" style="font-family: 微軟正黑體">常用表單下載</div>
      <div class="panel-body">
<asp:GridView ID="GridView1" runat="server" BorderStyle="None" GridLines="None" AllowSorting="True" AutoGenerateColumns="False" AllowPaging="True"  DataSourceID="SqlDataSource2" EnableModelValidation="True" Font-Names="微軟正黑體" ShowHeader="False" Width="100%" OnRowCommand="GridView0_RowCommand">
                    <PagerSettings Position="TopAndBottom" />
<%--                    <PagerStyle CssClass="pagination-ys" />--%>
                  <Columns>
                     
                           <asp:BoundField DataField="filename" HeaderText="filename" HeaderStyle-Wrap="False"  ItemStyle-Width="30%" SortExpression="filename" >
<HeaderStyle Wrap="False"></HeaderStyle>


                      </asp:BoundField>
                       <asp:TemplateField HeaderText="檔案下載" ItemStyle-Width="30%"><ItemTemplate>
                          <div style="text-align:center">
                          <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl='<%# Eval("url")%>'>
                              <asp:Image ID="Image1" runat="server" ImageUrl="~/img/downloadimg.png" /></asp:HyperLink>
                                    <asp:Button ID="Button3" runat="server" Text="檔案說明" CommandName="post"  CommandArgument='<%# Eval("explanation") %>' CssClass="btn btn-warning btn-sm" />
                          <asp:Button ID="Button2" runat="server" Text="檔案刪除" CommandName="del"  CommandArgument='<%# Eval("url") %>' CssClass="btn btn-danger btn-sm" />                              
                          </div>
                                         </ItemTemplate>

                      </asp:TemplateField>
                                                       </Columns>
                  <RowStyle Font-Size="Larger" VerticalAlign="Bottom" /> 
                  <HeaderStyle BackColor="#6B696B" Font-Bold="True" ForeColor="White" Font-Size="Medium" />

              </asp:GridView>
      </div>
    </div>

                <div class="panel panel-success">
      <div class="panel-heading" style="font-family: 微軟正黑體">檔案下載</div>
      <div class="panel-body">
<asp:GridView ID="GridView2" runat="server" BorderStyle="None" GridLines="None" AllowSorting="True" AutoGenerateColumns="False" AllowPaging="True"  DataSourceID="SqlDataSource3" EnableModelValidation="True" Font-Names="微軟正黑體" ShowHeader="False" Width="100%" OnRowCommand="GridView0_RowCommand">
                    <PagerSettings Position="TopAndBottom" />
<%--                    <PagerStyle CssClass="pagination-ys" />--%>
                  <Columns>
                     
                           <asp:BoundField DataField="filename" HeaderText="filename" HeaderStyle-Wrap="False"  ItemStyle-Width="30%" SortExpression="filename" >
<HeaderStyle Wrap="False"></HeaderStyle>


                      </asp:BoundField>
                       <asp:TemplateField HeaderText="檔案下載" ItemStyle-Width="30%"><ItemTemplate>
                          <div style="text-align:center">
                          <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl='<%# Eval("url")%>'>
                              <asp:Image ID="Image1" runat="server" ImageUrl="~/img/downloadimg.png" /></asp:HyperLink>
                                    <asp:Button ID="Button3" runat="server" Text="檔案說明" CommandName="post"  CommandArgument='<%# Eval("explanation") %>' CssClass="btn btn-warning  btn-sm" />
                          <asp:Button ID="Button2" runat="server" Text="檔案刪除" CommandName="del"  CommandArgument='<%# Eval("url") %>' CssClass="btn btn-danger btn-sm" />    
                          </div>
                                         </ItemTemplate>

                      </asp:TemplateField>
                                                       </Columns>
                  <RowStyle Font-Size="Larger" VerticalAlign="Bottom" /> 
                  <HeaderStyle BackColor="#6B696B" Font-Bold="True" ForeColor="White" Font-Size="Medium" />

              </asp:GridView>
      </div>
    </div>

                <div class="panel panel-primary">
      <div class="panel-heading" style="font-family: 微軟正黑體">其他文件下載</div>
      <div class="panel-body">
<asp:GridView ID="GridView3" runat="server" BorderStyle="None" GridLines="None" AllowSorting="True" AutoGenerateColumns="False" AllowPaging="True"  DataSourceID="SqlDataSource4" EnableModelValidation="True" Font-Names="微軟正黑體" ShowHeader="False" Width="100%" OnRowCommand="GridView0_RowCommand">
                    <PagerSettings Position="TopAndBottom" />
<%--                    <PagerStyle CssClass="pagination-ys" />--%>
                  <Columns>
                     
                           <asp:BoundField DataField="filename" HeaderText="filename" HeaderStyle-Wrap="False"  ItemStyle-Width="30%" SortExpression="filename" >
<HeaderStyle Wrap="False"></HeaderStyle>


                      </asp:BoundField>
                       <asp:TemplateField HeaderText="檔案下載" ItemStyle-Width="30%"><ItemTemplate>
                          <div style="text-align:center">
                          <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl='<%# Eval("url")%>'>
                              <asp:Image ID="Image1" runat="server" ImageUrl="~/img/downloadimg.png" /></asp:HyperLink>
                                   <asp:Button ID="Button3" runat="server" Text="檔案說明" CommandName="post"  CommandArgument='<%# Eval("explanation") %>' CssClass="btn btn-warning btn-sm" />
                          <asp:Button ID="Button2" runat="server" Text="檔案刪除" CommandName="del"  CommandArgument='<%# Eval("url") %>' CssClass="btn btn-danger btn-sm" />     
                          </div>
                                         </ItemTemplate>

                      </asp:TemplateField>
                                                       </Columns>
                  <RowStyle Font-Size="Larger" VerticalAlign="Bottom" /> 
                  <HeaderStyle BackColor="#6B696B" Font-Bold="True" ForeColor="White" Font-Size="Medium" />

              </asp:GridView>
      </div>
    </div>
      </div>

              <div class="col-md-2">
  </div>


</asp:Content>
