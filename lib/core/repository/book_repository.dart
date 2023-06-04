import 'package:dio/dio.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_interview_questions/core/interface/i_book_repository.dart';
import 'package:path_provider/path_provider.dart';

class BookRepository extends IBookRepository {
  @override
  Future downloadBook(int index, Reference ref) async {
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
