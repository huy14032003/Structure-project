package com.foxconn.fii.main.controller.mvc;

import com.foxconn.fii.security.model.UserContext;
import com.foxconn.fii.security.service.OAuth2Service;
import lombok.extern.slf4j.Slf4j;
import oauth.CivetOAuth;
import oauth.civetOAuth.UserInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContext;
import org.springframework.security.core.context.SecurityContextHolder;
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

    @Value("${server.domain}")
    private String domain;

    @Autowired
    private OAuth2Service authService;

    @RequestMapping("/page-403")
    public String page403(Model model) {
        model.addAttribute("path", "page-403");
        model.addAttribute("title", "Page 403");

        return commonView(model, "application-error", null);
    }

    @RequestMapping("/page-404")
    public String page404(Model model) {
        model.addAttribute("path", "page-404");
        model.addAttribute("title", "Page 404");

        return commonView(model, "application-error", null);
    }

    @RequestMapping("/handle-login-success")
    public void handleLoginSuccess(
            HttpServletRequest request,
            HttpServletResponse response) {
        try {
            String redirectUrl = request.getContextPath();

            for (Cookie cookie : request.getCookies()) {
                if ("previous_page".equalsIgnoreCase(cookie.getName())) {
                    redirectUrl = cookie.getValue();
                }
            }

            if (StringUtils.isEmpty(redirectUrl)) {
                response.sendRedirect(request.getHeader("referer"));
            } else {
                response.sendRedirect(redirectUrl);
            }

        } catch (Exception e) {
            log.error("### handle login error", e);
        }
    }

    @RequestMapping("/login-with-icivet")
    public void loginWithIcivet(
            HttpServletRequest request,
            HttpServletResponse response,
            String redirectUrl,
            String code) {
        try {
            String appid = "sslGW9wN1Mw1";
            CivetOAuth oAuth = new CivetOAuth(appid);
            UserInfo userInfo = oAuth.FastGetUserInfo(request);

            if (userInfo.getCivetno() != null) {
                UserContext userContext = authService.getUserInformation(userInfo.getCivetno());
                SecurityContext context = SecurityContextHolder.createEmptyContext();
                Authentication authentication =  new UsernamePasswordAuthenticationToken(userInfo.getCivetno(), null, userContext.getAuthorities());
//                Authentication authentication = new JwtAuthenticationToken(userContext, userContext.getAuthorities());
                context.setAuthentication(authentication);
                SecurityContextHolder.setContext(context);
            }

            if (StringUtils.isEmpty(redirectUrl)) {
                response.sendRedirect(request.getHeader("referer"));
            } else {
                response.sendRedirect(redirectUrl);
            }

        } catch (Exception e) {
            log.error("### logout error", e);
        }
    }

    private String commonView(Model model, String view, Integer level) {

        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        Object principal = authentication.getPrincipal();

        String employee = "";
        if (principal instanceof UserContext) {
            employee = ((UserContext) principal).getUsername();
        } else if (principal instanceof String && !"anonymousUser".equals(principal)) {
            employee = (String) principal;
        }
        int groupLevel = -1;
        if (!StringUtils.isEmpty(employee)) {
            model.addAttribute("employeeId", employee);
            model.addAttribute("employeeName", employee);
            model.addAttribute("employeeLevel", 10);
            groupLevel = 10;
        }

        if (level != null) {
            if (StringUtils.isEmpty(employee) || groupLevel < level) {
                return "redirect:401-error-page";
            }
        }

        return view;
    }

}
