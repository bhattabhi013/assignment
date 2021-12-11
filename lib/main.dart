import 'package:whatsub/bloc/space_screen_blox.dart';
import 'package:whatsub/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(
    Phoenix(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => SpaceScreenBloc(),
        )
      ],
      child: MaterialApp(
        title: 'DogeSpace',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            primaryColor: Colors.black,
            brightness: Brightness.dark,
            visualDensity: VisualDensity.adaptivePlatformDensity,
            iconTheme: IconThemeData(color: Colors.white),
            textTheme: GoogleFonts.montserratTextTheme()),
        home: SplashScreen(),
      ),
    );
  }
}
