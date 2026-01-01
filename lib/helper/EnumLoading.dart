import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

enum LoadingStatus{
  LOADING,
  SUCCESS,
  FAILURE
}

dynamic p_Listeneress<T>(BuildContext context) {
  return Provider.of<T>(context, listen: false);
}
dynamic p_Listener<T>(BuildContext context) {
  return Provider.of<T>(context, listen: true);
}
