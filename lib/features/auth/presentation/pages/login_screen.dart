import 'package:fake_shop/features/auth/presentation/pages/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/localization/get_os.dart';
import '../../../../core/localization/get_translate.dart';
import '../../../../core/routing/navigate_and_finish.dart';
import '../../../../core/routing/navigate_to.dart';
import '../../../../core/themes/colors.dart';
import '../../../../core/widget/adaptive/adaptive_button.dart';
import '../../../../core/widget/adaptive/adaptive_indicator.dart';
import '../../../../core/widget/adaptive/adaptive_text_field.dart';
import '../../../../core/widget/show_toast.dart';
import '../../../../core/injection_container.dart' as di;
import '../../../product/presentation/pages/home_page.dart';
import '../cubit/user_cubit.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => di.sl<UserCubit>(),
      child: BlocConsumer<UserCubit, UserState>(
        listener: (context, state) {
          if (state is LogInErrorState) {
            showToast(
              text: state.error,
              state: ToastStates.error,
            );
          }
          if (state is LogInSuccessState) {
            navigateAndFinish(context, const HomePage());
          }
        },
        builder: (context, state) {
          return Scaffold(
            body: state is LogInSuccessState
                ? Center(
                    child: AdaptiveIndicator(
                    os: getOs(),
                  ))
                : Container(
                    color: Colors.white,
                    height: MediaQuery.of(context).size.height,
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Form(
                          key: formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const SizedBox(height: 50),
                              const SizedBox(
                                height: 200,
                                child: Image(
                                  image: NetworkImage(
                                      'https://img.freepik.com/free-vector/sign-page-abstract-concept-illustration_335657-3875.jpg?t=st=1645145165~exp=1645145765~hmac=dd14710b06ae123c5b44548e67ac2010039152565d0f5fbad0b036c23726ddf0&w=740'),
                                  fit: BoxFit.contain,
                                ),
                              ),
                              Text(
                                getTranslated(context, 'LogIn_title'),
                                style: Theme.of(context)
                                    .textTheme
                                    .headline4!
                                    .copyWith(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                              const SizedBox(height: 30),
                              Container(
                                color: Colors.white,
                                child: AdaptiveTextField(
                                  os: getOs(),
                                  label: getTranslated(
                                      context, 'LogIn_email_textFiled_hint'),
                                  controller: emailController,
                                  type: TextInputType.emailAddress,
                                  validate: (value) {
                                    if (value!.isEmpty) {
                                      return getTranslated(context,
                                          'LogIn_email_controller_validate_isEmpty');
                                    }
                                  },
                                  prefix: Icons.email,
                                  textInputAction: TextInputAction.next,
                                  inputBorder: const UnderlineInputBorder(),
                                ),
                              ),
                              const SizedBox(height: 15),
                              Container(
                                color: Colors.white,
                                child: AdaptiveTextField(
                                  os: getOs(),
                                  label: getTranslated(
                                      context, 'LogIn_password_textFiled_hint'),
                                  controller: passwordController,
                                  type: TextInputType.visiblePassword,
                                  onSubmit: (value) {
                                    if (formKey.currentState!.validate()) {
                                      UserCubit.get(context).logInCubit(
                                        email: emailController.text,
                                        password: passwordController.text,
                                      );
                                    }
                                  },
                                  isPassword: UserCubit.get(context).isPassword,
                                  validate: (value) {
                                    if (value!.isEmpty) {
                                      return getTranslated(context,
                                          'LogIn_password_controller_validate_isEmpty');
                                    }
                                  },
                                  prefix: Icons.lock_outline,
                                  textInputAction: TextInputAction.done,
                                  suffix: UserCubit.get(context).suffix,
                                  suffixPressed: () {
                                    UserCubit.get(context)
                                        .changePasswordVisibility();
                                  },
                                  inputBorder: const UnderlineInputBorder(),
                                ),
                              ),
                              const SizedBox(height: 30),
                              (state is! LogInLoadingState)
                                  ? AdaptiveButton(
                                      os: getOs(),
                                      background: defaultColor,
                                      function: () {
                                        if (formKey.currentState!.validate()) {
                                          UserCubit.get(context).logInCubit(
                                            email: emailController.text,
                                            password: passwordController.text,
                                          );
                                        }
                                      },
                                      text: getTranslated(
                                          context, 'LogIn_button_text'),
                                      isUpperCase: true,
                                      radius: 20,
                                    )
                                  : const Center(
                                      child: CircularProgressIndicator()),
                              const SizedBox(height: 23),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    getTranslated(
                                        context, 'LogIn_text_register'),
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText1!
                                        .copyWith(
                                          color: Colors.grey,
                                        ),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      navigateTo(context, RegisterScreen());
                                    },
                                    child: Text(
                                      getTranslated(context,
                                          'LogIn_text_button_register'),
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1!
                                          .copyWith(
                                            color: Colors.blue,
                                          ),
                                    ),
                                  )
                                ],
                              ),
                              const SizedBox(height: 20),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
          );
        },
      ),
    );
  }
}
