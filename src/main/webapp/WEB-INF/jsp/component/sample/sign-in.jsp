<%@ page contentType="text/html;charset=UTF-8" language="java" %> <%@ taglib uri="http://java.sun.com/jsp/jstl/core"
prefix="c" %> <%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %> <%@ page
trimDirectiveWhitespaces="true" %>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>LMS - ${title}</title>
    <link rel="icon" type="image/ico" href="/sample-system/assets/images/logoFII.png" />

    <!-- Theme style -->
    <link rel="stylesheet" href="/sample-system/assets/dist/css/adminlte.min.css" />
    <!-- Font Awesome Icons -->
    <link rel="stylesheet" type="text/css" href="/sample-system/assets/plugins/fontawesome-free/css/all.min.css" />
    <!-- Daterange picker -->
    <link rel="stylesheet" href="/sample-system/assets/plugins/daterangepicker/daterangepicker.css" />
    <!-- Boostrap select -->
    <link rel="stylesheet" href="/sample-system/assets/plugins/bootstrap-select.1.13.14/dist/css/bootstrap-select.min.css" />
    <!-- Alertify JS -->
    <link rel="stylesheet" href="/sample-system/assets/plugins/alertify/alertify.min.css" />
    <!-- Customize -->
    <link rel="stylesheet" href="/sample-system/assets/css/custom/style.css" />

    <!-- jQuery -->
    <script src="/sample-system/assets/plugins/jquery/jquery.min.js"></script>
    <!-- Bootstrap 4 -->
    <script src="/sample-system/assets/plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
    <!-- AdminLTE App -->
    <script src="/sample-system/assets/dist/js/adminlte.js"></script>
    <!-- OPTIONAL SCRIPTS -->
    <script src="/sample-system/assets/dist/js/demo.js"></script>
    <!-- Daterangepicker -->
    <script src="/sample-system/assets/plugins/moment/moment.min.js"></script>
    <script src="/sample-system/assets/plugins/daterangepicker/daterangepicker.js"></script>
    <!-- Boostrap select -->
    <link rel="stylesheet" href="/sample-system/assets/plugins/bootstrap-select.1.13.14/dist/css/bootstrap-select.min.css" />
    <script src="/sample-system/assets/plugins/bootstrap-select.1.13.14/dist/js/bootstrap-select.min.js"></script>
    <!-- Alertify JS -->
    <link rel="stylesheet" href="/sample-system/assets/plugins/alertify/alertify.min.css" />
    <script src="/sample-system/assets/plugins/alertify/alertify.min.js"></script>
    <!-- Customize -->
    <script src="/sample-system/assets/js/custom/core-customize.js"></script>

    <style>
        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
        }

        select:disabled {
            background-color: #94abbf !important;
        }

        input.form-control,
        select.form-control {
            border: 0 !important;
            outline: 0 !important;
        }

        .title-page {
            font-size: 2rem;
            padding: 20px 0px;
            color: #fff;
            text-shadow: 0 3px black;
            letter-spacing: 5px;
        }

        .container-signin {
            background-image: url('/sample-system/assets/images/background-home-2.png');
            background-size: 100% 100%;
            background-position: center center;

            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
        }

        .sign-in {
            background-color: hsla(219, 74%, 20%, 0.7);
            border-radius: 15px;
            border: 1px solid #ccc;
            padding: 20px 25px !important;
            width: 500px;
        }

        .title-login {
            color: #137beb;

            text-shadow: 2px 2px 2px #140c0c;
            text-align: center;

            font-weight: 600;
        }

        label {
            color: #fff;
            letter-spacing: 2px;
            font-weight: 500;
        }

        footer {
            width: 100%;
            padding: 5px 0;
            position: fixed;
            bottom: 0;
            text-align: center;
            color: #76a9dd;
        }

        @media screen and (max-width: 560px) {
            .sign-in {
                width: 95%;
            }
        }

        @media screen and (max-width: 1023px) {
            .container-signin {
                background-size: cover;
                background-repeat: no-repeat;
                background-position: center center;
            }
        }
    </style>
</head>

