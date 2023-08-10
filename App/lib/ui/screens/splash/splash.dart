import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taskmanager/ui/screens/auth/login_screen.dart';
import 'package:taskmanager/ui/screens/home/hoem_screen.dart';


class SlpashScreen extends StatefulWidget {
  const SlpashScreen({Key? key}) : super(key: key);

  @override
  State<SlpashScreen> createState() => _SlpashScreenState();
}
class _SlpashScreenState extends State<SlpashScreen> {
  Future Delay() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? Username = prefs.getString('Task_Manager_Username');

    if(Username !=null) {
      await new Future.delayed(const Duration(seconds: 5));
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => HomeScreen()));
    } else {
      await new Future.delayed(const Duration(seconds: 5));
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => LoginScreen()));
    }
  }

  @override
  void initState(){
    super.initState();
    Delay();
  }
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal,
      body: Center(
        child: Text(
          "Text Manager",
          style: TextStyle(
            color: Colors.white,
            fontSize: 25,
            fontWeight: FontWeight.bold,
            fontFamily: 'Cairo',
        ),
        ),
      ),
    );
  }
}
