package com.foxconn.fii.security.config;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.foxconn.fii.security.filter.CustomOAuth2ClientContextFilter;
import com.foxconn.fii.security.filter.JwtAuthenticationFilter;
import com.foxconn.fii.security.filter.LanguageFilter;
import com.foxconn.fii.security.service.OAuth2Service;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.autoconfigure.security.oauth2.client.EnableOAuth2Sso;
import org.springframework.boot.context.properties.EnableConfigurationProperties;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Primary;
import org.springframework.core.io.ClassPathResource;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.builders.WebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.oauth2.client.filter.OAuth2ClientContextFilter;
import org.springframework.security.web.authentication.AuthenticationFailureHandler;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;
import org.springframework.security.web.authentication.preauth.AbstractPreAuthenticatedProcessingFilter;

@Configuration
@EnableOAuth2Sso
@EnableConfigurationProperties(OAuth2Properties.class)
public class WebSecurityConfig extends WebSecurityConfigurerAdapter {

    @Autowired
    private OAuth2Service oAuth2Service;

    @Autowired
    private AuthenticationFailureHandler failureHandler;

    @Autowired
    private OAuth2Properties oauth2Properties;


    @Value("${server.domains}")
    private String[] domains;

    @Value("${server.servlet.static-path}")
    private String staticPath;


    @Primary
    @Bean
    public OAuth2ClientContextFilter customOAuth2ClientContextFilter() {
        return new CustomOAuth2ClientContextFilter(domains);
    }

    protected JwtAuthenticationFilter buildJwtTokenAuthenticationProcessingFilter(String[] securedPaths, String[] ignoredPaths) throws Exception {
        PathRequestMatcher matcher = new PathRequestMatcher(securedPaths, ignoredPaths);
        JwtAuthenticationFilter filter = new JwtAuthenticationFilter(matcher, failureHandler, oAuth2Service);
        filter.setAuthenticationManager(authenticationManagerBean());
        return filter;
    }

    @Bean
    public JwksProperties loadJwks() throws Exception {
        ClassPathResource resource = new ClassPathResource("jwks.json");
        JwksProperties jwks = (new ObjectMapper()).readValue(resource.getInputStream(), JwksProperties.class);
        for (JwksProperties.Key key : jwks.getKeys()) {
            key.loadPublicKey();
        }
        assert jwks.getKeys().get(0).getPublicKey() != null;
        return jwks;
    }

    @Override
    protected void configure(AuthenticationManagerBuilder auth) throws Exception {
        super.configure(auth);
    }

    @Override
    public void configure(HttpSecurity http) throws Exception {
        String[] securedList = {
                "/**",
//                "/"
        };

        String[] ignoredList = {
//                "/**",
                "/",
                "/login**",
                "/sign-in",

                "/api/greeting",
                "/api/time/now",
        };

        http.antMatcher("/**")
                .authorizeRequests()
                .antMatchers(ignoredList).permitAll()
                .antMatchers("/v2/api-docs", "/configuration/ui", "/swagger-resources/**", "/configuration/security", "/swagger-ui.html").hasAnyRole("OAUTH_ADMIN")
                .anyRequest().hasAnyRole("OAUTH_USER")
//                .and().formLogin().loginPage("/sign-in")
//                .successForwardUrl("/home")
        ;

        http.logout()
                .invalidateHttpSession(true)
                .deleteCookies("SAMPLE_SESSION", "access_token", "refresh_token")
//                .logoutSuccessUrl("/home")
//                .logoutSuccessUrl(String.format("%s?redirectUrl=%s", oauth2Properties.getLogoutUrl(), domain))
                .logoutSuccessHandler(new CustomLogoutSuccessHandler(domains, oauth2Properties.getLogoutUrl()))
        ;

        http.csrf().disable();

        http.addFilterBefore(buildJwtTokenAuthenticationProcessingFilter(securedList, ignoredList), UsernamePasswordAuthenticationFilter.class)
                .addFilterBefore(new LanguageFilter(), AbstractPreAuthenticatedProcessingFilter.class);
    }

    @Override
    public void configure(WebSecurity web) throws Exception {
        web.ignoring().antMatchers(
//                "/**",
                "/webjars/**",
                "/templates/**",
                "/WEB-INF/jsp/**",
                "/error",
                "/page-**",
                staticPath + "/public/**"
        );
    }
}
