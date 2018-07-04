<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="WebForm1.aspx.cs" Inherits="JuicERP.Pages.WebForm1" %>

<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=12.0.0.0, Culture=neutral, PublicKeyToken=89845dcd8080cc91" Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <rsweb:ReportViewer ID="ReportViewer1" runat="server" Font-Names="Verdana" Font-Size="8pt" WaitMessageFont-Names="Verdana" WaitMessageFont-Size="14pt">
            <LocalReport ReportPath="Pages\Report1.rdlc">
                <DataSources>
                    <rsweb:ReportDataSource DataSourceId="ObjectDataSource1" Name="DataSet1" />
                </DataSources>
            </LocalReport>
        </rsweb:ReportViewer>
        <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" DeleteMethod="Delete" InsertMethod="Insert" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="JuicERP.Pages.DataSet1TableAdapters.pay11TableAdapter" UpdateMethod="Update">
            <DeleteParameters>
                <asp:Parameter Name="Original_emp_no" Type="String" />
            </DeleteParameters>
            <InsertParameters>
                <asp:Parameter Name="comp" Type="String" />
                <asp:Parameter Name="crea" Type="String" />
                <asp:Parameter Name="ugroup" Type="String" />
                <asp:Parameter Name="crea_d" Type="String" />
                <asp:Parameter Name="modi" Type="String" />
                <asp:Parameter Name="modi_d" Type="String" />
                <asp:Parameter Name="emp_no" Type="String" />
                <asp:Parameter Name="a_d" Type="String" />
                <asp:Parameter Name="acc_k" Type="String" />
                <asp:Parameter Name="addr1" Type="String" />
                <asp:Parameter Name="addr2" Type="String" />
                <asp:Parameter Name="aga" Type="String" />
                <asp:Parameter Name="attn" Type="String" />
                <asp:Parameter Name="birthday" Type="String" />
                <asp:Parameter Name="blood" Type="String" />
                <asp:Parameter Name="c01" Type="String" />
                <asp:Parameter Name="c_d" Type="String" />
                <asp:Parameter Name="card1" Type="String" />
                <asp:Parameter Name="card2" Type="String" />
                <asp:Parameter Name="depa_no" Type="String" />
                <asp:Parameter Name="email" Type="String" />
                <asp:Parameter Name="emp_cne" Type="String" />
                <asp:Parameter Name="emp_ene" Type="String" />
                <asp:Parameter Name="fo_r" Type="String" />
                <asp:Parameter Name="foo" Type="String" />
                <asp:Parameter Name="gp_no" Type="String" />
                <asp:Parameter Name="hei" Type="Decimal" />
                <asp:Parameter Name="hfcount" Type="Decimal" />
                <asp:Parameter Name="hrcount" Type="Decimal" />
                <asp:Parameter Name="id_no" Type="String" />
                <asp:Parameter Name="l_d" Type="String" />
                <asp:Parameter Name="mag" Type="String" />
                <asp:Parameter Name="mate" Type="String" />
                <asp:Parameter Name="mili" Type="String" />
                <asp:Parameter Name="mtel" Type="String" />
                <asp:Parameter Name="nati" Type="String" />
                <asp:Parameter Name="ori" Type="String" />
                <asp:Parameter Name="picpath" Type="String" />
                <asp:Parameter Name="pk_no" Type="String" />
                <asp:Parameter Name="rela" Type="String" />
                <asp:Parameter Name="rela_addr" Type="String" />
                <asp:Parameter Name="rela_tel" Type="String" />
                <asp:Parameter Name="rmk" Type="String" />
                <asp:Parameter Name="sex" Type="String" />
                <asp:Parameter Name="stay" Type="String" />
                <asp:Parameter Name="stayno" Type="String" />
                <asp:Parameter Name="tax_no" Type="String" />
                <asp:Parameter Name="tel1" Type="String" />
                <asp:Parameter Name="tel2" Type="String" />
                <asp:Parameter Name="vege" Type="String" />
                <asp:Parameter Name="wei" Type="Decimal" />
                <asp:Parameter Name="wok" Type="String" />
                <asp:Parameter Name="ymd01" Type="String" />
                <asp:Parameter Name="ymd02" Type="String" />
                <asp:Parameter Name="ymd03" Type="String" />
                <asp:Parameter Name="ymd04" Type="String" />
                <asp:Parameter Name="pension1" Type="String" />
                <asp:Parameter Name="pensionr" Type="Decimal" />
                <asp:Parameter Name="card_no" Type="String" />
                <asp:Parameter Name="l_no" Type="String" />
                <asp:Parameter Name="tur_no" Type="String" />
                <asp:Parameter Name="SEL_SW" Type="String" />
                <asp:Parameter Name="pay9902" Type="String" />
                <asp:Parameter Name="c1" Type="String" />
                <asp:Parameter Name="hr_k" Type="String" />
                <asp:Parameter Name="referrals" Type="String" />
                <asp:Parameter Name="rrela" Type="String" />
                <asp:Parameter Name="Ethnic" Type="String" />
                <asp:Parameter Name="ck" Type="String" />
                <asp:Parameter Name="ck_ne" Type="String" />
                <asp:Parameter Name="zipcode1" Type="String" />
                <asp:Parameter Name="zipcode2" Type="String" />
                <asp:Parameter Name="id_k" Type="String" />
                <asp:Parameter Name="h_k" Type="String" />
                <asp:Parameter Name="na_d" Type="String" />
                <asp:Parameter Name="p_no1" Type="String" />
            </InsertParameters>
            <UpdateParameters>
                <asp:Parameter Name="comp" Type="String" />
                <asp:Parameter Name="crea" Type="String" />
                <asp:Parameter Name="ugroup" Type="String" />
                <asp:Parameter Name="crea_d" Type="String" />
                <asp:Parameter Name="modi" Type="String" />
                <asp:Parameter Name="modi_d" Type="String" />
                <asp:Parameter Name="a_d" Type="String" />
                <asp:Parameter Name="acc_k" Type="String" />
                <asp:Parameter Name="addr1" Type="String" />
                <asp:Parameter Name="addr2" Type="String" />
                <asp:Parameter Name="aga" Type="String" />
                <asp:Parameter Name="attn" Type="String" />
                <asp:Parameter Name="birthday" Type="String" />
                <asp:Parameter Name="blood" Type="String" />
                <asp:Parameter Name="c01" Type="String" />
                <asp:Parameter Name="c_d" Type="String" />
                <asp:Parameter Name="card1" Type="String" />
                <asp:Parameter Name="card2" Type="String" />
                <asp:Parameter Name="depa_no" Type="String" />
                <asp:Parameter Name="email" Type="String" />
                <asp:Parameter Name="emp_cne" Type="String" />
                <asp:Parameter Name="emp_ene" Type="String" />
                <asp:Parameter Name="fo_r" Type="String" />
                <asp:Parameter Name="foo" Type="String" />
                <asp:Parameter Name="gp_no" Type="String" />
                <asp:Parameter Name="hei" Type="Decimal" />
                <asp:Parameter Name="hfcount" Type="Decimal" />
                <asp:Parameter Name="hrcount" Type="Decimal" />
                <asp:Parameter Name="id_no" Type="String" />
                <asp:Parameter Name="l_d" Type="String" />
                <asp:Parameter Name="mag" Type="String" />
                <asp:Parameter Name="mate" Type="String" />
                <asp:Parameter Name="mili" Type="String" />
                <asp:Parameter Name="mtel" Type="String" />
                <asp:Parameter Name="nati" Type="String" />
                <asp:Parameter Name="ori" Type="String" />
                <asp:Parameter Name="picpath" Type="String" />
                <asp:Parameter Name="pk_no" Type="String" />
                <asp:Parameter Name="rela" Type="String" />
                <asp:Parameter Name="rela_addr" Type="String" />
                <asp:Parameter Name="rela_tel" Type="String" />
                <asp:Parameter Name="rmk" Type="String" />
                <asp:Parameter Name="sex" Type="String" />
                <asp:Parameter Name="stay" Type="String" />
                <asp:Parameter Name="stayno" Type="String" />
                <asp:Parameter Name="tax_no" Type="String" />
                <asp:Parameter Name="tel1" Type="String" />
                <asp:Parameter Name="tel2" Type="String" />
                <asp:Parameter Name="vege" Type="String" />
                <asp:Parameter Name="wei" Type="Decimal" />
                <asp:Parameter Name="wok" Type="String" />
                <asp:Parameter Name="ymd01" Type="String" />
                <asp:Parameter Name="ymd02" Type="String" />
                <asp:Parameter Name="ymd03" Type="String" />
                <asp:Parameter Name="ymd04" Type="String" />
                <asp:Parameter Name="pension1" Type="String" />
                <asp:Parameter Name="pensionr" Type="Decimal" />
                <asp:Parameter Name="card_no" Type="String" />
                <asp:Parameter Name="l_no" Type="String" />
                <asp:Parameter Name="tur_no" Type="String" />
                <asp:Parameter Name="SEL_SW" Type="String" />
                <asp:Parameter Name="pay9902" Type="String" />
                <asp:Parameter Name="c1" Type="String" />
                <asp:Parameter Name="hr_k" Type="String" />
                <asp:Parameter Name="referrals" Type="String" />
                <asp:Parameter Name="rrela" Type="String" />
                <asp:Parameter Name="Ethnic" Type="String" />
                <asp:Parameter Name="ck" Type="String" />
                <asp:Parameter Name="ck_ne" Type="String" />
                <asp:Parameter Name="zipcode1" Type="String" />
                <asp:Parameter Name="zipcode2" Type="String" />
                <asp:Parameter Name="id_k" Type="String" />
                <asp:Parameter Name="h_k" Type="String" />
                <asp:Parameter Name="na_d" Type="String" />
                <asp:Parameter Name="p_no1" Type="String" />
                <asp:Parameter Name="Original_emp_no" Type="String" />
            </UpdateParameters>
        </asp:ObjectDataSource>
        <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    </div>
    <div>
        <iframe id="reportFrame" src="http://localhost:8080/WebReport/ReportServer?reportlet=WorkBook1.cpt" width = "100%" height = "500px"></iframe>
    </div>

    </form>
</body>
</html>
