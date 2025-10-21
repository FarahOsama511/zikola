import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../main.dart';
import '../../bussines logic/login_cubit.dart';
import '../../bussines logic/login_state.dart';

class SimpleLoginTest extends StatefulWidget {
  @override
  _SimpleLoginTestState createState() => _SimpleLoginTestState();
}

class _SimpleLoginTestState extends State<SimpleLoginTest> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void testLogin() async {
    await context.read<LoginCubit>().login(
          usernameController.text,
          passwordController.text,
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Test Login")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: usernameController,
              decoration: InputDecoration(labelText: "Username"),
            ),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(labelText: "Password"),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: testLogin,
              child: Text("Login"),
            ),
            const SizedBox(height: 20),
            BlocBuilder<LoginCubit, LoginState>(
              builder: (context, state) {
                if (state is LoadingLoginState) {
                  return Text("Loading...");
                } else if (state is SuccessLoginState) {
                  return Text("Success: ");
                } else if (state is ErrorLoginState) {
                  
                logger.d("Login error: ${state.error.message}");
              
                }
                return Text("Enter credentials to login");
              },
            ),
          ],
        ),
      ),
    );
  }
}


