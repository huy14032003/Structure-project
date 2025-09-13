const YourPage = (() => {
  const { hasError, requestHandlers, messageState } = DataSync;
  const { getFormId, putOrder,getOrderId } = requestHandlers;

  let _opts = {
  

  };
  const _state = {
    step: 0,
    schemas:[],
    renderOrder:[],
    idForm: null,
    orderId:null,
  };
  const _ui = {
    get form1() {
      return document.querySelector("#formEquipment");
    },

    get title() {
      return document.querySelector("#step7");
    },
    get btnSubmit() {
      return document.getElementById("btnSubmit");
    },
    get stepMenu() {
      return document.getElementById("stepMenu");
    },
  };

  // async function loadDataForm() {
  //   _state.idForm= Utils.getParamsURL("id"),
  //   _state.schemas = (await getFormId({ id: _state.idForm }))?.segments ?? [];
  //   renderForm(_state.schemas);
  //   console.log(_state.schemas);
  //   renderStep(_state.schemas);
  // }
  async function loadDetailOrder()
  {
    // // _state.orderId=Utils.getParamsURL('orderId')
    // _state.renderOrder = (await getOrderId({ orderId: _state.orderId }))?.form?.segments ?? [];
    // // await requestHandlers.getOrderId({orderId: _state.orderId})
    // // console.log(_state.renderOrder);
    // renderForm(_state.renderOrder);
    // // console.log(_state.renderOrder);
    // renderStep(_state.renderOrder);
  }


  function renderDetail(form, segment) {
    const segTitle = document.createElement("h5");
    segTitle.textContent = segment.name;
    form.appendChild(segTitle);
    console.log(segment.attributes);
    segment.attributes.forEach((f) => {
      const div = document.createElement("div");
      div.className = "mb-3";

      // Label
      const label = document.createElement("label");
      label.textContent = f.displayName;
      label.setAttribute("for", f.code);
      div.appendChild(label);

      let input;
      switch (f.type) {
        case "select":
          if(f.value===''||f.value===null||f.value===undefined)
          {
            return f.value=' ';
          }
          input = document.createElement("select");
          input.name = f.code;
          input.className = "form-control";
          const opt = document.createElement("option");
          opt.value = f.value;
          opt.textContent = "Select...";
          input.appendChild(opt);
          break;

        case "date":
          if(f.value===''||f.value===null||f.value===undefined)
          {
            return f.value=' ';
          }
          input = document.createElement("input");
          input.type = "date";
          input.value=f.value;
          break;

        case "input":
          if(f.value===''||f.value===null||f.value===undefined)
          {
            return f.value=' ';
          }
          input = document.createElement("input");
          input.type = "text";
          input.value=f.value;
          break;
      }

      if (input) {
        input.id = f.id;
        input.name = f.id;
        input.className = "form-control";
        div.appendChild(input);
      }

      form.appendChild(div);
    });
  }

  function renderForm(schemas) {
    const form1 = _ui.form1;
    form1.innerHTML = ""; // clear cũ

    const currentSegment = schemas[_state.step];
    if (currentSegment) {
      renderDetail(form1, currentSegment);
    }
  }

  function renderStep(schemas) {
    _ui.stepMenu.innerHTML = "";
    schemas.forEach((item, index) => {
      const span=document.createElement('span')
      span.classList.add('li-text')
      const li = document.createElement("li");
      span.textContent = item.name;
      li.append(span);
      li.addEventListener("click", (e) => {
        _state.step = index;
        e.target.classList.add("active"), renderForm(schemas);
        hanldleStepEvent(li);
      });
      _ui.stepMenu.appendChild(li);
      const listLi = document.querySelectorAll("#stepMenu li");
      listLi[0].classList.add('active')
    });
  }

  function hanldleStepEvent(step) {
    const listLi = document.querySelectorAll("#stepMenu li");
    listLi.forEach((item,i) => {
      item !== step
        ? item.classList.remove("active")
        : item.classList.add("active");
    });
  }



  async function handleClickSubmit() {
    if (window.confirm("ok")) {
      const formData = new FormData(_ui.form1);
      const attributeValues = [];
      formData.forEach((val, key) => {
        attributeValues.push({
          attributeId: key,  
          value: val,
          reason:''
        });
      });
  
      const body = {
        attributeValues: attributeValues,
      };
  
 
  
      await requestHandlers.putOrder(body, {
        id: _opts.idForm
      });
    }
  }
  
  
  function handleAddEventListener() {
    _ui.btnSubmit.addEventListener("click", handleClickSubmit);
  }

  function init(opts = {}) {
    // Utils.merge(_opts, opts);
    handleAddEventListener();
    // loadDataForm();
    loadDetailOrder();
  }
  
  return { init };
})();

document.addEventListener("DOMContentLoaded", () => {
  YourPage.init({

  });
});
