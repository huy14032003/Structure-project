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
        width: 400px !important;
    }

    li .dropdown-toggle::after {
        position: absolute;
        top: 50%;
        right: 0;
        transform: translateY(-50%);
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
        <li class="nav-item dropdown mr-3">
            <a href="#" class="nav-link dropdown-toggle" data-toggle="dropdown" id="lang-name"></a>
            <div class="dropdown-menu dropdown-menu-left" id="list_language">
                <div class="dropdown-item d-flex align-items-center justify-content-start" data-lang="vi-VN">
                    <a href="javascript:void(0)">
                        <img src="/sample-system/assets/images/language/vietnam.png" alt="VN">
                        <spring:message code="vietnamese" />
                    </a>
                </div>
                <div class="dropdown-item d-flex align-items-center" data-lang="en-US">
                    <a href="javascript:void(0)">
                        <img src="/sample-system/assets/images/language/united-kingdom.png" alt="VN">
                        <spring:message code="english" />
                    </a>
                </div>
                <div class="dropdown-item d-flex align-items-center" data-lang="zh-TW">
                    <a href="javascript:void(0)">
                        <img src="/sample-system/assets/images/language/china.png" alt="VN">
                        <spring:message code="chinese" />
                    </a>
                </div>
            </div>
        </li>
        <li class="nav-item dropdown dropdown-hover">
            <a class="nav-link" data-toggle="dropdown" href="#">
                <i class="far fa-user"></i>
                <span id="user-info"></span>
                <span class="caret"></span>
            </a>
            <div class="dropdown-menu dropdown-menu-sm dropdown-menu-right logout">
                <a href="/sample-system/profile" class="dropdown-item">
                    <i class="fas fa-user"></i>
                    <spring:message code="profile" />
                </a>
                <a href="#" onclick="logout()" class="dropdown-item">
                    <i class="fas fa-sign-out-alt"></i>
                    <spring:message code="logout" />
                </a>
            </div>
        </li>
    </ul>
</nav>

<script>
    getUserInfo();
    var lang = window.localStorage.getItem('lang');
    if (lang != null && lang != undefined && lang != '') {
        if (getCookie('lang') == null || getCookie('lang') == undefined || getCookie('lang') == '') {
            document.cookie = 'lang=;expires=Thu, 01 Jan 1970 00:00:00 UTC; path=/';
            document.cookie = 'lang=' + lang + ';path=/';
            window.location.reload();
        } else {
            if (lang != getCookie('lang')) {
                window.localStorage.setItem('lang', getCookie('lang'));
                window.location.reload();
            }
        }
    } else {
        if (getCookie('lang') == null || getCookie('lang') == undefined || getCookie('lang') == '') {
            document.cookie = 'lang=;expires=Thu, 01 Jan 1970 00:00:00 UTC; path=/';
            document.cookie = 'lang=vi-VN;path=/';
            window.localStorage.setItem('lang', 'vi-VN');
            window.location.reload();
        } else {
            window.localStorage.setItem('lang', getCookie('lang'));
            window.location.reload();
        }
    }

    $(document).ready(function () {
        $('#list_language .dropdown-item').on('click', function () {
            let lang = this.dataset.lang;
            document.cookie = 'lang=;expires=Thu, 01 Jan 1970 00:00:00 UTC; path=/';
            document.cookie = 'lang=' + lang + ';path=/';
            window.localStorage.setItem('lang', lang);
            window.location.reload();
        });

        checkImgLang();
    });

    function checkImgLang() {
        var lang = window.localStorage.getItem('lang');
        let html = '';
        if (lang == 'vi-VN') {
            html =
                `<div class="d-flex align-items-center justify-content-center">
                    <img src="/sample-system/assets/images/language/vietnam.png" alt="VN">
                    <span class="ml-2"><spring:message code="vietnamese" /></span>
                </div>`;
        } else if (lang == 'en-US') {
            html =
                `<div class="d-flex align-items-center justify-content-center">
                    <img src="/sample-system/assets/images/language/united-kingdom.png" alt="EN">
                    <span class="ml-2"><spring:message code="english" /></span>
                </div>`;
        } else if (lang == 'zh-TW') {
            html =
                `<div class="d-flex align-items-center justify-content-center" alt="CN">
                    <img src="/sample-system/assets/images/language/china.png">
                    <span class="ml-2"><spring:message code="chinese" /></span>
                </div>`;
        }

        $('#lang-name').html(html);
    }

    function getCookie(cname) {
        var name = cname + "=";
        var ca = document.cookie.split(';');
        for (var i = 0; i < ca.length; i++) {
            var c = ca[i];
            while (c.charAt(0) == ' ') {
                c = c.substring(1);
            }
            if (c.indexOf(name) == 0) {
                return c.substring(name.length, c.length);
            }
        }
        return "";
    }

    function getUserInfo() {
        $.ajax({
            type: 'GET',
            url: '/sample-system/api/v4/user/current',
            async: false,
            success: function (res) {
                var data = res.result;
                if (!isFalsy(data)) {
                    window.localStorage.setItem('userInfo', JSON.stringify(data));
                    var userName = formatUserName(data);
                    $('#user-info').html(userName);
                }
            },
            error: function (err) {
                // console.error(JSON.parse(err.responseText).message);
                $('.logout').addClass('hidden');
                $('.profile').addClass('hidden');
            },
            complete: function () {
                var userInfo = JSON.parse(window.localStorage.getItem('userInfo'));
                if (!isFalsy(userInfo)) {
                    var firstAccess = JSON.parse(window.localStorage.getItem('firstAccess'));
                    if (firstAccess == null || firstAccess) {
                        firstAccess = true;
                    }
                    if (firstAccess) {
                        welcomeToSystem(userInfo);
                        window.localStorage.setItem('firstAccess', false);
                    }
                }
            }
        });
    }

    function welcomeToSystem(userInfo) {
        var userName = formatUserName(userInfo);
        alertify.set('notifier', 'position', 'top-center');
        alertify.set('notifier', 'delay', 5);
        alertify.message('<b><spring:message code="welcome" /><br/><span class="text-primary">' + userName +
            '</span></b>');
    }
</script>