<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ImportImageAdmin.aspx.cs" Inherits="ECS_Web.Popups.ImportImageAdmin" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Nhập liệu lịch làm việc</title>
    <!-- Google Font: Source Sans Pro -->
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700&display=fallback" />
    <!-- Select2 -->
    <link rel="stylesheet" href="/AdminLTE/plugins/select2-bootstrap4-theme/select2-bootstrap4.min.css" />
    <!-- Theme style -->
    <link rel="stylesheet" href="/AdminLTE/dist/css/adminlte.min.css" />

    <!-- DataTables -->
    <link rel="stylesheet" href="/AdminLTE/plugins/datatables-bs4/css/dataTables.bootstrap4.min.css" />
    <link rel="stylesheet" href="/AdminLTE/plugins/datatables-responsive/css/responsive.bootstrap4.min.css" />
    <link rel="stylesheet" href="/AdminLTE/plugins/datatables-buttons/css/buttons.bootstrap4.min.css" />
    <!-- Toastr -->
    <link rel="stylesheet" href="/AdminLTE/plugins/toastr/toastr.min.css" />
    <style>
        .tpoloading {
            z-index: 99999999999999;
            background-image: url("/Images/loading.gif");
            background-size: 330px 220px;
            background-position: center;
            background-repeat: no-repeat;
            width: 100%;
            height: 100%;
            position: fixed;
            top: 0%;
            left: 0%;
        }

        ::-webkit-scrollbar {
            width: 6px;
            height: 6px;
        }

        ::-webkit-scrollbar-thumb {
            height: 6px;
            background-color: #ECECEC;
        }

        ::-webkit-scrollbar-track-piece {
            background-color: #ECECEC;
        }

        ::-webkit-scrollbar-thumb {
            box-shadow: 0 2px 1px 0 rgba(0,0,0,.05);
            background: linear-gradient(to right,rgba(200,200,200,.04)0,rgba(0,0,0,.04)100%),url(../images/scrollbar_thumb_bg.png) no-repeat center #6B6B6B;
            border-radius: 3px;
        }
    </style>

