import 'package:dio/dio.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_interview_questions/core/interface/i_book_repository.dart';
import 'package:path_provider/path_provider.dart';

class BookRepository extends IBookRepository {
  late Future<ListResult> _futureFiles;
  @override
  Future fetchBooks(Reference ref, String? root) async {
    _futureFiles = FirebaseStorage.instance.ref(root).listAll();

    final futureFiles = await _futureFiles;
    futureFiles.items;

    final url = await ref.getDownloadURL();

    final temp = await getTemporaryDirectory();
    final path = '${temp.path}/${ref.name}';

    //! for a file
    //! if (await existsFile(path)) return;

    final response = await Dio().download(
      url,
      path,
      // onReceiveProgress: (count, total) {
      //   double progress = count / total;
      //   setState(() => _downloadProgress[index] = progress);
      // },
    );
    return response.data;
    //!.whenComplete(() => setState(() => _isCompleted = true));
  }
}
