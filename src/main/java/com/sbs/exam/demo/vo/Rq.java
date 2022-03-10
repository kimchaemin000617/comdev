package com.sbs.exam.demo.vo;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.sbs.exam.demo.util.Ut;

import lombok.Getter;

public class Rq {

    @Getter
    private boolean isLogined;

    @Getter
    private int loginedMemberId;

    private HttpServletRequest req;
    private HttpServletResponse resp;
    private HttpSession httpSession;

    public Rq(HttpServletRequest req, HttpServletResponse resp) {
        this.req = req;
        this.resp = resp;
        this.httpSession = this.req.getSession();

        boolean isLogined = false;
        int loginedMemberId = 0;

        if (httpSession.getAttribute("LoginedMemberId") != null) {
            isLogined = true;
            loginedMemberId = (int) httpSession.getAttribute("LoginedMemberId");
        }

        this.isLogined = isLogined;
        this.loginedMemberId = loginedMemberId;
    }

    public void printHistoryBackJs(String msg) {
        resp.setContentType("text/html; charset=UTF-8");

        print(Ut.jsHistoryBack(msg));

    }

    private void print(String str) {
        try {
            resp.getWriter().append(str);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    public void login(Member member) {
        httpSession.setAttribute("LoginedMemberId", member.getId());
    }

    public void logout() {
        httpSession.removeAttribute("LoginedMemberId");
    }

    public String jsHistoryBackOnView(String msg) {
        req.setAttribute("msg", msg);
        req.setAttribute("historyBack", true);
        return "common/js";
    }

}
