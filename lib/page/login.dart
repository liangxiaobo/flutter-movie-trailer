import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_movie/http/http.dart';
import 'package:flutter_movie/http/url.dart';
import 'package:flutter_movie/page/home.dart';
import 'package:flutter_movie/page/register.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  static const routeName = '/login';
  @override
  State<StatefulWidget> createState() => _LoginState();

}

class _LoginState extends State<Login> {
  /// 注册接口
  Future<Response> postDate(email, password) async{
    Response response = await dio.post(apiUrl['login'] as String, data: {
      'email': email,
      'password': password
    });
    return response;
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController _emailController = TextEditingController();
    TextEditingController _passwordController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: Text('登录'),
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
                  labelText: '请输入邮箱',
              ),
            ),
          ),
          /*密码*/
          Padding(
            padding: EdgeInsets.all(10),
            child: TextField(
              controller: _passwordController,
              keyboardType: TextInputType.visiblePassword,
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(10),
                  icon: Icon(Icons.lock_outline),
                  labelText: '请输入密码',
              ),
            ),
          ),

          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              child: Text('注册'),
              onPressed: () {
                Navigator.pushNamed(context, Register.routeName);
              },
            ),
          ),

          Padding(
            padding: EdgeInsets.all(10),
            child: ElevatedButton(
              onPressed: () {
                print("email: ${_emailController.text} password: ${_passwordController.text}");
                if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
                  print("不能为空");
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('都不能为空')));
                  return;
                }

                postDate(_emailController.text, _passwordController.text).then((response) async {
                  print("登录结果：$response");
                  if(response.data['code'] != 200) {
                    print("注册失败结果: ${response.data['errMsg']}");
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(response.data['errMsg'])));
                    return;
                  }

                  if (response.data['data']) {
                    /// TODO 实际业务应该是存放登录后的用户信息到本地缓存中
                    final prefs = await SharedPreferences.getInstance();
                    prefs.setString('email', _emailController.text);

                    Navigator.pushNamed(context, Home.routeName);
                  }
                });
              },
              child: Text('登录'),
            ),
          ),
        ],
      ),
    );
  }

}