<body>
    <div class="container-signin" style="height: 100vh">
        <div class="text-center">
            <h1 class="title-page">SMART FACTORY</h1>
        </div>
        <div class="sign-in">
            <div id="content">
                <h4 class="my-2 title-login">ĐĂNG NHẬP</h4>
                <div class="form">
                    <div>
                        <label class="label-inline mt-3"> <i class="fa fa-user"></i> <span>Mã thẻ</span> </label>
                        <input type="text" id="inputUser" class="form-control" placeholder="Nhập mã thẻ" required="required" />
                    </div>

                    <div>
                        <label class="label-inline mt-3"> <i class="fa fa-key"></i> <span>Mật khẩu</span> </label>
                        <div style="position: relative">
                            <input type="password" id="inputPassword" class="form-control" placeholder="Nhập mật khẩu" required="" />
                            <i class="fa fa-eye" style="
                                        position: absolute;
                                        top: 50%;
                                        transform: translateY(-50%);
                                        right: 4%;
                                        color: #ccc;
                                    "></i>
                        </div>
                    </div>

                    <div>
                        <label class="label-inline mt-3"> <i class="fa fa-globe"></i> <span>Ngôn ngữ</span> </label>
                        <select class="form-control select-language" disabled id="language">
                            <option value="vi-VN">Tiếng Việt</option>
                            <option value="en-US">Tiếng Anh</option>
                            <option value="zh-TW">Tiếng Trung (Phồn thể)</option>
                            <option value="zh-CN">Tiếng Trung (Giản thể)</option>
                        </select>
                    </div>

                    <div class="w3ls-bot">
                        <div class="d-flex align-items-center justify-content-center">
                            <button id="idLogin" class="btn btn-primary my-3" onclick="login()">Đăng nhập</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <footer class="text-center">
        <strong>
            Bản quyền 2020 - <span class="current-year"></span>
            <span>. Fii - Software</span>
        </strong>
        <script>
            var currentYear = new Date().getFullYear();
            $('.current-year').html(currentYear);
        </script>
    </footer>

    <!-- modal -->
    <div class="modal fade" id="modal-forgotPass" role="dialog">
        <div class="modal-dialog modal-xl">
            <div class="modal-content" style="background: #070d22; background-image: radial-gradient(#06448c, #0d2251, #103246)">
                <div class="modal-header" style="padding: 5px; border-bottom: 1px solid #ccc">
                    <button type="button" id="close-error-3" class="close" data-dismiss="modal" style="right: 10px; top: 15%">
                        <i class="icon icon-cross" style="color: #fff"></i>
                    </button>
                    <div class="modal-title">
                        <span style="
                                    font-weight: bold;
                                    float: left;
                                    text-transform: capitalize;
                                    color: #fff;
                                    font-size: 15px;
                                ">Information</span>
                    </div>
                </div>
                <div class="modal-body" style="background-color: #ececec">
                    <p style="padding: 0; color: #000; font-size: 13px">
                        <i class="fa fa-info-circle" aria-hidden="true"></i> You can call to telephone 26152 or send
                        email to address: cpe-vn-fii-sw@mail.foxconn.com to reset password. Thank you so much!!
                    </p>
                </div>
            </div>
        </div>
    </div>

    <script>
        $(document).ready(function () {
            var empNo = window.localStorage.getItem('empNo');
            if (empNo != null && empNo != undefined && empNo != '') {
                document.getElementById('inputUser').value = empNo;
            }

            document.getElementById('inputUser').addEventListener('input', function () {
                this.value = this.value.toUpperCase();
            });

            document.getElementsByClassName('fa-eye')[0].addEventListener('click', function () {
                var inputPassword = document.getElementById('inputPassword');
                var inputType = inputPassword.getAttribute('type');
                if (inputType === 'password') {
                    inputPassword.setAttribute('type', 'text');
                    this.style.color = '#201f1f';
                } else {
                    inputPassword.setAttribute('type', 'password');
                    this.style.color = '#cccccc';
                }
            });
        });

        function login() {
            $.ajax({
                type: 'POST',
                url: '/sample-system/api/oauth/sign-in',
                data: {
                    username: $('#inputUser').val(),
                    password: $('#inputPassword').val(),
                    uuid: '################',
                },
                success: function (data) {
                    date = new Date();
                    date.setTime(date.getTime() + 6 * 60 * 30 * 1000);
                    document.cookie =
                        'access_token=' + data['access_token'] + ';path=/' + ';expires=' + date.toUTCString();

                    date = new Date();
                    date.setTime(date.getTime() + 30 * 24 * 60 * 60 * 1000);
                    document.cookie =
                        'refresh_token=' + data['refresh_token'] + ';path=/' + ';expires=' + date.toUTCString();

                    $.ajax({
                        type: 'GET',
                        url: '/sample-system/api/v4/user/current',
                        success: function (res) {
                            var data = res.result;
                            if (!isFalsy(data)) {
                                window.localStorage.setItem('empNo', $('#inputUser').val());
                                window.localStorage.setItem('userInfo', JSON.stringify(data));
                            }

                            var last_location = window.localStorage.getItem('last_location');

                            if (last_location == null || last_location == undefined) {
                                window.location.href = '/sample-system/port-monitoring-mobile';
                            } else {
                                window.location.href = last_location;
                            }
                        },
                        error: function (err) {
                            console.error(err);
                        },
                        complete: function () {},
                    });
                },
                error: function (error) {
                    if (error.responseJSON != null && error.responseJSON.message != null) {
                        alert(error.responseJSON.message);
                    } else {
                        alert('FAILED!');
                    }
                },
            });
        }
    </script>
</body>
<loom-container id="lo-engage-ext-container">
    <div></div>
    <loom-shadow classname="resolved"></loom-shadow>
</loom-container>

</html>