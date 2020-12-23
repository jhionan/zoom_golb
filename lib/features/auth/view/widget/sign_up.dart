import 'package:flutter/material.dart';
import 'package:zoom_golb/core/theme/app_colors.dart';

class SignUp extends StatelessWidget {
  final Function submit;

  const SignUp({Key key, this.submit}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.6,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
          color: AppColors.accent),
      child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Usuário não cadastrado! Deseja Cadastrar?',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24,
              ),
            ),
            SizedBox(
              height: 56,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                MaterialButton(
                    child: Text('CANCELAR'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    }),
                MaterialButton(
                    color: AppColors.primary,
                    child: Text(
                      'CONFIRMAR',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                      submit();
                    })
              ],
            )
          ]),
    );
  }
}
