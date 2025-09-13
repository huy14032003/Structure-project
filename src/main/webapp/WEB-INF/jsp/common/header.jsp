<%@ page contentType="text/html;charset=UTF-8" language="java" %>
  <div id="navBar" class="app_header app_header--size app_header--blur fixed-top d-flex align-items-center ">
    <div class="col-6 col-md-6 d-flex px-3">
      <div class=" logo rounded-3 d-flex justify-content-start align-items-center">
        <button class="btn p-2 bg-white shadow-sm d-flex justify-content-center align-items-center" id="btnMenu">
          <svg xmlns="http://www.w3.org/2000/svg" width="38" height="38"
            viewBox="0 0 24 24"><!-- Icon from Huge Icons by Hugeicons - undefined -->
            <path fill="none" stroke="currentColor" stroke-linejoin="round" stroke-width="1.5"
              d="M3.889 9.663C4.393 10 5.096 10 6.5 10s2.107 0 2.611-.337a2 2 0 0 0 .552-.552C10 8.607 10 7.904 10 6.5s0-2.107-.337-2.611a2 2 0 0 0-.552-.552C8.607 3 7.904 3 6.5 3s-2.107 0-2.611.337a2 2 0 0 0-.552.552C3 4.393 3 5.096 3 6.5s0 2.107.337 2.611a2 2 0 0 0 .552.552Zm11 0C15.393 10 16.096 10 17.5 10s2.107 0 2.611-.337a2 2 0 0 0 .552-.552C21 8.607 21 7.904 21 6.5s0-2.107-.337-2.611a2 2 0 0 0-.552-.552C19.607 3 18.904 3 17.5 3s-2.107 0-2.611.337a2 2 0 0 0-.552.552C14 4.393 14 5.096 14 6.5s0 2.107.337 2.611a2 2 0 0 0 .552.552Zm-11 11C4.393 21 5.096 21 6.5 21s2.107 0 2.611-.337a2 2 0 0 0 .552-.552C10 19.607 10 18.904 10 17.5s0-2.107-.337-2.611a2 2 0 0 0-.552-.552C8.607 14 7.904 14 6.5 14s-2.107 0-2.611.337a2 2 0 0 0-.552.552C3 15.393 3 16.096 3 17.5s0 2.107.337 2.611a2 2 0 0 0 .552.552Zm11 0C15.393 21 16.096 21 17.5 21s2.107 0 2.611-.337c.218-.146.406-.334.552-.552C21 19.607 21 18.904 21 17.5s0-2.107-.337-2.611a2 2 0 0 0-.552-.552C19.607 14 18.904 14 17.5 14s-2.107 0-2.611.337a2 2 0 0 0-.552.552C14 15.393 14 16.096 14 17.5s0 2.107.337 2.611c.146.218.334.406.552.552Z" />
          </svg>
        </button>
      </div>
      <div class="d-none d-xxl-flex flex-column justify-content-center ps-2">
        <h5 class="fw-bold mb-0 text-uppercase">${title}</h5>
        <nav aria-label="breadcrumb mb-0">
          <ol class="breadcrumb mb-0" id="breadcrumb">
            <li class="breadcrumb-item"><a href="/sample-system/" class="text-decoration-none">Home</a></li>
          </ol>
        </nav>
      </div>
    </div>

    <div class="col-6 col-md-6 d-flex justify-content-end align-items-center gap-4 pe-4">

      <div class="d-none d-xl-flex bg-white px-3 align-items-center rounded-3" style="height: 42px;">
        <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24">
          <path fill="none" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="1.5"
            d="m17 17l4 4m-2-10a8 8 0 1 0-16 0a8 8 0 0 0 16 0" />
        </svg>
        <input list="list" style=" width: 300px; border: 0;" class="bg-white" id="searchInput" placeholder="Search ?" type="search"
          maxlength="2048" tabindex="1">
        <datalist id="list">
          <option value="Trang chủ" data-url="/sample-system/"></option>
          <option value="Home-2" data-url="/sample-system/home2"></option>
          <option value="Dashboad" data-url="/sample-system/form-info-equipment"></option>
        </datalist>
      </div>


      <div class="d-none d-md-block">
        <div class="dropdown">
          <a class="btn bg-transparent dropdown-toggle p-0 border-0 d-flex justify-content-center align-items-center gap-2"
            href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
            <i class="bg-white btn p-1 rounded-5 d-flex justify-content-center align-items-center shadow-sm">
              <svg xmlns="http://www.w3.org/2000/svg" width="22" height="22"
                viewBox="0 0 24 24"><!-- Icon from Huge Icons by Hugeicons - undefined -->
                <g fill="none" stroke="currentColor" stroke-width="1.5">
                  <circle cx="12" cy="12" r="10" />
                  <path stroke-linejoin="round" d="M8 12c0 6 4 10 4 10s4-4 4-10s-4-10-4-10s-4 4-4 10Z" />
                  <path stroke-linecap="round" stroke-linejoin="round" d="M21 15H3m18-6H3" />
                </g>
              </svg>
            </i>

            <span id="currentLang">Vn</span>
          </a>
          <ul class="dropdown-menu">
            <li class="lang-selection " data-lang="vi-VN">
              <a class="dropdown-item " href="#">
                <span class="">Tiếng Việt</span>
              </a>
            </li>
            <li class="lang-selection" data-lang="en-US">
              <a class="dropdown-item" href="#">
                <span class="">English</span>
              </a>
            </li>
            <li class=" lang-selection" data-lang="zh-TW">
              <a class="dropdown-item" href="#">
                <span class="">中文</span>
              </a>
            </li>
        </div>
      </div>

      <div class="d-none d-md-block d-flex justify-content-center rounded-5 align-items-center shadow-sm full-screen">
        <i class="btn d-flex justify-content-center align-items-center bg-white btn-sm p-1 rounded-5" id="fullScreen">
          <svg xmlns="http://www.w3.org/2000/svg" width="22" height="22" viewBox="0 0 24 24">
            <path fill="none" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="1.5"
              d="M15.5 21c1.396 0 2.093 0 2.661-.172a4 4 0 0 0 2.667-2.667C21 17.593 21 16.896 21 15.5m0-7c0-1.396 0-2.093-.172-2.661a4 4 0 0 0-2.667-2.667C17.593 3 16.896 3 15.5 3m-7 18c-1.396 0-2.093 0-2.661-.172a4 4 0 0 1-2.667-2.667C3 17.593 3 16.896 3 15.5m0-7c0-1.396 0-2.093.172-2.661A4 4 0 0 1 5.84 3.172C6.407 3 7.104 3 8.5 3" />
          </svg>
        </i>
      </div>

      <div class="d-flex justify-content-center align-items-center gap-2 profile">
        <div class="avatar d-flex justify-content-center align-items-center rounded-2  shadow-sm">
          <img src="/sample-system/assets/images/background-home-2.png" alt="" />
        </div>
        <div class="d-flex flex-column">
          <span class="fw-bold" id="userName">XXXX</span>
          <span class="" id="userId">XXXX</span>
        </div>
      </div>
    </div>
  </div>