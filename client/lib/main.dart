import 'package:dishcover_client/core/app.dart';
import 'package:dishcover_client/core/bloc_providers.dart';
import 'package:dishcover_client/core/repository_providers.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    const RepositoryProviders(
      child: BlocProviders(
        child: App(),
      ),
    ),
  );
}
