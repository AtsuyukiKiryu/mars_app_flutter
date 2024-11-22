import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'providers.dart';
import 'photo.dart';

class PhotoListPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final photosAsync = ref.watch(photosProvider);

return Scaffold(
  appBar: AppBar(
    title: Center(child: Text('Mars Photos',textAlign: TextAlign.center,)),
    
  ),
  body: photosAsync.when(
    data: (photos) => GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // 列の数を2に設定
        crossAxisSpacing: 8.0, // 列間のスペース
        mainAxisSpacing: 8.0, // 行間のスペース
        childAspectRatio: 16/11, // 子要素のアスペクト比 (正方形)
      ),
      padding: const EdgeInsets.all(8.0), // グリッド全体のパディング
      itemCount: photos.length,
      itemBuilder: (context, index) {
        final photo = photos[index];
        return GridTile(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12.0), // 角を丸くする
                  child: Image.network(
                    photo.imgSrc,
                    fit: BoxFit.cover, // 画像をボックス内に収める
                  ),
                ),
              ),
              SizedBox(height: 4.0),
            ],
          ),
        );
      },
    ),
    loading: () => Center(child: CircularProgressIndicator()),
    error: (err, stack) => Center(child: Text('Error: $err')),
  ),
);
  }
}
