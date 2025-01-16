<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="TaiSan.aspx.cs" Inherits="ECS_Web.Report.TaiSan" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <!-- Main content -->
    <section class="content">
        <div class="container-fluid">
            <div class="card card-info">
                <div class="card-header">
                    <h3 class="card-title">Quản lý tài sản</h3>
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
                                <label>Phòng ban:</label>
                                <asp:DropDownList runat="server" ID="ddlCycle" class="form-control select2 select2-hidden-accessible" Style="width: 100%; height: 40px;">
                                    <asp:ListItem Value="1">-Tất cả-</asp:ListItem>
                                    <asp:ListItem Value="2">Sales</asp:ListItem>
                                    <asp:ListItem Value="3">Dự án</asp:ListItem>
                                    <asp:ListItem Value="4">IT</asp:ListItem>
                                </asp:DropDownList>
                            </div>
                        </div>
                        <div class="col-md-2" data-select2-id="30">
                            <div class="form-group">
                                <label>Vị trí:</label>
                                <asp:DropDownList runat="server" ID="DropDownList5" class="form-control select2 select2-hidden-accessible" Style="width: 100%; height: 40px;">
                                    <asp:ListItem Value="1">--Tất cả--</asp:ListItem>
                                    <asp:ListItem Value="2">Giám đốc Sales</asp:ListItem>
                                    <asp:ListItem Value="3">Sales</asp:ListItem>
                                    <asp:ListItem Value="4">Project Manager</asp:ListItem>
                                    <asp:ListItem Value="5">IT WEB</asp:ListItem>
                                </asp:DropDownList>
                            </div>
                        </div>
                        <div class="col-md-2" data-select2-id="30">
                            <div class="form-group">
                                <label>Nhân viên:</label>
                                <asp:DropDownList runat="server" ID="DropDownList4" class="form-control select2 select2-hidden-accessible" Style="width: 100%; height: 40px;">
                                    <asp:ListItem Value="1">--Tất cả--</asp:ListItem>
                                    <asp:ListItem Value="2">Nhân viên A</asp:ListItem>
                                    <asp:ListItem Value="3">Nhân viên B</asp:ListItem>
                                    <asp:ListItem Value="4">Nhân viên C</asp:ListItem>
                                    <asp:ListItem Value="5">Nhân viên D</asp:ListItem>
                                </asp:DropDownList>
                            </div>
                        </div>
                        <div class="col-md-2" data-select2-id="30">
                            <div class="form-group">
                                <label>Loại tài sản:</label>
                                <asp:DropDownList runat="server" ID="ddlArea" class="form-control select2 select2-hidden-accessible" Style="width: 100%; height: 40px;">
                                    <asp:ListItem Value="1">--Tất cả--</asp:ListItem>
                                    <asp:ListItem Value="2">Laptop</asp:ListItem>
                                    <asp:ListItem Value="2">Điện thoại</asp:ListItem>
                                    <asp:ListItem Value="3">Sạc</asp:ListItem>
                                    <asp:ListItem Value="4">Màn hình</asp:ListItem>
                                    <asp:ListItem Value="5">Chuột</asp:ListItem>
                                </asp:DropDownList>
                            </div>
                        </div>
                        <div class="col-md-2" data-select2-id="30">
                            <div class="form-group">
                                <label>Hãng tài sản:</label>
                                <asp:DropDownList runat="server" ID="ddlASM" class="form-control select2 select2-hidden-accessible" Style="width: 100%; height: 40px;">
                                    <asp:ListItem Value="1">--Tất cả--</asp:ListItem>
                                    <asp:ListItem Value="2">Apple</asp:ListItem>
                                    <asp:ListItem Value="3">Lenovo</asp:ListItem>
                                    <asp:ListItem Value="4">Dell</asp:ListItem>
                                    <asp:ListItem Value="5">Samsung</asp:ListItem>
                                </asp:DropDownList>
                            </div>
                        </div>

                        <div class="col-md-2" data-select2-id="30">
                            <div class="form-group" data-select2-id="29">
                                <label>T/ thái tài sản</label>
                                <asp:DropDownList runat="server" ID="ddl1" class="form-control select2 select2-hidden-accessible" Style="width: 100%; height: 40px;">
                                    <asp:ListItem Value="0">-Tất cả-</asp:ListItem>
                                    <asp:ListItem Value="1">Trong kho</asp:ListItem>
                                    <asp:ListItem Value="2">Đã cấp phát</asp:ListItem>
                                    <asp:ListItem Value="4">Đã mất</asp:ListItem>
                                    <asp:ListItem Value="3">Đã hủy</asp:ListItem>
                                </asp:DropDownList>
                            </div>
                        </div>
                        <div class="col-md-2">
                            <div class="form-group" data-select2-id="29">
                                <label>T/ Trạng tài sản</label>
                                <asp:DropDownList runat="server" ID="DropDownList1" class="form-control select2 select2-hidden-accessible" Style="width: 100%; height: 40px;">
                                    <asp:ListItem Value="0">-Tất cả-</asp:ListItem>
                                    <asp:ListItem Value="1">Mới 100%</asp:ListItem>
                                    <asp:ListItem Value="2">Hàng đã qua sử dụng</asp:ListItem>
                                    <asp:ListItem Value="3">Hư hỏng</asp:ListItem>
                                </asp:DropDownList>
                            </div>
                        </div>
                        <div class="col-md-2">
                            <div class="form-group" data-select2-id="29">
                                <label>Nhập Seri</label>
                                <asp:TextBox runat="server" ID="DropDow111" class="form-control" Style="width: 100%; height: 40px;">
                                </asp:TextBox>
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

    <section class="content">
        <div class="container-fluid">
            <div class="row">
                <div class="col-md-12">

                    <div class="card">
                        <div class="card-header">
                            <h3 class="card-title">Tổng hợp</h3>
                        </div>
                        <!-- /.card-header -->
                        <div class="card-body">
                            <style>
                                table.table td {
                                    text-align: center;
                                }
                            </style>
                            <table class="table table-bordered table-hover">
                                <thead style="text-align: center; vertical-align: central;">
                                    <tr>
                                        <th style="width: 10px" rowspan="2">#</th>
                                        <th rowspan="2">Tài sản</th>
                                        <th colspan="2">Trong kho</th>
                                        <th colspan="2">Đã cấp phát</th>
                                        <th rowspan="2">Đã hủy</th>
                                        <th rowspan="2">Đã mất</th>
                                        <th rowspan="2">Tổng tiền mua</th>
                                        <th rowspan="2">Giá trị tiền còn lại</th>
                                    </tr>
                                    <tr>
                                        <th>Mới 100 %</th>
                                        <th>Đã qua sử dụng</th>
                                        <th>Mới 100 %</th>
                                        <th>Đã qua sử dụng</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td>1.</td>
                                        <td>Laptop</td>
                                        <td>10</td>
                                        <td>2</td>
                                        <td>80</td>
                                        <td>10</td>
                                        <td>10</td>
                                        <td>5</td>
                                        <td>150.000.000đ</td>
                                        <td>120.000.000đ</td>
                                    </tr>
                                    <tr>
                                        <td>2.</td>
                                        <td>Sạc laptop</td>
                                        <td>10</td>
                                        <td>2</td>
                                        <td>80</td>
                                        <td>10</td>
                                        <td>10</td>
                                        <td>5</td>
                                        <td>150.000.000đ</td>
                                        <td>120.000.000đ</td>
                                    </tr>
                                    <tr>
                                        <td>3.</td>
                                        <td>Chuột</td>
                                        <td>10</td>
                                        <td>2</td>
                                        <td>80</td>
                                        <td>10</td>
                                        <td>10</td>
                                        <td>5</td>
                                        <td>150.000.000đ</td>
                                        <td>120.000.000đ</td>
                                    </tr>
                                    <tr>
                                        <td>4.</td>
                                        <td>Điện thoại</td>
                                        <td>10</td>
                                        <td>2</td>
                                        <td>80</td>
                                        <td>10</td>
                                        <td>10</td>
                                        <td>5</td>
                                        <td>150.000.000đ</td>
                                        <td>120.000.000đ</td>
                                    </tr>
                                    <tr style="font-weight: bold;">
                                        <td colspan="8">Tổng hợp</td>
                                        <td>600.000.000đ</td>
                                        <td>480.000.000đ</td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                        <!-- /.card-body -->
                        <div class="card-footer clearfix" style="display: none;">
                            <ul class="pagination pagination-sm m-0 float-right">
                                <li class="page-item"><a class="page-link" href="#">«</a></li>
                                <li class="page-item"><a class="page-link" href="#">1</a></li>
                                <li class="page-item"><a class="page-link" href="#">2</a></li>
                                <li class="page-item"><a class="page-link" href="#">3</a></li>
                                <li class="page-item"><a class="page-link" href="#">»</a></li>
                            </ul>
                        </div>
                    </div>

                </div>
            </div>
        </div>
    </section>

    <section class="content" id="sec_detail" runat="server">
        <div class="container-fluid">
            <div class="row">
                <div class="col-12">
                    <div class="card">
                        <div class="card-header">
                            <h3 class="card-title">Chi tiết cửa hàng</h3>
                        </div>
                        <div class="card-body">
                            <div id="example2_wrapper" class="dataTables_wrapper dt-bootstrap4">
                                <div class="row">
                                    <div class="col-sm-12">
                                        <asp:GridView runat="server" ID="gvSellOut" AutoGenerateColumns="false" class="table table-bordered table-hover dataTable dtr-inline">
                                            <Columns>
                                                <asp:TemplateField>
                                                    <ItemTemplate>
                                                        <asp:ImageButton ID="img" ImageUrl="~/images/plus.png" runat="server" OnClick="img_Click" CommandName="Show" />
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:BoundField HeaderText="STT" DataField="STT" />
                                                <asp:BoundField HeaderText="Mã tài sản" ControlStyle-ForeColor="Red" DataField="STT" />
                                                <asp:TemplateField HeaderText="Tên nhân viên">
                                                    <ItemTemplate>
                                                        <asp:Label runat="server" ID="lbShopName" Text='Trần Văn A ( EMP0001)'></asp:Label>
                                                        - 0900000000
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Phòng ban">
                                                    <ItemTemplate>
                                                        <asp:Label runat="server" ID="lbPB" Text='IT'></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Vị trí">
                                                    <ItemTemplate>
                                                        <asp:Label runat="server" ID="lbVT" Text='IT WEB'></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Quản lý">
                                                    <ItemTemplate>
                                                        <asp:Label runat="server" ID="lbQL" Text='Trần Văn B'></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Loại tài sản">
                                                    <ItemTemplate>
                                                        <asp:Label runat="server" ID="lbCustomer" Text='Laptop'></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Tên tài sản">
                                                    <ItemTemplate>
                                                        <asp:Label runat="server" ID="lbtts" Text='Macbook 2020'></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Ngày cấp">
                                                    <ItemTemplate>
                                                        <asp:Label runat="server" ID="lbt143ts" Text='15/10/2022'></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Giá trị bàn giao">
                                                    <ItemTemplate>
                                                        <asp:Label runat="server" ID="lbQC4343" Text='10.000.000đ'></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Giá trị còn lại">
                                                    <ItemTemplate>
                                                        <asp:Label runat="server" ID="lbQC13134343" Text='9.500.000đ'></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Khẩu hao (1 tháng)">
                                                    <ItemTemplate>
                                                        <asp:Label runat="server" ID="lbKHFF" Text='1.5%'></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField>
                                                    <ItemStyle Width="0px" />
                                                    <ItemTemplate>
                                                        <tr style="height: 40%">
                                                            <td colspan="100%" style="padding: 0px !important;">
                                                                <asp:Panel runat="server" ID="pnGrid" Visible="false" Style="padding: 10px; padding-left: 38px;">
                                                                    <asp:Panel runat="server" ID="plSO" Style="padding: 10px;">
                                                                        <div class="row">
                                                                            <table class="table-bordered">
                                                                                <tr style="text-align: left; vertical-align: top">
                                                                                    <thead>
                                                                                        <tr>
                                                                                            <th class="text-center">Mã giao dịch</th>
                                                                                            <th class="text-center">Loại giao dịch</th>
                                                                                            <th class="text-center">T/thái</th>
                                                                                            <th class="text-center">Giá trị bàn giao</th>
                                                                                            <th class="text-center">Khẩu hao (1 tháng )</th>
                                                                                            <th class="text-center">Giá trị thu hồi</th>
                                                                                            <th class="text-center">Nhân viên</th>
                                                                                            <th class="text-center">Ngày giao dịch</th>
                                                                                            <th class="text-center">Ghi chú</th>
                                                                                            <th class="text-center">File đính kèm</th>
                                                                                            <th class="text-center">Tools</th>
                                                                                        </tr>
                                                                                    </thead>
                                                                                    <tbody>
                                                                                        <tr>
                                                                                            <td style="text-align: center;">5454</td>
                                                                                            <td style="text-align: center;"><span class="badge bg-success">Bàn giao</span></td>
                                                                                            <td style="text-align: center;">Mới 100%</td>
                                                                                            <td style="text-align: center;">14.000.000đ</td>
                                                                                            <td style="text-align: center;">1.6%</td>
                                                                                            <td style="text-align: center;"></td>
                                                                                            <td style="text-align: center;">Trần Văn B</td>
                                                                                            <td style="text-align: center;">08/02/2019 13:40:00</td>
                                                                                            <td style="text-align: center;">Máy mới 100%</td>
                                                                                            <td style="text-align: center;"><a target="_blank" href="../Images/taisan.png"><i class="fa fa-file-alt"></i></a></td>
                                                                                            <td style="text-align: center;"><a target="_blank" href="../Images/taisan.png"><i class="fa fa-print"></i></a> | <a target="_blank" href="../Images/taisan.png"><i class="fa fa-edit"></i></a></td>
                                                                                        </tr>
                                                                                        <tr>
                                                                                            <td style="text-align: center;">5484</td>
                                                                                            <td style="text-align: center;"><span class="badge bg-danger">Thu hồi</span></td>
                                                                                            <td style="text-align: center;"></td>
                                                                                            <td style="text-align: center;">14.000.000đ</td>
                                                                                            <td style="text-align: center;">1.6%</td>
                                                                                            <td style="text-align: center;">10.000.000đ</td>
                                                                                            <td style="text-align: center;">Trần Văn B</td>
                                                                                            <td style="text-align: center;">07/02/2022 13:40:00</td>
                                                                                            <td style="text-align: center;">Có xước nhẹ</td>
                                                                                            <td style="text-align: center;"><a target="_blank" href="../Images/taisan.png"><i class="fa fa-file-alt"></i></a></td>
                                                                                            <td style="text-align: center;"><a target="_blank" href="../Images/taisan.png"><i class="fa fa-print"></i></a> | <a target="_blank" href="../Images/taisan.png"><i class="fa fa-edit"></i></a></td>
                                                                                        </tr>
                                                                                        <tr>
                                                                                            <td style="text-align: center;">5655</td>
                                                                                            <td style="text-align: center;"><span class="badge bg-success">Bàn giao</span></td>
                                                                                            <td style="text-align: center;">Mới 99%</td>
                                                                                            <td style="text-align: center;">10.000.000đ</td>
                                                                                            <td style="text-align: center;">1.5%</td>
                                                                                            <td style="text-align: center;"></td>
                                                                                            <td style="text-align: center;">Trần Văn A</td>
                                                                                            <td style="text-align: center;">08/02/2022 13:40:00</td>
                                                                                            <td style="text-align: center;">Máy qua sử dụng, có xước nhẹ.</td>
                                                                                            <td style="text-align: center;"><a target="_blank" href="../Images/taisan.png"><i class="fa fa-file-alt"></i></a></td>
                                                                                            <td style="text-align: center;"><a target="_blank" href="../Images/taisan.png"><i class="fa fa-print"></i></a> | <a target="_blank" href="../Images/taisan.png"><i class="fa fa-edit"></i></a></td>
                                                                                        </tr>
                                                                                    </tbody>
                                                                                </tr>
                                                                            </table>
                                                                        </div>
                                                                    </asp:Panel>
                                                                </asp:Panel>
                                                            </td>
                                                        </tr>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                            </Columns>
                                        </asp:GridView>
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
    <div class="modal fade" id="modal-default" style="display: none;" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h4 class="modal-title">Ảnh mẫu sản phẩm</h4>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">×</span>
                    </button>
                </div>
                <div class="modal-body">
                    <img src="../Images/product_temp.jpg" />
                </div>
            </div>
            <!-- /.modal-content -->
        </div>
        <!-- /.modal-dialog -->
    </div>
    <script>
        function showvalue() {
            document.getElementById('<%= hdlChooseDisplay.ClientID %>').value = $("#ddlmt").val();
        }
        var requestManager = Sys.WebForms.PageRequestManager.getInstance();
        requestManager.add_endRequest(function () {
            try {
                var s2 = $("#ddlmt").select2({
                    placeholder: "--All--",
                    tags: true
                });
                var vals = document.getElementById('<%= hdlChooseDisplay.ClientID %>').value.split(','); // ["1", "2", "3"];
                s2.val(vals).trigger("change");
            } catch (e) {

            }
        });
    </script>
</asp:Content>
