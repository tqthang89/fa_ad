<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Register.aspx.cs" Inherits="FAuditService.WebMobile.Register" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>AdminLTE 3 | Registration Page</title>
    <!-- Google Font: Source Sans Pro -->
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700&display=fallback">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://syngenta.e-technology.vn/AdminLTE/plugins/fontawesome-free/css/all.min.css">
    <!-- icheck bootstrap -->
    <link rel="stylesheet" href="https://syngenta.e-technology.vn/AdminLTE/plugins/icheck-bootstrap/icheck-bootstrap.min.css">
    <!-- Theme style -->
    <link rel="stylesheet" href="https://syngenta.e-technology.vn/AdminLTE/dist/css/adminlte.min.css">
</head>
<body class="hold-transition register-page">
    <form id="form1" runat="server" method="post">
        <div class="register-box">
            <div class="card">
                <div class="card-body register-card-body">
                    <p class="login-box-msg">Register a new membership</p>

                    <div class="input-group mb-3" style="display:none;">
                        <input type="text" class="form-control" placeholder="Full name">
                        <div class="input-group-append">
                            <div class="input-group-text">
                                <span class="fas fa-user"></span>
                            </div>
                        </div>
                    </div>
                    <div class="input-group mb-3">
                        <asp:TextBox runat="server" ID="txtEmail" class="form-control" placeholder="Email"></asp:TextBox>
                        <%--<input type="email" class="form-control" placeholder="Email">--%>
                        <div class="input-group-append">
                            <div class="input-group-text">
                                <span class="fas fa-envelope"></span>
                            </div>
                        </div>
                    </div>
                    <div class="input-group mb-3">
                        <asp:TextBox runat="server" ID="txtPassWord" TextMode="Password" class="form-control" placeholder="Password"></asp:TextBox>
                        <%--<input type="password" class="form-control" placeholder="Password">--%>
                        <div class="input-group-append">
                            <div class="input-group-text">
                                <span class="fas fa-lock"></span>
                            </div>
                        </div>
                    </div>
                    <div class="input-group mb-3">
                        <%--<input type="password" class="form-control" placeholder="Retype password">--%>
                        <asp:TextBox runat="server" ID="txtRetypePassWord" TextMode="Password" class="form-control" placeholder="Retype password"></asp:TextBox>
                        <div class="input-group-append">
                            <div class="input-group-text">
                                <span class="fas fa-lock"></span>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-8">
                            <div class="icheck-primary">
                                <%--<input type="checkbox" id="agreeTerms" name="terms" value="agree">--%>
                                <asp:CheckBox ID="cbAllow" Text="I agree to the terms" runat="server" />
                              <%--  <label for="agreeTerms">
                                    I agree to the <a href="#">terms</a>
                                </label>--%>
                            </div>
                        </div>
                        <!-- /.col -->
                        <div class="col-4">
                            <%--<button type="submit" class="btn btn-primary btn-block">Register</button>--%>
                            <asp:Button runat="server" ID="txtRegister" class="btn btn-primary btn-block" Text="Register" OnClick="txtRegister_Click" />
                        </div>
                        <!-- /.col -->
                    </div>

                    <div class="social-auth-links text-center" style="display:none;">
                        <p>- OR -</p>
                        <a href="#" class="btn btn-block btn-primary">
                            <i class="fab fa-facebook mr-2"></i>
                            Sign up using Facebook
        </a>
                        <a href="#" class="btn btn-block btn-danger">
                            <i class="fab fa-google-plus mr-2"></i>
                            Sign up using Google+
        </a>
                    </div>
                    <asp:Label runat="server" ID="lbError" style="color:red;"></asp:Label>
                    <%--<a href="login.html" class="text-center">I already have a membership</a>--%>
                </div>
                <!-- /.form-box -->
            </div>
        </div>
        <script src="https://syngenta.e-technology.vn/AdminLTE/plugins/jquery/jquery.min.js"></script>
        <!-- Bootstrap 4 -->
        <script src="https://syngenta.e-technology.vn/AdminLTE/plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
        <!-- AdminLTE App -->
        <script src="https://syngenta.e-technology.vn/AdminLTE/dist/js/adminlte.min.js"></script>
    </form>
</body>
</html>
