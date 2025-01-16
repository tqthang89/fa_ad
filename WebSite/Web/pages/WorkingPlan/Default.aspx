<%@ Page Title="" Language="C#" MasterPageFile="~/SiteAudit.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="ECS_Web.pages.WorkingPlan.Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <section class="content">
        <div class="container-fluid">
            <div class="card card-info">
                <div class="card-body">
                    <div class="row">
                         <div class="col-md-2">
                            <div class="form-group">
                                <label>Loại thực thi:<span style="color:red;"> *</span></label>
                                <asp:DropDownList runat="server" ID="ddlType" class="form-control select2 select2-hidden-accessible" Style="width: 100%; height: 40px;" AutoPostBack="true" OnSelectedIndexChanged="ddlType_SelectedIndexChanged">
                                    <asp:ListItem Value="1">Thêm dữ liệu</asp:ListItem>
                                     <asp:ListItem Value="2">Xuất báo cáo</asp:ListItem>
                                </asp:DropDownList>
                            </div>
                        </div>
                        <div class="col-md-2" id="div_create1" runat="server" >
                            <div class="form-group">
                                <label>Ngày làm việc :</label>
                                <div class="input-group date" id="reservationdatewp" data-target-input="nearest">
                                    <asp:TextBox runat="server" ID="txtWPDate" CssClass="form-control datetimepicker-input" data-target="#reservationdatewp"></asp:TextBox>
                                    <div class="input-group-append" data-target="#reservationdatewp" data-toggle="datetimepicker">
                                        <div class="input-group-text"><i class="fa fa-calendar"></i></div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-2" id="div_export1" runat="server" visible="false">
                            <div class="form-group">
                                <label>Từ ngày :</label>
                                <div class="input-group date" id="reservationdate" data-target-input="nearest">
                                    <asp:TextBox runat="server" ID="txtFromDate" CssClass="form-control datetimepicker-input" data-target="#reservationdate"></asp:TextBox>
                                    <div class="input-group-append" data-target="#reservationdate" data-toggle="datetimepicker">
                                        <div class="input-group-text"><i class="fa fa-calendar"></i></div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-2" id="div_export2" runat="server" visible="false">
                            <div class="form-group">
                                <label>Đến ngày :</label>
                                <div class="input-group date" id="reservationdate1" data-target-input="nearest">
                                    <asp:TextBox runat="server" ID="txtToDate" CssClass="form-control datetimepicker-input" data-target="#reservationdate1"></asp:TextBox>
                                    <div class="input-group-append" data-target="#reservationdate1" data-toggle="datetimepicker">
                                        <div class="input-group-text"><i class="fa fa-calendar"></i></div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-2">
                            <div class="form-group">
                                <label>Supervisor:</label>
                                <asp:DropDownList runat="server" ID="ddlSup" class="form-control select2 select2-hidden-accessible" Style="width: 100%; height: 40px;" AutoPostBack="true" OnSelectedIndexChanged="ddlSup_SelectedIndexChanged">
                                </asp:DropDownList>
                            </div>
                        </div>
                        <div class="col-md-2">
                            <div class="form-group">
                                <label>Auditor:</label>
                                <asp:DropDownList runat="server" ID="ddlAuditor" class="form-control select2 select2-hidden-accessible" Style="width: 100%; height: 40px;">
                                </asp:DropDownList>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-6">
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
                            <asp:Button ID="btnImport" CssClass="btn btn-danger" runat="server" Text="Thêm dữ liệu" OnClientClick="popWindow_Custom('/Popups/ImportWorkingPlan.aspx', 700, 520); return false;" />
                            <asp:Button runat="server" class="btn btn-primary" Visible="false" Text="Xuất báo cáo" ID="btnExport" OnClick="btnExport_Click" UseSubmitBehavior="false" OnClientClick="this.value='Đang xuất file...'; this.disabled='true'" />
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- /.container-fluid -->
    </section>
    <section class="content" id="workresult" runat="server">
        <div class="container-fluid">
            <div class="row">
                <div class="col-sm-12">
                    <div class="card">
                        <div class="col-sm-12">
                            <div class="card-header">
                                <h3 class="card-title">Phân quyền lịch làm việc
                                </h3>
                            </div>
                            <div class="card-body">
                                <div id="example2_wrapper" class="dataTables_wrapper dt-bootstrap4">
                                    <div class="row">
                                        <div class="col-sm-12">
                                            <table border="0" cellpadding="0" cellspacing="0" width="100%">
                                                <tr>
                                                    <td style="width: 43%; padding: 10px 0; text-align: center; vertical-align: middle; font-weight: bold">
                                                        <asp:Literal runat="server" ID="ltrShop" Text="Cửa hàng"></asp:Literal></td>
                                                    <td></td>
                                                    <td style="width: 43%; padding: 10px 0; text-align: center; vertical-align: middle; font-weight: bold">
                                                        <asp:Literal runat="server" ID="ltrShopChoosen" Text="Cửa hàng đã chọn"></asp:Literal></td>
                                                </tr>
                                                <tr>
                                                    <td style="width: 43%; padding: 10px 0; text-align: center; vertical-align: middle;">
                                                        <asp:ListBox ID="lbAvailable" CssClass="listbox-multi" runat="server" SelectionMode="Multiple"
                                                            Width="90%" Height="300px" DataTextField="ShopName" DataValueField="ShopId"></asp:ListBox>
                                                        <br />
                                                        <b>
                                                            <asp:Literal runat="server" ID="ltrAvailable"></asp:Literal>
                                                        </b>
                                                    </td>
                                                    <td style="width: 14%; padding: 10px 0; text-align: center; vertical-align: middle;">


                                                        <asp:ImageButton runat="server" ID="btnAdd" OnClick="btnAdd_Click" ImageUrl="~/images/Go-Next-64.png" Width="48" Height="48" />
                                                        <br />
                                                        <asp:ImageButton runat="server" ID="btnAddAll" OnClick="btnAddAll_Click" ImageUrl="~/Images/Go-Last-64.png" Width="48" Height="48" />
                                                        <br />
                                                        <asp:ImageButton runat="server" ID="btnRemove" OnClick="btnRemove_Click" ImageUrl="~/Images/Go-Previous-64.png" Width="48" Height="48" />
                                                        <br />
                                                        <asp:ImageButton runat="server" ID="btnRemoveAll" OnClick="btnRemoveAll_Click" ImageUrl="~/Images/Go-First-64.png" Width="48" Height="48" />
                                                    </td>
                                                    <td style="width: 43%; padding: 10px 0; text-align: center; vertical-align: middle;">
                                                        <asp:ListBox ID="lbChoosen" CssClass="listbox-multi" runat="server" SelectionMode="Multiple"
                                                            Width="90%" Height="300px" DataTextField="ShopName" DataValueField="WPId"></asp:ListBox>
                                                        <br />
                                                        <b>
                                                            <asp:Literal runat="server" ID="ltrChoosen"></asp:Literal>
                                                        </b>
                                                    </td>
                                                </tr>
                                            </table>
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
