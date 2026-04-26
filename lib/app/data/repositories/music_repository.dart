import 'dart:collection';

import 'package:music_player/app/data/models/music.dart';
import 'package:music_player/app/data/models/album.dart';
import 'package:music_player/app/data/models/playlist.dart';

int i = 1; //Replace later for real IDs

class ProductsRepository {
  final List<Music> _musics = [];
  final List<Album> _albums = [];
  final List<Playlist> _playlists = [];

  UnmodifiableListView<Music> get musics => UnmodifiableListView(_musics);
  UnmodifiableListView<Album> get albums => UnmodifiableListView(_albums);
  UnmodifiableListView<Playlist> get playlists => UnmodifiableListView(_playlists);

  Future<List<Music>> loadSongs() async {
    await Future.delayed(Duration(seconds: 2));
    return musics;
  }

  Future<List<Album>> loadAlbums() async {
    await Future.delayed(Duration(seconds: 2));
    return albums;
  }

  Future<List<Playlist>> loadPlayLists() async {
    await Future.delayed(Duration(seconds: 2));
    return playlists;
  }

  void createPlaylist(String name) {
    _playlists.add(
      Playlist(
        id: i,
        name: name,
        coverUrl: "",
        musicList: [],
      ),
    );
    i=i+1;
  }

  ///////////////////////////////////////////////////////
  Future<void> addProduct(String productName) async {
    await Future.delayed(Duration(seconds: 2));
    _productsList.add(
      Product(title: productName),
    );
  }

  Future<List<Product>> loadProducts() async {
    await Future.delayed(Duration(seconds: 2));
    return products;
  }

  void toggleCartItem(Product product) {
    int productIndex = _cartItems.indexWhere(
      (item) => item.product.title == product.title,
    );
    if (productIndex >= 0) {
      _cartItems.removeAt(productIndex);
      return;
    }
    _cartItems.add(CartItem(product: product, amount: 1));
  }

  void _changeAmount(CartItem cartItem, int amount) {
    final index = cartItems.indexWhere(
      (item) => item.product.title == cartItem.product.title,
    );
    _cartItems[index] = CartItem(product: cartItem.product, amount: amount);
  }

  void increase(CartItem cartItem) {
    final amount = cartItem.amount + 1;
    _changeAmount(cartItem, amount);
  }

  void decrease(CartItem cartItem) {
    final amount = (cartItem.amount == 0) ? 0 : cartItem.amount - 1;
    _changeAmount(cartItem, amount);
  }
}
}
