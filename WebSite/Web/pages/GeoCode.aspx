<%@ Page Title="" Language="C#" MasterPageFile="~/SiteAudit.Master" AutoEventWireup="true" CodeBehind="GeoCode.aspx.cs" Inherits="ECS_Web.pages.GeoCode" %>



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
                            <asp:LinkButton runat="server" class="nav-link active" CommandName="QUERY" ID="lbITQuery" OnClick="lbITQuery_Click">IT Query</asp:LinkButton>
                        </li>
                        <%-- <li class="nav-item" runat="server" id="li_posm">
                            <asp:LinkButton runat="server" class="nav-link" CommandName="POSM" ID="lbPOSM" OnClick="lbKPI_Click">KPIPOSM</asp:LinkButton>
                        </li>--%>
                    </ul>
                </div>
            </div>
        </div>
    </section>


    <asp:Panel runat="server" ID="plITQuery">
        <section class="content">
            <div class="container-fluid">
                <div class="card card-info">
                    <div class="card-body">
                        <div class="row">
                            <div class="col-md-3">
                                <div class="form-group">
                                    <label>Danh sách tọa độ:</label>
                                    <asp:TextBox runat="server" ID="txtAuditDate" TextMode="MultiLine" CssClass="form-control" />
                                </div>
                            </div>
                            <div class="col-md-2" style="display:none;">
                                <div class="form-group">
                                    <label>ShopId:</label>
                                    <asp:TextBox runat="server" ID="txtShopId" CssClass="form-control" />
                                </div>
                            </div>
                            <div class="col-md-2" style="display:none;">
                                <div class="form-group">
                                    <label>EmployeeId:</label>
                                    <asp:TextBox runat="server" ID="txtEmployeeId" CssClass="form-control" />
                                </div>
                            </div>
                            <div class="col-md-3" style="display:none;">
                                <div class="form-group">
                                    <label>Loại support:</label>
                                    <asp:DropDownList runat="server" ID="ddlTypeITSupport" CssClass="form-control">
                                        <asp:ListItem Value="6">Gỡ báo cáo ra làm lại + xóa hình checkout</asp:ListItem>
                                        <asp:ListItem Value="7">Thêm ảnh checkin với mấy TH lỗi không checkin được</asp:ListItem>
                                        <asp:ListItem Value="8">Thêm ảnh overview với mấy TH lỗi không overview được</asp:ListItem>
                                        <asp:ListItem Value="9">Done hộ trường hợp thiếu ảnh checkout + đã quá ngày</asp:ListItem>
                                    </asp:DropDownList>
                                </div>
                            </div>
                            <div class="col-md-2" style="display:none;">
                                <div class="form-group">
                                    <label>.</label>
                                    <asp:Button runat="server" ID="btnAdd" CssClass="form-control btn btn-primary" Text="Thêm" OnClick="btnAdd_Click" />
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="card-footer">
                        <div class="row">
                            <div class="col-md-3" data-select2-id="30">
                                <asp:Button runat="server" class="btn btn-primary" Text="Tìm kiếm" ID="btnFilterITQuery" OnClick="btnFilterITQuery_Click" />
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <section class="content">
            <div class="container-fluid">
                <div class="row">
                    <div class="col-12">
                        <div class="card">
                            <div class="card-header">
                                <h3 class="card-title">Chi tiết chấm công</h3>
                            </div>
                            <div class="card-body">
                                <div id="example2_wrapper" class="dataTables_wrapper dt-bootstrap4">
                                    <div class="row">
                                        <div class="col-sm-12">
                                            <table class="table table-bordered table-hover dataTable dtr-inline">
                                                <thead>
                                                    <tr>
                                                        <th style="text-align: center; vertical-align: inherit;">STT</th>
                                                        <th style="text-align: center; vertical-align: inherit;">Lat</th>
                                                        <th style="text-align: center; vertical-align: inherit;">Long</th>
                                                        <th style="text-align: center; vertical-align: inherit;">Địa chỉ</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <asp:Repeater runat="server" ID="rptITSupport">
                                                        <ItemTemplate>
                                                            <tr>
                                                                <td style="text-align: center;"><%# Eval("RN") %></td>
                                                                <td style="text-align: center;"><%# Eval("Lat") %></td>
                                                                <td style="text-align: center;"><%# Eval("Long") %></td>
                                                                <td style="text-align: center;"><%# Eval("Address") %></td>
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

    </asp:Panel>

</asp:Content>
