<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <aside id="appAside"
        class="app_aside-left--size fixed-top bg-white min-vh-100 px-2 py-3 gap-3 flex-column overflow-auto">
        <header class=" app_aside-logo--size d-flex gap-3 align-items-center mb-3">
            <button
                class="border-0 btn p-0 app_aside-link--size w-100 mb-3">
                <div class="d-flex align-items-center gap-3">
                    <i class="app_aside-icon d-flex justify-content-center align-items-center">
                        <svg xmlns="http://www.w3.org/2000/svg" width="30" height="30" viewBox="0 0 24 24"><!-- Icon from Huge Icons by Hugeicons - undefined --><g fill="none" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="1.5"><path d="m8.643 3.146l-1.705.788C4.313 5.147 3 5.754 3 6.75s1.313 1.603 3.938 2.816l1.705.788c1.652.764 2.478 1.146 3.357 1.146s1.705-.382 3.357-1.146l1.705-.788C19.687 8.353 21 7.746 21 6.75s-1.313-1.603-3.938-2.816l-1.705-.788C13.705 2.382 12.879 2 12 2s-1.705.382-3.357 1.146"/><path d="M20.788 11.097c.141.199.212.406.212.634c0 .982-1.313 1.58-3.938 2.776l-1.705.777c-1.652.753-2.478 1.13-3.357 1.13s-1.705-.377-3.357-1.13l-1.705-.777C4.313 13.311 3 12.713 3 11.731c0-.228.07-.435.212-.634"/><path d="M20.377 16.266c.415.331.623.661.623 1.052c0 .981-1.313 1.58-3.938 2.776l-1.705.777C13.705 21.624 12.879 22 12 22s-1.705-.376-3.357-1.13l-1.705-.776C4.313 18.898 3 18.299 3 17.318c0-.391.208-.72.623-1.052"/></g></svg>
                    </i>
                    <span class="text-nowrap app_aside-hide fw-bold text-primary fs-5">ENF-TRACKING</span>
                </div>
            </button>
        </header>
        <!-- menu cấp 1 -->
        <ul class="flex-grow-1 list-unstyled d-flex flex-column gap-2 ps-0">
            <li>
                <a data-path="/" href="/sample-system/"
                    class="w-100 text-start btn btn-toggle d-flex justify-content-between align-items-center gap-2 border-0 app_aside-link--animation app_aside-link--size">
                    <div class="d-flex align-items-center gap-3">
                        <svg width="25" height="25" fill="currentColor">
                            <use href="/sample-system/assets/images/icons.svg#iconHome"></use>
                        </svg>
                        <span class="text-nowrap app_aside-hide">Trang chủ</span>
                    </div>
                </a>
            </li>

            <li class="">
                <a data-path="form-info-equipment" href="/sample-system/form-info-equipment"
                    class="w-100 text-start btn btn-toggle d-flex justify-content-between align-items-center gap-2 border-0 app_aside-link--animation app_aside-link--size">
                    <div class="d-flex align-items-center gap-3">
                        <svg width="25" height="25" fill="currentColor">
                            <use href="/sample-system/assets/images/icons.svg#iconHome"></use>
                        </svg>
                        <span class="text-nowrap app_aside-hide">Dashboad</span>
                    </div>
                </a>
            </li>

            <!-- menu đa cấp -->
            <li class=" ">
                <a
                    class=" app_aside-link--size w-100 text-start btn btn-toggle d-flex justify-content-between align-items-center gap-2 border-0 app_aside-link--animation mb-2"
                    data-bs-toggle="collapse" data-bs-target="#menuLevel1" aria-expanded="false">
                    <div class="d-flex align-items-center gap-3">
                        <svg width="25" height="25" fill="currentColor">
                            <use href="/sample-system/assets/images/icons.svg#iconHome"></use>
                        </svg>
                        <span class="text-nowrap app_aside-hide">Quản lý nhập xuất</span>
                    </div>
                    <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor"
                        class="bi bi-chevron-right" viewBox="0 0 16 16">
                        <path fill-rule="evenodd"
                            d="M4.646 1.646a.5.5 0 0 1 .708 0l6 6a.5.5 0 0 1 0 .708l-6 6a.5.5 0 0 1-.708-.708L10.293 8 4.646 2.354a.5.5 0 0 1 0-.708" />
                    </svg>
                </a>
                <div class="collapse" id="menuLevel1">
                    <ul class="w-100 list-unstyled app_aside-hide ps-2">
                        <!-- Cấp 2 -->
                        <li class="">
                            <a class="app_aside-link--size w-100 text-start btn btn-toggle d-flex align-items-center justify-content-between gap-2 border-0 app_aside-link--animation mb-2"
                                data-bs-toggle="collapse" data-bs-target="#menuLevel2" aria-expanded="false">
                                <div class="d-flex justify-content-start align-items-center gap-2">
                                    <svg xmlns="http://www.w3.org/2000/svg" width="12" height="12" fill="currentColor"
                                        class="bi bi-circle" viewBox="0 0 16 16">
                                        <path d="M8 15A7 7 0 1 1 8 1a7 7 0 0 1 0 14m0 1A8 8 0 1 0 8 0a8 8 0 0 0 0 16" />
                                    </svg>
                                    <span class="">Danh mục</span>
                                </div>
                                <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor"
                                    class="bi bi-chevron-right" viewBox="0 0 16 16">
                                    <path fill-rule="evenodd"
                                        d="M4.646 1.646a.5.5 0 0 1 .708 0l6 6a.5.5 0 0 1 0 .708l-6 6a.5.5 0 0 1-.708-.708L10.293 8 4.646 2.354a.5.5 0 0 1 0-.708" />
                                </svg>
                            </a>
                            <div class="collapse" id="menuLevel2">
                                <ul class="list-unstyled ps-2">
                                    <!-- Cấp 3 -->
                                    <li class="mb-2">
                                        <a href="/admin"
                                            class="w-100 text-start btn btn-toggle d-flex justify-content-between align-items-center gap-2 border-0 app_aside-link--animation app_aside-link--size">
                                            <div class="d-flex justify-content-start align-items-center gap-2">
                                                <svg xmlns="http://www.w3.org/2000/svg" width="12" height="12"
                                                    fill="currentColor" class="bi bi-circle" viewBox="0 0 16 16">
                                                    <path
                                                        d="M8 15A7 7 0 1 1 8 1a7 7 0 0 1 0 14m0 1A8 8 0 1 0 8 0a8 8 0 0 0 0 16" />
                                                </svg>
                                                <span>Nhập thông tin</span>
                                            </div>
                                        </a>
                                    </li>
                                    <li class="mb-2">
                                        <a href="/outputsalary"
                                            class="w-100 text-start btn btn-toggle d-flex justify-content-between align-items-center gap-2 border-0 app_aside-link--animation app_aside-link--size">
                                            <div
                                                class="d-flex justify-content-start align-items-center gap-2 app_aside-hide">
                                                <svg xmlns="http://www.w3.org/2000/svg" width="12" height="12"
                                                    fill="currentColor" class="bi bi-circle" viewBox="0 0 16 16">
                                                    <path
                                                        d="M8 15A7 7 0 1 1 8 1a7 7 0 0 1 0 14m0 1A8 8 0 1 0 8 0a8 8 0 0 0 0 16" />
                                                </svg>
                                                <span>Xuất chi tiêu</span>
                                            </div>
                                        </a>
                                    </li>
                                </ul>
                            </div>
                        </li>
                        <li class="">
                            <a href="/report"
                                class="w-100 text-start btn btn-toggle d-flex justify-content-between align-items-center gap-2 border-0 app_aside-link--animation app_aside-link--size">
                                <div class="d-flex justify-content-start align-items-center gap-2 app_aside-hide">
                                    <svg xmlns="http://www.w3.org/2000/svg" width="12" height="12" fill="currentColor"
                                        class="bi bi-circle" viewBox="0 0 16 16">
                                        <path d="M8 15A7 7 0 1 1 8 1a7 7 0 0 1 0 14m0 1A8 8 0 1 0 8 0a8 8 0 0 0 0 16" />
                                    </svg>
                                    <span>Báo cáo</span>
                                </div>
                            </a>
                        </li>
                    </ul>
                </div>
            </li>
            <li>
                <a onclick="logout()" href="#"
                    class="w-100 text-start btn btn-toggle d-flex justify-content-between align-items-center gap-2 border-0 app_aside-link--animation app_aside-link--size">
                    <div class="d-flex align-items-center gap-3">
                        <svg width="25" height="25" fill="currentColor">
                            <use href="/sample-system/assets/images/icons.svg#iconHome"></use>
                        </svg>
                        <span class="text-nowrap app_aside-hide">Logout</span>
                    </div>
                </a>
            </li>
        </ul>
    </aside>