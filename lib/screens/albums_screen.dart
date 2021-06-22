import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:state_management_bloc/blocs/albums/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:state_management_bloc/blocs/albums/events.dart';
import 'package:state_management_bloc/blocs/albums/states.dart';
import 'package:state_management_bloc/models/album.dart';
import 'package:state_management_bloc/widgets/error.dart';
import 'package:state_management_bloc/widgets/loading.dart';

class AlbumsScreen extends StatefulWidget {
  const AlbumsScreen({Key? key}) : super(key: key);

  @override
  _AlbumsScreenState createState() => _AlbumsScreenState();
}

class _AlbumsScreenState extends State<AlbumsScreen> {
  @override
  void initState() {
    super.initState();

    _loadingAlbums();
  }

  _loadingAlbums() {
    context.read<AlbumbsBloc>().add(AlbumsEvent.fetchAlbums);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Albums"),
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: BlocBuilder<AlbumbsBloc, AlbumsState>(
                  builder: (BuildContext context, AlbumsState state) {
                    if (state is AlbumsLoadingErrorState) {
                      String message = "${state.error.message}\nTap to retry";
                      return Center(
                        child: ErrorText(
                          message: message, 
                          onPressed: _loadingAlbums,
                        )
                      );
                    } else if (state is AlbumsLoadedState) {
                      List<Album> albums = state.albums;
                      return _albumList(albums);
                    }
                    return Center(
                      child: Loading(),
                    );
              }),
            )
          ],
        ),
      ),
    );
  }

  Widget _albumList(List<Album> albums) {
    return ListView.builder(
        itemCount: albums.length,
        itemBuilder: (BuildContext context, index) {
          Album album = albums[index];
          return Container(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("ID: ${album.id}"),
                Text(
                  album.title,
                  style: TextStyle(fontSize: 20),
                  // Divider(),
                ),
              ],
            ),
          );
        });
  }
}
