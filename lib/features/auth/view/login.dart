import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zoom_golb/core/base_bloc/base_bloc.dart';
import 'package:zoom_golb/core/theme/app_colors.dart';
import 'package:zoom_golb/features/auth/bloc/auth_events.dart';
import 'package:zoom_golb/features/auth/bloc/auth_provider.dart';
import 'package:zoom_golb/features/auth/bloc/auth_states.dart';
import 'package:zoom_golb/features/auth/view/widget/sign_up.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController _emailController;
  TextEditingController _passwordController;
  FocusNode _emailFocusNode;
  FocusNode _passwordFocusNode;
  BaseBloc<AuthEvent, AuthState> _bloc;
  bool _opennedDialog = false;

  @override
  void initState() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _emailFocusNode = FocusNode();
    _passwordFocusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String _emailLabelText = 'Email';
    String _passwordLabelText = 'Senha';
    return Scaffold(
      backgroundColor: Color(0xFFfafafa),
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [AppColors.primary, AppColors.secundary],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
            ),
          ),
          SingleChildScrollView(
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              child: Column(children: [
                Flexible(
                  flex: 40,
                  child: Container(),
                ),
                Expanded(
                  flex: 60,
                  child: Container(
                    padding: EdgeInsets.all(24),
                    height: double.infinity,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(24),
                          topRight: Radius.circular(24),
                        ),
                        color: Colors.white),
                    child: Consumer(
                      builder: (BuildContext context,
                          T Function<T>(ProviderBase<Object, T>) watch,
                          Widget child) {
                        _bloc = watch(AuthProvider.authBloc);
                        print(_bloc);
                        return StreamBuilder<AuthState>(
                            stream: _bloc.event$,
                            builder: (context, snapshot) {
                              bool obscure =
                                  snapshot?.data?.obscurePassword ?? true;

                              if (snapshot?.data is AuthStateUserNotFound &&
                                  !_opennedDialog) {
                                _opennedDialog = true;
                                Future.microtask(() {
                                  Scaffold.of(context).showBottomSheet(
                                      (context) => SignUp(
                                            submit: _submitRegister,
                                          ),
                                      backgroundColor: Colors.transparent);
                                });
                              }

                              return Column(children: [
                                TextField(
                                  focusNode: _emailFocusNode,
                                  controller: _emailController,
                                  decoration: InputDecoration(
                                    labelText: _emailLabelText,
                                  ),
                                ),
                                SizedBox(
                                  height: 16,
                                ),
                                TextField(
                                  focusNode: _passwordFocusNode,
                                  controller: _passwordController,
                                  obscureText: obscure,
                                  decoration: InputDecoration(
                                    labelText: _passwordLabelText,
                                    suffixIcon: IconButton(
                                      icon: Icon(
                                        Icons.visibility_outlined,
                                        color: AppColors.primary,
                                      ),
                                      onPressed: () {
                                        _bloc.inEvent.add(
                                            AuthEventToggleObscure(!obscure));
                                      },
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 48,
                                ),
                                MaterialButton(
                                    color: AppColors.accent,
                                    child: Text('Logar'),
                                    onPressed: () {
                                      _submitLogin();
                                    })
                              ]);
                            });
                      },
                    ),
                  ),
                )
              ]),
            ),
          ),
          Consumer(
            builder: (BuildContext context,
                T Function<T>(ProviderBase<Object, T>) watch, Widget child) {
              BaseBloc<AuthEvent, AuthState> bloc =
                  watch(AuthProvider.authBloc);

              return StreamBuilder<bool>(
                  stream: bloc.event$
                      .map((event) => event != null && event.loading),
                  initialData: false,
                  builder: (context, snapshot) {
                    if (snapshot.data ?? false) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      return SizedBox.shrink();
                    }
                  });
            },
          )
        ],
      ),
    );
  }

  _submitLogin() {
    _opennedDialog = false;
    _bloc.inEvent.add(AuthEventSubmit(
        email: _emailController.text,
        password: _passwordController.text,
        success: _navigate));
  }

  _submitRegister() {
    _opennedDialog = false;
    _bloc.inEvent.add(AuthEventRegister(
        email: _emailController.text,
        password: _passwordController.text,
        success: _navigate));
  }

  _navigate() {
    //TODO Navigate to feed
    print('NAVIGATE!');
  }
}
