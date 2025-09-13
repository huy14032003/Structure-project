function Layout(obj = {}) {
  const _obj = { ...obj };

  let _state = {
    isOpen: true,
    mode: "overlay",
    darkmode: "light",
    user: null,
    sessionLogin: null,
  };

  const _ui = {
    get selectLang() {
      return document.getElementById("selectLang");
    },
    get currentLang() {
      return document.getElementById("currentLang");
    },
    get langs() {
      return document.querySelectorAll(".lang-selection ");
    },
    get breadcrumb() {
      return document.querySelector("#breadcrumb ");
    },
    get fullScreen() {
      return document.querySelector("#fullScreen");
    },
    get menu() {
      return document.querySelector("#btnMenu");
    },

    get navBar() {
      return document.querySelector("#navBar");
    },

    get sideBar() {
      return document.querySelector("#appAside");
    },

    get hiddenText() {
      return document.querySelectorAll(".app_aside-hide");
    },

    get multiBox() {
      return document.querySelector("#multiBox");
    },

    get groupMultiLang() {
      return document.querySelector("#groupMultiLang");
    },

    get iconLink() {
      return document.querySelectorAll(".app_aside-link--animation");
    },

    get link() {
      return document.querySelectorAll(".app_aside-link--size");
    },

    get main() {
      return document.querySelector("#appMain");
    },

    get userName() {
      return document.querySelector("#userName");
    },

    get userId() {
      return document.querySelector("#userId");
    },
  };

  function setState(newState) {
    _state = { ..._state, ...newState };
    loadData();
  }

  function expandActiveMenu() {
    const activeLinks = document.querySelectorAll(".active");
    activeLinks.forEach((link) => {
      let parentCollapse = link.closest(".collapse");
      while (parentCollapse) {
        parentCollapse.classList.add("show");
        const toggleBtn = document.querySelector(
          `[data-bs-target="#${parentCollapse.id}"]`
        );
        if (toggleBtn) {
          toggleBtn.setAttribute("aria-expanded", "true");
        }
        parentCollapse = parentCollapse.parentElement.closest(".collapse");
      }
    });
  }

  function handleClickLink(item) {
    const currentPath = window.location.pathname;
    item.classList.remove("active");
    if (item.getAttribute("href") === currentPath) {
      item.classList.add("active");

      const path = item.getAttribute("data-path")?.split("/") || [];
      const current = item.querySelector("span")?.textContent.trim() || "";

      let breadcrumb = `<li class="breadcrumb-item"><a class="text-decoration-none" href="/sample-system">Trang chủ</a></li>`;

      path.forEach((level) => {
        breadcrumb += `<li class="breadcrumb-item"><a class="text-decoration-none" href="#">${level}</a></li>`;
      });

      breadcrumb += `<li class="breadcrumb-item active" aria-current="page">${current}</li>`;
      _ui.breadcrumb.innerHTML = breadcrumb;
    }
    expandActiveMenu();
  }

  function handleClickMenu() {
    const newIsOpen = !_state.isOpen;
    localStorage.setItem("isOpen", JSON.stringify(newIsOpen));
    setState({ isOpen: newIsOpen });
  }

  function handleClickFullScreen() {
    if (!document.fullscreenElement) {
      document.documentElement.requestFullscreen();
      _ui.fullScreen.innerHTML = `
      <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24"><!-- Icon from Huge Icons by Hugeicons - undefined --><path fill="none" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="1.5" d="M14.23 17.995c-.01-.75-.526-3.234 0-3.76c.527-.527 3.01-.01 3.76 0M21 20.999l-6.385-6.383M9.77 17.994c.01-.75.525-3.233-.001-3.76c-.527-.526-3.01-.01-3.76.001M3 20.998l6.386-6.384M6.007 9.761c.75.01 3.234.522 3.76-.005s.006-3.01-.006-3.76m-.384 3.371L3.002 3.002m14.99 6.759c-.75.01-3.234.522-3.76-.005s-.006-3.01.006-3.76m.384 3.371l6.375-6.365"/></svg>
      `;
    } else {
      document.exitFullscreen();
      _ui.fullScreen.innerHTML = `
      <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20"viewBox="0 0 24 24"><path fill="none" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="1.5" d="M15.5 21c1.396 0 2.093 0 2.661-.172a4 4 0 0 0 2.667-2.667C21 17.593 21 16.896 21 15.5m0-7c0-1.396 0-2.093-.172-2.661a4 4 0 0 0-2.667-2.667C17.593 3 16.896 3 15.5 3m-7 18c-1.396 0-2.093 0-2.661-.172a4 4 0 0 1-2.667-2.667C3 17.593 3 16.896 3 15.5m0-7c0-1.396 0-2.093.172-2.661A4 4 0 0 1 5.84 3.172C6.407 3 7.104 3 8.5 3" />
      </svg>
      `;
    }
  }
/**
 * 
 * @param {string} mode  có thể điền collapse hoặc overlay
 */
  function setMode(mode) {
    setState({ mode });
    localStorage.setItem("sidebar-mode", mode);
  }

  function logout() {
    Swal.fire({
      title: "Are you sure?",
      icon: "warning",
      showCancelButton: true,
      confirmButtonColor: "#3085d6",
      cancelButtonColor: "#d33",
    }).then((result) => {
      if (result.isConfirmed) {
        localStorage.removeItem("sidebar-mode");
        localStorage.removeItem("isOpen");
        _state.user = null;
        window.location.href = "/sample-system/logout";
      }
    });
  }

  function renderUser() {
    _state.sessionLogin = sessionLogin;
    _ui.userName.textContent =
      _state.sessionLogin.chineseName || _state.sessionLogin.name;
    _ui.userId.textContent = _state.sessionLogin.username;
  }

  function renderDarkMode() {
    document.documentElement.setAttribute("data-bs-theme", _state.darkmode);
    if (_ui.darkModeSwitch) {
      _ui.darkModeSwitch.checked = _state.darkmode === "dark";
    }
  }

  function renderSidebar() {
    _ui.main?.classList.remove("action-collapse", "action-overlay");
    _ui.navBar?.classList.remove("action-collapse", "action-overlay");
    _ui.sideBar?.classList.remove("action-collapse", "action-overlay");
    _ui.hiddenText.forEach((item) => item.classList.remove("active"));
    _ui.iconLink.forEach((item) =>
      item.classList.remove("justify-content-center")
    );

    if (!_state.isOpen) return;

    if (_state.mode === "overlay") {
      _ui.navBar?.classList.add("action-overlay");
      _ui.sideBar?.classList.add("action-overlay");
      _ui.main?.classList.add("action-overlay");
    }

    if (_state.mode === "collapse") {
      _ui.hiddenText.forEach((item) => item.classList.add("active"));
      _ui.iconLink.forEach((item) =>
        item.classList.add("justify-content-center")
      );
      _ui.main?.classList.add("action-collapse");
      _ui.navBar?.classList.add("action-collapse");
      _ui.sideBar?.classList.add("action-collapse");
    }
  }

  function loadData() {
    renderSidebar();
    renderDarkMode();
  }

function setupLang(evt) {
  let key = "Vi";
  if (evt.target && evt.target.tagName === "SELECT") {
    key = evt.target.value;
  } 
  else if (evt.currentTarget?.dataset?.lang) {
    key = evt.currentTarget.dataset.lang;
  }

  Cookies.set("lang", key, { expires: 60 * 60 * 24 * 30, path: "/" });
  location.reload();
}

  function drawLang() {
    let langName = "Vi";
    switch (Cookies.get("lang")) {
      case "en-US":
        langName = "En";
        break;
      case "vi-VN":
        langName = "Vi";
        break;
      case "zh-TW":
        langName = "中文";
        break;
      default:
        langName = "Vi";
        break;
    }
    _ui.currentLang.innerText = langName;    
    _ui.selectLang.value = Cookies.get("lang");
    
  }

  function handlePoiterDown(e) {
    if (
      !_ui.multiBox?.contains(e.target) &&
      !_ui.groupMultiLang?.contains(e.target)
    ) {
      _ui.multiBox?.classList.add("d-none");
    }
  }
  function handleEventListener() {
    _ui.selectLang.addEventListener("change",  (e)=> {
      setupLang(e)

    })
    _ui.fullScreen.addEventListener("click", handleClickFullScreen);
    _ui.menu?.addEventListener("click", handleClickMenu);
    _ui.groupMultiLang?.addEventListener("click", () => {
      _ui.multiBox.classList.toggle("d-none");
    });
    document.addEventListener("pointerdown", (e) => handlePoiterDown(e));
    _ui.link.forEach((item) =>
      item.addEventListener("click", handleClickLink(item))
    );
    _ui.langs.forEach(item => item.addEventListener('click', e=>{setupLang(e)}));
  }

  function getLocalStorage(key, defaultValue) {
    try {
      const value = localStorage.getItem(key);
      return value !== null ? JSON.parse(value) : defaultValue;
    } catch (e) {
      console.warn(`Error parsing localStorage key "${key}":`, e);
      return defaultValue;
    }
  }

  function changeState() {
    _state.user = getLocalStorage("userinfo", null);
    _state.isOpen = getLocalStorage("isOpen", false);
    _state.darkmode = getLocalStorage("dark-mode", "light");
  }

  function init() {
    changeState();
    handleEventListener();
    loadData();
    renderUser();
    drawLang();
  }

  return { init, setMode, logout };
}

export default Layout;
document.addEventListener("DOMContentLoaded", () => {
  const layout = Layout(); // tạo instance
  layout.init();
  layout.setMode("collapse");
  window.logout = layout.logout;
});
  document.getElementById("searchInput").addEventListener("change", function () {
    const value = this.value;
    const option = document.querySelector(`#list option[value="${value}"]`);
    if (option && option.dataset.url) {
      window.location.href = option.dataset.url;
    }
  });