<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>员工列表</title>
    <%
        pageContext.setAttribute("APP_PATH", request.getContextPath());
    %>
    <%--  web路径：
      不以/开始的相对路径，找资源，以当前资源的路径为基准，经常容易出问题；
      以/开始的相对路径，找资源，以服务器的路径为标准（http://localhost:8080）需要加上项目名称
      http://localhost:8080/ssm_crud/
      --%>
    <script type="text/javascript" src="${APP_PATH}/static/js/jquery-2.1.4.min.js"></script>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css"
          integrity="sha384-HSMxcRTRxnN+Bdg0JdbxYKrThecOKuH5zCYotlSAcp1+c8xmyTe9GYg1l9a69psu" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.cn/npm/jquery@1.12.4/dist/jquery.min.js"
            integrity="sha384-nvAa0+6Qg9clwYCGGPpDQLVpLNn0fRaROjHqs13t4Ggj3Ez50XnGQqc/r8MhnRDZ"
            crossorigin="anonymous"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"
            integrity="sha384-aJ21OjlMXNL5UyIl/XNwTMqvzeRMZH2w8c5cRVpzpU8Y5bApTppSuUkhZXN0VxHd"
            crossorigin="anonymous"></script>
</head>
<body>
<!-- 员工修改的模态框 -->
<div class="modal fade" id="empUpdateModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title">员工修改</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">
                    <div class="form-group">
                        <label class="col-sm-2 control-label">empName</label>
                        <div class="col-sm-10">
                            <p class="form-control-static" id="empName_update_static"></p>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">email</label>
                        <div class="col-sm-10">
                            <input type="text" name="email" class="form-control" id="email_update_input"
                                   placeholder="email@oxygen.com">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">gender</label>
                        <div class="col-sm-10">
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender1_update_input" value="M" checked="checked">
                                男
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender2_update_input" value="F"> 女
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">deptName</label>
                        <div class="col-sm-4">
                            <%-- 部门提交部门id --%>
                            <select class="form-control" name="dId"></select>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="emp_update_btn">更新</button>
            </div>
        </div>
    </div>
</div>
<!-- 员工添加的模态框 -->
<div class="modal fade" id="empAddModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title" id="myModalLabel">员工添加</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">
                    <div class="form-group">
                        <label class="col-sm-2 control-label">empName</label>
                        <div class="col-sm-10">
                            <input type="text" name="empName" class="form-control" id="empName_add_input"
                                   placeholder="empName">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">email</label>
                        <div class="col-sm-10">
                            <input type="text" name="email" class="form-control" id="email_add_input"
                                   placeholder="email@oxygen.com">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">gender</label>
                        <div class="col-sm-10">
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender1_add_input" value="M" checked="checked"> 男
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender2_add_input" value="F"> 女
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">deptName</label>
                        <div class="col-sm-4">
                            <%-- 部门提交部门id --%>
                            <select class="form-control" name="dId"></select>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="emp_save_btn">保存</button>
            </div>
        </div>
    </div>
</div>
<%-- 搭建显示页面 --%>
<div class="container">
    <%-- 标题 --%>
    <div class="row">
        <div class="col-md-12">
            <h1>SSM-CRUD</h1>
        </div>
    </div>
    <%-- 按钮 --%>
    <div class="row">
        <div class="col-md-4 col-md-offset-8">
            <button class="btn btn-primary" id="emp_add_modal_btn">新增</button>
            <button class="btn btn-danger" id="emp_delete_all_btn">删除</button>
        </div>
    </div>
    <%-- 显示表格数据 --%>
    <div class="row">
        <div class="col-md-12">
            <table class="table table-striped" id="emps_table">
                <thead>
                <tr>
                    <th>
                        <input type="checkbox" id="check_all"/>
                    </th>
                    <th>#</th>
                    <th>empName</th>
                    <th>gender</th>
                    <th>email</th>
                    <th>deptName</th>
                    <th>操作</th>
                </tr>
                </thead>
                <tbody>
                </tbody>
            </table>
        </div>
    </div>
    <%-- 显示分页信息 --%>
    <div class="row">
        <%-- 分页文字信息 --%>
        <div class="col-md-6" id="page_info_area"></div>
        <%-- 分页条信息 --%>
        <div class="col-md-6" id="page_nav_area"></div>
    </div>
