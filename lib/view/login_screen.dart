
import 'package:flutter/material.dart';
import 'package:flutter_api_project_mvvm/res/components/round_button.dart';
import 'package:flutter_api_project_mvvm/view_model/auth_view_model.dart';

import '../utils/utils.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget{
  const LoginScreen({super.key});

  @override
  State<StatefulWidget> createState() =>_LoginScreenState();

}

class _LoginScreenState extends State<LoginScreen>{

  TextEditingController emailController=TextEditingController();
  TextEditingController passwordController=TextEditingController();

  ValueNotifier<bool> _obscurePassword = ValueNotifier<bool>(true);
  FocusNode emailFocus = FocusNode();
  FocusNode passFocus = FocusNode();

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
    _obscurePassword.dispose();
    emailFocus.dispose();
    passFocus.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authViewModel= Provider.of<AuthViewModel>(context);

    final height=MediaQuery.of(context).size.height*1;

    return Scaffold(
      resizeToAvoidBottomInset: false,
    appBar: AppBar(
      title: const Text('Login'),
      centerTitle: true,

    ),
    body:   SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
      children: [
      TextFormField(
        controller: emailController,
        focusNode: emailFocus,
        keyboardType: TextInputType.emailAddress,
        onFieldSubmitted: (value){
          Utils.focusNode(context, emailFocus, passFocus);
          // FocusScope.of(context).requestFocus(passFocus);
        },
        decoration: const InputDecoration(
          hintText: 'Enter email',
          labelText: 'Email',
          prefixIcon: Icon(Icons.alternate_email)
        ),
      ),
        ValueListenableBuilder(valueListenable: _obscurePassword, builder: (context,value,child){
          return  TextFormField(
            controller: passwordController,
            obscureText: _obscurePassword.value,
            focusNode: passFocus,
            obscuringCharacter: '*',
            decoration: InputDecoration(
                hintText: 'Enter password',
                labelText: 'Password',
                prefixIcon: Icon(Icons.lock_outline),
                suffixIcon: InkWell(
                  child:  Icon(_obscurePassword.value? Icons.visibility_off_outlined : Icons.visibility),
                  onTap: (){
                    _obscurePassword.value =! _obscurePassword.value;
                  },
                )
            ),
          );
        }),
        SizedBox(height: height * .05),
        RoundButton(
          title: 'Login',
          loading: authViewModel.loading,
          onPress: (){
            if(emailController.text.isEmpty){
              Utils.flushBarErrorMessage("Please enter email", context);
            }else if(passwordController.text.isEmpty){
              Utils.flushBarErrorMessage("Please enter password", context);
            }else if(passwordController.text.length<8){
              Utils.flushBarErrorMessage("Password should contain at least 8 characters", context);
            }else{
              Map data={
                'email':emailController.text.toString(),
                'password':passwordController.text.toString()
              };
              authViewModel.loginApi(data,context);
              debugPrint('Api hit');
            }
          },
        ),
      ],
    ),
    )
  );
  }
}