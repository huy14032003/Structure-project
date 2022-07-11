<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<style>
    .main-container {
        /* border: 1px solid green; */
        margin-top: 1rem;
        background-color: #EBEDF9;
    }

    .title-header {
        text-align: center;
        font-weight: bold;
        background-color: #003D9D;
        color: #f8f8f8;
        margin: 0;
        padding: 0.35rem;
        text-transform: uppercase;
        margin-top: 2px;
        border-radius: 3px;
    }


    .table-content {
        position: relative;
        /* height: 81vh; */
        max-height: 84vh;
        overflow: auto;
    }

    .btnUploadFileShippingMode,
    .btnDownloadFileShippingMode {
        background-color: #003D9D;
        color: #f8f8f8;
        margin: 5px 10px;
        padding: 5px;
    }

    .btnUploadFileShippingMode:hover,
    .btnDownloadFileShippingMode:hover {
        color: #f8f8f8;
    }

    #tblListShippingMode {
        margin-bottom: 10px;
    }

    #tblListShippingMode th,
    #tblListShippingMode td {
        vertical-align: middle;
        text-align: center;
        font-size: 14px;
        border: 1px solid #ccc;
    }

    #tblListShippingMode th {
        position: sticky;
        top: -1px;
        z-index: 1;
        font-weight: 600;
        background-color: #CCFFFF;
        color: #003D9D;
    }


    #tblListShippingMode td {
        background-color: #f8f8f8;
        color: #000;
        padding: 0.5rem 0.25rem;
    }

    #tblListShippingMode td:first-child {
        width: 5%;
    }

    #tblListShippingMode td:last-child {
        width: 5%;
    }

    .btnDeleteShippingMode {
        margin-left: 10px;
        font-size: 16px;
        cursor: pointer;
    }

    .modal-header {
        background-color: #003D9D;
        color: #FFF;
        padding: 8px;
    }

    .close {
        line-height: 0;
    }

    #modal-delete-shipping-mode .modal-body {
        font-size: 16px;
    }

    #modal-delete-shipping-mode .modal-footer {
        padding-bottom: 10px;
    }

    .btnConfirmDeleteUser {
        box-shadow: 0 0 3px;
    }

    #modal-upload-shipping-mode .modal-footer {
        padding: 6px 11px 6px 11px;
        border-top: 1px solid #767676;
    }

    .btnConfirmUploadShippingMode {
        background-color: #003D9D;
        color: #f8f8f8;
        padding: 5px 10px;
    }

    .btnConfirmUploadShippingMode:hover {
        columns: #f8f8f8;
    }

    .btnTriggerUpload {
        background-color: #efefef;
        border: 1px solid #767676;
        padding: 1px 8px;
        text-transform: none;
    }

    .linkDownloadShippingModeFormat {
        font-weight: bold;
        text-decoration: underline;
    }

    /* Cai dat cho cac man hinh nho ho hon 1920px */
    @media screen and (max-width:1919px) {
        .title-header {
            font-size: 14px;
            padding: .75rem;
        }

        .table-content {
            /* height: 74vh; */
            max-height: 80vh;
        }

        #tblListShippingMode th,
        #tblListShippingMode td {
            vertical-align: middle;
            text-align: center;
            font-size: 12px;
        }

        .dataTables_paginate .paginate_button {
            padding: 5px;
        }
    }

    .dataTables_filter {
        float: right;
        display: none;
    }

    .dataTables_filter input {
        padding: 8px 24px 8px 8px;
        border: 1px solid #ccc;
        border-radius: 5px;
        height: 30px;
        margin-left: 10px;
    }

    .dataTables_filter>label:after {
        right: 8px
    }

    #inputSearch {
        border: 1px solid gray;
        width: 200px;
        height: 30px;
        border-radius: 5px;
        margin-top: 6px;
        margin-bottom: 6px;
    }

    #tblListShippingMode_wrapper .dt-buttons {
        display: none;
    }
</style>

<div class="loader hidden"></div>
<div class="row main-container">
    <div class="col-md-12">
        <h5 class="title-header">Shipping Mode Management</h5>
    </div>
    <div class="col-md-12 table-content">
        <div class="redirect" style="display: flex; align-items: center; justify-content: flex-end;">
            <button class="btn pull-right btnDownloadFileShippingMode"><i class="fa fa-download"></i> Export file</button>
            <button class="btn pull-right btnUploadFileShippingMode " onclick="showModalUploadShippingMode()"><i class="fa fa-upload"></i> Import file</button>
            <input type="text" id="inputSearch" placeholder="Search...">
        </div>
        <table class="table table-sm table-bordered" id="tblListShippingMode">
            <thead>
                <tr>
                    <th>#</th>
                    <th>Factory</th>
                    <th>BU</th>
                    <th>CFT</th>
                    <th>Supplier</th>
                    <th>Vendor code</th>
                    <th>Distributor</th>
                    <th>Shipping mode</th>
                    <th class="config">Action</th>
                </tr>
            </thead>
            <tbody>

            </tbody>
        </table>
    </div>
