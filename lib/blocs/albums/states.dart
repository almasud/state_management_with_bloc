import 'package:equatable/equatable.dart';
import 'package:state_management_bloc/models/album.dart';

abstract class AlbumsState extends Equatable {
  @override
  List<Object?> get props => [];
}

class AlbumsInitialState extends AlbumsState {}

class AlbumsLoadingState extends AlbumsState {}

class AlbumsLoadedState extends AlbumsState {
  final List<Album> albums;

  AlbumsLoadedState({required this.albums});
}

class AlbumsLoadingErrorState extends AlbumsState {
  final error;

  AlbumsLoadingErrorState({this.error});
}
