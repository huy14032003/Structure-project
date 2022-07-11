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

function pageButtons(pages) {
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

    var pagination = document.querySelector('.pagination ul');
    var html = '';

    for (var page = maxLeft; page <= maxRight; page++) {
        if (page == 1) {
            html += '<li class="numb active li' + page + '" value="' + page + '"><span>' + page + '</span></li>';
        } else {
            html += '<li class="numb li' + page + '" value="' + page + '"><span>' + page + '</span></li>';
        }
    }

    if (state.page != 1 || state.page == pages) {
        html = '<li class="btn-custom prev" value="1"><i class="fa fa-angle-left"></i><span style="margin-left: 5px">First</span></li>' + html;
    }

    if (state.page != pages && state.page < pages) {
        html += '<li class="btn-custom next" value="' + pages + '"><span style="margin-right: 5px">Last</span><i class="fa fa-angle-right"></i></li>';
    }
    pagination.innerHTML = html;

    var li = document.querySelectorAll('.pagination ul li');
    for (let i = 0; i < li.length; i++) {
        li[i].addEventListener('click', function (e) {
            state.page = Number(this.getAttribute('value'));
            getResultPagination();
        });
    }
}