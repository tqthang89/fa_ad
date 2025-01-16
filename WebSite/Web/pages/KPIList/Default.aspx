<%@ Page Title="" Language="C#" MasterPageFile="~/SiteAudit.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="ECS_Web.pages.KPIList.Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <!-- jQuery -->
    <script src="../../AdminLTE/plugins/jquery/jquery.min.js"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <section class="content">
        <div class="container-fluid">
            <div class="card card-primary card-outline card-tabs">
                <div class="card-header p-0 pt-1 border-bottom-0">
                    <ul class="nav nav-tabs" id="custom-tabs-three-tab" role="tablist">
                        <li class="nav-item" runat="server" id="li_shopformat">
                            <asp:LinkButton runat="server" class="nav-link active" CommandName="SF" ID="lbSF" OnClick="lbKPI_Click">ShopFormat</asp:LinkButton>
                        </li>
                        <li class="nav-item" runat="server" id="li_posm">
                            <asp:LinkButton runat="server" class="nav-link" CommandName="POSM" ID="lbPOSM" OnClick="lbKPI_Click">KPIPOSM</asp:LinkButton>
                        </li>
                        <li class="nav-item" runat="server" id="li_osa">
                            
                            <asp:LinkButton  runat="server" class="nav-link" CommandName="OSA" ID="lbOSA"  OnClick="lbKPI_Click">KPIOSA</asp:LinkButton>
                        </li>
                    </ul>
                </div>
            </div>
        </div>
    </section>


    <section class="content">
        <div class="container-fluid">
            <div class="card card-info">
                <div class="card-body">
                    <div class="row">
                        <div class="col-md-3">
                            <div class="form-group">
                                <label>Chu kỳ:</label>
                                <asp:DropDownList runat="server" ID="ddlCycle" CssClass="form-control select2 select2-hidden-accessible" Style="width: 100%; height: 40px;">
                                </asp:DropDownList>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="form-group">
                                <label>Chọn file import :</label>
                                <div class="input-group date" id="reservationdate" data-target-input="nearest">
                                    <input type="file" id="fileImport" onchange="Upfile();" class="form-control" />
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

            </div>
        </div>
        <!-- /.container-fluid -->
    </section>
    <asp:Panel runat="server" ID="plSF">
        <section class="content">
            <div class="container-fluid">
                <div class="card card-info">
                    <div class="card-footer">
                        <div class="row">
                            <div class="col-md-12">

                                <table class="table">
                                    <tr>
                                        <th>ShopformatId</th>
                                        <th>KPI</th>
                                        <th>ShopType</th>
                                        <th>Description</th>
                                    </tr>
                                      <tr>
                                        <td>1</td>
                                        <td>OSA</td>
                                        <td>GT</td>
                                        <td>DIAMOND</td>
                                    </tr>
                                     <tr>
                                        <td>2</td>
                                        <td>OSA</td>
                                        <td>GT</td>
                                        <td>GOLD</td>
                                    </tr>
                                     <tr>
                                        <td>3</td>
                                        <td>OSA</td>
                                        <td>GT</td>
                                        <td>Titanium</td>
                                    </tr>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
    </asp:Panel>
    <asp:Panel runat="server" ID="plPOSM" Visible="false">
        <section class="content">
            <div class="container-fluid">
                <div class="card card-info">
                    <div class="card-footer">
                        <div class="row">
                            <div class="col-md-12">
                                 
                                <asp:Button runat="server" class="btn btn-info " Text="Xuất báo cáo - POSM" ID="btnExport" CommandArgument="POSM" OnClick="btnExport_Click" UseSubmitBehavior="false"
                                    OnClientClick="this.value='Đang xuất file...'; this.disabled='true'" />
                                <asp:Button ID="btnImport" CssClass="btn btn-danger" runat="server" CommandArgument="POSM" Text="Thêm dữ liệu - POSM" UseSubmitBehavior="false"
                                    OnClientClick="this.value='Đang nhập liệu...'; this.disabled='true'" OnClick="btnImport_Click" />
                                <asp:Button runat="server" class="btn btn-primary" CommandArgument="POSM" Text="Template - POSM" ID="btnTemplate" OnClick="btnTemplate_Click" UseSubmitBehavior="false"
                                    OnClientClick="this.value='Đang nhập liệu...'; this.disabled='true'" />
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
    </asp:Panel>
    <asp:Panel runat="server" ID="plOSA" Visible="false">
        <section class="content">
            <div class="container-fluid">
                <div class="card card-info">
                    <div class="card-footer">
                        <div class="row">
                            <div class="col-md-12">
                               <asp:Button runat="server" class="btn btn-info " Text="Xuất báo cáo - OSA" CommandArgument="OSA" ID="btnExportOSA" OnClick="btnExport_Click" UseSubmitBehavior="false"
                                    OnClientClick="this.value='Đang xuất file...'; this.disabled='true'" />
                                <asp:Button ID="Button2" CssClass="btn btn-danger" runat="server" Text="Thêm dữ liệu - OSA" CommandArgument="OSA" UseSubmitBehavior="false"
                                    OnClientClick="this.value='Đang nhập liệu...'; this.disabled='true'" OnClick="btnImport_Click" />
                                 <asp:Button ID="btnImportOSAMTFA" CssClass="btn btn-danger" runat="server" Text="Thêm dữ liệu - OSA MT FA" CommandArgument="OSAMTFA" UseSubmitBehavior="false"
                                    OnClientClick="this.value='Đang nhập liệu...'; this.disabled='true'" OnClick="btnImport_Click" />
                                <a class="btn btn-primary" style="float:right;" href="../../Template/template_kpi_osa.xlsx">Template - OSA</a>
                                <%--<asp:Button runat="server" class="btn btn-primary" Text="Template - OSA" CommandArgument="OSA" ID="Button3" CommandName="OSA" OnClick="btnTemplate_Click" UseSubmitBehavior="false"
                                    OnClientClick="this.value='Đang nhập liệu...'; this.disabled='true'" />--%>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
    </asp:Panel>
    <section class="content" id="error" runat="server" visible="false">
        <div class="container-fluid">
            <div class="row">
                <div class="col-12">
                    <div class="card">
                        <div class="card-header">
                            <h3 class="card-title">Chi tiết lỗi</h3>
                        </div>
                        <div class="card-body">
                            <div id="example2_wrapper" class="dataTables_wrapper dt-bootstrap4">
                                <div class="row">
                                    <div class="col-sm-12">
                                        <table class="table table-bordered table-hover dataTable dtr-inline">
                                            <thead>
                                                <tr>
                                                    <th>#</th>
                                                    <th>Mô tả lỗi</th>
                                                    <th></th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <asp:Repeater runat="server" ID="rptError">
                                                    <ItemTemplate>
                                                        <tr>
                                                            <td><%# Container.ItemIndex + 1 %></td>
                                                            <td><%# Eval("Message") %></td>
                                                            <td><%# Eval("Cell") %></td>
                                                        </tr>
                                                    </ItemTemplate>
                                                </asp:Repeater>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

        </div>
    </section>
</asp:Content>
