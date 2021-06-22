import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:state_management_bloc/api/services.dart';
import 'package:state_management_bloc/blocs/albums/bloc.dart';
import 'package:state_management_bloc/screens/albums_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'A Flutter project on state management with BLOC',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: BlocProvider(
        create: (context) => AlbumbsBloc(albumsRepo: AlbumsService()),
        child: AlbumsScreen(),
      ),
    );
  }
}
