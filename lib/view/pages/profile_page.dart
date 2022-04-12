import 'package:flutter/material.dart';
import 'package:labtour/cubit/auth_cubit.dart';
import 'package:labtour/shared/theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    handleLogout(String token) async {
      await context.read<AuthCubit>().logout(token: token);
      Navigator.pushNamedAndRemoveUntil(context, '/sign-in', (route) => false);
    }

    Widget nama(String nama) {
      return Container(
        margin: EdgeInsets.only(bottom: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Nama",
              style: grey1TextStyle.copyWith(fontSize: 16),
            ),
            SizedBox(height: 8),
            Text(
              nama,
              style: blackTextStyle.copyWith(fontSize: 20, fontWeight: medium),
            )
          ],
        ),
      );
    }

    Widget username(String username) {
      return Container(
        margin: EdgeInsets.only(bottom: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Username",
              style: grey1TextStyle.copyWith(fontSize: 16),
            ),
            SizedBox(height: 8),
            Text(
              username,
              style: blackTextStyle.copyWith(fontSize: 20, fontWeight: medium),
            )
          ],
        ),
      );
    }

    Widget email(String email) {
      return Container(
        margin: EdgeInsets.only(bottom: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Email",
              style: grey1TextStyle.copyWith(fontSize: 16),
            ),
            SizedBox(height: 8),
            Text(
              email,
              style: blackTextStyle.copyWith(fontSize: 20, fontWeight: medium),
            )
          ],
        ),
      );
    }

    Widget button(String token) {
      return BlocBuilder<AuthCubit, AuthState>(
        builder: (context, state) {
          if (state is AuthLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          return GestureDetector(
            onTap: () async {
              await handleLogout(token);
            },
            child: Center(
              child: Container(
                padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
                decoration: BoxDecoration(
                    color: redlight, borderRadius: BorderRadius.circular(5)),
                child: Text(
                  "Keluar",
                  style:
                      redTextStyle.copyWith(fontSize: 16, fontWeight: medium),
                ),
              ),
            ),
          );
        },
      );
    }

    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        if (state is AuthSuccess) {
          return Container(
            margin: EdgeInsets.fromLTRB(24, 40, 24, 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 80,
                        backgroundImage: NetworkImage(state.user.image),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 40),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    nama(state.user.name),
                    username(state.user.username),
                    email(state.user.email),
                  ],
                ),
                Spacer(),
                button(state.user.token),
              ],
            ),
          );
        }

        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
