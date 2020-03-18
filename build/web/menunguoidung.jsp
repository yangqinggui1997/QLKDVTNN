<%-- 
    Document   : menunguoidung
    Created on : Oct 31, 2018, 11:16:17 PM
    Author     : DELL
--%>


<%@page contentType="text/html" pageEncoding="UTF-8"%>
<p hidden="" id="idnd"><%= session.getAttribute("mand") %></p>
<p hidden="" id="tennd"><%= session.getAttribute("tennd") %></p>
<div class="dropdown" style="text-align: right;">
    <a class="dropdown-toggle" data-toggle="dropdown" style="cursor: pointer; text-decoration: none;">
      <span class="glyphicon glyphicon-user"></span> 
      Chào <script>document.write($('#tennd').text());</script>!
      <span class="caret"></span>
    </a>
      
    <ul class="dropdown-menu dropdown-menu-right">
<!--        <li><a style="cursor: pointer;" id="btntb"><span class="glyphicon glyphicon-envelope"></span> Thông báo</a></li>
        <li><a style="cursor: pointer;" id="btncntt" data-toggle="modal" data-target="#fcapnhatthongtin"><span class="glyphicon glyphicon-edit"></span> Hồ sơ cá nhân</a></li>-->
        <li><a style="cursor: pointer;" id="btndmk" data-toggle="modal" data-target="#fsuamk"><span class="glyphicon glyphicon-wrench"></span> Đổi mật khẩu</a></li>
      <li class="divider"></li>
      <li><a style="cursor: pointer;" id="btndangxuat"><span class="glyphicon glyphicon-log-out"></span> Đăng xuất</a></li>
    </ul>
    <!-- Hộp modal chứa form sửa mk -->
    <div class="modal fade" id="fsuamk" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" id="dismiss">&times;</button>
                <h4 class="modal-title text-center">Đổi mật khẩu</h4>
            </div>
            <div class="modal-body">
                <form>
                    <div class="form-group">
                        <input class="form-control"  type="password" 
                                                id="txtmkcu" placeholder="Mật khẩu cũ" required>
                    </div>
                    <div class="form-group">
                        <input class="form-control"  type="password" 
                               id="txtmkmoi" placeholder="Mật khẩu mới" required disabled="">
                    </div>
                    <div class="form-group">
                        <input class="form-control"  type="password" 
                               id="txtxnmkmoi" placeholder="Xác nhậb mật khẩu mới" required disabled="">
                    </div>   
                </form>          
            </div>
            <div class="modal-footer">
                <div class="form-group align-content-center">
                    <button class="btn btn-primary" id="nutcapnhatmk">Sửa</button>
                </div>
            </div>

            </div>
        </div>
    </div>
    <script>
        $('#fsuamk').on('keydown', function(e) {
                if (e.which === 13) {
                    $('#nutcapnhatmk').click();
                }
            });

        let url="";
        if(window.location.pathname.toString().split('/').length === 4){
            url="../proccess.jsp";
        }
        else if(window.location.pathname.toString().split('/').length === 5){
            url="../../proccess.jsp";
        }
        else if(window.location.pathname.toString().split('/').length === 6){
            url="../../../proccess.jsp";
        }

        let mnd = $('#idnd').text();
                
        //kiểm tra mật khuẩu cũ
        const $mkcuchange = document.querySelector('#txtmkcu');
        const typeHandler = function() {
            if($('#txtmkcu').val().toString().trim() === ""){
                $('#txtmkcu').css({"border": "1px solid", "border-color":"#66afe9"});
                $('#txtmkmoi').val("");
                $('#txtxnmkmoi').val("");
                $('#txtmkmoi').removeAttr("disabled");
                $('#txtxnmkmoi').removeAttr("disabled");
                $('#txtmkmoi').attr({"disabled":""});
                $('#txtxnmkmoi').attr({"disabled":""});
            }
            else{
                $.ajax({
                    type: "POST",
                    url: url,
                    data: {mand: mnd, mkcu: $('#txtmkcu').val(), hd: "ktmkcu"},
                    success: function(data) {
                        let dt=data;
                        dt= dt.toString().trim();
                        if(dt !== null){
                            if(dt === "tc"){
                                $('#txtmkcu').css({"border": "1px solid", "border-color":"#66afe9"});
                                $('#txtmkmoi').removeAttr("disabled");
                                $('#txtxnmkmoi').removeAttr("disabled");
                            }
                            else{
                                $('#txtmkcu').css({"border": "1px solid", "border-color":"#ff0000"});
                                $('#txtmkmoi').val("");
                                $('#txtxnmkmoi').val("");
                                $('#txtmkmoi').removeAttr("disabled");
                                $('#txtxnmkmoi').removeAttr("disabled");
                                $('#txtmkmoi').attr({"disabled":""});
                                $('#txtxnmkmoi').attr({"disabled":""});
                            }

                        }
                        else{
                            $('#txtmkcu').css({"border": "1px solid", "border-color":"#ff0000"});
                            $('#txtmkmoi').val("");
                            $('#txtxnmkmoi').val("");
                            $('#txtmkmoi').removeAttr("disabled");
                            $('#txtxnmkmoi').removeAttr("disabled");
                            $('#txtmkmoi').attr({"disabled":""});
                            $('#txtxnmkmoi').attr({"disabled":""});
                        }
                    },
                    error: function() {
                        $('#txtmkcu').css({"border": "1px solid", "border-color":"#ff0000"});
                        $('#txtmkmoi').val("");
                        $('#txtxnmkmoi').val("");
                        $('#txtmkmoi').removeAttr("disabled");
                        $('#txtxnmkmoi').removeAttr("disabled");
                        $('#txtmkmoi').attr({"disabled":""});
                        $('#txtxnmkmoi').attr({"disabled":""});
                    }
                });
            }
        };

        $mkcuchange.addEventListener('input', typeHandler); // register for oninput
        $mkcuchange.addEventListener('propertychange', typeHandler); // for IE8
        $('#dismiss').click(function() {});
        //Cập nhật mật khẩu mới
        $('#nutcapnhatmk').click(function() {
            let mkcu=$('#txtmkcu').val(), mkmoi=$('#txtmkmoi').val(), nlmk=$('#txtxnmkmoi').val();
            if(mkcu ==="" || mkmoi === "" || nlmk===""){
                alert("Vui lòng nhập đầy đủ thông tin!");
                return false;
            }
            else{
                if(mkmoi.length < 6){
                    alert("Độ dài mật khẩu tối thiểu phải có 6 ký tự!");
                    return false;
                }
                else{
                    if(mkmoi !== nlmk){
                        $('#txtmkmoi').val("");
                        $('#txtxnmkmoi').val("");
                        $('#txtmkmoi').focus();
                        alert("Xác nhận mật khẩu không đúng, hãy nhập lại mật khẩu!");
                        return false;
                    }
                    else if(mkmoi === mkcu){
                        alert("Mật khẩu mới không được trùng với mật khẩu cũ!");
                        return false;
                    }
                    else
                    {
                        $.ajax({
                            type: "POST",
                            url: url,
                            data: {mand: mnd, mkmoi: mkmoi, hd: "doimk"},
                            success: function(data) {
                                let dt=data;
                                dt=dt.toString().trim();
                                if(dt !== null){
                                    if(dt === "tc"){
                                        
                                        alert("Sửa thành công!");
                                        $('#dismiss').click();
                                    }
                                    else{
                                        alert("Sửa mật khẩu, hãy thử lại lần nữa!");
                                        return false;
                                    }
                                }
                                else{
                                    alert("Sửa mật khẩu, hãy thử lại lần nữa!");
                                    return false;
                                }

                            },
                            error: function() {
                                alert("Sửa mật khẩu, hãy thử lại lần nữa!");
                                return false;
                            }

                        });
                    }
                }
               
            }
        });
        
        //nhấn nút exit
        $('#btndangxuat').click(function() {
            var cf = confirm("Bạn có thật sự muốn đăng xuất?");
            if(cf===true){
                $.ajax({
                   type: 'POST',
                   url: url,
                   data: {mand: mnd, hd: 'dangxuat'},
                   success: function(data) {
                       let dt=data;
                       dt=dt.toString().trim();
                       if(dt !== null){
                           if(dt === "tc"){
                               if(window.location.pathname.toString().split('/').length === 4){
                                    location.replace('../');
                                }
                                else if(window.location.pathname.toString().split('/').length === 5){
                                    location.replace('../../');
                                }
                                else if(window.location.pathname.toString().split('/').length === 6){
                                    location.replace('../../../');
                                }
                           }
                           else{
                               alert("Đã có lỗi xảy ra!");
                               return false;
                           }
                       }
                       else{
                           alert("Đã có lỗi xảy ra!");
                           return false;
                       }
                    },
                    error: function() {
                        alert("Đã có lỗi xảy ra!");
                        return false;
                    }
                });
            }
        });
    </script>
  </div>
