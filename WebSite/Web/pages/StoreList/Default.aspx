<%@ Page Title="" Language="C#" MasterPageFile="~/SiteAudit.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="ECS_Web.pages.StoreList.Default" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        th {
            text-align: center;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <section class="content">
        <div class="container-fluid">
            <div class="card card-info">
                <div class="card-body">
                    <div class="row">
                        <div class="col-md-3">
                            <div class="form-group">
                                <label>Khu vực:</label>
                                <asp:DropDownList runat="server" ID="ddlArea" class="form-control select2 select2-hidden-accessible" Style="width: 100%; height: 40px;" AutoPostBack="true"
                                    OnSelectedIndexChanged="ddlArea_SelectedIndexChanged">
                                </asp:DropDownList>
                            </div>
                        </div>
                        <div class="col-md-3">
                            <div class="form-group">
                                <label>Tỉnh/Thành phố:</label>
                                <asp:DropDownList runat="server" ID="ddlProvince" class="form-control select2 select2-hidden-accessible" Style="width: 100%; height: 40px;" AutoPostBack="true" OnSelectedIndexChanged="ddlProvince_SelectedIndexChanged">
                                </asp:DropDownList>
                            </div>
                        </div>
                        <div class="col-md-3">
                            <div class="form-group">
                                <label>Quận/Huyện:</label>
                                <asp:DropDownList runat="server" ID="ddlDistrict" class="form-control select2 select2-hidden-accessible" Style="width: 100%; height: 40px;" AutoPostBack="true"
                                    OnSelectedIndexChanged="ddlDistrict_SelectedIndexChanged">
                                </asp:DropDownList>
                            </div>
                        </div>
                        <div class="col-md-3">
                            <div class="form-group">
                                <label>Phường/Xã:</label>
                                <asp:DropDownList runat="server" ID="ddlTown" class="form-control select2 select2-hidden-accessible" Style="width: 100%; height: 40px;">
                                </asp:DropDownList>
                            </div>
                        </div>
                        <div class="col-md-3">
                            <div class="form-group">
                                <label>Loại cửa hàng:</label>
                                <asp:DropDownList runat="server" ID="ddlType" class="form-control select2 select2-hidden-accessible" Style="width: 100%; height: 40px;">
                                    <asp:ListItem Text="ALL" Value="ALL" />
                                    <asp:ListItem Text="GT" Value="GT" />
                                    <asp:ListItem Text="MT" Value="MT" />
                                </asp:DropDownList>
                            </div>
                        </div>
                        <div class="col-md-3">
                            <div class="form-group">
                                <label>Mã cửa hàng:</label>
                                <asp:TextBox runat="server" ID="txtShopCode" CssClass="form-control" />
                            </div>
                        </div>
                    </div>
                </div>
                <div class="card-footer">
                    <div class="row">
                        <div class="col-md-12">
                            <asp:Button runat="server" class="btn btn-primary" Text="Tìm kiếm" ID="btnFilter" OnClick="btnFilter_Click" />
                            <asp:Button runat="server" class="btn btn-info " Text="Xuất báo cáo" ID="btnExport" OnClick="btnExport_Click" UseSubmitBehavior="false" OnClientClick="this.value='Đang xuất file...'; this.disabled='true'" />
                            <asp:Button ID="btnImport" CssClass="btn btn-danger" runat="server" Text="Thêm dữ liệu" OnClientClick="popWindow_Custom('/Popups/ImportStoreList.aspx', 700, 520); return false;" />
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- /.container-fluid -->
    </section>
    <section class="content" id="listemployee" runat="server" visible="false">
        <div class="container-fluid">
            <div class="row">
                <div class="col-12">
                    <div class="card">
                        <div class="card-header">
                            <h3 class="card-title">Danh sách cửa hàng</h3>
                        </div>
                        <div class="card-body">
                            <div id="example2_wrapper" class="dataTables_wrapper dt-bootstrap4">
                                <div class="row">
                                    <div class="col-sm-12">
                                        <table class="table table-bordered table-hover dataTable dtr-inline">
                                            <thead>
                                                <tr>
                                                    <th>#</th>
                                                    <th>ShopId</th>
                                                    <th>Cửa hàng</th>
                                                    <th>Địa chỉ</th>
                                                    <th>Khu vực</th>
                                                    <th>Tỉnh/Thành phố</th>
                                                    <th>Quận/Huyện</th>
                                                    <th>Phường/Xã</th>
                                                    <th>Loại CH</th>
                                                    <th>Lat-Long</th>
                                                    <th>Ngày tạo</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <asp:Repeater runat="server" ID="rpStoreList">
                                                    <ItemTemplate>
                                                        <tr>
                                                            <td><%# Eval("RN") %></td>
                                                            <td><%# Eval("ShopId") %></td>
                                                            <td><%# Eval("ShopCode") %> - <%# Eval("ShopName") %></td>
                                                            <td><%# Eval("AddressLine") %></td>
                                                            <td><%# Eval("AreaName") %></td>
                                                            <td><%# Eval("ProvinceName") %></td>
                                                            <td><%# Eval("DistrictName") %></td>
                                                            <td><%# Eval("TownName") %></td>
                                                            <td><%# Eval("ShopType") %></td>
                                                            <td><%# Eval("Latitude") %> , <%# Eval("Longitude") %></td>
                                                            <td><%# Eval("CreatedDate") %></td>
                                                        </tr>
                                                    </ItemTemplate>
                                                </asp:Repeater>
                                            </tbody>
                                        </table>
                                        <asp:Panel runat="server" ID="plPaging" Visible="false">
                                            <div class="row">
                                                <div class="col-sm-12 col-md-5">
                                                    <div class="dataTables_info" id="example2_info" role="status" aria-live="polite">
                                                        Showing
                                                        <asp:Label ID="lblFrom" runat="server" />
                                                        to
                                                        <asp:Label ID="lblTo" runat="server" />
                                                        of
                                                        <asp:Label ID="lblTotalRows" runat="server" />
                                                        entries
                                                    </div>
                                                </div>
                                                <div class="col-sm-12 col-md-7">
                                                    <div class="dataTables_paginate paging_simple_numbers" id="example2_paginate">
                                                        <ul class="pagination">
                                                            <li class="paginate_button page-item previous" id="example2_previous">
                                                                <asp:LinkButton Text="Previous" runat="server" CssClass="page-link" ID="lnkPrevious" CommandName="Previous" OnClick="lnkPrevious_Click" />
                                                            </li>
                                                            <asp:Repeater runat="server" ID="rptPaging">
                                                                <ItemTemplate>
                                                                    <li class='<%# Eval("Active") %>'>
                                                                        <asp:LinkButton ID="lnkPage" Text='<%# Eval("PageNumber") %>' CommandName="Page" runat="server" CssClass="page-link" OnClick="lnkPage_Click" />
                                                                    </li>
                                                                </ItemTemplate>
                                                            </asp:Repeater>
                                                            <li class="paginate_button page-item next" id="example2_next">
                                                                <asp:LinkButton Text="Next" runat="server" CssClass="page-link" ID="lnkNext" CommandName="Next" OnClick="lnkNext_Click" />
                                                            </li>
                                                        </ul>
                                                    </div>
                                                </div>
                                            </div>
                                        </asp:Panel>
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
