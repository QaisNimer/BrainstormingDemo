import 'package:flutter/material.dart';
import 'login_screen.dart';
import 'otp_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ResetPasswordScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/login_photo.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Center(
            child: Container(
              padding: EdgeInsets.all(20),
              width: MediaQuery.of(context).size.width * 0.85,
              decoration: BoxDecoration(
                color: Theme.of(context).brightness == Brightness.dark
                    ? Colors.grey[900]
                    : Colors.white,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginScreen()),
                      );
                    },
                    child: Row(
                      children: [
                        Icon(Icons.arrow_back, color: Theme.of(context).brightness == Brightness.dark ? Colors.white70 : Colors.black54),
                        SizedBox(width: 5),
                        RichText(
                          text: TextSpan(
                            text: AppLocalizations.of(context)!.back_to,
                            style: TextStyle(color: Theme.of(context).brightness == Brightness.dark ? Colors.white70 : Colors.black54),
                            children: <TextSpan>[
                              TextSpan(
                                text: " ",
                              ),
                              TextSpan(
                                text: AppLocalizations.of(context)!.login,
                                style: TextStyle(color: Colors.green),
                              ),
                              TextSpan(
                                text: " ",
                              ),
                              TextSpan(
                                text: AppLocalizations.of(context)!.page,
                                style: TextStyle(color: Theme.of(context).brightness == Brightness.dark ? Colors.white70 : Colors.black54),
                              ),
                            ],
                          ),
                        )

                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    AppLocalizations.of(context)!.reset_password,
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    AppLocalizations.of(context)!.enter_your_email_or_phone_and_we_will_send_you_a_link_to_get_back_into_your_account,
                    style: TextStyle(color: Theme.of(context).brightness == Brightness.dark ? Colors.white70 : Colors.black54),
                  ),
                  SizedBox(height: 20),
                  TextField(
                    decoration: InputDecoration(
                      hintText: AppLocalizations.of(context)!.email,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    height: 45,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => OTPScreen(email: 'user@example.com', isSignup: true),),
                        );
                      },
                      child: Text(
                        AppLocalizations.of(context)!.btn_send,
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}