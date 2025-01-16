<%@ Page Title="" Language="C#" MasterPageFile="~/SiteAudit.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="ECS_Web.pages.KPIPosm.Default" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <!-- jQuery -->
    <script src="../../AdminLTE/plugins/jquery/jquery.min.js"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
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
                <div class="card-footer">
                    <div class="row">
                        <div class="col-md-12">
                            <asp:Button runat="server" class="btn btn-info " Text="Xuất báo cáo" ID="btnExport" OnClick="btnExport_Click" UseSubmitBehavior="false"
                                OnClientClick="this.value='Đang xuất file...'; this.disabled='true'" />
                            <asp:Button ID="btnImport" CssClass="btn btn-danger" runat="server" Text="Thêm dữ liệu" UseSubmitBehavior="false"
                                OnClientClick="this.value='Đang nhập liệu...'; this.disabled='true'" OnClick="btnImport_Click" />
                            <asp:Button runat="server" class="btn btn-primary" Text="Template" ID="btnTemplate" OnClick="btnTemplate_Click" UseSubmitBehavior="false"
                                OnClientClick="this.value='Đang nhập liệu...'; this.disabled='true'" />
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- /.container-fluid -->
    </section>
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
