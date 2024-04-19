// Copyright (c) 2023, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:dio/dio.dart';
import 'package:fetch_client/fetch_client.dart';
// ignore: implementation_imports
import 'package:native_dio_adapter/src/conversion_layer_adapter.dart';

HttpClientAdapter getNativeAdapter({bool? cronetHttp2}) =>
    ConversionLayerAdapter(FetchClient(mode: RequestMode.cors));
