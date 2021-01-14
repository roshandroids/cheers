import 'package:cheers/bloc/auth/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocProvider(
        create: (context) => AuthBloc(),
        child: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state is AuthInitial) {
              return Center(
                child: RaisedButton(
                  onPressed: () {
                    BlocProvider.of<AuthBloc>(context).add(
                      AuthLoginEvent(
                          password: "jhagdhja", username: "ajhsdgahjs"),
                    );
                  },
                  child: Text("Click Me"),
                ),
              );
            } else if (state is AuthLoadingState) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is AuthLoggedInState) {
              return Center(
                child: Text("Welcome"),
              );
            } else if (state is AuthErrorState) {
              return Center(
                child: Text("Error"),
              );
            } else {
              return Center(
                child: Text("We broke something...."),
              );
            }
          },
        ),
      ),
    );
  }
}
