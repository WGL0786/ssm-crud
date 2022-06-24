package com.crud.bean;

import java.util.HashMap;
import java.util.Map;

/**
 * 通用的返回类
 */
public class Msg {
    // 状态码 100-成功 200-失败
    private int code;
    // 提示信息
    private String msg;
    // 用户要返回给浏览器的数据
    private Map<String, Object> extend = new HashMap<String, Object>();

    public static Msg success() {
        Msg result = new Msg();
        result.setCode(100);
        result.setMsg("处理成功！");
        return result;
    }

    public static Msg fail() {
        Msg result = new Msg();
        result.setCode(200);
        result.setMsg("处理失败！");
        return result;
    }

    public Msg add(String key, Object value) {
        this.getExtend().put(key, value);
        return this;
    }

    public int getCode() {
        return this.code;
    }

    public void setCode(final int code) {
        this.code = code;
    }

    public String getMsg() {
        return this.msg;
    }

    public void setMsg(final String msg) {
        this.msg = msg;
    }

    public Map<String, Object> getExtend() {
        return this.extend;
    }

    public void setExtend(final Map<String, Object> extend) {
        this.extend = extend;
    }
}
