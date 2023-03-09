<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<style>
    .sidebar-mini .nav-sidebar,
    .sidebar-mini .nav-sidebar .nav-link,
    .sidebar-mini .nav-sidebar>.nav-header {
        color: rgba(248, 248, 250, 0.8);
    }

    .sidebar::-webkit-scrollbar {
        width: 0;
    }

    .nav-sidebar .nav-link p {
        color: #fff;
    }

    .nav-sidebar>.nav-item>.nav-link>img,
    [class*=sidebar-dark-] .nav-treeview>.nav-item>.nav-link>img {
        width: 25px;
        height: 25px;
    }

    .layout-navbar-fixed .wrapper .brand-link {
        width: 350px;
    }

    .layout-navbar-fixed .wrapper .main-sidebar:hover .brand-link {
        width: 350px !important;
    }

    body:not(.sidebar-mini-md) .content-wrapper,
    body:not(.sidebar-mini-md) .main-footer,
    body:not(.sidebar-mini-md) .main-header {
        margin-left: 350px;
    }

    .main-sidebar:hover {
        width: 350px !important;
    }

    .main-sidebar,
    .main-sidebar::before {
        width: 350px;
    }

    .brand-link {
        display: flex;
        align-items: center;
        justify-content: flex-start;

        background-color: #2061C5 !important;
    }

    .brand-link .brand-image {
        margin: 0;
    }

    .brand-link:hover .brand-image {
        transition: all 1s;
        animation: spin 3s linear infinite;
    }

    .brand-text {
        font-weight: bold !important;
        letter-spacing: 2px;
        text-shadow: 2px 2px 1px black;
        color: #d2eeff;
    }


    @keyframes spin {
        0% {
            transform: rotateY(0deg);
        }

        50% {
            transform: rotateY(180deg);
        }

        100% {
            transform: rotateY(360deg);
        }
    }

    @media screen and (max-width: 1000px) {

        body:not(.sidebar-mini-md) .content-wrapper,
        body:not(.sidebar-mini-md) .main-footer,
        body:not(.sidebar-mini-md) .main-header {
            margin-left: auto !important;
        }

        .main-sidebar:hover {
            width: auto !important;
        }

        .main-sidebar,
        .main-sidebar::before {
            width: auto !important;
        }
    }

    @media screen and (min-width: 1024px) and (max-width: 1365px) {
        div.sidebar {
            font-size: 14px;
        }

        .nav-sidebar>.nav-item .nav-icon.fas {
            font-size: 1rem;
        }

        .nav-sidebar>.nav-item>.nav-link>img,
        [class*=sidebar-dark-] .nav-treeview>.nav-item>.nav-link>img {
            width: 23px;
            height: 23px;
        }
    }

    @media screen and (min-width: 1366px) and (max-width: 1919px) {
        div.sidebar {
            font-size: 15px;
        }

        .nav-sidebar>.nav-item .nav-icon.fas {
            font-size: 1.1rem;
        }

        [class*=sidebar-dark-] .nav-treeview>.nav-item>.nav-link>img {
            width: 23px;
            height: 23px;
        }
    }
</style>
<!-- Main Sidebar Container -->
<aside class="main-sidebar sidebar-dark-primary elevation-4"
    style="background-image: linear-gradient(#2061C5 , #2061C5);">
    <!-- Brand Logo -->
    <a href="/sample-system/" class="brand-link">
        <!-- <img src="/sample-system/assets/dist/img/iconM2.png" alt="Material Management Logo" class="brand-image elevation-3"
            style="opacity: .8"> -->
        <img src="/sample-system/assets/images/logoFII.png" alt="logo" class="brand-image">
        <span class="brand-text font-weight-light" style="font-size: 18px;">SAMPLE SYSTEM</span>
    </a>

    <div class="sidebar">
        <nav class="mt-2">
            <ul class="nav nav-pills nav-sidebar flex-column nav-child-indent" data-widget="treeview" role="menu"
                data-accordion="false">
                <li class="nav-item" path="home">
                    <a href="/sample-system/" class="nav-link">
                        <i class="nav-icon fas fa-tachometer-alt"></i>
                        <p>Home</p>
                    </a>
                </li>
                <!-- <li class="nav-item has-treeview">
                    <a href="/sample-system/setting" class="nav-link">
                        <i class="nav-icon fas fa-cogs"></i>
                        <p>Setting</p>
                    </a>
                    <ul class="nav nav-treeview">
                            <li class="nav-item" path="lms-setting">
                                <a href="/sample-system/setting" class="nav-link">
                                    <i class="nav-icon fas fa-truck-moving"></i>
                                    <p>
                                        Setting Truck
                                    </p>
                                </a>
                            </li>
                            <li class="nav-item">
                                <a href="/sample-system/setting-map" class="nav-link">
                                    <i class="nav-icon fas fa-map-marked-alt"></i>
                                    <p>
                                        Setting Distance
                                    </p>
                                </a>
                            </li>
                        </ul>
                </li> -->

                <li class="nav-item logout">
                    <a href="#" class="nav-link" onclick="logout()">
                        <i class="nav-icon fas fa-sign-out-alt"></i>
                        <p>
                            <spring:message code="logout" />
                        </p>
                    </a>
                </li>
            </ul>
        </nav>
    </div>
    <script>
        var userInfo = JSON.parse(window.localStorage.getItem('userInfo'));
        var role = '';

        if (!isFalsy(userInfo)) {
            role = userInfo.role;
        }

        let userDataPath = {
            // Các người dùng thông thường không thể truy cập
            deny: [
                'truck-dispatch',
                'management-common',
                'ga/order/dispatch',
                'fixed-schedule'
            ]
        };

        let guardianDataPath = {
            // Các trang bảo vệ có thể truy cập
            accept: [
                'port-monitoring'
            ],
            // Các trang bảo vệ không thể truy cập
            deny: [
                'general-administration',
                'zero-waste'
            ]
        };

        let menuLv1 = document.querySelectorAll('.sidebar > nav > ul > li');

        if (role == 'USER') {
            for (let i = 0; i < menuLv1.length; i++) {
                
                let menuLv2 = menuLv1[i].querySelectorAll('li');
                for (let j = 0; j < menuLv2.length; j++) {
                    if (userDataPath.deny.indexOf(menuLv2[j].getAttribute('data-path')) > -1) {
                        menuLv2[j].remove();
                    }
                }
            }
        } else if (role == 'GUARDIAN') {
            for (let i = 0; i < menuLv1.length; i++) {

                if (guardianDataPath.deny.indexOf(menuLv1[i].getAttribute('data-path')) > -1) {
                    menuLv1[i].remove();

                } else {
                    let menuLv2 = menuLv1[i].querySelectorAll('li');
                    for (let j = 0; j < menuLv2.length; j++) {
                        if (guardianDataPath.accept.indexOf(menuLv2[j].getAttribute('data-path')) == -1) {
                            menuLv2[j].remove();
                        }
                    }

                }
            }
        }
    </script>
</aside>