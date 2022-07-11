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
        max-height: 84vh;
        overflow: auto;
    }

    .btnUploadFilePart,
    .btnDownloadFilePart {
        background-color: #003D9D;
        color: #f8f8f8;
        margin: 5px 10px;
        padding: 5px;
    }

    .btnUploadFilePart:hover,
    .btnDownloadFilePart:hover {
        color: #f8f8f8;
    }

    #tblListPart {
        margin-bottom: 10px;
    }

    #tblListPart th,
    #tblListPart td {
        vertical-align: middle;
        text-align: center;
        font-size: 14px;
    }

    #tblListPart th {
        position: sticky;
        top: -1px;
        z-index: 1;
        font-weight: 600;
        background-color: #CCFFFF;
        border: 1px solid #ccc;
        color: #003D9D;
    }

    #tblListPart td {
        background-color: #f8f8f8;
        color: #000;
        padding: 0.5rem 0.25rem;
    }

    #tblListPart td:first-child {
        width: 5%;
    }

    #tblListPart td:last-child {
        width: 5%;
    }

    .btnUpdateUser {
        margin-right: 10px;
        font-size: 16px;
        cursor: pointer;
    }

    .btnUpdateUser.disabled {
        cursor: not-allowed;
        color: #000;
    }

    .btnDeletePath {
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

    #modal-delete-part .modal-body {
        font-size: 16px;
    }

    #modal-delete-part .modal-footer {
        padding-bottom: 10px;
    }

    .btnConfirmDeleteUser {
        box-shadow: 0 0 3px;
    }

    #modal-update-part .form-group {
        margin-bottom: 10px;
    }

    #modal-update-part .form-group label {
        font-weight: bold;
    }

    #modal-update-part .modal-footer {
        padding-bottom: 10px;
    }

    .btnConfirmUpdateUser {
        box-shadow: 0 0 3px;
        background-color: #003D9D;
        color: #f8f8f8;
    }

    #modal-upload-part .modal-footer {
        padding: 6px 11px 6px 11px;
        border-top: 1px solid #767676;
    }

    .btnConfirmUploadUser {
        background-color: #003D9D;
        color: #f8f8f8;
        padding: 5px 10px;
    }

    .btnConfirmUploadUser:hover {
        color: #f8f8f8;
    }

    .btnTriggerUpload {
        background-color: #efefef;
        border: 1px solid #767676;
        padding: 1px 8px;
        text-transform: none;
    }

    .linkDownloadPartFormat {
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
            max-height: 80vh;
        }

        #tblListPart th,
        #tblListPart td {
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

    #tblListPart_wrapper .dt-buttons {
        display: none;
    }
</style>

<div class="loader hidden"></div>
<div class="row main-container">
    <div class="col-md-12">
        <h5 class="title-header">PART MANAGEMENT</h5>
    </div>
    <div class="col-md-12 table-content">
        <div class="redirect" style="display: flex; align-items: center; justify-content: flex-end;">
            <button class="btn pull-right btnDownloadFilePart"><i class="fa fa-download"></i> Export file</button>
            <button class="btn pull-right btnUploadFilePart" onclick="showModalUploadPart()"><i class="fa fa-upload"></i> Import file</button>
            <input type="text" id="inputSearch" placeholder="Search...">
        </div>
        <table class="table table-sm table-bordered" id="tblListPart">
            <thead>
                <th>#</th>
                <th>Factory</th>
                <th>BU</th>
                <th>CFT</th>
                <th>Part Number</th>
                <th>MPN Material</th>
                <th>Manufacture Part</th>
                <th>Vendor Code</th>
                <th>Buyer Code</th>
                <th class="config">Action</th>
            </thead>
            <tbody></tbody>
        </table>
    </div>
</div>

<!-- Modal to upload file users -->
<div class="modal fade" id="modal-upload-part">
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
                <div class="" style="display: flex;align-items: center;justify-content: space-between;">
                    <a href="/assets/files/part_management.xlsx" class="linkDownloadPartFormat"><i class="fa fa-download"></i> Format file</a>
                    <button class="btn btn-sm btn-outline-secondary btnConfirmUploadUser" onclick="uploadPart()">Upload</button>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Modal to confirm delete user -->
<div class="modal fade" id="modal-delete-part">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">Delete Part</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span></button>
            </div>
            <div class="modal-body" style="background-color: #F7F7FF;">
                <div class="col-md-12">
                    <span>Are you sure want to delete part </span>
                    <span class="title-idcard-delete"></span>
                    <span>?</span>
                </div>
            </div>
            <div class="modal-footer">
                <button class="btn btn-sm btn-outline-secondary btnConfirmDeleteUser" onclick="deletePart()" data-dismiss="modal">Delete</button>
            </div>
        </div>
    </div>
</div>

