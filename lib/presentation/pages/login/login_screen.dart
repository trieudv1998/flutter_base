import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_base/core/application/common/widgets/app_text_field.dart';
import 'package:flutter_base/core/domain/constants/app_colors.dart';
import 'package:flutter_base/presentation/pages/login/cubit/login_cubit.dart';
import 'package:flutter_base/presentation/routes/route_name.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late LoginCubit _cubit;
  CancelToken? _cancelToken;
  final GlobalKey _passwordKey = GlobalKey();
  late TextEditingController taxEmailController;
  late TextEditingController passwordController;
  bool password = false;
  bool showPass = false;

  @override
  void initState() {
    super.initState();
    _cubit = BlocProvider.of<LoginCubit>(context);
    _cancelToken = CancelToken();
    taxEmailController = TextEditingController(text: "");
    passwordController = TextEditingController(text: "");
  }

  @override
  void dispose() {
    super.dispose();
    _cubit.close();
    taxEmailController.dispose();
    passwordController.dispose();
    _cancelToken?.cancel();
    _cancelToken = null;
  }

  void _onToggleShowPass() {
    setState(() {
      showPass = !showPass;
    });
  }

  void _onCheckPassword() {
    String _text = passwordController.text;
    if (!password && _text.isNotEmpty) {
      setState(() {
        password = true;
      });
    } else if (password && _text.isEmpty) {
      setState(() {
        password = false;
      });
    }
  }

  Widget _buildEyeIcon() {
    return (SvgPicture.asset(
      "assets/images/icon_eye.svg",
      width: 25.w,
    ));
  }

  Widget _buildEyeCloseIcon() {
    return (SvgPicture.asset(
      "assets/images/icon_eye_close.svg",
      width: 25.w,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              children: <Widget>[
                Container(
                  height: 400,
                  decoration: const BoxDecoration(image: DecorationImage(image: AssetImage('assets/images/background.png'), fit: BoxFit.fill)),
                  child: Stack(
                    children: <Widget>[
                      Positioned(
                        left: 30,
                        width: 80,
                        height: 200,
                        child: Container(
                          decoration: const BoxDecoration(image: DecorationImage(image: AssetImage('assets/images/light-1.png'))),
                        ),
                      ),
                      Positioned(
                        left: 140,
                        width: 80,
                        height: 150,
                        child: Container(
                          decoration: const BoxDecoration(image: DecorationImage(image: AssetImage('assets/images/light-2.png'))),
                        ),
                      ),
                      Positioned(
                        right: 40,
                        top: 40,
                        width: 80,
                        height: 150,
                        child: Container(
                          decoration: const BoxDecoration(image: DecorationImage(image: AssetImage('assets/images/clock.png'))),
                        ),
                      ),
                      Positioned(
                        child: Container(
                          margin: const EdgeInsets.only(top: 50),
                          child: const Center(
                            child: Text(
                              "Login",
                              style: TextStyle(color: Colors.white, fontSize: 40, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Column(
                    children: <Widget>[
                      Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10), boxShadow: const [BoxShadow(color: Color.fromRGBO(143, 148, 251, .2), blurRadius: 20.0, offset: Offset(0, 10))]),
                        child: Column(
                          children: <Widget>[
                            Container(
                              color: AppColors.white,
                              margin: EdgeInsets.symmetric(vertical: 5.h),
                              child: BlocBuilder<LoginCubit, LoginState>(
                                buildWhen: (previous, current) => previous.phoneValidate != current.phoneValidate,
                                builder: (_, state) => AppTextField(
                                  hintText: "Nhập SDT ở đây bạn nhé ...",
                                  isRequired: true,
                                  validator: state.phoneValidate,
                                  controller: taxEmailController,
                                  onChanged: (value) {
                                    _cubit.onChangePhoneNumber(value);
                                  },
                                  keyboardType: TextInputType.number,
                                  inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
                                ),
                              ),
                            ),
                            Container(
                              color: AppColors.white,
                              margin: EdgeInsets.symmetric(vertical: 5.h),
                              child: BlocBuilder<LoginCubit, LoginState>(
                                buildWhen: (previous, current) => previous.passwordValidate != current.passwordValidate,
                                builder: (_, state) => AppTextField(
                                  key: _passwordKey,
                                  hintText: "●●●●●●",
                                  isRequired: true,
                                  validator: state.passwordValidate,
                                  controller: passwordController,
                                  onChanged: (value) {
                                    _onCheckPassword();
                                    _cubit.onChangePassword(value);
                                  },
                                  suffixIcon: password
                                      ? GestureDetector(
                                          onTap: _onToggleShowPass,
                                          child: showPass ? _buildEyeCloseIcon() : _buildEyeIcon(),
                                        )
                                      : const SizedBox(),
                                  obscureText: !showPass,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      BlocBuilder<LoginCubit, LoginState>(
                        builder: (_, state) {
                          return Opacity(
                            opacity: state.isEnable == true ? 1 : 0.2,
                            child: GestureDetector(
                              onTap: state.isEnable == true
                                  ? () {
                                      _cubit.login(cancelToken: _cancelToken);
                                      Navigator.of(context).pushNamedAndRemoveUntil(
                                        RouteName.rootScreen,
                                        (Route<dynamic> route) => false,
                                      );
                                    }
                                  : null,
                              child: Container(
                                height: 50,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    gradient: const LinearGradient(colors: [
                                      Color.fromRGBO(143, 148, 251, 1),
                                      Color.fromRGBO(143, 148, 251, .6),
                                    ])),
                                child: const Center(
                                  child: Text(
                                    "Login",
                                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                      const SizedBox(
                        height: 70,
                      ),
                      const Text("Forgot Password?", style: TextStyle(color: Color.fromRGBO(143, 148, 251, 1))),
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
