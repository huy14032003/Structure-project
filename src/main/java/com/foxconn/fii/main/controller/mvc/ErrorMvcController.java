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
import org.springframework.web.bind.annotation.RequestMethod;

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

    @RequestMapping(value = "/error", method = RequestMethod.GET)
    public String errorPage(HttpServletRequest request,
                            HttpServletResponse response,
                            Model model) {
        HttpStatus status = getStatus(request);

        if (status.value() == 401) {
            return "redirect:/error-401";
        } else if (status.value() == 403) {
            return "redirect:/error-403";
        } else if (status.value() == 404) {
            return "redirect:/error-404";
        } else if (status.value() == 500) {
            return "redirect:/error-500";
        } else {
            return "redirect:/error-404";
        }
    }


    @RequestMapping(value = "/error-401", method = RequestMethod.GET)
    public String error401(Model model) {
        model.addAttribute("path", "error-401");
        model.addAttribute("title", "Error 401");
        model.addAttribute("error", "Error 401");

        return "application-error";
    }

    @RequestMapping(value = "/error-403", method = RequestMethod.GET)
    public String error403(Model model) {
        model.addAttribute("path", "error-403");
        model.addAttribute("title", "Error 403");
        model.addAttribute("error", "Error 403");

        return "application-error";
    }

    @RequestMapping(value = "/error-404", method = RequestMethod.GET)
    public String error404(Model model) {
        model.addAttribute("path", "error-404");
        model.addAttribute("title", "Error 404");
        model.addAttribute("error", "Error 404");

        return "application-error";
    }

    @RequestMapping(value = "/error-500", method = RequestMethod.GET)
    public String error500(Model model) {
        model.addAttribute("path", "error-500");
        model.addAttribute("title", "Error 500");
        model.addAttribute("error", "Error 500");

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
