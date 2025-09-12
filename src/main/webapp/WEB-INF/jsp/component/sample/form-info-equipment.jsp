<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<!-- <script src="/assets/js/custom/formInfo.js"></script> -->
<script src="assets/js/custom/form-info-equipment.js"></script>
<style>
    ol
    {
        list-style-type: none;
        padding: 0;
        
    }
    ol>li
    {
        margin-bottom: 15px;
        padding: 10px;
        cursor: pointer;
        height: 50px;
        display: flex;
        justify-content: start;
        align-items: center;
        border-radius: 15px;    
      
        text-overflow: ellipsis;
        overflow: hidden;
    }
    ol>li:hover{
      background-color: #F2F2F7;
      
    }
    li.active
    {
        background-color: #FFF3CD;
    }
    li.active:hover
    {
      background-color: #FFF3CD;
    }

    .li-text {
      max-width: 200px;       
      white-space: nowrap;    
      overflow: hidden;       
      text-overflow: ellipsis;
      display: inline-block;  
    }
</style>
  <div class=" row g-3 ">
    <div class="col-3">
      <div class="card bg-white border-0 mb-4 h-100 card-step">
        <div class="card-body" >
            <div >
                <ol class="stepMenu" id="stepMenu">  
                </ol>
            </div>
        </div>
      </div>
    </div>
    <div class="col-9">
      <div class="card bg-white border-0 mb-4  h-100" >
        <div class="card-header bg-white border-0 p-3 pb-0">
          <div class="d-flex align-items-center justify-content-start">
            <span  class="fw-bold" id="title">${title}</span>
          </div>
        </div>
        <div class="card-body">
          <form class="needs-validation" name="info" id="formEquipment" novalidate >
            <div class="d-flex justify-content-center align-items-center">
            </div>
          </form>
          <form class=" needs-validation" name="info" id="developmentStatus"novalidate ></form>
          
          <pre id="result"></pre>
          <div class="d-flex justify-content-center align-items-center save ">
            <button class="btn btn-primary" id="btnSubmit">
              <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-file-earmark-check" viewBox="0 0 16 16">
                <path d="M10.854 7.854a.5.5 0 0 0-.708-.708L7.5 9.793 6.354 8.646a.5.5 0 1 0-.708.708l1.5 1.5a.5.5 0 0 0 .708 0z"/>
                <path d="M14 14V4.5L9.5 0H4a2 2 0 0 0-2 2v12a2 2 0 0 0 2 2h8a2 2 0 0 0 2-2M9.5 3A1.5 1.5 0 0 0 11 4.5h2V14a1 1 0 0 1-1 1H4a1 1 0 0 1-1-1V2a1 1 0 0 1 1-1h5.5z"/>
              </svg>
              <span>Save your change</span>
            </button>
          </div>
        </div>
      </div>
    </div>
  </div>
</sript>
