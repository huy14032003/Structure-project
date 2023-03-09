/**
 * ================================================
 * 1. Check empty object
 * 2. Check empty array
 * 3. Check falsy value
 * 4. Format
 * 5. Custome scroll
 * 6. Pagination
 * 7. Alertify
 * 8. Convert minute to hour
 * 
 * Common function
 * Username login
 * ================================================
 */


/**
 * 1. Check empty object
 */
function isObjectEmpty(value) {
    return (
        Object.prototype.toString.call(value) === '[object Object]' && JSON.stringify(value) === '{}'
    );
}

/**
 * 2. Check empty array
 */
function isArrayEmpty(value) {
    if (Array.isArray(value) && value.length === 0) return true;
    return false;
}

/**
 * 3. Check empty value
 */
function isFalsy(value) {
    if (value === "" || value === null || value === undefined || value === 'null' || value === 'undefined' || Number.isNaN(value)) return true;
    return false;
}

/**
 * 4. Format
 */
function formatEmpty(value) {
    if (value === "" || value === null || value === undefined || value === 'null' || value === 'undefined') return '';
    return value;
}

function formatNA(value) {
    if (value === "" || value === null || value === undefined || value === 'null' || value === 'undefined') return 'N/A';
    return value;
}

function formatZero(value) {
    if (value === '' || value === null || value === undefined || value === 'null' || value === 'undefined') return 0;
    return value;
}

/**
 * 5. Custome scroll
 */
function customScroll(table) {
    var slider = document.querySelector(table);
    var isDown = false;
    var startX;
    var scrollLeft;

    slider.addEventListener('mousedown', function (e) {
        e.stopPropagation();
        slider.style = 'point-events: none;';
        isDown = true;
        startX = e.pageX - slider.offsetLeft;
        scrollLeft = slider.scrollLeft;
    });

    slider.addEventListener('mouseup', function (e) {
        isDown = false;
        slider.style = 'point-events: auto;';
    });

    slider.addEventListener('mouseleave', function (e) {
        isDown = false;
    });

    slider.addEventListener('mousemove', function (e) {
        if (!isDown) {
            return;
        }
        e.preventDefault();
        e.stopPropagation();
        slider.style = 'point-events: none;';
        var x = e.pageX - slider.offsetLeft;
        var walk = (x - startX) * 3;
        slider.scrollLeft = scrollLeft - walk;
    });
}

// 6. Pagination
function pagination(data, page, rows) {
    var trimStart = (page - 1) * rows;
    var trimEnd = trimStart + rows;

    var trimedData = data.slice(trimStart, trimEnd);
    var pages = Math.ceil(data.length / rows);

    return ({
        data: trimedData,
        pages: pages
    });
}

function pageButtons(pages, elem) {
    let pagination;
    if (isFalsy(elem)) {
        pagination = document.querySelector('.pagination ul');
    } else {
        pagination = document.querySelector('.pagination.' + elem + ' ul');
    }

    if (!isFalsy(pages) || pages != 0) {
        var maxLeft = state.page - Math.floor(state.window / 2);
        var maxRight = state.page + Math.floor(state.window / 2);
        if (maxLeft < 1) {
            maxLeft = 1;
            maxRight = state.window;
        }

        if (maxRight > pages) {
            maxLeft = pages - (state.window - 1);
            maxRight = pages;
            if (maxLeft < 1) {
                maxLeft = 1;
            }
        }

        var html = '';

        for (var page = maxLeft; page <= maxRight; page++) {
            if (page == 1) {
                html += '<li class="numb active li' + page + '" value="' + page + '"><span>' + page + '</span></li>';
            } else {
                html += '<li class="numb li' + page + '" value="' + page + '"><span>' + page + '</span></li>';
            }
        }

        if (state.page != 1 || (state.page == pages && state.page > 1)) {
            html =
                '<li class="btn-custom prev" value="1">' +
                '<i class="fa fa-angle-left"></i>' +
                '<i class="fa fa-angle-left"></i>' +
                '</li>' + html;
        }

        if (state.page != pages && state.page < pages) {
            html +=
                '<li class="btn-custom next" value="' + pages + '">' +
                '<i class="fa fa-angle-right"></i>' +
                '<i class="fa fa-angle-right"></i>' +
                '</li>';
        }
        pagination.innerHTML = html;

        var li = pagination.querySelectorAll('li');
        for (let i = 0; i < li.length; i++) {
            li[i].addEventListener('click', function (e) {
                state.page = Number(this.getAttribute('value'));
                getResultPagination();
                resetHighlight();
            });
        }
        pagination.style.display = '';
    } else {
        pagination.style.display = 'none !important';
    }

    function resetHighlight() {
        // Active page
        let li = pagination.querySelectorAll('li');
        for (let i = 0; i < li.length; i++) {
            li[i].classList.remove('active');
        }

        let liActive = pagination.querySelector('.li' + state.page);
        if (liActive != null && liActive != undefined) {
            document.querySelector('.li' + state.page).classList.add('active');
        }
    }
}

