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
 * Username
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
    if (value === null || value === undefined || value === 0 || value === "") return true;
    return false;
}

/**
 * 4. Format
 */
function formatEmpty(value) {
    if (value === "" || value === null || value === undefined) return '';
    return value;
}

function formatNA(value) {
    if (value === "" || value === null || value === undefined) return 'N/A';
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
        isDown = true;
        startX = e.pageX - slider.offsetLeft;
        scrollLeft = slider.scrollLeft;
    });

    slider.addEventListener('mouseup', function (e) {
        isDown = false;
    });

    slider.addEventListener('mouseleave', function (e) {
        isDown = false;
    });

    slider.addEventListener('mousemove', function (e) {
        if (!isDown) {
            return;
        }
        e.preventDefault();
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

function pageButtons(pages, typeName = '') {
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

    var pagination;
    if (isFalsy(typeName)) {
        pagination = document.querySelector('.pagination ul');
    } else {
        pagination = document.querySelector('.pagination.' + typeName + ' ul');
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
        html = '<li class="btn-custom prev" value="1"><i class="fa fa-angle-left"></i><i class="fa fa-angle-left"></i><span style="margin-left: 5px">First</span></li>' + html;
    }

    if (state.page != pages && state.page < pages) {
        html += '<li class="btn-custom next" value="' + pages + '"><span style="margin-right: 5px">Last</span><i class="fa fa-angle-right"></i></span><i class="fa fa-angle-right"></i></li>';
    }
    pagination.innerHTML = html;

    var li = document.querySelectorAll('.pagination' + (!isFalsy(typeName) ? typeName : '') + ' ul li');
    for (let i = 0; i < li.length; i++) {
        li[i].addEventListener('click', function (e) {
            state.page = Number(this.getAttribute('value'));
            getResultPagination();
        });
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
    // setUpAlertJS();
    if (type === 'success') {
        alertify.success('<span style="color: #fff;"><i class="fa fa-check-circle"></i> ' + content + '</span>');
    } else if (type === 'error') {
        alertify.error('<span style="color: #fff;"><i class="fa fa-times-circle"></i> ' + content + '</span>');
    } else if (type === 'warning') {
        alertify.warning('<span style="color: #fff;"><i class="fa fa-exclamation-triangle"></i> ' + content + '</span>');
    }
}

/**
 * 8. Convert minute to hour
 */
var minuteToHour = function (value) {
    if (value < 60) {
        var time = value + '\'';
    } else {
        var hours = (value / 60);
        var rhours = Math.floor(hours);
        var minute = (hours - rhours) * 60;
        var rminute = Math.floor(minute);
        var time = rhours + 'h' + rminute + '\'';
    }
    return time;
}

/**
 * Username
 */
function formatUserName(userInfo) {
    var nameVn = !isFalsy(userInfo.nameVn) ? userInfo.nameVn : '';
    var nameCn = !isFalsy(userInfo.nameCn) ? ' (' + userInfo.nameCn + ')' : '';
    var cardNo = !isFalsy(userInfo.empNo) ? ' - ' + userInfo.empNo : '';
    return nameVn + nameCn + cardNo;
}