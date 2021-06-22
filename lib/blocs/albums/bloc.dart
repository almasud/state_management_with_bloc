import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:state_management_bloc/api/exceptions.dart';
import 'package:state_management_bloc/api/services.dart';
import 'package:state_management_bloc/blocs/albums/events.dart';
import 'package:state_management_bloc/blocs/albums/states.dart';
import 'package:state_management_bloc/models/album.dart';

class AlbumbsBloc extends Bloc<AlbumsEvent, AlbumsState> {
  final AlbumsRepo albumsRepo;
  List<Album> albums = [];

  AlbumbsBloc({required this.albumsRepo}) : super(AlbumsInitialState());

  @override
  Stream<AlbumsState> mapEventToState(AlbumsEvent event) async* {
    switch (event) {
      case AlbumsEvent.fetchAlbums:
        yield AlbumsLoadingState();
        try {
          albums = await albumsRepo.getAlbums();
          yield AlbumsLoadedState(albums: albums);
        } on SocketException {
          yield AlbumsLoadingErrorState(
              error: NoInternetException("No internet!")
          );
        } on HttpException {
          yield AlbumsLoadingErrorState(
              error: NoServiceException("No service found!")
          );
        } on FormatException {
          yield AlbumsLoadingErrorState(
              error: InvalidFormatException("The response format is invalid!")
          );
        } catch (e) {
          yield AlbumsLoadingErrorState(
              error: UnknownException("Unknown error!")
          );
        }
        break;
    }
  }
}