/**
 * 7. Alertify
 */
alertify.set('notifier', 'position', 'top-center');
alertify.set('notifier', 'delay', 3);

var setUpAlertJS = function () {
    alertify.set('notifier', 'position', 'top-center');
    alertify.set('notifier', 'delay', 3);
}


var showAlertJS = function (type, content) {
    setUpAlertJS();
    if (type === 'success') {
        alertify.success('<span style="color: #fff;"><i class="fa fa-check-circle"></i> ' + content + '</span>');
    } else if (type === 'error') {
        alertify.error('<span style="color: #fff;">' + content + '</span>');
    } else if (type === 'warning') {
        alertify.warning('<span style="color: #fff;"><i class="fa fa-exclamation-triangle"></i> ' + content + '</span>');
    }
}

/**
 * 8. Convert minute to hour
 */
var minuteToHour = function (second) {
    if (second > 0 && second > 60) {
        var value = second / 60;
        if (!isFalsy(value)) {
            value = value < 1 ? Math.ceil(value) : value;
            if (value < 60) {
                var time = Math.floor(value) + '\'';
            } else {
                var hours = (value / 60);
                var rhours = Math.floor(hours);
                var minute = (hours - rhours) * 60;
                var rminute = Math.floor(minute);
                var time = rhours + 'h' + rminute + '\'';
            }
            return time;
        }
        return value;
    } else if (second > 0 && second <= 60) {
        return '1\'';
    } else {
        return '0\'';
    }
}

/**
 * Username login
 */
function formatUserName(userInfo) {
    var nameVn = !isFalsy(userInfo.nameVn) ? userInfo.nameVn : '';
    var nameCn = !isFalsy(userInfo.nameCn) ? ' (' + userInfo.nameCn + ')' : '';
    var cardNo = !isFalsy(userInfo.empNo) ? ' - ' + userInfo.empNo : '';
    return nameVn + nameCn + cardNo;
}

const exportToExcel = function (table, fileName, timeSpan = '') {
    let tblExport = document.getElementById(table);
    let html = '';
    for (let i = 0; i < tblExport.rows.length; i++) {
        let frame = tblExport.rows[i].innerHTML;
        if (frame != '') {
            html += '<tr>' + frame + '</tr>';
        }
    }

    html = '<table border="1">' + html + '</table>';

    let browser = window.navigator.userAgent;
    if (browser.indexOf('MSIE') > -1 || browser.indexOf('Trident') > -1) {
        window.document.open("data:application/vnd.ms-excel;");
        window.document.write(html);
        window.document.close();
        sa = window.document.execCommand("SaveAs", true, fileName + '_' + timeSpan + ".xls");
        return sa;

    } else {
        let link = window.document.createElement("a");
        link.setAttribute("href", "data:application/vnd.ms-excel;charset=utf-8,%EF%BB%BF" + encodeURIComponent(
            html));
        link.setAttribute("download", fileName + '_' + timeSpan + ".xls");
        link.click();
    }
}


// *Format trạng thái của xe
// =====================================================================
// key: trả về trạng thái của từng xe
// truckColor: xác định maàu cho chữ
// truckStatus: xác định nội dung cho trạng thái
function formatCarStatus(value) {
    switch (value) {
        case 'MOVING':
            return ({
                key: 'moving',
                color: 'text-moving',
                status: '<spring:message code="moving" />'
            });
        case 'DOCKING':
            return ({
                key: 'docking',
                color: 'text-docking',
                status: '<spring:message code="arrived" />'
            });
        case 'LOADING_UNLOADING':
            return ({
                key: 'loading_unloading',
                color: 'text-loading-unloading',
                status: '<spring:message code="loadingUnloading" />'
            });
        case 'STAND_BY':
            return ({
                key: 'stand_by',
                color: 'text-moving',
                status: '<spring:message code="standBy" />'
            });
        case 'OFFLINE':
            return ({
                key: 'offline',
                color: 'text-danger',
                status: '<spring:message code="offline" />'
            });
        default:
            return ({
                key: '',
                color: '',
                status: ''
            });
    }
}

const searchParams = function (param) {
    let queryString = window.location.search;
    let urlParams = new URLSearchParams(queryString);
    return urlParams.get(param);
}