import 'package:http/http.dart';
import 'package:state_management_bloc/models/album.dart';

abstract class AlbumsRepo {
  Future<List<Album>> getAlbums();
}

class AlbumsService extends AlbumsRepo {
  static const String _BASE_URL = "jsonplaceholder.typicode.com";
  static const String _ALBUMS_URL = "/albums";

  @override
  Future<List<Album>> getAlbums() async {
    Uri url = Uri.https(_BASE_URL, _ALBUMS_URL);
    Response response = await get(url);
    List<Album> albums = albumFromJson(response.body);
    return albums;
  }
}
