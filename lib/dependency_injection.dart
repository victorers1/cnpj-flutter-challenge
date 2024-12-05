import 'package:cnpj_flutter_challenge/pages/home_store.dart';
import 'package:cnpj_flutter_challenge/services/cnpj_service.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> providers = [
  Provider.value(value: CnpjService()),
  ChangeNotifierProvider(create: (ctx) => HomeStore(ctx.read())),
];
