import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:itsallwidgets_podcast/network/base_response.dart';
import 'package:itsallwidgets_podcast/ui/custom/author_span_widget.dart';
import 'package:itsallwidgets_podcast/ui/custom/title_widget.dart';
import 'package:provider/provider.dart';

import 'list_item_view.dart';
import 'list_store.dart';

class PodCastList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final store = Provider.of<ListStore>(context);
    return SafeArea(
      child: Scaffold(
        body: Observer(
          builder: (context) {
            switch (store.response!.status) {
              case Status.LOADING:
                return Center(child: CircularProgressIndicator());
              case Status.COMPLETED:
                return SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      TitleWidget(title: store.response!.data!.feed!.title),
                      Container(
                        color: Colors.blue,
                        height: 3,
                        width: 50,
                        margin:
                            EdgeInsets.only(left: 16, right: 16, bottom: 16),
                      ),
                      AuthorSpanWidget(
                        authorText: store.response!.data!.feed!.author,
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 16, right: 16, bottom: 8),
                        child: Text(
                          store.response!.data!.feed!.description!,
                          style: TextStyle(fontSize: 16.0),
                        ),
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return ListItemView(
                            item: store.response!.data!.items![index],
                            feed: store.response!.data!.feed,
                          );
                        },
                        itemCount: store.response!.data!.items!.length,
                      ),
                    ],
                  ),
                );
              case Status.ERROR:
                return Center(child: Text('${store.response!.message}'));
              default:
                return Center(child: Text('${store.response!.message}'));
            }
          },
        ),
      ),
    );
  }
}
