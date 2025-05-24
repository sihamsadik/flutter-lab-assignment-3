import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import 'presentation/blocs/album_bloc.dart';
import 'data/repositories/album_repository.dart';
import 'app/router.dart'; // Make sure you created this router file

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final AlbumRepository albumRepository = AlbumRepository();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AlbumBloc>(
          create: (_) => AlbumBloc(albumRepository)..add(FetchAlbums()),
        ),
      ],
      child: MaterialApp.router(
        title: 'Album Viewer',
        routerConfig: router,
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: const Color(0xFF1E2A38), // light blue-black
          // cardColor: const Color(0xFF2C3E50), // lighter blue-black for blocks
          textTheme: ThemeData.dark().textTheme.apply(
            bodyColor: Colors.white,
            displayColor: Colors.white70,
          ),
          appBarTheme: const AppBarTheme(
            backgroundColor: Color(0xFF2C3E50),
            titleTextStyle: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
            iconTheme: IconThemeData(color: Colors.white),
          ),
          listTileTheme: const ListTileThemeData(
            tileColor: Color(0xFF2C3E50), // block background
            textColor: Colors.white,
            iconColor: Colors.white70,
          ),
        ),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
