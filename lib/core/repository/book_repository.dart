import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_interview_questions/core/interface/i_book_repository.dart';

class BookRepository extends IBookRepository {
  @override
  Future<ListResult> fetchBooks(List<String> path) async {
    for (var p in path) {
      await FirebaseStorage.instance.ref(p).listAll();
    }
    //final futureFiles = FirebaseStorage.instance.ref(path).listAll();

    // final url = await ref.getDownloadURL();

    // final temp = await getTemporaryDirectory();
    // final path = '${temp.path}/${ref.name}';

    //! for a file
    //! if (await existsFile(path)) return;

    // final response = await Dio().download(
    //   url,
    //   path,
    // onReceiveProgress: (count, total) {
    //   double progress = count / total;
    //   setState(() => _downloadProgress[index] = progress);
    // },
    // );
    return futureFiles;
    //!.whenComplete(() => setState(() => _isCompleted = true));
  }
}