</head>
<body>
    <form id="form1" runat="server">
        <div class="wrapper">
            <asp:ScriptManager runat="server" AsyncPostBackTimeout="3000" ID="ScriptManager1">
                <Scripts>
                    <asp:ScriptReference Path="~/Scripts/popup.js" />
                    <asp:ScriptReference Path="~/Scripts/jquery-1.7.1.min.js" />
                </Scripts>
            </asp:ScriptManager>
            <div class="content-wrapper">
                <div class="container-fluid">
                    <div class="card card-info" style="margin-bottom: 0px !important;">
                        <div class="card-header">
                            <h3 class="card-title">
                                <asp:Label Text="Nhập liệu cửa hàng" runat="server" /></h3>
                            <div class="card-tools">
                                <button type="button" class="btn btn-tool" data-card-widget="collapse">
                                    <i class="fas fa-minus"></i>
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
                <%--<asp:UpdatePanel runat="server" ID="UpdatePanel1">
                    <ContentTemplate>--%>
                <section class="content">
                    <div class="container-fluid">
                        <div class="card card-info">
                            <div class="card-body">
                                <div class="row">
                                    <div class="col-md-4">
                                        <div class="form-group">
                                            <label>KPI :</label>
                                            <asp:DropDownList runat="server" CssClass="form-control select2 select2-hidden-accessible" ID="ddlKPI" OnSelectedIndexChanged="ddlType_SelectedIndexChanged" AutoPostBack="true">
                                                <asp:ListItem Text="Attendance" Value="0" />
                                                <asp:ListItem Text="Phiếu xác nhận" Value="4" />
                                                <asp:ListItem Text="Báo cáo trưng bày" Value="2" />
                                                <asp:ListItem Text="HotZone" Value="1" />
                                                <asp:ListItem Text="POSM" Value="3" />
                                                 <asp:ListItem Text="CTKM" Value="7" />
                                            </asp:DropDownList>
                                        </div>
                                    </div>
                                    <div class="col-md-4">
                                        <div class="form-group">
                                            <label>WorkId :</label>
                                            <asp:TextBox runat="server" ID="txtWorkId" OnTextChanged="txtWorkId_TextChanged" AutoPostBack="true" placeholder="WorkId" CssClass="form-control">
                                            </asp:TextBox>
                                        </div>
                                    </div>
                                    <div class="col-md-4" style="display: none;">
                                        <div class="form-group">
                                            <label>ID Ảnh :</label>

                                        </div>
                                    </div>
                                    <div class="col-md-4" style="display: none;">
                                        <div class="form-group">
                                            <label>Chọn file import :</label>
                                            <div class="input-group date" id="reservationdate" data-target-input="nearest">
                                            </div>
                                        </div>
                                    </div>
                                    <%--<div class="col-md-4">
                                        <div class="form-group">
                                            <label>Loại thay đổi :</label>
                                            <asp:DropDownList runat="server" CssClass="form-control select2 select2-hidden-accessible" ID="ddlTypeAction">
                                                <asp:ListItem Text="Thay thế ảnh" Value="0" />
                                            </asp:DropDownList>
                                        </div>
                                    </div>--%>
                                </div>
                            </div>
                            <div class="card-footer">
                                <div class="row">
                                    <div class="col-md-3" style="display: none;">
                                        <asp:Button runat="server" class="btn btn-danger" Text="Tìm kiếm" ID="btnFilter" OnClick="btnFilter_Click" UseSubmitBehavior="false"
                                            OnClientClick="this.value='Đang tìm kiếm...'; this.disabled='true'" />
                                    </div>
                                    <div class="col-md-6" >
                                        <input type="file" id="fileImport" onchange="Upfile();" class="form-control" />
                                    </div>
                                    <div class="col-md-9" runat="server" id="divChange">
                                        <table style="float: left;">
                                            <tr>
                                               <%-- <td></td>--%>
                                                    
                                                <td>
                                                    <asp:TextBox runat="server" ID="txtImageId" placeholder="ID Ảnh" CssClass="form-control">
                                                    </asp:TextBox></td>
                                                <td>
                                                    <asp:Button runat="server" class="btn btn-primary" Text="Thay thế" ID="btnImport" OnClick="btnImport_Click" UseSubmitBehavior="false"
                                                        OnClientClick="this.value='Đang nhập liệu...'; this.disabled='true'" />
                                                </td>
                                            </tr>
                                        </table>
                                    </div>
                                    <div class="col-md-12" runat="server" id="divInsert" visible="false">
                                        <table style="float: left;width:100%;">
                                            <tr>
                                                <td style="display:none;">
                                                    <input type="file" id="fileImport1" onchange="Upfile();" class="form-control" /></td>
                                                <td>
                                                    <asp:TextBox runat="server" ID="txtItemId" placeholder="ItemId" CssClass="form-control">
                                                    </asp:TextBox></td>
                                                <td>
                                                    <asp:TextBox runat="server" ID="txtTime" placeholder="Time(yyyy-mm-dd hh:mm:ss)" CssClass="form-control">
                                                    </asp:TextBox></td>
                                                <td>
                                                    <asp:Button runat="server" class="btn btn-primary" Text="Thêm mới" ID="btnInsert" OnClick="btnInsert_Click" UseSubmitBehavior="false"
                                                        OnClientClick="this.value='Đang nhập liệu...'; this.disabled='true'" />
                                                </td>
                                            </tr>
                                        </table>
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
                                        <h3 class="card-title">Kết quả làm việc</h3>
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

                <section class="content" id="Section1" runat="server">
                    <div class="container-fluid">
                        <div class="row">
                            <div class="col-12">
                                <div class="card">
                                    <div class="card-header">
                                        <h3 class="card-title">Danh sách ảnh</h3>
                                    </div>
                                    <div class="card-body">
                                        <div id="example2_wrapper11" class="dataTables_wrapper dt-bootstrap4">
                                            <div class="row">
                                                <div class="col-sm-12">
                                                    <table class="table table-bordered table-hover dataTable dtr-inline">
                                                        <thead>
                                                            <tr>
                                                                <th>#</th>
                                                                <th>ID Ảnh</th>
                                                                <th>Mô tả</th>
                                                                <th>Ảnh</th>
                                                                <th>Thời gian</th>
                                                                <th>T/Thái</th>
                                                            </tr>
                                                        </thead>
                                                        <tbody>
                                                            <asp:Repeater runat="server" ID="rpt_list_image">
                                                                <ItemTemplate>
                                                                    <tr>
                                                                        <td><%# Eval("RN") %>
                                                                            <asp:Label runat="server" ID="lbImageId" Visible="false" Text='<%# Eval("ImageId") %>'></asp:Label>
                                                                            <asp:Label runat="server" ID="lbShopId" Visible="false" Text='<%# Eval("ShopId") %>'></asp:Label>
                                                                            <asp:Label runat="server" ID="lbAuditDate" Visible="false" Text='<%# Eval("AuditDate") %>'></asp:Label>
                                                                            <asp:Label runat="server" ID="lbWorkId" Visible="false" Text='<%# Eval("WorkId") %>'></asp:Label>
                                                                            <asp:Label runat="server" ID="lbImageTime" Visible="false" Text='<%# Eval("ImageTime") %>'></asp:Label>
                                                                        </td>
                                                                        <td><%# Eval("ImageId") %></td>
                                                                        <td><%# Eval("Desc") %></td>
                                                                        <td>
                                                                            <img src='<%# Eval("ImagePath") %>' style="width: 125px; height: 150px;" /></td>
                                                                        <td><%# Eval("ImageTime") %> </td>
                                                                        <td><%--<%# Eval("Status") %>--%>
                                                                            <asp:DropDownList runat="server" OnSelectedIndexChanged="ddlStatus_SelectedIndexChanged" AutoPostBack="true" SelectedValue='<%# Eval("StatusCode") %>' ID="ddlStatus">
                                                                                <asp:ListItem Value="0">Inactive</asp:ListItem>
                                                                                <asp:ListItem Value="1">Active</asp:ListItem>
                                                                            </asp:DropDownList>

                                                                        </td>
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

            </div>
        </div>
        <!-- /.content-wrapper -->
        <footer class="main-footer">
            <div class="float-right d-none d-sm-block">
                <b>Version</b> 3.1.0
               
            </div>
            <strong>Copyright &copy; 2021 <a href="#">Ecosystem</a>.</strong> All rights reserved.
        </footer>

        <!-- Control Sidebar -->
        <aside class="control-sidebar control-sidebar-dark">
            <!-- Control sidebar content goes here -->
        </aside>
        <!-- jQuery -->
        <script src="../Scripts/jquery-1.7.1.min.js"></script>
        <script src="/AdminLTE/plugins/jquery/jquery.min.js"></script>
        <!-- Bootstrap 4 -->
        <script src="/AdminLTE/plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
        <!-- Toastr -->
        <script src="/AdminLTE/plugins/toastr/toastr.min.js"></script>
        <!-- /.control-sidebar -->
        <script>
            Upfile = function () {
                var fileExtension = ['jpg', 'png'];
                if ($.inArray($('#fileImport').val().split('.').pop().toLowerCase(), fileExtension) == -1) {
                    alert("Only formats are allowed : " + fileExtension.join(', '));
                    $('#fileImport').val('');
                    //$('.FileContent').html('');
                }
                else {
                    var formData = new FormData();
                    var files = document.getElementById("fileImport");
                    var totalFiles = files.files.length;
                    if (totalFiles < 1) {
                        alert("Chọn template để import");
                        //return false;
                    }
                    if (totalFiles > 1) {
                        alert("Vui lòng chọn 1 file để import.");
                        //return false;
                    }
                    var file = files.files[0];
                    formData.append("FileUpload", file);
                    $.ajax({
                        type: "POST",
                        url: '../pages/SaveTempExcel.ashx',
                        data: formData,
                        dataType: 'text',
                        contentType: false,
                        processData: false,
                        success: function (Data) {
                            //alert(Data);
                            //$('span.FileContent').html(Data);SSSSSSSSSSSSSSSSSSSS
                            // alert('Upload file successfully.');
                            toastr.success(Data + ' file');
                        },
                        error: function (error) {
                            alert("error");
                            $('#fileImport').val('');
                        }
                    });
                }
            }
        </script>
    </form>
</body>
</html>