</div>
<script type="text/javascript">
    var totalRecord, currentPage;
    // 1、页面加载完成以后，直接去发送一个ajax请求，要到分页数据
    $(function () {
        // 去首页
        to_page(1);
    });

    function to_page(pn) {
        $.ajax({
            url: "${APP_PATH}/emps",
            data: "pn=" + pn,
            type: "GET",
            success: function (result) {
                // console.log(result);
                // 1、解析并显示员工数据
                build_emps_table(result);
                // 2、解析并显示分页信息
                build_page_info(result);
                // 3、解析并显示分页条数据
                build_page_nav(result);
            }
        });
    }

    function build_emps_table(result) {
        // 清空table表格
        $("#emps_table tbody").empty();
        var emps = result.extend.pageInfo.list;
        $.each(emps, function (index, item) {
            var checkBoxTd = $("<td><input type='checkbox' class='check_item' /></td>");
            var empIdTd = $("<td></td>").append(item.empId);
            var empNameTd = $("<td></td>").append(item.empName);
            var genderTd = $("<td></td>").append(item.gender == "M" ? "男" : "女");
            var emailTd = $("<td></td>").append(item.email);
            var deptNameTd = $("<td></td>").append(item.department.deptName);
            var editBtn = $("<button></button>").addClass("btn btn-primary btn-sm edit_btn").append($("<span></span>").addClass("glyphicon glyphicon-pencil")).append("编辑");
            // 为编辑按钮添加一个自定义的属性，来表示当前员工id
            editBtn.attr("edit_id", item.empId);
            var delBtn = $("<button></button>").addClass("btn btn-danger btn-sm delete_btn").append($("<span></span>").addClass("glyphicon glyphicon-trash")).append("删除");
            // 为删除按钮添加一个自定义的属性，来表示当前员工id
            delBtn.attr("del_id", item.empId);
            var btnTd = $("<td></td>").append(editBtn).append(" ").append(delBtn);
            // append执行完成以后还是返回原来的元素
            $("<tr></tr>").append(checkBoxTd).append(empIdTd).append(empNameTd).append(genderTd).append(emailTd).append(deptNameTd).append(btnTd).appendTo("#emps_table tbody");
        });
    }

    // 解析显示分页信息
    function build_page_info(result) {
        $("#page_info_area").empty();
        $("#page_info_area").append("当前【" + result.extend.pageInfo.pageNum + "】页，总【" + result.extend.pageInfo.pages + "】页，总【" + result.extend.pageInfo.total + "】条记录");
        totalRecord = result.extend.pageInfo.total;
        currentPage = result.extend.pageInfo.pageNum;
    }

    // 解析显示分页条，点击分页要能取下一页。。。
    function build_page_nav(result) {
        $("#page_nav_area").empty();
        var ul = $("<ul></ul>").addClass("pagination");
        // 构建元素
        var firstPageLi = $("<li></li>").append($("<a></a>").append("首页").attr("href", "#"));
        var prePageLi = $("<li></li>").append($("<a></a>").append("&laquo;"));
        if (result.extend.pageInfo.hasPreviousPage == false) {
            firstPageLi.addClass("disabled");
            prePageLi.addClass("disabled");
        } else {
            // 为元素添加点击事件
            firstPageLi.click(function () {
                to_page(1);
            });
            prePageLi.click(function () {
                to_page(result.extend.pageInfo.pageNum - 1);
            });
        }
        var nextPageLi = $("<li></li>").append($("<a></a>").append("&raquo;"));
        var lastPageLi = $("<li></li>").append($("<a></a>").append("末页").attr("href", "#"));
        if (result.extend.pageInfo.hasNextPage == false) {
            nextPageLi.addClass("disabled");
            lastPageLi.addClass("disabled");
        } else {
            nextPageLi.click(function () {
                to_page(result.extend.pageInfo.pageNum + 1);
            });
            lastPageLi.click(function () {
                to_page(result.extend.pageInfo.pages);
            });
        }
        // 添加首页和前一页的提示
        ul.append(firstPageLi).append(prePageLi);
        // 页码号1、2、3、4、5 遍历给ul中添加页码的提示
        $.each(result.extend.pageInfo.navigatepageNums, function (index, item) {

            var numLi = $("<li></li>").append($("<a></a>").append(item));
            if (result.extend.pageInfo.pageNum == item) {
                numLi.addClass("active");
            }
            numLi.click(function () {
                to_page(item);
            });
            ul.append(numLi);
        });
        // 添加下一页和末页的提示
        ul.append(nextPageLi).append(lastPageLi);
        // 把ul添加到nav中
        var navEle = $("<nav></nav>").append(ul);
        navEle.appendTo("#page_nav_area");
    }

    // 清空表单样式及内容
    function reset_form(ele) {
        $(ele)[0].reset();
        // 清空表单样式
        $(ele).find("*").removeClass("has-success has-error");
        $(ele).find(".help-block").text("");
    }

    // 点击新增按钮弹出模态框
    $("#emp_add_modal_btn").click(function () {
        // 清除表单数据（表单完整重置（表单的数据、样式））
        reset_form("#empAddModal form");
        // $("#empAddModal form")[0].reset();
        // 发送ajax请求，查出部门信息，显示在下拉列表中
        getDepts("#empAddModal select");
        // 弹出模态框
        $("#empAddModal").modal({
            backdrop: "static"
        });
    });

    // 查出所有部门信息，并显示在下拉列表中
    function getDepts(ele) {
        // 清空之前下拉列表的值
        $(ele).empty();
        $.ajax({
            url: "${APP_PATH}/depts",
            type: "GET",
            success: function (result) {
                // {"code":100,"msg":"处理成功！","extend":{"depts":[{"deptId":1,"deptName":"开发部"},{"deptId":2,"deptName":"测试部"}]}}
                // console.log(result);
                // 显示部门信息在下拉列表中
                // $("#empAddModal select").append();
                $.each(result.extend.depts, function () {
                    var optionEle = $("<option></option>").append(this.deptName).attr("value", this.deptId);
                    optionEle.appendTo(ele);
                });
            }
        });
    }

    // 校验表单数据
    function validate_add_form() {
        // 1、拿到要校验的数据，可以使用正则表达式
        var empName = $("#empName_add_input").val();
        var regName = /(^[a-zA-Z0-9_-]{3,16}$)|(^[\u2E80-\u9FFF]{2,5}$)/;
        if (!regName.test(empName)) {
            show_validate_msg("#empName_add_input", "error", "用户名必须是3-16位英文和数字的组合或2-5位中文！");
            return false;
        } else {
            show_validate_msg("#empName_add_input", "success", "");
        }
        // 2、校验邮箱数据
        var email = $("#email_add_input").val();
        var regEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
        if (!regEmail.test(email)) {
            show_validate_msg("#email_add_input", "error", "邮箱格式不正确！");
            return false;
        } else {
            show_validate_msg("#email_add_input", "success", "");
        }
        return true;
    }

    // 显示校验结果的提示信息
    function show_validate_msg(ele, status, msg) {
        // 清除元素当前的校验状态
        $(ele).parent().removeClass("has-success has-error");
        $(ele).next("span").text("");
        if ("success" == status) {
            $(ele).parent().addClass("has-success");
            $(ele).next("span").text(msg);
        } else if ("error" == status) {
            $(ele).parent().addClass("has-error");
            $(ele).next("span").text(msg);
        }
    }

    // 校验用户名是否可用
    $("#empName_add_input").change(function () {
        // 发送ajax请求校验用户名是否可用
        var empName = this.value;
        $.ajax({
            url: "${APP_PATH}/checkuser",
            data: "empName=" + empName,
            type: "POST",
            success: function (result) {
                if (result.code == 100) {
                    show_validate_msg("#empName_add_input", "success", "用户名可用！");
                    $("#emp_save_btn").attr("ajax-validate", "success");
                } else {
                    show_validate_msg("#empName_add_input", "error", result.extend.va_msg);
                    $("#emp_save_btn").attr("ajax-validate", "error");
                }
            }
        });
    });

    // 点击保存员工数据
    $("#emp_save_btn").click(function () {
        // 1、将模态框中填写的表单数据提交给服务器进行保存
        // 先对要提交给服务器的数据进行校验
        if (!validate_add_form()) {
            return false;
        }
        // 判断之前的ajax校验是否成功
        if ($(this).attr("ajax-validate") == "error") {
            return false;
        }
        // 2、发送ajax请求保存员工数据
        // alert($("#empAddModal form").serialize());
        $.ajax({
            url: "${APP_PATH}/emp",
            type: "POST",
            data: $("#empAddModal form").serialize(),
            success: function (result) {
                // alert(result.msg);
                if (result.code == 100) {
                    // 员工保存成功
                    // 1、关闭模态框
                    $("#empAddModal").modal("hide");
                    // 2、来到最后一页，显示刚才保存的数据
                    // 发送ajax请求显示最后一页数据
                    to_page(totalRecord);
                } else {
                    // 显示失败信息
                    // console.log(result);        
                    // 有哪个字短的错误信息就显示哪个字短的错误信息
                    if (undefined != result.extend.errorFields.empName) {
                        // 显示用户名错误信息
                        show_validate_msg("#empName_add_input", "error", result.extend.errorFields.empName);
                    }
                    if (undefined != result.extend.errorFields.email) {
                        // 显示邮箱错误信息
                        show_validate_msg("#email_add_input", "error", result.extend.errorFields.email);
                    }
                }
            }
        });
    });

    // 编辑按钮的模态框显示数据信息
    $(document).on("click", ".edit_btn", function () {
        // alert("edit");
        // 查出部门信息，显示在部门列表
        getDepts("#empUpdateModal select");
        // 查出员工信息并显示
        getEmp($(this).attr("edit_id"));
        // 把员工的id传递给更新按钮
        $("#emp_update_btn").attr("edit_id", $(this).attr("edit_id"));
        // 弹出模态框
        $("#empUpdateModal").modal({
            backdrop: "static"
        });
    });

    // 通过员工id，获取员工信息
    function getEmp(id) {
        $.ajax({
            url: "${APP_PATH}/emp/" + id,
            type: "GET",
            success: function (result) {
                // console.log(result);
                var empData = result.extend.emp;
                $("#empName_update_static").text(empData.empName);
                $("#email_update_input").val(empData.email)
                $("#empUpdateModal input[name=gender]").val([empData.gender]);
                $("#empUpdateModal select").val([empData.dId]);
            }
        });
    }

    // 点击更新，更新员工信息
    $("#emp_update_btn").click(function () {
        // 验证邮箱是否合法
        // 校验邮箱数据
        var email = $("#email_update_input").val();
        var regEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
        if (!regEmail.test(email)) {
            show_validate_msg("#email_update_input", "error", "邮箱格式不正确！");
            return false;
        } else {
            show_validate_msg("#email_update_input", "success", "");
        }
        // 发送ajax请求，保存更新的员工数据
        $.ajax({
            url: "${APP_PATH}/emp/" + $(this).attr("edit_id"),
            // type: "POST",
            // data: $("#empUpdateModal form").serialize() + "&_method=PUT",
            type: "PUT",
            data: $("#empUpdateModal form").serialize(),
            success: function (result) {
                // alert(result.msg);
                // 1、关闭模态框
                $("#empUpdateModal").modal("hide");
                // 2、回到当前页
                to_page(currentPage);
            }
        });
    });

    // 删除单条记录
    $(document).on("click", ".delete_btn", function () {
        // 弹出是否确认删除对话框
        // alert($(this).parents("tr").find("td:eq(1)").text());
        var empName = $(this).parents("tr").find("td:eq(2)").text();
        var empId = $(this).attr("del_id");
        if (confirm("确认删除【" + empName + "】吗？")) {
            // 确认，发送ajax请求即可
            $.ajax({
                url: "${APP_PATH}/emp/" + empId,
                type: "DELETE",
                success: function (result) {
                    alert(result.msg);
                    // 回到当前页
                    to_page(currentPage);
                }
            });
        }
    });

    // 完成全选，全不选功能
    $("#check_all").click(function () {
        // attr获取checked是undefined。 attr获取的是自定义属性的值
        // prop来修改和获取dom原生的值
        $(".check_item").prop("checked", $(this).prop("checked"));
    });

    // 为check_item绑定点击事件
    $(document).on("click", ".check_item", function () {
        var flag = $(".check_item:checked").length == $(".check_item").length;
        $("#check_all").prop("checked", flag);
    });

    // 批量删除
    $("#emp_delete_all_btn").click(function () {
        var empNames = "";
        var del_idstr = "";
        $.each($(".check_item:checked"), function () {
            empNames += $(this).parents("tr").find("td:eq(2)").text() + ",";
            del_idstr += $(this).parents("tr").find("td:eq(1)").text() + "-";
        });
        // 去除empNames多余的"，"
        empNames = empNames.substring(0, empNames.length - 1);
        // 去除del_idstr多余的"-"
        del_idstr = del_idstr.substring(0, del_idstr.length - 1);
        if (confirm("确认删除【" + empNames + "】吗？")) {
            // 确认，发送ajax请求即可
            $.ajax({
                url: "${APP_PATH}/emp/" + del_idstr,
                type: "DELETE",
                success: function (result) {
                    alert(result.msg);
                    // 回到当前页
                    to_page(currentPage);
                }
            });
        }
    });
</script>
</body>
</html>