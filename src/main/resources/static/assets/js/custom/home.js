const Home = (() => {
  const _opts = {
    tableId: null,
  };
  const _ui = {
    get btnSaveModal() {
      return document.getElementById("saveModal");
    },
    get addNewOrder() {
      return document.getElementById("addNewOrdder");
    },
    get idForm() {
      return document.getElementById("idForm");
    },
    get remarkText() {
      return document.getElementById("remarkText");
    },
    get id() {
      return document.getElementById("table-order");
    },

    modal: null,
  };
  // console.log(_ui.id);
 
  const { hasError, requestHandlers, messageState } = DataSync;
  const { getModalInfor, postOrder,getOrderId } = requestHandlers;

  async function loadModalInfor() {
    const data = await requestHandlers.getModalInfor({});

    data.forEach((item) => {
      const opt = document.createElement("option");
      opt.value = `${item.id}`;
      opt.textContent = `${item.name}`;
      _ui.idForm.append(opt);
    });
  }

  async function loadDataTableOrder() {

    const dt = new AppLib.DataTableLib({
      api: "/sample-system/api/v1/order?idCard=V3244723 ",
      tableId: "table-order", 
      rows: 10,
      currentPage: 1,
      serverSide: true,
      paginationId:"table-order-pagination",
      buildUrl: (page) => {
        const params = {
            idCard:"V3244723",
            pageNumber: page,
            pageSize: 10,
        };
        let url = `/sample-system/api/v1/order?${new URLSearchParams(params).toString()}`;
        return url;
      },
      formatData: (res) => { 
        console.log(res);
        res.data = res.result?.content ?? [];
        res.total=res.result?.totalElements??[];
        console.log(res);
        return res.data || [];;
      },
      columnsConfig: [
        
        { label: "No." },
        { label: "Tên form" },
        { label: "Trạng thái" },
        { label: "Thời gian tạo" },
        { label: "Người tạo" },
        { label: "Ghi chú" },
        { label: "Hành động" },
      ],
      rowRenderer: (item, index, meta) => {
        const page = meta?.currentPage ?? 1;
        const size = meta?.rowsPerPage ?? 10;
        const stt = (page - 1) * size + index + 1;
        const link={
          summary:'<a class="text-decoration-none" id="summary" style="color:#0D6EFD" href="#">Summary</a>',
          update:`<a class="text-decoration-none" id="update" data-id=${item.id} style="color:#FD7E14" href="#">Update</a>`,
          history:'<a class="text-decoration-none" id="history"  style="color:#198754" href="#">History</a>',
        }
        
         return `
          <td>${stt}</td>
          <td>${item.formName}</td>
          <td>${item.status}</td>
          <td>${item.createdAt}</td>
          <td>${item.createdBy}</td>
          <td>${item.remark}</td>
          <td>${link.summary} ${link.update} ${link.history}</td>
        `;
      },
      
    });
    dt.init();   
  }
  async function handleAddOrder() {
    await requestHandlers.postOrder({
      formId: _ui.idForm.value,
      remark: _ui.remarkText.value,
    });
  }
 
  function handleAddEventListener() {
    _ui.addNewOrder.addEventListener("click", (e) => {
      e.preventDefault();
      _ui.modal.show();
    });

    _ui.btnSaveModal.addEventListener("click", () => {
      const id = _ui.idForm.value;
      handleAddOrder();
      window.location.href = `/sample-system/form-info-equipment?id=${id}`;
    });

    document.addEventListener('click',(e)=>{
      if(e.target&& e.target.id==="update")
      {
        const id=e.target.dataset.id
        window.location.href = `/sample-system/form-info-equipment?orderId=${id}`
      }
    })
  }

  function init(opts = {}) {

    _ui.modal = new bootstrap.Modal(document.getElementById("myModal"));
    handleAddEventListener();
    loadModalInfor();
    loadDataTableOrder();
  }

  return { init };
})();
