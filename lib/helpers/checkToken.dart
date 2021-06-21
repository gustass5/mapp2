import 'package:mapp2/router/router_state.dart';

import 'package:jwt_decode/jwt_decode.dart';

void checkToken(String token, RouterState routerState) {
  if (token == null) {
    routerState.navigationIndex = null;
    return;
  }

  if (DateTime.now().isAfter(Jwt.getExpiryDate(token))) {
    routerState.navigationIndex = null;
  }
}