</div>

<!-- Modal to upload file users -->
<div class="modal fade" id="modal-upload-shipping-mode">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">Import File</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span></button>
            </div>
            <div class="modal-body" style="background-color: #F7F7FF;">
                <div class="row" style="display: flex;align-items: center;">
                    <div class="" style="width: 20%;">
                        <button class="btn btn-sm btnTriggerUpload">Choose File</button>
                        <input type="file" id="fileUpload" class="hidden" accept="application/vnd.openxmlformats officedocument.spreadsheetml.sheet">
                    </div>
                    <div class="" style="width: 80%;">
                        <span class="file-name">No file chosen...</span>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <div style="display: flex;align-items: center;justify-content: space-between;">
                    <a href="/assets/files/shipping_mode.xlsx" class="linkDownloadShippingModeFormat"><i class="fa fa-download"></i> Format file</a>
                    <button class="btn btn-sm btn-outline-secondary btnConfirmUploadShippingMode" onclick="uploadShippingMode()">Upload</button>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Modal to confirm delete user -->
<div class="modal fade" id="modal-delete-shipping-mode">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">Delete Shipping Mode</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span></button>
            </div>
            <div class="modal-body" style="background-color: #F7F7FF;">
                <div class="col-md-12">
                    <span>Are you sure want to delete shipping mode </span>
                    <span class="title-shipping-mode-delete"></span>
                    <span>?</span>
                </div>
            </div>
            <div class="modal-footer">
                <button class="btn btn-sm btn-outline-secondary btnConfirmDeleteUser" onclick="deleteShippingMode()" data-dismiss="modal">Delete</button>
            </div>
        </div>
    </div>
</div>

