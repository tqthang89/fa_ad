<%@ Page Title="" Language="C#" MasterPageFile="~/SiteAudit.Master" AutoEventWireup="true" CodeBehind="Create.aspx.cs" Inherits="ECS_Web.pages.Employees.Create" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <section class="content">
        <div class="container-fluid">
            <div class="card card-info">
                <div class="card-body">
                    <div class="row">
                        <div class="col-md-12">
                            <div class="mx-auto" style="width: 140px;">
                                <div class="d-flex justify-content-center align-items-center rounded" style="height: 140px; background-color: transparent">
                                    <%-- <span style="color: rgb(166, 168, 170); font: bold 8pt Arial;">
                                                        </span>--%>
                                    <asp:Image ID="imgAvatar" ImageUrl="~/Images/no_avatar.jpg" runat="server" Width="140" Height="140" Style="border-radius: 50%" />
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-2">
                            <div class="form-group">
                                <label>Mã nhân viên:</label>
                                <asp:TextBox runat="server" ID="txtEmployeeCode" CssClass="form-control" />
                            </div>
                        </div>
                        <div class="col-md-2">
                            <div class="form-group">
                                <label>Tên nhân viên:</label>
                                <asp:TextBox runat="server" ID="txtEmployeeName" CssClass="form-control" />
                            </div>
                        </div>
                        <div class="col-md-2">
                            <div class="form-group">
                                <label>Quản lý:</label>
                                <asp:DropDownList runat="server" ID="ddlSup" class="form-control select2 select2-hidden-accessible" Style="width: 100%; height: 40px;">
                                </asp:DropDownList>
                            </div>
                        </div>
                        <div class="col-md-2">
                            <div class="form-group">
                                <label>Ngày sinh :</label>
                                <div class="input-group date" id="reservationdate" data-target-input="nearest">
                                    <asp:TextBox runat="server" ID="txtDateOfBirth" CssClass="form-control datetimepicker-input" data-target="#reservationdate"></asp:TextBox>
                                    <div class="input-group-append" data-target="#reservationdate" data-toggle="datetimepicker">
                                        <div class="input-group-text"><i class="fa fa-calendar"></i></div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-2">
                            <div class="form-group">
                                <label>Số điện thoại:</label>
                                <asp:TextBox runat="server" ID="txtPhone" CssClass="form-control" />
                            </div>
                        </div>
                        <div class="col-md-2">
                            <div class="form-group">
                                <label>CMND/CCCD:</label>
                                <asp:TextBox runat="server" ID="txtIdentityCard" CssClass="form-control" />
                            </div>
                        </div>
                        <div class="col-md-2">
                            <div class="form-group">
                                <label>Email:</label>
                                <asp:TextBox runat="server" ID="txtEmail" CssClass="form-control" />
                            </div>
                        </div>
                        <div class="col-md-2">
                            <div class="form-group">
                                <label>Giới tính:</label>
                                <asp:DropDownList runat="server" ID="ddlSex" CssClass="form-control select2 select2-hidden-accessible" Style="width: 100%; height: 40px;">
                                    <asp:ListItem Text="Nam" Value="1" Selected="True" />
                                    <asp:ListItem Text="Nữ" Value="0" />
                                    <asp:ListItem Text="Khác" Value="-1" />
                                </asp:DropDownList>
                            </div>
                        </div>
                        <div class="col-md-2">
                            <div class="form-group">
                                <label>Loại nhân viên:</label>
                                <asp:DropDownList runat="server" ID="ddlType" class="form-control select2 select2-hidden-accessible" Style="width: 100%; height: 40px;">
                                </asp:DropDownList>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="form-group">
                                <label>Địa chỉ:</label>
                                <asp:TextBox runat="server" ID="txtAddress" CssClass="form-control" />
                            </div>
                        </div>
                        <div class="col-md-2">
                            <div class="form-group">
                                <label>Trạng thái:</label>
                                <asp:DropDownList runat="server" ID="ddlStatus" CssClass="form-control select2 select2-hidden-accessible" Style="width: 100%; height: 40px;">
                                    <asp:ListItem Text="Hoạt động" Value="1" Selected="True" />
                                    <asp:ListItem Text="Không hoạt động" Value="0" />
                                </asp:DropDownList>
                            </div>
                        </div>
                        <div class="col-md-2">
                            <div class="form-group">
                                <label>Tên đăng nhập:</label>
                                <asp:TextBox runat="server" ID="txtUsername" CssClass="form-control" />
                            </div>
                        </div>
                        <div class="col-md-2">
                            <div class="form-group">
                                <label>Mật khẩu:</label>
                                <asp:TextBox runat="server" ID="txtPass" CssClass="form-control" />
                            </div>
                        </div>
                        <div class="col-md-2">
                            <div class="form-group">
                                <label>Nhập lại mật khẩu:</label>
                                <asp:TextBox runat="server" ID="txtRePass" CssClass="form-control" />
                            </div>
                        </div>
                    </div>
                </div>
                <div class="card-footer">
                    <div class="row">
                        <div class="col-md-12">
                            <asp:Button runat="server" class="btn btn-primary" Text="Lưu thông tin" ID="btnSave" OnClick="btnSave_Click" />
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
</asp:Content>
