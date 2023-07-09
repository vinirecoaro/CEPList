import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:listacep/pages/cep_list_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          primarySwatch: Colors.blue, textTheme: GoogleFonts.robotoTextTheme()),
      debugShowCheckedModeBanner: false,
      home: const CepListPage(),
    );
  }
}
