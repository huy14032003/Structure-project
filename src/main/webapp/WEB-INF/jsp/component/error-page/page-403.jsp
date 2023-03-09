<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<style>
    #page-403 {
        width: 100%;
        height: 100vh;
        background-image: url('/sample-system/assets/images/background-home.png');
        background-position: center;
        background-size: cover;
    }

    .main {
        width: 100%;
        height: 100vh;
        /* display: flex;
        align-items: center;
        justify-content: center; */
    }

    p {
        position: relative;
        color: #dc3545;
        text-shadow: 0 10px 10px black;
        font-size: 12rem;
        font-weight: bold;
    }

    p::before,
    p:after {
        content: '403 ERROR';
        position: absolute;
        top: 0;
        left: 0;
        z-index: -1;
        color: #fff;
        transition: all .4s;
    }

    p:hover::before {
        transform: translate(-5px, -5px);
        text-shadow: 4px 4px 20px #ff0101;
    }

    p:hover::after {
        transform: translate(5px, 5px);
        text-shadow: 4px 4px 20px #351fff;
    }


    @media only screen and (min-width: 1024px) and (max-width: 1919px) {
        p {
            font-size: 9rem;
        }
    }
</style>
<div class="d-flex align-items-center justify-content-start flex-column" id="page-403">
    <div class="col-md-12 p-4 main d-flex align-items-center justify-content-center flex-column">
        <p>403 ERROR</p>
        <h5 class="alert alert-warning">
            <i class="fa fa-triangle-exclamation"></i>
            <span class="mr-2">
                <spring:message code="alertNoPermissionOnPage" />
            </span>
            <button class="btn btn-primary" onclick="goHome()">
                <i class="fa fa-home"></i>
                <spring:message code="backHome" />
            </button>
            <button class="btn btn-primary" onclick="logout()">
                <i class="fas fa-sign-out-alt"></i>
                <spring:message code="logout" />
            </button>
        </h5>
    </div>
</div>

<script>
    function goHome() {
        window.location.href = "/sample-system/";
    }

    function logout() {
        window.location.href = "/sample-system/logout";
    }
</script>