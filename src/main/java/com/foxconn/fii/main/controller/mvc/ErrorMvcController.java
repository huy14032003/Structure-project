package com.foxconn.fii.main.controller.mvc;

import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.autoconfigure.web.ServerProperties;
import org.springframework.boot.web.servlet.error.ErrorController;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@Slf4j
@Controller
public class ErrorMvcController implements ErrorController {

    @Autowired
    private ServerProperties serverProperties;

    @Value("${server.domains}")
    private String[] domains;


    @Override
    public String getErrorPath() {
        return serverProperties.getError().getPath();
    }

    @RequestMapping("/error")
    public String handleError(HttpServletRequest request,
                              HttpServletResponse response,
                              Model model) {
        HttpStatus status = getStatus(request);

        if (status.value() == 404) {
            model.addAttribute("path", "page-404");
            model.addAttribute("title", "Page 404");
        } else if (status.value() == 403) {
            model.addAttribute("path", "page-403");
            model.addAttribute("title", "Page 403");
        } else if (status.value() == 500) {
            model.addAttribute("path", "page-500");
            model.addAttribute("title", "Page 500");
        }

        return "application-error";
    }


    @RequestMapping("/page-401")
    public String page401(Model model) {
        model.addAttribute("path", "page-401");
        model.addAttribute("title", "Page 401");

        return "application-error";
    }

    @RequestMapping("/page-403")
    public String page403(Model model) {
        model.addAttribute("path", "page-403");
        model.addAttribute("title", "Page 403");

        return "application-error";
    }

    @RequestMapping("/page-404")
    public String page404(Model model) {
        model.addAttribute("path", "page-404");
        model.addAttribute("title", "Page 404");

        return "application-error";
    }

    @RequestMapping("/page-500")
    public String page500(Model model) {
        model.addAttribute("path", "page-500");
        model.addAttribute("title", "Page 500");

        return "application-error";
    }


    protected HttpStatus getStatus(HttpServletRequest request) {
        Integer statusCode = (Integer) request.getAttribute("javax.servlet.error.status_code");

        if (statusCode == null) {
            return HttpStatus.INTERNAL_SERVER_ERROR;
        }

        try {
            return HttpStatus.valueOf(statusCode);
        } catch (Exception ex) {
            return HttpStatus.INTERNAL_SERVER_ERROR;
        }
    }
}
