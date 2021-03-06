package com.comdev.exam.demo.config;

import com.comdev.exam.demo.interceptor.BeforeActionInterceptor;
import com.comdev.exam.demo.interceptor.NeedLoginInterceptor;
import com.comdev.exam.demo.interceptor.NeedLogoutInterceptor;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
public class MyWebMvcConfigurer implements WebMvcConfigurer {
    // beforeActionInterceptor 인터셉터 불러오기
    @Autowired
    BeforeActionInterceptor beforeActionInterceptor;

    // NeedLoginInterceptor 인터셉터 불러오기
    @Autowired
    NeedLoginInterceptor needLoginInterceptor;

    @Autowired
    NeedLogoutInterceptor needLogoutInterceptor;

    // 이 함수는 인터셉터를 적용하는 역할을 합니다.
    @Override
    public void addInterceptors(InterceptorRegistry registry) {
        InterceptorRegistration ir;

        ir = registry.addInterceptor(beforeActionInterceptor);

        ir.addPathPatterns("/**");
        ir.excludePathPatterns("/favicon.ico");
        ir.excludePathPatterns("/resource/**");
        ir.excludePathPatterns("/error");

        ir = registry.addInterceptor(needLoginInterceptor);
        ir.addPathPatterns("/usr/member/myPage");
        ir.addPathPatterns("/usr/member/passwordCheck");
        ir.addPathPatterns("/usr/member/doPasswordCheck");
        ir.addPathPatterns("/usr/member/modify");
        ir.addPathPatterns("/usr/member/doModify");
        ir.addPathPatterns("/usr/reply/modify");
        ir.addPathPatterns("/usr/reply/doModify");
        ir.addPathPatterns("/usr/reply/doWrite");
        ir.addPathPatterns("/usr/reply/doDelete");
        ir.addPathPatterns("/usr/article/Add");
        ir.addPathPatterns("/usr/article/doAdd");
        ir.addPathPatterns("/usr/article/doIncreaseLikePoint");
        ir.addPathPatterns("/usr/article/doDecreaseLikePoint");
        ir.addPathPatterns("/usr/article/doDelete");
        ir.addPathPatterns("/usr/article/modify");
        ir.addPathPatterns("/usr/article/doModify");

        ir = registry.addInterceptor(needLogoutInterceptor);
        ir.addPathPatterns("/usr/member/login");
        ir.addPathPatterns("/usr/member/doLogin");
        ir.addPathPatterns("/usr/member/join");
        ir.addPathPatterns("/usr/member/doJoin");
        ir.addPathPatterns("/usr/member/findLoginId");
        ir.addPathPatterns("/usr/member/findLoginPw");
        ir.addPathPatterns("/usr/member/doFindLoginId");
        ir.addPathPatterns("/usr/member/doFindLoginPw");
        ir.addPathPatterns("/usr/member/getLoginIdDup");
    }
}