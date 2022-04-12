import 'package:flutter/material.dart';
import 'package:labtour/cubit/auth_cubit.dart';
import 'package:labtour/cubit/location_cubit.dart';
import 'package:labtour/cubit/obsecure_cubit.dart';
import 'package:labtour/cubit/page_cubit.dart';
import 'package:labtour/shared/theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ignore: must_be_immutable
class SignUpPage extends StatelessWidget {
  TextEditingController nameController = TextEditingController(text: '');
  TextEditingController usernameController = TextEditingController(text: '');
  TextEditingController emailController = TextEditingController(text: '');
  TextEditingController passwordController = TextEditingController(text: '');

  @override
  Widget build(BuildContext context) {
    var state = context.watch<ObsecureCubit>().state;

    void showError(String message) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: red,
          content: Text(
            message,
            textAlign: TextAlign.center,
          ),
        ),
      );
    }

    handleRegister() async {
      if (emailController.text.isEmpty &&
          passwordController.text.isEmpty &&
          nameController.text.isEmpty &&
          usernameController.text.isEmpty) {
        showError("Semua Field harus diisi");
      } else if (emailController.text.isEmpty) {
        showError("Email harus diisi");
      } else if (passwordController.text.isEmpty) {
        showError("Password harus diisi");
      } else if (nameController.text.isEmpty) {
        showError("Nama harus diisi");
      } else if (usernameController.text.isEmpty) {
        showError("Username harus diisi");
      } else if (passwordController.text.length < 8) {
        showError("Password minimal 8 angka atau huruf");
      } else {
        await context.read<LocationCubit>().getInitCity();
        await context.read<AuthCubit>().register(
              name: nameController.text,
              username: usernameController.text,
              email: emailController.text,
              password: passwordController.text,
            );
      }
    }

    Widget header() {
      return Container(
        margin: EdgeInsets.fromLTRB(24, 60, 24, 0),
        child: Center(
          child: Column(
            children: [
              Image.asset(
                'assets/image_auth.png',
                width: 200,
                height: 165,
              ),
              SizedBox(height: 40),
              Text(
                'Selamat Datang',
                style:
                    blackTextStyle.copyWith(fontSize: 24, fontWeight: medium),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'di ',
                    style: blackTextStyle.copyWith(
                        fontSize: 24, fontWeight: medium),
                  ),
                  Text(
                    'Labtour',
                    style: blueTextStyle.copyWith(
                        fontSize: 24, fontWeight: medium),
                  ),
                ],
              )
            ],
          ),
        ),
      );
    }

    Widget form() {
      Widget nameForm() {
        return Container(
          height: 55,
          width: double.infinity,
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
              color: greylight, borderRadius: BorderRadius.circular(10)),
          child: TextFormField(
            controller: nameController,
            decoration: InputDecoration.collapsed(
                hintText: 'Nama',
                hintStyle:
                    grey2TextStyle.copyWith(fontSize: 14, fontWeight: medium)),
          ),
        );
      }

      Widget usernameForm() {
        return Container(
          height: 55,
          width: double.infinity,
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
              color: greylight, borderRadius: BorderRadius.circular(10)),
          child: TextFormField(
            controller: usernameController,
            decoration: InputDecoration.collapsed(
                hintText: 'Username',
                hintStyle:
                    grey2TextStyle.copyWith(fontSize: 14, fontWeight: medium)),
          ),
        );
      }

      Widget emailForm() {
        return Container(
          height: 55,
          width: double.infinity,
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
              color: greylight, borderRadius: BorderRadius.circular(10)),
          child: TextFormField(
            controller: emailController,
            decoration: InputDecoration.collapsed(
                hintText: 'Email',
                hintStyle:
                    grey2TextStyle.copyWith(fontSize: 14, fontWeight: medium)),
          ),
        );
      }

      Widget passwordForm() {
        return Container(
          height: 55,
          width: double.infinity,
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
              color: greylight, borderRadius: BorderRadius.circular(10)),
          child: Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: passwordController,
                  obscureText: state,
                  decoration: InputDecoration.collapsed(
                      hintText: 'Password',
                      hintStyle: grey2TextStyle.copyWith(
                          fontSize: 14, fontWeight: medium)),
                ),
              ),
              IconButton(
                  icon: Icon(state
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined),
                  onPressed: () {
                    context.read<ObsecureCubit>().setView(!state);
                  }),
            ],
          ),
        );
      }

      return Container(
        margin: EdgeInsets.fromLTRB(24, 50, 24, 0),
        child: Column(
          children: [
            nameForm(),
            SizedBox(height: 24),
            usernameForm(),
            SizedBox(height: 24),
            emailForm(),
            SizedBox(height: 24),
            passwordForm(),
          ],
        ),
      );
    }

    Widget button() {
      return BlocConsumer<AuthCubit, AuthState>(
        listener: (context, auth) {
          if (auth is AuthSuccess) {
            context.read<PageCubit>().setPage(0);
            Navigator.pushNamedAndRemoveUntil(
                context, '/main', (route) => false);
          } else if (auth is AuthFailed) {
            showError(auth.error);
          }
        },
        builder: (context, auth) {
          return BlocBuilder<LocationCubit, String>(
            builder: (context, location) {
              if (location == "loading" || auth is AuthLoading) {
                return Center(
                  child: Container(
                      margin: EdgeInsets.fromLTRB(
                          24, MediaQuery.of(context).size.height * 0.08, 24, 0),
                      child: CircularProgressIndicator()),
                );
              }

              return GestureDetector(
                onTap: () async {
                  await handleRegister();
                },
                behavior: HitTestBehavior.translucent,
                child: Container(
                  margin: EdgeInsets.fromLTRB(
                      24, MediaQuery.of(context).size.height * 0.08, 24, 0),
                  height: 55,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: blue, borderRadius: BorderRadius.circular(10)),
                  child: Center(
                    child: Text(
                      "Daftar",
                      style: whiteTextStyle.copyWith(fontSize: 16),
                    ),
                  ),
                ),
              );
            },
          );
        },
      );
    }

    Widget daftar() {
      return Container(
        margin: EdgeInsets.only(top: 24, bottom: 24),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Sudah Punya akun? ',
                style:
                    blackTextStyle.copyWith(fontSize: 14, fontWeight: medium)),
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              behavior: HitTestBehavior.translucent,
              child: Text('Masuk',
                  style:
                      blueTextStyle.copyWith(fontSize: 14, fontWeight: medium)),
            ),
          ],
        ),
      );
    }

    return Scaffold(
        body: ListView(
      children: [
        header(),
        form(),
        button(),
        daftar(),
      ],
    ));
  }
}
