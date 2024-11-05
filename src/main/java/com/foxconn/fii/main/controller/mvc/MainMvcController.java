package com.foxconn.fii.main.controller.mvc;

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

    @Value("${server.domains}")
    private String[] domains;


    @RequestMapping("/")
    public String index(Model model) {
        model.addAttribute("path", "home");
        model.addAttribute("title", "Index");

        return commonView(model, "application", false);
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

//    @RequestMapping("/login-with-icivet")
//    public void loginWithIcivet(
//            HttpServletRequest request,
//            HttpServletResponse response,
//            String redirectUrl,
//            String code) {
//        try {
//            String appid = "sslGW9wN1Mw1";
//            CivetOAuth oAuth = new CivetOAuth(appid);
//            UserInfo userInfo = oAuth.FastGetUserInfo(request);
//
//            if (userInfo.getCivetno() != null) {
//                UserContext userContext = authService.getUserInformation(userInfo.getCivetno());
//                SecurityContext context = SecurityContextHolder.createEmptyContext();
//                Authentication authentication =  new UsernamePasswordAuthenticationToken(userInfo.getCivetno(), null, userContext.getAuthorities());
////                Authentication authentication = new JwtAuthenticationToken(userContext, userContext.getAuthorities());
//                context.setAuthentication(authentication);
//                SecurityContextHolder.setContext(context);
//            }
//
//            if (StringUtils.isEmpty(redirectUrl)) {
//                response.sendRedirect(request.getHeader("referer"));
//            } else {
//                response.sendRedirect(redirectUrl);
//            }
//
//        } catch (Exception e) {
//            log.error("### logout error", e);
//        }
//    }

    private String commonView(Model model, String view, boolean authorityFlag) {
        if (authorityFlag) {
            try {
                OAuth2User currentUser = authService.getCurrentUser();
                model.addAttribute("empNo", currentUser.getUsername());
                model.addAttribute("nameVn", currentUser.getName());
                model.addAttribute("nameCn", currentUser.getChineseName());
            } catch (Exception e) {
                return "redirect:/error-401";
            }
        }

        return view;
    }

}
