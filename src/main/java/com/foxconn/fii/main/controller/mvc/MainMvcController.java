package com.foxconn.fii.main.controller.mvc;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.foxconn.fii.security.model.OAuth2User;
import com.foxconn.fii.security.service.OAuth2Service;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@Slf4j
@Controller
public class MainMvcController {

    @Autowired
    private OAuth2Service authService;

    @Autowired
    private ObjectMapper objectMapper;

    @Value("${server.domains}")
    private String[] domains;


    @RequestMapping("/")
    public String index(Model model) {
        model.addAttribute("path", "home");
        model.addAttribute("title", "Index");

        return commonView(model, "main", true);
    }
    @RequestMapping("/form-info-equipment")
    public String formInfoEquipment(Model model) {
        model.addAttribute("path", "form-info-equipment");
        model.addAttribute("title", "EQUIPMENT INFORMATION FORM");

        return commonView(model, "main", true);
    }
    @RequestMapping("/home2")
    public String home2(Model model) {
        model.addAttribute("path", "home2");
        model.addAttribute("title", "Home 2");

        return commonView(model, "main", true);
    }

    @RequestMapping("/handle-login-success")
    public void handleLoginSuccess(
            HttpServletRequest request,
            HttpServletResponse response) {
        try {
            String redirectUrl = "";

            for (Cookie cookie : request.getCookies()) {
                if ("previous_page".equalsIgnoreCase(cookie.getName()) && cookie.getValue().startsWith(request.getContextPath())) {
                    redirectUrl = cookie.getValue();
                }
            }

            if (StringUtils.isEmpty(redirectUrl)) {
                redirectUrl = request.getContextPath() + "/";
            }

            response.sendRedirect(redirectUrl);

        } catch (Exception e) {
            log.error("### handle login error", e);
        }
    }


    private String commonView(Model model, String view, boolean authorityFlag) {
        if (authorityFlag) {
            try {
                OAuth2User currentUser = authService.getCurrentUser();
                model.addAttribute("empNo", currentUser.getUsername());
                model.addAttribute("nameVn", currentUser.getName());
                model.addAttribute("nameCn", currentUser.getChineseName());
                model.addAttribute("dataLogin", objectMapper.writeValueAsString(currentUser) );
            } catch (Exception e) {
                return "redirect:/error-401";
            }
        }

        return view;
    }

}
