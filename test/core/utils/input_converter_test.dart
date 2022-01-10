import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:franks_invoice_tool/core/util/input_converter.dart';

void main() {
  late InputConverter inputConverter;
  String inputPositivInteger = '123';
  setUp(() {
    inputConverter = InputConverter();
  });
  test('should return an integer when the input string contains only numbers', () async {
    // Arrange

    // Act
    final result = inputConverter.convertStringToUnsignedInt(inputPositivInteger);
    // Assert
    expect(result, const Right(123));
  });
  test('should return a InvalidInputFailure when the string contains a negativeNumber', () async {
    // Arrange

    // Act
    final result = inputConverter.convertStringToUnsignedInt('-123');
    // Assert
    expect(result, Left(InvalidInputFailure()));
  });

  test('should return an InvalidInputFailure when the string does not contain a pure number', () async {
    // Arrange
    // Act
    final result = inputConverter.convertStringToUnsignedInt('.=+12314aawavb');
    // Assert
    expect(result, Left(InvalidInputFailure()));
  });
}
