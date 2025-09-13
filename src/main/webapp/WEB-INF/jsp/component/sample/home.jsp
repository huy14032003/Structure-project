<%@ page contentType="text/html;charset=UTF-8" language="java"%>

<div
  class="modal fade"
  id="myModal"
  tabindex="-1"
  aria-labelledby="myModalLabel"
  aria-hidden="true"
>
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="myModalLabel">Tiêu đề modal</h5>
        <button
          type="button"
          class="btn-close"
          data-bs-dismiss="modal"
          aria-label="Đóng"
        ></button>
      </div>
      <div class="modal-body">
        <form action="" id="remarkForm"></form>
        <label for="idForm">Pick form</label>
        <select name="idForm" id="idForm" class="form-select"></select>
        <label for="remarkText">Remark text</label>
        <input
          type="text"
          name="remarkText"
          id="remarkText"
          class="form-control"
        />
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">
          Đóng
        </button>
        <button type="button" class="btn btn-primary" id="saveModal">
          Lưu
        </button>
      </div>
    </div>
  </div>
</div>

  <div class=" mx-3 ">
    <div class="card bg-white border-0">
      <div class="card-header bg-white border-0 p-3 pb-0">
        <div class="d-flex align-items-center justify-content-start">
          <!-- <span class="fw-bold">LIST OF ORDER</span> -->
        </div>
      </div>
      <div class="card-body">
        <div
          class="d-flex gap-3 mb-3 flex-wrap text-nowrap justify-content-between"
        >
          <div class="d-flex gap-2">
            <a
              type="button"
              href="#"
              class="btn bg-primary text-light d-flex gap-2 align-items-center"
              id="addNewOrdder"
            >
              <svg
                xmlns="http://www.w3.org/2000/svg"
                width="24"
                height="24"
                viewBox="0 0 24 24"
              >
                <!-- Icon from Huge Icons by Hugeicons - undefined -->
                <path
                  fill="none"
                  stroke="currentColor"
                  stroke-linecap="round"
                  stroke-linejoin="round"
                  stroke-width="1.5"
                  d="M12 4v16m8-8H4"
                  color="currentColor"
                />
              </svg>
              <span>Tạo chứng chỉ</span>
            </a>
            <button
              id="table-export"
              class="btn btn-defaul bg-primary bg-opacity-10 text-primary d-flex gap-1 align-items-center"
            >
              <svg
                xmlns="http://www.w3.org/2000/svg"
                width="24"
                height="24"
                viewBox="0 0 24 24"
              >
                <!-- Icon from Huge Icons by Hugeicons - undefined -->
                <path
                  fill="none"
                  stroke="currentColor"
                  stroke-linecap="round"
                  stroke-linejoin="round"
                  stroke-width="1.5"
                  d="M12 15V5m0 10c-.7 0-2.008-1.994-2.5-2.5M12 15c.7 0 2.008-1.994 2.5-2.5M5 19h14"
                />
              </svg>
              Tải xuống XLS
            </button>
          </div>
          <input
            type="search"
            id="table-search"
            name="table-search"
            class="form-control app_table-search"
            placeholder="Search by anything"
          />
        </div>
        <div class="table-responsive">
          <table
            id="table-order"
            class="table table-hover table-bordered bg-light text-center text-nowrap"
          >
            <thead class="table-light">
             
            </thead>
            <tbody>
              <tr>
                <td colspan="6">Chưa có đơn order</td>
              </tr>
            </tbody>
          </table>
        </div>
        <div
          id="table-order-pagination"
          class="d-flex gap-2 justify-content-end"
        >
        </div>
      </div>
    </div>
  </div>

<a href="" ></a>
<script src="assets/js/custom/home.js"></script>

<script >
  // import { Home } from "/sample-system/assets/js/custom/home.js";
  // document.addEventListener("DOMContentLoaded", () => {
  //   Home.init({
  //     tableId: "#table-order"
  //   });
  // });
</script>
