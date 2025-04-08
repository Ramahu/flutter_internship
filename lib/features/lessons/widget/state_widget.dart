import 'package:flutter/material.dart';

import '../../../core/util/colors.dart';

Widget loadingWidget() => const Center(
        child: CircularProgressIndicator(
      color: defaultBlue2,
    ));

Widget errorWidget(errorMsg) => Center(child: Text('Error: $errorMsg'));
