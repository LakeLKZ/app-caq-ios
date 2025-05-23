import 'package:colegio_abogados_app/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';


void main() {
  testWidgets('App smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MyApp());

    // Verificar que la aplicación se renderiza correctamente
    expect(find.byType(MaterialApp), findsOneWidget);
    
    // No realizamos más pruebas por ahora, solo verificamos
    // que la aplicación se construya sin errores
  });
}