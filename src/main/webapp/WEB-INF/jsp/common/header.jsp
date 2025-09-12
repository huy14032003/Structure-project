<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<div  id="navBar" class="app_header app_header--size app_header--blur fixed-top d-flex align-items-center px-4">
      <div class="col-4 d-flex">
        <div class="logo rounded-3 d-flex justify-content-start align-items-center">
          <button class="ms-3 btn bg-white shadow-sm d-flex justify-content-center align-items-center" id="btnMenu">
            <svg width="25" height="25" fill="currentColor">
              <use href="/sample-system/assets/images/icons.svg#iconMenu"></use>
            </svg>
          </button>
        </div>
        <div class="title ms-3">
            <div class="head_title">
                <span class="fw-bold fs-4">List order</span>
            </div>
            <div class="sub_Title">
                <span >Home/123</span>
            </div>
        </div>
      </div>
      <div class="col-8 d-flex justify-content-end align-items-center gap-4">
        <div class="d-none d-md-block">
          <div class="multi-lang position-relative">
            <div class="btn d-flex align-items-center justify-content-between gap-2" id="groupMultiLang">
             <svg xmlns="http://www.w3.org/2000/svg" width="18" height="18" fill="currentColor" class="bi bi-translate" viewBox="0 0 16 16">
              <path d="M4.545 6.714 4.11 8H3l1.862-5h1.284L8 8H6.833l-.435-1.286zm1.634-.736L5.5 3.956h-.049l-.679 2.022z"/>
              <path d="M0 2a2 2 0 0 1 2-2h7a2 2 0 0 1 2 2v3h3a2 2 0 0 1 2 2v7a2 2 0 0 1-2 2H7a2 2 0 0 1-2-2v-3H2a2 2 0 0 1-2-2zm2-1a1 1 0 0 0-1 1v7a1 1 0 0 0 1 1h7a1 1 0 0 0 1-1V2a1 1 0 0 0-1-1zm7.138 9.995q.289.451.63.846c-.748.575-1.673 1.001-2.768 1.292.178.217.451.635.555.867 1.125-.359 2.08-.844 2.886-1.494.777.665 1.739 1.165 2.93 1.472.133-.254.414-.673.629-.89-1.125-.253-2.057-.694-2.82-1.284.681-.747 1.222-1.651 1.621-2.757H14V8h-3v1.047h.765c-.318.844-.74 1.546-1.272 2.13a6 6 0 0 1-.415-.492 2 2 0 0 1-.94.31"/>
            </svg>
              <span>Tiếng Việt</span>
            </div>
            <div class="box-multi d-none card position-absolute mt-2" id="multiBox">
              <div class="card-body p-0">
                <ul class="list-unstyled m-0 list_hover">
                  <li class="mb-2 p-2" onclick="location.href='./navbar.html'">Tiếng Việt</li>
                  <li class="mb-2 p-2" onclick="location.href='./navbar.html'">Tiếng Anh</li>
                  <li class="p-2" onclick="location.href='./navbar.html'">Tiếng Trung</li>
                </ul>
              </div>
            </div>
          </div>
        </div>

        <div class="d-flex justify-content-center align-items-center gap-2 profile">
          <div class="avatar d-flex justify-content-center align-items-center rounded-5">
            <img src="/sample-system/assets/images/imageUser.png" alt="" />
          </div>
          <div class="d-flex flex-column">
            <span class="fw-bold" id="userName">XXXX</span>
            <span class="" id="userId">XXXX</span>
          </div>
        </div>
        <div class="bg-white rounded-3 setting" id="setting">
          <button class="btn bg-white shadow-sm d-flex justify-content-center align-items-center" id="setting" type="button" data-bs-toggle="offcanvas" data-bs-target="#mySidebar">
            <svg width="25" height="25" fill="currentColor">
              <use href="/sample-system/assets/images/icons.svg#iconSetting"></use>
            </svg>
          </button>
        </div>
      </div>
    </div>
    <div class="offcanvas offcanvas-end custom-sidebar custom-offcanvas" id="mySidebar">
      <div class="offcanvas-header border-bottom">
        <h5 class="offcanvas-title fw-bold">Cài đặt</h5>
        <button type="button" class="btn-close" data-bs-dismiss="offcanvas"></button>
      </div>

      <div class="offcanvas-body px-2 d-flex flex-column gap-3">
        <!-- Multi Lang -->
        <div class="d-flex align-items-center justify-content-between setting-item">
          <div class="d-flex align-items-center gap-2">
            <span>Đổi ngôn ngữ</span>
          </div>
          <div class="form-check form-switch m-0">
            <select class="form-select-sm w-auto">
              <option>Tiếng Việt</option>
              <option>English</option>
              <option>中文</option>
            </select>
          </div>
        </div>

        <!-- Dark / Light Mode -->
        <div class="d-flex align-items-center justify-content-between setting-item">
          <div class="d-flex align-items-center gap-2">
            <span>Chế độ tối</span>
          </div>
          <div class="form-check form-switch m-0 ">
            <input class="form-check-input" type="checkbox" id="darkModeSwitch" />
          </div>
        </div>

        <div class="d-flex align-items-center justify-content-between setting-item ">
          <div class="d-flex align-items-center gap-2 text-danger">
            <span>Đăng xuất</span>
          </div>
          <button onclick="logout()" class="btn btn-sm btn-outline-primary">Thoát</button>
        </div>
      </div>
    </div>