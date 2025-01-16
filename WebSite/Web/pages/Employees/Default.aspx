<%@ Page Title="" Language="C#" MasterPageFile="~/SiteAudit.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="ECS_Web.pages.Employees.Default" %>

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
                                <label>Nhân viên:</label>
                                <asp:DropDownList runat="server" ID="ddlAuditor" class="form-control select2 select2-hidden-accessible" Style="width: 100%; height: 40px;">
                                </asp:DropDownList>
                            </div>
                        </div>
                        <div class="col-md-3">
                            <div class="form-group">
                                <label>Vị trí:</label>
                                <asp:DropDownList runat="server" ID="ddlType" class="form-control select2 select2-hidden-accessible" Style="width: 100%; height: 40px;">
                                </asp:DropDownList>
                            </div>
                        </div>
                        <div class="col-md-3">
                            <div class="form-group">
                                <label>Trạng thái:</label>
                                <asp:DropDownList runat="server" ID="ddlStatus" CssClass="form-control select2 select2-hidden-accessible" Style="width: 100%; height: 40px;">
                                    <asp:ListItem Text="Hoạt động" Value="1" Selected="True" />
                                    <asp:ListItem Text="Không hoạt động" Value="0" />
                                </asp:DropDownList>
                            </div>
                        </div>
                        <div class="col-md-3">
                            <div class="form-group">
                                <label>Tên đăng nhập:</label>
                                <asp:TextBox runat="server" ID="txtUsername" CssClass="form-control" />
                            </div>
                        </div>
                        <div class="col-md-3">
                            <div class="form-group">
                                <label>Mã nhân viên:</label>
                                <asp:TextBox runat="server" ID="txtEmployeeCode" CssClass="form-control" />
                            </div>
                        </div>
                        <div class="col-md-3">
                            <div class="form-group">
                                <label>Tên nhân viên:</label>
                                <asp:TextBox runat="server" ID="txtEmployeeName" CssClass="form-control" />
                            </div>
                        </div>
                        <div class="col-md-3">
                            <div class="form-group">
                                <label>Số điện thoại:</label>
                                <asp:TextBox runat="server" ID="txtPhone" CssClass="form-control" />
                            </div>
                        </div>
                    </div>
                </div>
                <div class="card-footer">
                    <div class="row">
                        <div class="col-md-12">
                            <asp:Button runat="server" class="btn btn-primary" Text="Tìm kiếm" ID="btnFilter" OnClick="btnFilter_Click" />
                            <asp:Button runat="server" class="btn btn-primary" Text="Xuất báo cáo" ID="btnExport" OnClick="btnExport_Click" UseSubmitBehavior="false" OnClientClick="this.value='Đang xuất file...'; this.disabled='true'" />
                            <asp:Button ID="btnImport" CssClass="btn btn-danger" runat="server" Text="Thêm dữ liệu" OnClientClick="popWindow_Custom('/Popups/ImportEmployees.aspx', 700, 520); return false;" />
                            <a href="Create.aspx" class="btn btn-info" target="_blank">Tạo nhân viên</a>
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
                            <h3 class="card-title">Danh sách nhân viên</h3>
                        </div>
                        <div class="card-body">
                            <div id="example2_wrapper" class="dataTables_wrapper dt-bootstrap4">
                                <div class="row">
                                    <div class="col-sm-12">
                                        <table class="table table-bordered table-hover dataTable dtr-inline">
                                            <thead>
                                                <tr>
                                                    <th>#</th>
                                                    <th>ID NV</th>
                                                    <th>Mã nhân viên</th>
                                                    <th>Nhân viên</th>
                                                    <th>Mã quản lý</th>
                                                    <th>Quản lý</th>
                                                    <th>Ngày sinh</th>
                                                    <th>Email</th>
                                                    <th>Loại nhân viên</th>
                                                    <th>Tài khoản</th>
                                                    <th>Trạng thái</th>
                                                    <th>Ngày tạo</th>
                                                    <th>Công cụ</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <asp:Repeater runat="server" ID="rpEmployees">
                                                    <ItemTemplate>
                                                        <tr>
                                                            <td><%# Eval("RN") %></td>
                                                            <td><%# Eval("EmployeeId") %></td>
                                                            <td><%# Eval("EmployeeCode") %></td>
                                                            <td><%# Eval("EmployeeName") %></td>
                                                            <td><%# Eval("SupCode") %></td>
                                                            <td><%# Eval("SupName") %></td>
                                                            <td><%# Eval("DateOfBirth") %></td>
                                                            <td><%# Eval("EmailAddress") %></td>
                                                            <td><%# Eval("TypeName") %></td>
                                                            <td><%# Eval("UserName") %></td>
                                                            <td><%# CheckStatusEmployee(Convert.ToInt32(Eval("Status"))) %></td>
                                                            <td><%# Eval("CreateDate") %></td>
                                                            <td>
                                                                <a href='<%# "Create.aspx?EmployeeId=" + Convert.ToString(Eval("EmployeeId")) %>' target="_blank">
                                                                    <img src="../../Images/icon_edit.png" width="20" />
                                                                </a>
                                                            </td>
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