<!-- Modal to update info of user -->
<div class="modal fade" id="modal-update-part">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">Update Part</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span></button>
            </div>
            <div class="modal-body" style="background-color: #F7F7FF;">
                <div class="form-group row">
                    <label for="idCard" class="control-label col-md-3">ID Card:</label>
                    <div class="col-md-9">
                        <input type="text" id="idCard" class="form-control form-control-sm" disabled>
                    </div>
                </div>
                <div class="form-group row">
                    <label for="email" class="control-label col-md-3">Email:</label>
                    <div class="col-md-9">
                        <input type="text" id="email" class="form-control form-control-sm">
                    </div>
                </div>
                <div class="form-group row">
                    <label for="role" class="control-label col-md-3">Role:</label>
                    <div class="col-md-9">
                        <input type="text" id="role" class="form-control form-control-sm">
                    </div>
                </div>
                <div class="form-group row">
                    <label for="bu" class="control-label col-md-3">BU:</label>
                    <div class="col-md-9">
                        <select name="" id="bu" class="form-control form-control-sm"></select>
                    </div>
                </div>
                <div class="form-group row">
                    <label for="cft" class="control-label col-md-3">CFT:</label>
                    <div class="col-md-9">
                        <select name="" id="cft" class="form-control form-control-sm"></select>
                    </div>
                </div>
                <div class="form-group row">
                    <label for="factory" class="control-label col-md-3">Factory:</label>
                    <div class="col-md-9">
                        <select name="" id="factory" class="form-control form-control-sm"></select>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <button class="btn btn-sm btnConfirmUpdateUser" onclick="updateBuyer()" data-dismiss="modal">Update</button>
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

    var tblListPart;
    var widthScreen = document.body.offsetWidth;

    function init() {
        loadListPart();
    }

    function loadListPart() {
        if (tblListPart) {
            tblListPart.destroy();
        }
        $('.loader').removeClass('hidden');
        $.ajax({
            type: 'GET',
            url: '/api/pm/sd/part',
            data: {
                bu: dataset.bu,
                factory: dataset.factory,
                cft: dataset.cft
            },
            contentType: 'application/json; charset=utf-8',
            success: function (res) {
                var data = res.data;
                var html = '';
                for (var i = 0; i < data.length; i++) {
                    html +=
                        '<tr>' +
                        '<td>' + (i + 1) + '</td>' +
                        '<td>' + checkNull(data[i].factory) + '</td>' +
                        '<td>' + checkNull(data[i].bu) + '</td>' +
                        '<td>' + checkNull(data[i].cft) + '</td>' +
                        '<td>' + checkNull(data[i].partNumber) + '</td>' +
                        '<td>' + checkNull(data[i].mpnMaterial) + '</td>' +
                        '<td>' + checkNull(data[i].manufacturePart) + '</td>' +
                        '<td>' + checkNull(data[i].vendorCode) + '</td>' +
                        '<td>' + checkNull(data[i].buyerCode) + '</td>' +
                        '<td class="config">' + '<i class="fa fa-trash text-danger btnDeletePath" onclick="showModalDeletePart(\'' + data[i].partNumber + '\',' + data[i].id + ')"></i>' + '</td>' +
                        '</tr>';
                }
                $('#tblListPart tbody').html(html);

                var page = 13;
                if (widthScreen >= 1920) {
                    page = 20;
                }
                tblListPart = $('#tblListPart').DataTable({
                    "paging": true,
                    "pageLength": page,
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

                $('#inputSearch').on('keyup', function () {
                    tblListPart.search($(this).val()).draw();
                });
            },
            error: function (err) {
                console.log(err)
            },
            complete: function () {
                $('.loader').addClass('hidden');
                if (dataset.smmsRole == 'MPM') {
                    $('.config').remove();
                } else if (dataset.smmsRole == 'BUYER') {
                    $('.config').remove();
                }
            }
        });
    }

    function showModalDeletePart(partNumber, partId) {
        dataset.partId = partId * 1; //moi khi nguoi dung click vao nut xoa se dong thoi gan gia tri idUser
        $('.title-idcard-delete').html(partNumber);
        $('#modal-delete-part').modal('show');
    }

    function deletePart() {
        $.ajax({
            type: 'DELETE',
            url: '/api/pm/sd/part',
            data: {
                bu: dataset.bu,
                factory: dataset.factory,
                cft: dataset.cft,
                partId: dataset.partId
            },
            // contentType: 'application/json; charset=utf-8',
            success: function (res) {
                alert(res.message);
            },
            error: function (err) {
                console.log('err');
            },
            complete: function () {
                loadListPart();
            }
        });
    }

    function showModalUpdatePart(context) {
        $('#modal-update-part').modal('show');
        $('.title-idcard-update').html(idCard);
        $('#idCard').val(context.dataset.idcard);
        $('#email').val(context.dataset.email);
        $('#role').val(context.dataset.role);
        $('#bu').val(context.dataset.bu);
        $('#cft').val(context.dataset.cft);
        $('#factory').val(context.dataset.factory);

    }

    function showModalUploadPart() {
        $('#modal-upload-part').modal('show');
    }

    function uploadPart() {
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
            form.append('znm22File', file);
            $.ajax({
                type: 'POST',
                url: '/api/pm/sd/part',
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
                    $('#modal-upload-part').modal('hide');
                    $('.file-name').html('No file chosen...');
                    $('#fileUpload').val('');
                    loadListPart();
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
        if (val == null || val == undefined || val == '') {
            return 'N/A';
        }
        return val;
    }

    $('.btnTriggerUpload').on('click', function () {
        $('#fileUpload').trigger('click');
    });

    $('#fileUpload').on('change', function () {
        $('.file-name').html(this.files[0].name)
    });

    function checkSMMSRole() {
        if (dataset.smmsRole == 'MPM') {
            $('.btnUploadFilePart').remove();
        } else if (dataset.smmsRole == 'BUYER') {
            $('.btnUploadFilePart').remove();
        }
    }

    $('.btnDownloadFilePart').on('click', function () {
        $('#tblListPart_wrapper .dt-buttons > .dt-button').trigger('click');
    });

    $(document).ready(function () {
        init();
        checkSMMSRole();
    })
</script>