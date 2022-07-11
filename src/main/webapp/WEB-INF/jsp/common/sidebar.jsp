<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<style>
    .sidebar::-webkit-scrollbar {
        width: 0;
        height: 0;
    }

    .sidebar-mini .nav-sidebar,
    .sidebar-mini .nav-sidebar .nav-link,
    .sidebar-mini .nav-sidebar>.nav-header {
        color: rgba(248, 248, 250, 0.8);
    }

    .nav-sidebar .nav-link p {
        color: #fff;
    }

    [class*=sidebar-dark-] .nav-treeview>.nav-item>.nav-link>img {
        width: 24px;
        height: 24px;
    }

    .layout-navbar-fixed .wrapper .brand-link {
        width: 300px;
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
    }

    @media screen and (min-width: 1366px) and (max-width: 1919px) {
        div.sidebar {
            font-size: 15px;
        }

        .nav-sidebar>.nav-item .nav-icon.fas {
            font-size: 1.1rem;
        }
    }
</style>
<!-- Main Sidebar Container -->
<aside class="main-sidebar sidebar-dark-primary elevation-4" style="background-image: linear-gradient(#2061C5 , #2061C5);">
    <!-- Brand Logo -->
    <a href="/pm-system/" class="brand-link" style="background-color: #2061C5; border-bottom: 1px solid #cccccc;">
        <img src="/pm-system/assets/dist/img/iconM2.png" alt="Material Management Logo" class="brand-image elevation-3" style="opacity: .8">
        <span class="brand-text font-weight-light" style="font-size: 18px;">Project Manager System</span>
    </a>

    <div class="sidebar">
        <nav class="mt-2">
            <ul class="nav nav-pills nav-sidebar flex-column nav-child-indent" data-widget="treeview" role="menu" data-accordion="false">
                <li class="nav-item">
                    <a href="#" class="nav-link">
                        <i class="nav-icon fas fa-tachometer-alt"></i>
                        <p>
                            PO ETAC
                            <i class="fas fa-angle-right right"></i>
                        </p>
                    </a>
                    <ul class="nav nav-treeview">
                        <li class="nav-item" style="word-break: break-all;" data-path="po-customer-management">
                            <a href="/pm-system/po-customer-management" class="nav-link">
                                <i class="nav-icon fas fa-list"></i>
                                <p>
                                    Customer Management
                                </p>
                            </a>
                        </li>
                        <li class="nav-item" data-path="foxconn-pn-management">
                            <a href="/pm-system/foxconn-pn-management" class="nav-link">
                                <i class="nav-icon fas fa-list"></i>
                                <p>
                                    Foxconn PN Management
                                </p>
                            </a>
                        </li>
                        <li class="nav-item" data-path="create-sign-process">
                            <a href="/pm-system/create-sign-process" class="nav-link">
                                <i class="nav-icon fas fa-list"></i>
                                <p>
                                    Create Sign Process
                                </p>
                            </a>
                        </li>
                        <li class="nav-item" data-path="po-create-form">
                            <a href="/pm-system/po-create-form" class="nav-link">
                                <i class="nav-icon fas fa-list"></i>
                                <p>
                                    Create Form
                                </p>
                            </a>
                        </li>
                        <li class="nav-item" data-path="po-sign">
                            <a href="/pm-system/po-sign" class="nav-link">
                                <i class="nav-icon fas fa-list"></i>
                                <p>
                                    Sign
                                </p>
                            </a>
                        </li>
                        <li class="nav-item" data-path="management-file">
                            <a href="/pm-system/management-file" class="nav-link">
                                <i class="nav-icon fas fa-list"></i>
                                <p>
                                    File Management
                                </p>
                            </a>
                        </li>
                        <li class="nav-item" data-path="my-application">
                            <a href="/pm-system/my-application" class="nav-link">
                                <i class="nav-icon fas fa-list"></i>
                                <p>
                                    My Application
                                </p>
                            </a>
                        </li>
                        <li class="nav-item" data-path="management-po">
                            <a href="/pm-system/management-po" class="nav-link">
                                <i class="nav-icon fas fa-list"></i>
                                <p>
                                    PO Management
                                </p>
                            </a>
                        </li>
                        <li class="nav-item" data-path="management-fo">
                            <a href="/pm-system/management-fo" class="nav-link">
                                <i class="nav-icon fas fa-list"></i>
                                <p>
                                    FO Management
                                </p>
                            </a>
                        </li>
                        <li class="nav-item" data-path="management-shipment">
                            <a href="/pm-system/management-shipment" class="nav-link">
                                <i class="nav-icon fas fa-list"></i>
                                <p>
                                    Shipment Management
                                </p>
                            </a>
                        </li>
                        <li class="nav-item" data-path="management-etac">
                            <a href="/pm-system/management-etac" class="nav-link">
                                <i class="nav-icon fas fa-list"></i>
                                <p>
                                    ETAC Management
                                </p>
                            </a>
                        </li>
                        <li class="nav-item" data-path="management-wka1">
                            <a href="/pm-system/management-wka1" class="nav-link">
                                <i class="nav-icon fas fa-list"></i>
                                <p>
                                    ETAC WKA1 Management
                                </p>
                            </a>
                        </li>
                    </ul>
                </li>
                <li class="nav-item logout">
                    <a href="#" class="nav-link" onclick="logout()">
                        <i class="nav-icon fas fa-sign-out-alt"></i>
                        <p>
                            Logout
                        </p>
                    </a>
                </li>
            </ul>
        </nav>
    </div>
</aside>