<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<style>
</style>

<div class="loader hidden"></div>
<div class="row">
    <div class="col-12 my-2 component">
        <div class="row">
            <div class="col-md-12 border-bottom py-2">
                <span class="title-table">Add Sign Process</span>
            </div>
            <div class="col-md-12 py-3">
                <div class="row">
                    <div class="col-4">
                        <div class="form-group d-flex-rcb">
                            <label class="label-inline col-4">Sign process:</label>
                            <div class="col-8">
                                <input id="sign-process" class="form-control input-custome" />
                            </div>
                        </div>
                    </div>
                    <div class="col-4">
                        <div class="form-group d-flex-rcb">
                            <label class="label-inline col-4">Type:</label>
                            <div class="col-8">
                                <select id="sl-type" class="form-control select-custome">
                                    <option value="" disabled selected>--Select--</option>
                                    <option value="PO">PO</option>
                                    <option value="FO">FO</option>
                                    <option value="Shipment">Shipment</option>
                                    <option value="Input ETAC">Input ETAC</option>
                                </select>
                            </div>
                        </div>
                    </div>
                    <div class="col-4">
                        <div class="form-group d-flex-rcb">
                            <label class="label-inline col-4">Sign level:</label>
                            <div class="col-8">
                                <input type="number" min="1" max="100" id="signRank" class="form-control input-custome" placeholder="1-100" />
                            </div>
                        </div>
                    </div>
                    <div class="col-4">
                        <div class="form-group d-flex-rcb">
                            <label class="label-inline col-4">Card ID:</label>
                            <div class="col-8">
                                <input id="cardId" class="form-control input-custome" />
                            </div>
                        </div>
                    </div>
                    <div class="col-4">
                        <div class="form-group d-flex-rcb">
                            <label class="label-inline col-4">User name:</label>
                            <div class="col-8">
                                <input id="userName" class="form-control input-custome" disabled />
                            </div>
                        </div>
                    </div>
                    <div class="col-4">
                        <div class="form-group d-flex-rcb">
                            <label class="label-inline col-4">Email:</label>
                            <div class="col-8">
                                <input id="email" class="form-control input-custome" disabled />
                            </div>
                        </div>
                    </div>
                </div>
                <div class="d-flex-rcc">
                    <button class="btn btn-sm btn-primary btn-confirm-add mx-1" onclick="confirmAdd()"><i class="fa fa-check-circle"></i> Add</button>
                    <button class="btn btn-sm btn-warning hidden btn-confirm-update mx-1" onclick="confirmUpdate()"><i class="fa fa-pen-alt"></i> Update</button>
                    <button class="btn btn-sm btn-danger hidden btn-confirm-cancel mx-1" onclick="confirmCancel()"><i class="fa fa-times-cicle"></i> Cancel</button>
                </div>
            </div>
        </div>
    </div>

    <div class="col-md-12 my-2 component">
        <div class="row">
            <div class="col-md-12 border-bottom py-2">
                <span class="title-table">List Sign Process</span>
            </div>
            <div class="col-12">
                <div class="row">
                    <div class="col-4 py-2">
                        <div class="d-flex-rcb">
                            <label class="label-inline col-4">Type:</label>
                            <div class="col-8">
                                <select id="sl-type-lookup" class="form-control form-control-sm">
                                    <option value="">All</option>
                                    <option value="PO">PO</option>
                                    <option value="FO">FO</option>
                                    <option value="Shipment">Shipment</option>
                                    <option value="Input ETAC">Input ETAC</option>
                                </select>
                            </div>
                        </div>
                    </div>
                    <div class="col-4 py-2">
                        <div class="d-flex-rcb">
                            <label class="label-inline col-4">Sign process:</label>
                            <div class="col-8">
                                <select id="sl-sign-process" class="form-control form-control-sm"></select>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-12 py-3">
                <table class="table table-sm my-table" id="tbl-list-sign">
                    <thead>
                        <tr>
                            <th>#</th>
                            <th>Sign process</th>
                            <th>Type</th>
                            <th>Card ID</th>
                            <th>User name</th>
                            <th>Email</th>
                            <th>Permission</th>
                            <th>Sign level</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody></tbody>
                </table>
                <div class="pagination d-flex-rce">
                    <ul></ul>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
    var obj = {
        tableData: null
    };

    var state = {
        data: null,
        page: 1,
        rows: 10,
        window: 7
    }

    $(document).ready(function () {
        init();
    });

    function init() {
        getListSignProcess();
    }

    function getListSignProcess(typeFile) {
        if (typeFile == undefined) typeFile = '';
        $('.loader').removeClass('hidden');
        $.ajax({
            type: 'GET',
            url: '/pm-system/api/sign/listSignProcess',
            data: {
                type: typeFile
            },
            success: function (res) {
                var data = res.data;
                var html = '';
                html += '<option value="">All</option>';
                if (!isArrayEmpty(data) && !isFalsy(data)) {
                    for (var i = 0; i < data.length; i++) {
                        html += '<option value="' + data[i].sign_process + '">' + data[i].sign_process + '</option>';
                    }
                }
                $('#sl-sign-process').html(html);
            },
            error: function (err) {
                $('.loader').addClass('hidden');
                // console.error(JSON.parse(err.responseText).message);
            },
            complete: function () {
                $('.loader').addClass('hidden');
                obj.signProcess = $('#sl-sign-process').val();
                obj.type = $('#sl-type-lookup').val();
                getDataTablePagination();
            }
        });
    }

    $('#sl-sign-process').on('change', function () {
        var signProcess = $(this).val().trim();
        obj.signProcess = signProcess;
        getDataTablePagination();
    });

    $('#sl-type-lookup').on('change', function () {
        var typeFile = $(this).val().trim();
        obj.type = typeFile;
        getListSignProcess(typeFile);
    });

    function getDataTablePagination() {
        $('.loader').removeClass('hidden');
        state.page = 1;
        $.ajax({
            type: 'GET',
            url: '/pm-system/api/sign/listSigner',
            data: {
                signProcess: obj.signProcess,
                type: obj.type
            },
            contentType: "application/json; charset=utf-8",
            success: function (res) {
                obj.tableData = res.data;
                state.data = obj.tableData;
            },
            error: function (errMesg) {
                $('.loader').addClass('hidden');
                console.log(errMesg);
            },
            complete: function () {
                $('.loader').addClass('hidden');
                getListSignProcessTable();
            }
        });
    }

    function getListSignProcessTable() {
        var html = '';
        var myData = pagination(state.data, state.page, state.rows);
        var data = myData.data;
        if (!isArrayEmpty(data) && !isFalsy(data)) {
            for (var i = 0; i < data.length; i++) {
                html +=
                    '<tr>' +
                    '<td>' + (Number(state.page - 1) * state.rows + Number(i + 1)) + '</td>' +
                    '<td class="sign-process-' + data[i].idSignRank + '">' + data[i].sign_process + '</td>' +
                    '<td class="type-' + data[i].idSignRank + '">' + data[i].type + '</td>' +
                    '<td class="cardId-' + data[i].idSignRank + '">' + data[i].id_card + '</td>' +
                    '<td class="username-' + data[i].idSignRank + '">' + data[i].name + '</td>' +
                    '<td class="email-' + data[i].idSignRank + '">' + data[i].mail + '</td>' +
                    '<td class="permission-' + data[i].idSignRank + '">' + data[i].permission + '</td>' +
                    '<td class="sign-rank-' + data[i].idSignRank + '">' + data[i].rank_sign + '</td>' +
                    '<td style="width: 1%;">' +
                    '<div class="d-flex-rcc">' +
                    '<button class="btn btn-sm btn-warning btn-update-sign mx-1" onclick="updateSignProcess(' + data[i].idSignRank + ')"><i class="fa fa-pen-alt"></i></button>' +
                    '<button class="btn btn-sm btn-danger btn-delete-sign mx-1" onclick="deleteSignProcess(' + data[i].idSignRank + ')"><i class="fa fa-trash-alt"></i></button>' +
                    '</div>' +
                    '</td>' +
                    '</tr>';
            }
        } else {
            html += '<tr><td colspan="9">No data to display</td></tr>';
        }
        $('#tbl-list-sign tbody').html(html);

        pageButtons(myData.pages);

        // active page
        var li = document.querySelectorAll('.pagination ul li');
        for (var i = 0; i < li.length; i++) {
            li[i].classList.remove('active');
        }

        var liActive = document.querySelector('.pagination ul .li' + state.page);
        if (liActive != null && liActive != undefined) {
            document.querySelector('.pagination ul .li' + state.page).classList.add('active');
        }

        
    }

    // Ham nay dung cho chuc nang phan trang (khi su dung o trang khac thi chi can thay doi noi dung ben trong ham)
    function getResultPagination() {
        getListSignProcessTable();
    }

    $('#cardId').on('input', function () {
        var cardId = $(this).val().toUpperCase().trim();
        $(this).val(cardId);
        getUserInfo(cardId);
    });

    function getUserInfo(cardId) {
        $.ajax({
            type: 'GET',
            url: '/pm-system/api/sign/getUser',
            data: {
                idCard: cardId
            },
            success: function (res) {
                if (res.code == 'SUCCESS') {
                    var data = res.result;
                    $('#userName').val(data.name);
                    $('#email').val(data.mail);
                } else {
                    $('#userName').val('');
                    $('#email').val('');
                }
            },
            error: function (err) {
                console.log(err);
            }
        });
    }

    function confirmAdd() {
        var signProcess = formatEmpty($('#sign-process').val()).trim();
        var type = formatEmpty($('#sl-type').val()).trim();
        var signRank = formatEmpty($('#signRank').val()).trim();
        var cardId = formatEmpty($('#cardId').val()).trim();
        var userName = formatEmpty($('#userName').val()).trim();
        var email = formatEmpty($('#email').val()).trim();

        if (isFalsy(signProcess)) {
            showAlertJS('error', 'Sign process cannot be empty');
            return;
        } else if (isFalsy(type)) {
            showAlertJS('error', 'Type cannot be empty');
            return;
        } else if (isFalsy(signRank)) {
            showAlertJS('error', 'Sign level cannot be empty');
            return;
        } else if (signRank <= 0 || signRank > 100) {
            showAlertJS('error', 'Sign level is invalid');
            return;
        } else if (isFalsy(cardId)) {
            showAlertJS('error', 'Card ID is invalid');
            return;
        }

        var confirm = window.confirm('Do you want to add?');
        if (confirm) {
            $.ajax({
                type: 'POST',
                url: '/pm-system/api/sign/addSigner',
                data: {
                    signProcess: signProcess,
                    type: type,
                    idCard: cardId,
                    rankSign: signRank
                },
                success: function (res) {
                    if (res.code == 'SUCCESS') {
                        showAlertJS('success', res.message);
                        // Fomart empty input and select
                        $('.input-custome').val('');
                        $('.select-custome').val($('#sl-type option:first-child').val());
                        getDataTablePagination();
                    } else {
                        showAlertJS('error', res.message);
                        return;
                    }
                },
                error: function (err) {
                    console.log(err)
                }
            })
        }
    }

    function updateSignProcess(idSignRank) {
        $('.btn-confirm-add').addClass('hidden');
        $('.btn-confirm-update').removeClass('hidden');
        $('.btn-confirm-cancel').removeClass('hidden');

        $('#sign-process').attr('disabled', 'disabled');
        $('#sl-type').attr('disabled', 'disabled');

        var signProcess = $('.sign-process-' + idSignRank).html();
        var type = $('.type-' + idSignRank).html();
        var signRank = $('.sign-rank-' + idSignRank).html();
        var carId = $('.cardId-' + idSignRank).html();
        var userName = $('.username-' + idSignRank).html();
        var email = $('.email-' + idSignRank).html();
        // console.log(signProcess, type, carId, username, email);

        $('#sign-process').val(signProcess);
        $('#sl-type').val(type);
        $('#signRank').val(signRank);
        $('#cardId').val(carId);
        $('#userName').val(userName);
        $('#email').val(email);

        obj.tempIdSignRank = idSignRank;
    }

    function confirmUpdate() {
        var signRank = formatEmpty($('#signRank').val()).trim();
        var cardId = formatEmpty($('#cardId').val()).trim();

        if (isFalsy(signRank)) {
            showAlertJS('error', 'Sign level cannot be empty');
            return;
        } else if (signRank <= 0 || signRank > 100) {
            showAlertJS('error', 'Sign level is invalid');
            return;
        } else if (isFalsy(cardId)) {
            showAlertJS('error', 'Card ID is invalid');
            return;
        }

        var confirm = window.confirm('Do you want to update?');
        if (confirm) {
            $('.loader').removeClass('hidden');
            $.ajax({
                type: 'POST',
                url: '/pm-system/api/sign/updateSigner',
                data: {
                    idSignRank: obj.tempIdSignRank,
                    idCard: cardId,
                    rankSign: signRank
                },
                success: function (res) {
                    if (res.code == 'SUCCESS') {
                        showAlertJS('success', res.message);
                        // Fomart empty input and select
                        $('.input-custome').val('');
                        $('.select-custome').val($('#sl-type option:first-child').val());
                        $('.btn-confirm-add').removeClass('hidden');
                        $('.btn-confirm-update').addClass('hidden');
                        $('.btn-confirm-cancel').addClass('hidden');
                        $('#sign-process').removeAttr('disabled');
                        $('#sl-type').removeAttr('disabled');
                        getDataTablePagination();
                    } else {
                        showAlertJS('error', res.message);
                        return;
                    }
                },
                error: function (err) {
                    $('.loader').addClass('hidden');
                    console.log(err)
                }
            });
        }
    }

    function confirmCancel() {
        $('.btn-confirm-add').removeClass('hidden');
        $('.btn-confirm-update').addClass('hidden');
        $('.btn-confirm-cancel').addClass('hidden');
        $('#sign-process').removeAttr('disabled');
        $('#sl-type').removeAttr('disabled');

        // Fomart empty input and select
        $('.input-custome').val('');
        $('.select-custome').val($('#sl-type option:first-child').val());
    }


    function deleteSignProcess(idSignRank) {
        var confirm = window.confirm('Do you want to delete?');
        if (confirm) {
            $('.loader').removeClass('hidden');
            $.ajax({
                type: 'POST',
                url: '/pm-system/api/sign/deleteSigner',
                data: {
                    idSignRank: idSignRank,
                },
                success: function (res) {
                    if (res.code == 'SUCCESS') {
                        showAlertJS('success', res.message);
                        getDataTablePagination();
                    } else {
                        showAlertJS('error', res.message);
                        return;
                    }
                },
                error: function (err) {
                    $('.loader').addClass('hidden');
                    console.log(err)
                }
            });
        }
    }
</script>