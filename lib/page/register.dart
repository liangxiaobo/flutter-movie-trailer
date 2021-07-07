import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_movie/http/http.dart';
import 'package:flutter_movie/http/url.dart';

import 'login.dart';

class Register extends StatefulWidget {
  static const routeName = '/register';
  @override
  State<StatefulWidget> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  /// 注册接口
  Future<Response> postDate(email, userName, password) async{
    Response response = await dio.post(apiUrl['register'] as String, data: {
      'email': email,
      'userName': userName,
      'password': password
    });
    return response;
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController _emailController = TextEditingController();
    TextEditingController _userController = TextEditingController();
    TextEditingController _passwordController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: Text('注册'),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(10),
            child: TextField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(10),
                icon: Icon(Icons.email_outlined),
                labelText: '邮箱',
              ),
            ),
          ),

          Padding(
            padding: EdgeInsets.all(10),
            child: TextField(
              controller: _userController,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(10),
                icon: Icon(Icons.person_outline),
                labelText: '用户名',
              ),
            ),
          ),

          Padding(
            padding: EdgeInsets.all(10),
            child: TextField(
              controller: _passwordController,
              keyboardType: TextInputType.visiblePassword,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(10),
                icon: Icon(Icons.lock_outline),
                labelText: '密码',
              ),
            ),
          ),

          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              child: Text('立即登录'),
              onPressed: () {
                Navigator.pushNamed(context, Login.routeName);
              },
            ),
          ),

          Padding(
            padding: EdgeInsets.all(10),
            child: SizedBox(
              height: 40,
              width: 150,
              child: ElevatedButton(
                onPressed: () {
                  print("email: ${_emailController.text} password: ${_passwordController.text}");

                  // if (postDate(_emailController.text, _userController.text, _passwordController.text)) {
                  //
                  // }
                  if (_emailController.text.isEmpty || _userController.text.isEmpty || _passwordController.text.isEmpty) {
                    print("不能为空");
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('都不能为空')));
                    return;
                  }
                  postDate(_emailController.text, _userController.text, _passwordController.text)
                      .then((response) {
                        print("注册结果：$response");
                        if(response.data['code'] != 200) {
                          print("注册失败结果: ${response.data['errMsg']}");
                          return;
                        }

                        if (response.data['data'] != null) {
                          /// 跳转到登录
                          Navigator.pushNamed(context, Login.routeName);
                        }
                  });
                },
                child: Text('注册'),
              ),
            ),
          ),
        ],
      ),
    );
  }

}