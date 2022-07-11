<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<style>
    #page-403 {
        width: 100%;
        height: 100vh;
        background-color: rgb(238, 197, 197);
        background-position: center;
        background-size: cover;
    }

    .main {
        width: 100%;
        height: 100vh;
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
        content: 'ERROR 403';
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
<div class="d-flex-ccs" id="page-403">
    <div class="col-md-12 p-4 main d-flex-ccc">
        <p>ERROR 403</p>
        <h5 class="alert alert-warning">
            <i class="fa fa-triangle-exclamation"></i>
            <span class="mr-2">
                You don't have permission access to system
            </span>
            <button class="btn btn-primary mx-2" onclick="logout()">
                <i class="fas fa-sign-out-alt"></i>
                Logout
            </button>
            <a type="button" href="/pm-system/assets/files/user_format_po_etac.xlsx" class="btn btn-success mx-2"><i class="fa fa-download"></i> User format</a>
        </h5>
        <h5><i class="fa fa-envelope"></i>: <a href="#">cpe-vn-fii-sw@mail.foxconn.com</a></h5>
    </div>
</div>

<script>
    function logout() {
        window.location.href = "/pm-system/logout";
    }
</script>