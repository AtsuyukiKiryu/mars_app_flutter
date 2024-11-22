import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'photo_model.dart';
import 'photo_notifier.dart';
import 'photo_repository.dart';

class PhotoListScreen extends ConsumerStatefulWidget {
  const PhotoListScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<PhotoListScreen> createState() => _PhotoListScreenState();
}

class _PhotoListScreenState extends ConsumerState<PhotoListScreen> {
  final PagingController<int, PhotoModel> _pagingController =
      PagingController(firstPageKey: 1);

  @override
  void initState() {
    super.initState();
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPhotos(pageKey);
    });
  }

  Future<void> _fetchPhotos(int pageKey) async {
    try {
      final repository = ref.read(photoRepositoryProvider);
      final photos = await repository.fetchPhotos(pageKey, 20);
      final isLastPage = photos.length < 20;
      if (isLastPage) {
        _pagingController.appendLastPage(photos);
      } else {
        _pagingController.appendPage(photos, pageKey + 1);
      }
    } catch (e) {
      _pagingController.error = e;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Mars Photos')),
      body: 
       PagedGridView<int, PhotoModel>(
        pagingController: _pagingController,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 8.0,
          mainAxisSpacing: 8.0,
          childAspectRatio: 1.0,
        ),
        builderDelegate: PagedChildBuilderDelegate<PhotoModel>(
          itemBuilder: (context, item, index) => Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16.0),
              child: 
              Image.network(
                item.url,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return const Center(child: CircularProgressIndicator());
                },
                errorBuilder: (context, error, stackTrace) =>
                    const Icon(Icons.broken_image),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
