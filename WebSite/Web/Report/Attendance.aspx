<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Attendance.aspx.cs" Inherits="ECS_Web.Report.Attendance" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <section class="content">
        <div class="container-fluid">
            <div class="card card-info">
                <div class="card-header">
                    <h3 class="card-title">Báo cáo chấm công</h3>
                    <div class="card-tools">
                        <button type="button" class="btn btn-tool" data-card-widget="collapse">
                            <i class="fas fa-minus"></i>
                        </button>
                    </div>
                </div>
                <!-- /.card-header -->
                <div class="card-body">
                    <div class="row">
                        <div class="col-md-2" data-select2-id="30">
                            <div class="form-group">
                                <label>Chu kỳ:</label>
                                <asp:DropDownList runat="server" ID="ddlCycle" class="form-control select2 select2-hidden-accessible" Style="width: 100%; height: 40px;">
                                    <asp:ListItem Value="1">Chu kỳ 1/2022</asp:ListItem>
                                    <asp:ListItem Value="2">Chu kỳ 2/2022</asp:ListItem>
                                    <asp:ListItem Value="3">Chu kỳ 3/2022</asp:ListItem>
                                    <asp:ListItem Value="4">Chu kỳ 4/2022</asp:ListItem>
                                    <asp:ListItem Value="4">Chu kỳ 5/2022</asp:ListItem>
                                    <asp:ListItem Value="5">Chu kỳ 6/2022</asp:ListItem>
                                </asp:DropDownList>
                            </div>
                        </div>
                        <div class="col-md-2" data-select2-id="30">
                            <div class="form-group">
                                <label>Khu vực:</label>
                                <asp:DropDownList runat="server" ID="ddlArea" class="form-control select2 select2-hidden-accessible" Style="width: 100%; height: 40px;">
                                    <asp:ListItem Value="1">--Tất cả--</asp:ListItem>
                                    <asp:ListItem Value="2">Miền Bắc</asp:ListItem>
                                    <asp:ListItem Value="3">Miền Trung</asp:ListItem>
                                    <asp:ListItem Value="4">Miền Đông</asp:ListItem>
                                    <asp:ListItem Value="5">HCM</asp:ListItem>
                                    <asp:ListItem Value="6">Mê Kông</asp:ListItem>
                                </asp:DropDownList>
                            </div>
                        </div>
                        <div class="col-md-2" data-select2-id="30">
                            <div class="form-group">
                                <label>ASM:</label>
                                <asp:DropDownList runat="server" ID="ddlASM" class="form-control select2 select2-hidden-accessible" Style="width: 100%; height: 40px;">
                                    <asp:ListItem Value="1">--Tất cả--</asp:ListItem>
                                    <asp:ListItem Value="2">ASM 1</asp:ListItem>
                                    <asp:ListItem Value="3">ASM 2</asp:ListItem>
                                    <asp:ListItem Value="4">ASM 3</asp:ListItem>
                                </asp:DropDownList>
                            </div>
                        </div>
                        <div class="col-md-3" data-select2-id="30">
                            <div class="form-group">
                                <label>Supervisor:</label>
                                <asp:DropDownList runat="server" ID="ddlSUP" class="form-control select2 select2-hidden-accessible" Style="width: 100%; height: 40px;">
                                    <asp:ListItem Value="1">--Tất cả--</asp:ListItem>
                                    <asp:ListItem Value="2">Supervisor 1</asp:ListItem>
                                    <asp:ListItem Value="3">Supervisor 2</asp:ListItem>
                                    <asp:ListItem Value="4">Supervisor 3</asp:ListItem>
                                </asp:DropDownList>
                            </div>
                        </div>
                        <div class="col-md-3" data-select2-id="30">
                            <div class="form-group" data-select2-id="29">
                                <label>(MT) Chuỗi siêu thị</label>
                                <asp:DropDownList runat="server" ID="ddl1" class="form-control select2 select2-hidden-accessible" Style="width: 100%; height: 40px;">
                                    <asp:ListItem Value="0">-Tất cả-</asp:ListItem>
                                    <asp:ListItem Value="1">Aeon</asp:ListItem>
                                    <asp:ListItem Value="2">BHX</asp:ListItem>
                                    <asp:ListItem Value="3">BigC</asp:ListItem>
                                </asp:DropDownList>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-2">
                            <div class="form-group" data-select2-id="29">
                                <label>(MT) Loại hình</label>
                                <asp:DropDownList runat="server" ID="DropDownList1" class="form-control select2 select2-hidden-accessible" Style="width: 100%; height: 40px;">
                                    <asp:ListItem Value="0">-Tất cả-</asp:ListItem>
                                    <asp:ListItem Value="1">Supermarket</asp:ListItem>
                                    <asp:ListItem Value="2">Hypermarket</asp:ListItem>
                                    <asp:ListItem Value="3">Minimart</asp:ListItem>
                                </asp:DropDownList>
                            </div>
                        </div>
                        <div class="col-md-2">
                            <div class="form-group" data-select2-id="29">
                                <label>(GT) Nhà phân phối</label>
                                <asp:DropDownList runat="server" ID="DropDownList2" class="form-control select2 select2-hidden-accessible" Style="width: 100%; height: 40px;">
                                    <asp:ListItem Value="0">-Tất cả-</asp:ListItem>
                                    <asp:ListItem Value="1">NPP 1</asp:ListItem>
                                    <asp:ListItem Value="2">NPP 2</asp:ListItem>
                                    <asp:ListItem Value="3">NPP 3</asp:ListItem>
                                </asp:DropDownList>
                            </div>
                        </div>
                        <div class="col-md-2" data-select2-id="30">
                            <div class="form-group">
                                <label>Nhân viên:</label>
                                <asp:DropDownList runat="server" ID="DropDownList3" class="form-control select2 select2-hidden-accessible" Style="width: 100%; height: 40px;">
                                    <asp:ListItem Value="1">--Tất cả--</asp:ListItem>
                                    <asp:ListItem Value="2">Nhân viên 1</asp:ListItem>
                                    <asp:ListItem Value="3">Nhân viên 2</asp:ListItem>
                                    <asp:ListItem Value="4">Nhân viên 3</asp:ListItem>
                                </asp:DropDownList>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- /.card-body -->
                <div class="card-footer">
                    <div class="row">
                        <div class="col-md-3" data-select2-id="30">
                            <asp:Button runat="server" class="btn btn-primary" Text="Tìm kiếm" ID="btnFilter" OnClick="btnFilter_Click" />
                            <asp:Button runat="server" class="btn btn-primary" Visible="false" Text="Xuất báo cáo" ID="btnExport1111" OnClick="btnExport1111_Click" />
                            <asp:Label runat="server" ID="lbMessage" Text=""></asp:Label>
                        </div>
                        <div class="col-md-3" data-select2-id="30">
                        </div>
                        <div class="col-md-3" data-select2-id="30" style="display: none;">
                            <div class="form-group">
                                <div class="input-group">
                                    <div class="custom-file">
                                        <input type="file" class="custom-file-input" id="exampleInputFile">
                                        <asp:FileUpload runat="server" ID="flImport" class="custom-file-input" />
                                        <label class="custom-file-label" for="exampleInputFile">Choose file</label>
                                    </div>
                                    <div class="input-group-append">
                                        <asp:Button runat="server" class="btn btn-danger" Text="Nhập liệu" ID="Button1" />
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <asp:HiddenField ID="hdlChooseDisplay" runat="server" />
            </div>
        </div>
        <!-- /.container-fluid -->
    </section>
    <section class="content" id="sec_detail" runat="server">
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
                                            <tr>
                                                <th rowspan="2" style="text-align: center; vertical-align: inherit;">STT</th>
                                                <th rowspan="2" style="text-align: center; vertical-align: inherit;">Nhân viên</th>
                                                <th rowspan="2" style="text-align: center; vertical-align: inherit;">Quản lý</th>
                                                <th colspan="2" style="text-align: center;">2022-11-01</th>
                                                <th colspan="2" style="text-align: center;">2022-11-02</th>
                                                <th colspan="2" style="text-align: center;">2022-11-03</th>
                                                <th colspan="2" style="text-align: center;">2022-11-04</th>
                                                <th colspan="2" style="text-align: center;">2022-11-05</th>
                                            </tr>
                                            <tr>
                                                <th style="text-align: center;">Thực đạt</th>
                                                <th style="text-align: center;">T/Gian LV</th>
                                                <th style="text-align: center;">Thực đạt</th>
                                                <th style="text-align: center;">T/Gian LV</th>
                                                <th style="text-align: center;">Thực đạt</th>
                                                <th style="text-align: center;">T/Gian LV</th>
                                                <th style="text-align: center;">Thực đạt</th>
                                                <th style="text-align: center;">T/Gian LV</th>
                                                <th style="text-align: center;">Thực đạt</th>
                                                <th style="text-align: center;">T/Gian LV</th>
                                            </tr>
                                            <tr>
                                                <td style="text-align: center;">1</td>
                                                <td>Trần Văn A</td>
                                                <td>Trần Văn B</td>
                                                <td style="text-align: center; background-color: red; color: white;">50% - 10/20</td>
                                                <td style="text-align: center;">9h (07:48 - 16:48)</td>
                                                <td style="text-align: center;">90% - 18/20</td>
                                                <td style="text-align: center;">8h (07:48 - 15:48)</td>
                                                <td style="text-align: center;">90% - 18/20</td>
                                                <td style="text-align: center;">9h (07:48 - 16:48)</td>
                                                <td style="text-align: center;">90% - 18/20</td>
                                                <td style="text-align: center;">9h (07:48 - 16:48)</td>
                                                <td style="text-align: center;">90% - 18/20</td>
                                                <td style="text-align: center;">9h (07:48 - 16:48)</td>
                                            </tr>
                                            <tr>
                                                <td style="text-align: center;">2</td>
                                                <td>Trần Văn A</td>
                                                <td>Trần Văn B</td>
                                                <td style="text-align: center;">100% - 20/20</td>
                                                <td style="text-align: center;">9h (07:48 - 16:48)</td>
                                                <td style="text-align: center;">90% - 18/20</td>
                                                <td style="text-align: center; background-color: red; color: white;">7h (07:48 - 14:48)</td>
                                                <td style="text-align: center;">90% - 18/20</td>
                                                <td style="text-align: center;">9h (07:48 - 16:48)</td>
                                                <td style="text-align: center;">90% - 18/20</td>
                                                <td style="text-align: center;">9h (07:48 - 16:48)</td>
                                                <td style="text-align: center;">90% - 18/20</td>
                                                <td style="text-align: center;">9h (07:48 - 16:48)</td>
                                            </tr>
                                            <tr>
                                                <td style="text-align: center;">3</td>
                                                <td>Trần Văn A</td>
                                                <td>Trần Văn B</td>
                                                <td style="text-align: center; background-color: red; color: white;">50% - 10/20</td>
                                                <td style="text-align: center;">9h (07:48 - 16:48)</td>
                                                <td style="text-align: center;">90% - 18/20</td>
                                                <td style="text-align: center;">8h (07:48 - 15:48)</td>
                                                <td style="text-align: center;">90% - 18/20</td>
                                                <td style="text-align: center;">9h (07:48 - 16:48)</td>
                                                <td style="text-align: center;">90% - 18/20</td>
                                                <td style="text-align: center;">9h (07:48 - 16:48)</td>
                                                <td style="text-align: center;">90% - 18/20</td>
                                                <td style="text-align: center;">9h (07:48 - 16:48)</td>
                                            </tr>
                                            <tr>
                                                <td style="text-align: center;">4</td>
                                                <td>Trần Văn A</td>
                                                <td>Trần Văn B</td>
                                                <td style="text-align: center;">100% - 20/20</td>
                                                <td style="text-align: center;">9h (07:48 - 16:48)</td>
                                                <td style="text-align: center;">90% - 18/20</td>
                                                <td style="text-align: center; background-color: red; color: white;">7h (07:48 - 14:48)</td>
                                                <td style="text-align: center;">90% - 18/20</td>
                                                <td style="text-align: center;">9h (07:48 - 16:48)</td>
                                                <td style="text-align: center;">90% - 18/20</td>
                                                <td style="text-align: center;">9h (07:48 - 16:48)</td>
                                                <td style="text-align: center;">90% - 18/20</td>
                                                <td style="text-align: center;">9h (07:48 - 16:48)</td>
                                            </tr>
                                            <tr>
                                                <td style="text-align: center;">5</td>
                                                <td>Trần Văn A</td>
                                                <td>Trần Văn B</td>
                                                <td style="text-align: center; background-color: red; color: white;">50% - 10/20</td>
                                                <td style="text-align: center;">9h (07:48 - 16:48)</td>
                                                <td style="text-align: center;">90% - 18/20</td>
                                                <td style="text-align: center;">8h (07:48 - 15:48)</td>
                                                <td style="text-align: center;">90% - 18/20</td>
                                                <td style="text-align: center;">9h (07:48 - 16:48)</td>
                                                <td style="text-align: center;">90% - 18/20</td>
                                                <td style="text-align: center;">9h (07:48 - 16:48)</td>
                                                <td style="text-align: center;">90% - 18/20</td>
                                                <td style="text-align: center;">9h (07:48 - 16:48)</td>
                                            </tr>
                                            <tr>
                                                <td style="text-align: center;">6</td>
                                                <td>Trần Văn A</td>
                                                <td>Trần Văn B</td>
                                                <td style="text-align: center;">100% - 20/20</td>
                                                <td style="text-align: center;">9h (07:48 - 16:48)</td>
                                                <td style="text-align: center;">90% - 18/20</td>
                                                <td style="text-align: center; background-color: red; color: white;">7h (07:48 - 14:48)</td>
                                                <td style="text-align: center;">90% - 18/20</td>
                                                <td style="text-align: center;">9h (07:48 - 16:48)</td>
                                                <td style="text-align: center;">90% - 18/20</td>
                                                <td style="text-align: center;">9h (07:48 - 16:48)</td>
                                                <td style="text-align: center;">90% - 18/20</td>
                                                <td style="text-align: center;">9h (07:48 - 16:48)</td>
                                            </tr>
                                            <tr>
                                                <td style="text-align: center;">7</td>
                                                <td>Trần Văn A</td>
                                                <td>Trần Văn B</td>
                                                <td style="text-align: center; background-color: red; color: white;">50% - 10/20</td>
                                                <td style="text-align: center;">9h (07:48 - 16:48)</td>
                                                <td style="text-align: center;">90% - 18/20</td>
                                                <td style="text-align: center;">8h (07:48 - 15:48)</td>
                                                <td style="text-align: center;">90% - 18/20</td>
                                                <td style="text-align: center;">9h (07:48 - 16:48)</td>
                                                <td style="text-align: center;">90% - 18/20</td>
                                                <td style="text-align: center;">9h (07:48 - 16:48)</td>
                                                <td style="text-align: center;">90% - 18/20</td>
                                                <td style="text-align: center;">9h (07:48 - 16:48)</td>
                                            </tr>
                                            <tr>
                                                <td style="text-align: center;">8</td>
                                                <td>Trần Văn A</td>
                                                <td>Trần Văn B</td>
                                                <td style="text-align: center;">100% - 20/20</td>
                                                <td style="text-align: center;">9h (07:48 - 16:48)</td>
                                                <td style="text-align: center;">90% - 18/20</td>
                                                <td style="text-align: center; background-color: red; color: white;">7h (07:48 - 14:48)</td>
                                                <td style="text-align: center;">90% - 18/20</td>
                                                <td style="text-align: center;">9h (07:48 - 16:48)</td>
                                                <td style="text-align: center;">90% - 18/20</td>
                                                <td style="text-align: center;">9h (07:48 - 16:48)</td>
                                                <td style="text-align: center;">90% - 18/20</td>
                                                <td style="text-align: center;">9h (07:48 - 16:48)</td>
                                            </tr>
                                            <tr>
                                                <td style="text-align: center;">9</td>
                                                <td>Trần Văn A</td>
                                                <td>Trần Văn B</td>
                                                <td style="text-align: center; background-color: red; color: white;">50% - 10/20</td>
                                                <td style="text-align: center;">9h (07:48 - 16:48)</td>
                                                <td style="text-align: center;">90% - 18/20</td>
                                                <td style="text-align: center;">8h (07:48 - 15:48)</td>
                                                <td style="text-align: center;">90% - 18/20</td>
                                                <td style="text-align: center;">9h (07:48 - 16:48)</td>
                                                <td style="text-align: center;">90% - 18/20</td>
                                                <td style="text-align: center;">9h (07:48 - 16:48)</td>
                                                <td style="text-align: center;">90% - 18/20</td>
                                                <td style="text-align: center;">9h (07:48 - 16:48)</td>
                                            </tr>
                                            <tr>
                                                <td style="text-align: center;">10</td>
                                                <td>Trần Văn A</td>
                                                <td>Trần Văn B</td>
                                                <td style="text-align: center;">100% - 20/20</td>
                                                <td style="text-align: center;">9h (07:48 - 16:48)</td>
                                                <td style="text-align: center;">90% - 18/20</td>
                                                <td style="text-align: center; background-color: red; color: white;">7h (07:48 - 14:48)</td>
                                                <td style="text-align: center;">90% - 18/20</td>
                                                <td style="text-align: center;">9h (07:48 - 16:48)</td>
                                                <td style="text-align: center;">90% - 18/20</td>
                                                <td style="text-align: center;">9h (07:48 - 16:48)</td>
                                                <td style="text-align: center;">90% - 18/20</td>
                                                <td style="text-align: center;">9h (07:48 - 16:48)</td>
                                            </tr>
                                        </table>
                                    </div>
                                </div>

                                <div class="row">
                                    <div class="col-sm-12 col-md-5">
                                        <div class="dataTables_info" id="example2_info" role="status" aria-live="polite">Showing 1 to 10 of 57 entries</div>
                                    </div>
                                    <div class="col-sm-12 col-md-7">
                                        <div class="dataTables_paginate paging_simple_numbers" id="example2_paginate">
                                            <ul class="pagination">
                                                <li class="paginate_button page-item previous disabled" id="example2_previous"><a href="#" aria-controls="example2" data-dt-idx="0" tabindex="0" class="page-link">Previous</a></li>
                                                <li class="paginate_button page-item active"><a href="#" aria-controls="example2" data-dt-idx="1" tabindex="0" class="page-link">1</a></li>
                                                <li class="paginate_button page-item "><a href="#" aria-controls="example2" data-dt-idx="2" tabindex="0" class="page-link">2</a></li>
                                                <li class="paginate_button page-item "><a href="#" aria-controls="example2" data-dt-idx="3" tabindex="0" class="page-link">3</a></li>
                                                <li class="paginate_button page-item "><a href="#" aria-controls="example2" data-dt-idx="4" tabindex="0" class="page-link">4</a></li>
                                                <li class="paginate_button page-item "><a href="#" aria-controls="example2" data-dt-idx="5" tabindex="0" class="page-link">5</a></li>
                                                <li class="paginate_button page-item "><a href="#" aria-controls="example2" data-dt-idx="6" tabindex="0" class="page-link">6</a></li>
                                                <li class="paginate_button page-item next" id="example2_next"><a href="#" aria-controls="example2" data-dt-idx="7" tabindex="0" class="page-link">Next</a></li>
                                            </ul>
                                        </div>
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
