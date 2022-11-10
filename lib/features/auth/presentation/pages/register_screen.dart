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
import '../../../product/presentation/pages/home_page.dart';
import '../cubit/user_cubit.dart';
import 'login_screen.dart';
import '../../../../core/injection_container.dart' as di;

class RegisterScreen extends StatelessWidget {
  final formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();

  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  final confirmPasswordController = TextEditingController();

  RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => di.sl<UserCubit>(),
      child: BlocConsumer<UserCubit, UserState>(
        listener: (context, state) {
          ///ToDO: chang it
          /*      if (state is SignUpErrorState) {
            showToast(
              text: state.error,
              state: ToastStates.error,
            );
          }*/
          if (state is SignUpErrorState) {
            showToast(
              text: state.error,
              state: ToastStates.error,
            );
          }
          if (state is SignUpSuccessState) {
            navigateAndFinish(context, const HomePage());
          }
        },
        builder: (context, state) {
          UserCubit userCubit = UserCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
            ),
            body: state is SignUpLoadingState
                ? Center(
                    child: AdaptiveIndicator(
                    os: getOs(),
                  ))
                : SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Form(
                        key: formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              getTranslated(context, 'Add_user_title'),
                              style: Theme.of(context)
                                  .textTheme
                                  .headline4!
                                  .copyWith(
                                    color: Colors.black,
                                  ),
                            ),
                            const SizedBox(
                              height: 25,
                            ),
                            AdaptiveTextField(
                              os: getOs(),
                              label:
                                  getTranslated(context, 'Add_user_label_name'),
                              controller: nameController,
                              type: TextInputType.name,
                              textInputAction: TextInputAction.next,
                              validate: (value) {
                                if (value!.isEmpty) {
                                  return getTranslated(
                                      context, 'Add_user_validate_name');
                                }
                              },
                              prefix: Icons.person,
                              inputBorder: const UnderlineInputBorder(),
                              boxDecoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                  color: defaultColor,
                                  width: 1,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 15.0,
                            ),
                            AdaptiveTextField(
                              os: getOs(),
                              label: getTranslated(
                                  context, 'Add_user_label_email'),
                              controller: emailController,
                              type: TextInputType.emailAddress,
                              textInputAction: TextInputAction.next,
                              validate: (value) {
                                if (value!.isEmpty) {
                                  return getTranslated(
                                      context, 'Add_user_validate_email');
                                }
                              },
                              prefix: Icons.email,
                              inputBorder: const UnderlineInputBorder(),
                              boxDecoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                  color: defaultColor,
                                  width: 1,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 15.0,
                            ),
                            AdaptiveTextField(
                              os: getOs(),
                              label: getTranslated(
                                  context, 'Add_user_label_password'),
                              controller: passwordController,
                              type: TextInputType.visiblePassword,
                              textInputAction: TextInputAction.next,
                              validate: (value) {
                                if (value!.isEmpty) {
                                  return getTranslated(
                                      context, 'Add_user_validate_password');
                                }
                                if (value.length < 4) {
                                  return getTranslated(context,
                                      'add_user_password_controller_validate_isWeek');
                                }
                              },
                              prefix: Icons.lock_outline,
                              inputBorder: const UnderlineInputBorder(),
                              boxDecoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                  color: defaultColor,
                                  width: 1,
                                ),
                              ),
                              suffix: userCubit.suffix,
                              suffixPressed: () {
                                userCubit.changePasswordVisibility();
                              },
                              isPassword: userCubit.isPassword,
                            ),
                            const SizedBox(
                              height: 15.0,
                            ),
                            AdaptiveTextField(
                              os: getOs(),
                              label: getTranslated(
                                  context, 'Add_user_label_confirmPassword'),
                              controller: confirmPasswordController,
                              type: TextInputType.visiblePassword,
                              textInputAction: TextInputAction.done,
                              validate: (value) {
                                if (value!.isEmpty) {
                                  return getTranslated(context,
                                      'Add_user_validate_confirmPassword');
                                }
                              },
                              prefix: Icons.lock_outline,
                              inputBorder: const UnderlineInputBorder(),
                              boxDecoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                  color: defaultColor,
                                  width: 1,
                                ),
                              ),
                              suffix: userCubit.suffix,
                              suffixPressed: () {
                                userCubit.changePasswordVisibility();
                              },
                              isPassword: userCubit.isPassword,
                            ),
                            const SizedBox(
                              height: 30.0,
                            ),
                            state is! SignUpLoadingState ||
                                    state is SignUpErrorState
                                ? AdaptiveButton(
                                    radius: 20,
                                    function: () {
                                      if (formKey.currentState!.validate()) {
                                        if (passwordController.text ==
                                            confirmPasswordController.text) {
                                          userCubit.signUpCubit(
                                            name: nameController.text,
                                            email: emailController.text,
                                            password: passwordController.text
                                                .toString(),
                                          );
                                        } else {
                                          showToast(
                                              text: getTranslated(context,
                                                  "Add_user_showToast_error"),
                                              state: ToastStates.error);
                                        }
                                        // navigateTo(context,ProductsScreen());
                                      }
                                    },
                                    text: getTranslated(
                                        context, 'Add_user_text_button'),
                                    isUpperCase: true,
                                    background: defaultColor,
                                    os: getOs(),
                                  )
                                : const Center(
                                    child: CircularProgressIndicator()),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    height: 1,
                                    color: Colors.grey,
                                  ),
                                ),
                                Text(
                                  getTranslated(context, 'LogIn_text_or'),
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .copyWith(
                                        color: Colors.grey,
                                      ),
                                ),
                                Expanded(
                                  child: Container(
                                    height: 1,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                            /*SizedBox()(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                InkWell(
                                  onTap: () {
                                    userCubit
                                        .signInWithFacebook(context);
                                  },
                                  child: Container(
                                    height: 50,
                                    width: 90,
                                    decoration: BoxDecoration(
                                      image: const DecorationImage(
                                          image: AssetImage(
                                              'assets/images/facebook.png')),
                                      borderRadius:
                                          const BorderRadius.all(Radius.circular(15)),
                                      border: Border.all(
                                        color: Colors.grey.withOpacity(0.5),
                                        width: 0.5,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox()(width: 25),
                                InkWell(
                                  onTap: () {
                                    userCubit.signInWithGoogle(
                                        context: context);
                                  },
                                  child: Container(
                                    height: 50,
                                    width: 90,
                                    decoration: BoxDecoration(
                                      image: const DecorationImage(
                                          image: AssetImage(
                                              'assets/images/gmail.png')),
                                      borderRadius:
                                          const BorderRadius.all( Radius.circular(15)),
                                      border: Border.all(
                                        color: Colors.grey.withOpacity(0.5),
                                        width: 0.5,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),*/
                            const SizedBox(height: 23),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  getTranslated(
                                      context, 'Add_user_text_register'),
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
                                    navigateTo(context, LoginScreen());
                                  },
                                  child: Text(
                                    getTranslated(context,
                                        'Add_user_text_button_register'),
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
                          ],
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

//enum addUserType { user, supervisor, admin }
