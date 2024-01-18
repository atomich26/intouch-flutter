import 'package:flutter/material.dart';
import 'package:intouch/intouch_widgets/comment_box.dart';
import 'package:intouch/models/comment.dart';
import 'package:intouch/models/post.dart';
import 'package:intouch/services/database.dart';
import 'package:intouch/services/firebase_storage.dart';

class PostPage extends StatelessWidget {
  PostPage({
    super.key,
    required this.post});

    Post post;
    final StorageService _storage =StorageService();
    final PostDatabaseService _postDatabaseService = PostDatabaseService();
    TextEditingController controller = TextEditingController();

    @override
    void dispose() {
    controller.dispose();
  }
  @override
  Widget build(BuildContext context) {
    
    Future<List<Comment>?>? _comments = _postDatabaseService.getCommentOfPost(post.id) ;
    List<Future<String>> imageUrl = List.generate(post.album!.length, (e) => _storage.getPostImageUrl(post.album![e]));
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        PageView.builder(
        itemBuilder: (context, i){
          return FutureBuilder<String>(
            future: imageUrl[i],
            builder: (context, snapshot) {
              return SafeArea(
                child: Container(
                  decoration: snapshot.hasData? 
                  BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(snapshot.data!) ,
                      fit: BoxFit.cover
                      )
                    ) : 
                  const BoxDecoration( color:Colors.black),
                  ),
              );
            }
          );
        },
        itemCount: post.album!.length,),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: FloatingActionButton(
            
            child: Icon(Icons.comment),
            onPressed: (){
              showModalBottomSheet(
                context: context, 
                builder: (context){
                  return Scaffold(
                    resizeToAvoidBottomInset: true,
                    body: FutureBuilder(
                      future: _comments!, 
                      builder: (context, comments){
                        if(comments.hasData){
                          if(comments.data!.isEmpty){
                            return SizedBox(width: double.infinity);
                          } else {
                            return ListView.builder(
                              itemCount: comments.data!.length,
                              itemBuilder: ((context, i){
                                return CommentBox(comment: comments.data![i]);

                              }));
                          }
                        } else return SizedBox();
                      }),
                  bottomNavigationBar: Padding(
                    padding: EdgeInsets.fromLTRB(12.0, 0, 12.0, MediaQuery.of(context).viewInsets.bottom + 12.0),
                    child: TextFormField(
                      controller: controller,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.message),
                        suffixIcon: IconButton(
                          icon: Icon(Icons.arrow_forward),
                          onPressed: (){print(controller.text);},)
                      ),
                    ),
                  ),
                );
                }
              );
            }
          ),
        )
      ],
    );
  }
}