<script>
    var dataset = {
        bu: '${bu}',
        factory: '${factory}',
        cft: '${cft}',
        smmsRole: '${employeeSMMSRole}'
    };
    var tblListShippingMode;
    var widthScreen = document.body.offsetWidth;

    init();

    function init() {
        loadListShippingMode();
    }

    function loadListShippingMode() {
        if (tblListShippingMode) {
            tblListShippingMode.destroy();
        }
        $('.loader').removeClass('hidden');
        $.ajax({
            type: 'GET',
            url: '/api/pm/sd/shipping-mode',
            data: {
                bu: dataset.bu,
                factory: dataset.factory,
                cft: dataset.cft
            },
            contentType: 'application/json; charset=utf-8',
            success: function (res) {
                // console.log(res);
                var data = res.data;
                var html = '';
                for (var i = 0; i < data.length; i++) {
                    html +=
                        '<tr>' +
                        '<td>' + (i + 1) + '</td>' +
                        '<td>' + checkNull(data[i].factory) + '</td>' +
                        '<td>' + checkNull(data[i].bu) + '</td>' +
                        '<td>' + checkNull(data[i].cft) + '</td>' +
                        '<td>' + checkNull(data[i].supplier) + '</td>' +
                        '<td>' + checkNull(data[i].vendorCode) + '</td>' +
                        '<td>' + checkNull(data[i].distributor) + '</td>' +
                        '<td>' + checkNull(data[i].shippingMode) + '</td>' +
                        '<td class="config">' +
                        '<i class="fa fa-trash text-danger btnDeleteShippingMode" onclick="showModalDeleteShippingMode(\'' +
                        data[i].shippingMode + '\',' + data[i].id + ')"></i>' +
                        '</td>' +
                        '</tr>';
                }
                $('#tblListShippingMode tbody').html(html);
                if (widthScreen >= 1920) {
                    tblListShippingMode = $('#tblListShippingMode').DataTable({
                        "paging": true,
                        "pageLength": 20,
                        "lengthChange": false,
                        "searching": true,
                        "ordering": true,
                        "info": false,
                        "autoWidth": true,
                        "language": {
                            "paginate": {
                                "previous": "<",
                                "next": ">"
                            }
                        },
                        "dom": 'Bfrtip',
                        "buttons": [{
                            "extend": ['excel'],
                            "text": 'Export Excel',
                        }]
                    });
                } else {
                    tblListShippingMode = $('#tblListShippingMode').DataTable({
                        "paging": true,
                        "pageLength": 13,
                        "lengthChange": false,
                        "searching": true,
                        "ordering": true,
                        "info": false,
                        "autoWidth": true,
                        "language": {
                            "paginate": {
                                "previous": "<",
                                "next": ">"
                            }
                        },
                        "dom": 'Bfrtip',
                        "buttons": [{
                            "extend": ['excel'],
                            "text": 'Export Excel',
                        }]
                    });
                }

                $('#inputSearch').on('keyup', function () {
                    tblListShippingMode.search($(this).val()).draw();
                });
            },
            error: function (err) {
                console.log(err)
            },
            complete: function () {
                $('.loader').addClass('hidden');
                // if (dataset.smmsRole != 'MANAGER') {
                //     $('.btnUploadFileuUser').css('display','none');
                //     $('.dataTables_filter').css({
                //         "margin":" 6px 0px 6px 0px"
                //     });
                // }

                if (dataset.smmsRole == 'MPM') {
                    $('.config').remove();
                } else if (dataset.smmsRole == 'BUYER') {
                    $('.config').remove();
                }
            }
        });
    }

    function showModalDeleteShippingMode(shippingMode, idShippingMode) {
        //moi khi nguoi dung click vao nut xoa se dong thoi gan gia tri idUser
        dataset.idShippingMode = idShippingMode * 1;
        $('.title-shipping-mode-delete').html(shippingMode);
        $('#modal-delete-shipping-mode').modal('show');
    }

    function deleteShippingMode() {
        $.ajax({
            type: 'DELETE',
            url: '/api/pm/sd/shipping-mode',
            data: {
                bu: dataset.bu,
                factory: dataset.factory,
                cft: dataset.cft,
                shippingModeId: dataset.idShippingMode
            },
            // contentType: 'application/json; charset=utf-8',
            success: function (res) {
                alert(res.message);
            },
            error: function (err) {
                console.log('err');
            },
            complete: function () {
                loadListShippingMode();
            }
        });
    }

    function showModalUploadShippingMode() {
        $('#modal-upload-shipping-mode').modal('show');
    }

    function uploadShippingMode() {
        var confirm = window.confirm('Do you want to upload file?');
        if (confirm) {
            var listFile = $('#fileUpload')[0].files;
            var file = '';
            if (listFile.length > 0 || $('#fileUpload').val() != '') {
                file = listFile[0];
            } else {
                alert('File isn\'t uploaded,again!');
                return;
            }

            var form = new FormData();
            form.append('bu', dataset.bu);
            form.append('cft', dataset.cft);
            form.append('factory', dataset.factory);
            form.append('shippingModeListFile', file);
            $.ajax({
                type: 'POST',
                url: '/api/pm/sd/shipping-mode',
                data: form,
                processData: false,
                contentType: false,
                mimeType: 'multipart/form-data',
                success: function (res) {
                    var data = JSON.parse(res)
                    alert(data.message);
                },
                error: function (err) {
                    console.log(err);
                    alert(JSON.parse(err.responseText).message);
                },
                complete: function () {
                    $('#modal-upload-shipping-mode').modal('hide');
                    $('.file-name').html('No file chosen...');
                    $('#fileUpload').val('');
                    loadListShippingMode();
                }
            });
        }

    }

    //Lay gia tri cua cac param tren URL
    function searchParams(name) {
        var results = new RegExp('[\?&]' + name + '=([^&#]*)').exec(window.location.href);
        if (results == null) {
            return null;
        } else {
            return decodeURIComponent(results[1]) || 0;
        }
    }

    //Format lai gia tri khi null,undefined hoac rong
    function checkNull(val) {
        if (val == null || val == 'null' || val == undefined || val == '') {
            return '';
        }
        return val;
    }

    $('.btnTriggerUpload').on('click', function () {
        $('#fileUpload').trigger('click');
    });

    $('#fileUpload').on('change', function () {
        $('.file-name').html(this.files[0].name);
    });

    function checkSMMSRole() {
        if (dataset.smmsRole == 'MPM') {
            $('.btnUploadFileShippingMode').remove();
        } else if (dataset.smmsRole == 'BUYER') {
            $('.btnUploadFileShippingMode').remove();
        }
    }

    $('.btnDownloadFileShippingMode').on('click', function () {
        $('#tblListShippingMode_wrapper .dt-buttons > .dt-button').trigger('click');
    });

    $(document).ready(function () {
        checkSMMSRole();
    })

    // $('#modal-upload-shipping-mode').on('hidden.bs.modal',function(){
    //     $('.file-name').html('No file chosen...')
    // });
</script>