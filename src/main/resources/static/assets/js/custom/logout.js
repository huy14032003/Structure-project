function logout() {
    var userInfo = JSON.parse(window.localStorage.getItem('userInfo'));
    if (!isFalsy(userInfo)) {
        var name = formatUserName(userInfo);
        alertify.confirm('<spring:message code="alert" />', '<spring:message code="signOut" /><b> ' + name + '</b>?', function () {
            window.localStorage.removeItem('userInfo');
            window.localStorage.removeItem('firstAccess');
            window.location.href = "/sample-system/logout";
        }, function () {
            // Cancel
        }).set('labels', {
            ok: '<spring:message code="ok" />',
            cancel: '<spring:message code="cancel" />'
        });
    }
}