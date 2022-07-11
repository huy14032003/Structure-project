<style>
    .icon-language .input-group-text {
        background: transparent;
        border: 0;
        color: #f3f3f3;
        padding: 0 !important;
    }

    #sl-language {
        background: transparent;
        border: 0;
        color: #fff;
    }

    #sl-language option {
        color: #212529;
    }

    .alertify-notifier.ajs-center.ajs-top .ajs-message.ajs-visible {
        max-width: 400px !important;
    }

    @media screen and (min-width: 1024px) and (max-width: 1365px) {
        nav.main-header {
            font-size: 14px;
        }

        #sl-language {
            font-size: 14px;
        }
    }

    @media screen and (min-width: 1366px) and (max-width: 1919px) {
        nav.main-header {
            font-size: 15px;
        }

        #sl-language {
            font-size: 15px;
        }
    }
</style>

<nav class="main-header navbar navbar-expand navbar-dark" style="background-color: #2061C5;">
    <ul class="navbar-nav">
        <li class="nav-item">
            <a class="nav-link" data-widget="pushmenu" href="#"><i class="fas fa-bars"></i></a>
        </li>
        <li class="nav-item">
            <a class="nav-link" style="font-weight: bold;" href="#">${title}</a>
        </li>
    </ul>

    <ul class="navbar-nav ml-auto">
        <li class="nav-item dropdown dropdown-hover">
            <a class="nav-link" data-toggle="dropdown" href="#">
                <i class="far fa-user"></i>
                <span id="user-info"></span>
                <span class="caret"></span>
            </a>
            <div class="dropdown-menu dropdown-menu-sm dropdown-menu-right logout">
                <a href="#" onclick="logout()" class="dropdown-item">
                    <i class="fas fa-sign-out-alt"></i>
                    Logout
                </a>
            </div>
        </li>
    </ul>
</nav>

<script>
    $(document).ready(function () {});

    getUserInfo();

    function getUserInfo() {
        $.ajax({
            type: 'GET',
            url: '/pm-system/api/customer/getUser',
            data: {},
            success: function (res) {
                var data = res.result;
                if (!isFalsy(data)) {
                    var userInfo = data.userName + ' (' + data.idCard + ')';
                    $('#user-info').html(userInfo);
                    window.localStorage.setItem('userInfo', JSON.stringify(data));
                } else {
                    window.location.href = ('/pm-system/page-403');
                }
            },
            error: function (err) {
                console.error(err);
                $('.logout').addClass('hidden');
            },
            complete: function () {}
        });
    }
</script>