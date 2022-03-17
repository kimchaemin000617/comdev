package com.sbs.exam.demo.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import com.sbs.exam.demo.interceptor.BeforeActionInterceptor;
import com.sbs.exam.demo.interceptor.NeedLoginInterceptor;

@Configuration
public class MyWebMvcConfigurer implements WebMvcConfigurer {
    // beforeActionInterceptor 인터셉터 불러오기
    @Autowired
    BeforeActionInterceptor beforeActionInterceptor;

    // NeedLoginInterceptor 인터셉터 불러오기
    @Autowired
    NeedLoginInterceptor needLoginInterceptor;

    // 이 함수는 인터셉터를 적용하는 역할을 합니다.
    @Override
    public void addInterceptors(InterceptorRegistry registry) {
        registry.addInterceptor(beforeActionInterceptor).addPathPatterns("/**").excludePathPatterns("/resource/**")
                .excludePathPatterns("/error");
        registry.addInterceptor(needLoginInterceptor).addPathPatterns("/usr/article/doAdd")
                .addPathPatterns("/usr/article/Add")
                .addPathPatterns("/usr/article/doModify").addPathPatterns("/usr/article/doDelete")
                .addPathPatterns("/usr/article/doIncreaseLikePoint")
                .addPathPatterns("/usr/article/doDecreaseLikePoint")
                .addPathPatterns("/usr/member/doLogout").addPathPatterns("/usr/member/doLogout");
    }
}