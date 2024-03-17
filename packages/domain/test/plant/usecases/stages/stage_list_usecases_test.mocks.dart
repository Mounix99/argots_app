// Mocks generated by Mockito 5.4.4 from annotations
// in domain/test/plant/usecases/stages/stage_list_usecases_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;

import 'package:dartz/dartz.dart' as _i2;
import 'package:domain/core/errors/failure.dart' as _i5;
import 'package:domain/core/success_objects/success_object.dart' as _i6;
import 'package:domain/plants/entities/plant_model.dart' as _i7;
import 'package:domain/plants/entities/stage_model.dart' as _i8;
import 'package:domain/plants/repositories/plant_repository.dart' as _i3;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: deprecated_member_use
// ignore_for_file: deprecated_member_use_from_same_package
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeEither_0<L, R> extends _i1.SmartFake implements _i2.Either<L, R> {
  _FakeEither_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [PlantsRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockPlantsRepository extends _i1.Mock implements _i3.PlantsRepository {
  @override
  _i4.Future<_i2.Either<_i5.Failure, _i6.Success>> addPlant({required Map<String, dynamic>? plantData}) =>
      (super.noSuchMethod(
        Invocation.method(
          #addPlant,
          [],
          {#plantData: plantData},
        ),
        returnValue: _i4.Future<_i2.Either<_i5.Failure, _i6.Success>>.value(_FakeEither_0<_i5.Failure, _i6.Success>(
          this,
          Invocation.method(
            #addPlant,
            [],
            {#plantData: plantData},
          ),
        )),
        returnValueForMissingStub:
            _i4.Future<_i2.Either<_i5.Failure, _i6.Success>>.value(_FakeEither_0<_i5.Failure, _i6.Success>(
          this,
          Invocation.method(
            #addPlant,
            [],
            {#plantData: plantData},
          ),
        )),
      ) as _i4.Future<_i2.Either<_i5.Failure, _i6.Success>>);

  @override
  _i4.Future<_i2.Either<_i5.Failure, _i6.Success>> updatePlant({
    required int? plantId,
    required Map<String, dynamic>? plantData,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #updatePlant,
          [],
          {
            #plantId: plantId,
            #plantData: plantData,
          },
        ),
        returnValue: _i4.Future<_i2.Either<_i5.Failure, _i6.Success>>.value(_FakeEither_0<_i5.Failure, _i6.Success>(
          this,
          Invocation.method(
            #updatePlant,
            [],
            {
              #plantId: plantId,
              #plantData: plantData,
            },
          ),
        )),
        returnValueForMissingStub:
            _i4.Future<_i2.Either<_i5.Failure, _i6.Success>>.value(_FakeEither_0<_i5.Failure, _i6.Success>(
          this,
          Invocation.method(
            #updatePlant,
            [],
            {
              #plantId: plantId,
              #plantData: plantData,
            },
          ),
        )),
      ) as _i4.Future<_i2.Either<_i5.Failure, _i6.Success>>);

  @override
  _i4.Future<_i2.Either<_i5.Failure, _i6.Success>> deletePlant({required int? plantId}) => (super.noSuchMethod(
        Invocation.method(
          #deletePlant,
          [],
          {#plantId: plantId},
        ),
        returnValue: _i4.Future<_i2.Either<_i5.Failure, _i6.Success>>.value(_FakeEither_0<_i5.Failure, _i6.Success>(
          this,
          Invocation.method(
            #deletePlant,
            [],
            {#plantId: plantId},
          ),
        )),
        returnValueForMissingStub:
            _i4.Future<_i2.Either<_i5.Failure, _i6.Success>>.value(_FakeEither_0<_i5.Failure, _i6.Success>(
          this,
          Invocation.method(
            #deletePlant,
            [],
            {#plantId: plantId},
          ),
        )),
      ) as _i4.Future<_i2.Either<_i5.Failure, _i6.Success>>);

  @override
  _i4.Future<_i2.Either<_i5.Failure, List<_i7.PlantModel>>> getPlantsCreatedByUser({
    required String? userId,
    required int? page,
    required int? size,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #getPlantsCreatedByUser,
          [],
          {
            #userId: userId,
            #page: page,
            #size: size,
          },
        ),
        returnValue: _i4.Future<_i2.Either<_i5.Failure, List<_i7.PlantModel>>>.value(
            _FakeEither_0<_i5.Failure, List<_i7.PlantModel>>(
          this,
          Invocation.method(
            #getPlantsCreatedByUser,
            [],
            {
              #userId: userId,
              #page: page,
              #size: size,
            },
          ),
        )),
        returnValueForMissingStub: _i4.Future<_i2.Either<_i5.Failure, List<_i7.PlantModel>>>.value(
            _FakeEither_0<_i5.Failure, List<_i7.PlantModel>>(
          this,
          Invocation.method(
            #getPlantsCreatedByUser,
            [],
            {
              #userId: userId,
              #page: page,
              #size: size,
            },
          ),
        )),
      ) as _i4.Future<_i2.Either<_i5.Failure, List<_i7.PlantModel>>>);

  @override
  _i4.Future<_i2.Either<_i5.Failure, List<_i7.PlantModel>>> getUserPlants({
    required String? userId,
    required int? page,
    required int? size,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #getUserPlants,
          [],
          {
            #userId: userId,
            #page: page,
            #size: size,
          },
        ),
        returnValue: _i4.Future<_i2.Either<_i5.Failure, List<_i7.PlantModel>>>.value(
            _FakeEither_0<_i5.Failure, List<_i7.PlantModel>>(
          this,
          Invocation.method(
            #getUserPlants,
            [],
            {
              #userId: userId,
              #page: page,
              #size: size,
            },
          ),
        )),
        returnValueForMissingStub: _i4.Future<_i2.Either<_i5.Failure, List<_i7.PlantModel>>>.value(
            _FakeEither_0<_i5.Failure, List<_i7.PlantModel>>(
          this,
          Invocation.method(
            #getUserPlants,
            [],
            {
              #userId: userId,
              #page: page,
              #size: size,
            },
          ),
        )),
      ) as _i4.Future<_i2.Either<_i5.Failure, List<_i7.PlantModel>>>);

  @override
  _i4.Future<_i2.Either<_i5.Failure, List<_i7.PlantModel>>> getMarketPlants({
    required int? page,
    required int? size,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #getMarketPlants,
          [],
          {
            #page: page,
            #size: size,
          },
        ),
        returnValue: _i4.Future<_i2.Either<_i5.Failure, List<_i7.PlantModel>>>.value(
            _FakeEither_0<_i5.Failure, List<_i7.PlantModel>>(
          this,
          Invocation.method(
            #getMarketPlants,
            [],
            {
              #page: page,
              #size: size,
            },
          ),
        )),
        returnValueForMissingStub: _i4.Future<_i2.Either<_i5.Failure, List<_i7.PlantModel>>>.value(
            _FakeEither_0<_i5.Failure, List<_i7.PlantModel>>(
          this,
          Invocation.method(
            #getMarketPlants,
            [],
            {
              #page: page,
              #size: size,
            },
          ),
        )),
      ) as _i4.Future<_i2.Either<_i5.Failure, List<_i7.PlantModel>>>);

  @override
  _i4.Future<_i2.Either<_i5.Failure, _i7.PlantModel>> getPlantInfo({required int? plantId}) => (super.noSuchMethod(
        Invocation.method(
          #getPlantInfo,
          [],
          {#plantId: plantId},
        ),
        returnValue:
            _i4.Future<_i2.Either<_i5.Failure, _i7.PlantModel>>.value(_FakeEither_0<_i5.Failure, _i7.PlantModel>(
          this,
          Invocation.method(
            #getPlantInfo,
            [],
            {#plantId: plantId},
          ),
        )),
        returnValueForMissingStub:
            _i4.Future<_i2.Either<_i5.Failure, _i7.PlantModel>>.value(_FakeEither_0<_i5.Failure, _i7.PlantModel>(
          this,
          Invocation.method(
            #getPlantInfo,
            [],
            {#plantId: plantId},
          ),
        )),
      ) as _i4.Future<_i2.Either<_i5.Failure, _i7.PlantModel>>);

  @override
  _i4.Future<_i2.Either<_i5.Failure, _i6.Success>> addStage({required Map<String, dynamic>? stageData}) =>
      (super.noSuchMethod(
        Invocation.method(
          #addStage,
          [],
          {#stageData: stageData},
        ),
        returnValue: _i4.Future<_i2.Either<_i5.Failure, _i6.Success>>.value(_FakeEither_0<_i5.Failure, _i6.Success>(
          this,
          Invocation.method(
            #addStage,
            [],
            {#stageData: stageData},
          ),
        )),
        returnValueForMissingStub:
            _i4.Future<_i2.Either<_i5.Failure, _i6.Success>>.value(_FakeEither_0<_i5.Failure, _i6.Success>(
          this,
          Invocation.method(
            #addStage,
            [],
            {#stageData: stageData},
          ),
        )),
      ) as _i4.Future<_i2.Either<_i5.Failure, _i6.Success>>);

  @override
  _i4.Future<_i2.Either<_i5.Failure, _i6.Success>> updateStage({
    required int? stageId,
    required Map<String, dynamic>? stageData,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #updateStage,
          [],
          {
            #stageId: stageId,
            #stageData: stageData,
          },
        ),
        returnValue: _i4.Future<_i2.Either<_i5.Failure, _i6.Success>>.value(_FakeEither_0<_i5.Failure, _i6.Success>(
          this,
          Invocation.method(
            #updateStage,
            [],
            {
              #stageId: stageId,
              #stageData: stageData,
            },
          ),
        )),
        returnValueForMissingStub:
            _i4.Future<_i2.Either<_i5.Failure, _i6.Success>>.value(_FakeEither_0<_i5.Failure, _i6.Success>(
          this,
          Invocation.method(
            #updateStage,
            [],
            {
              #stageId: stageId,
              #stageData: stageData,
            },
          ),
        )),
      ) as _i4.Future<_i2.Either<_i5.Failure, _i6.Success>>);

  @override
  _i4.Future<_i2.Either<_i5.Failure, _i6.Success>> deleteStage({required int? stageId}) => (super.noSuchMethod(
        Invocation.method(
          #deleteStage,
          [],
          {#stageId: stageId},
        ),
        returnValue: _i4.Future<_i2.Either<_i5.Failure, _i6.Success>>.value(_FakeEither_0<_i5.Failure, _i6.Success>(
          this,
          Invocation.method(
            #deleteStage,
            [],
            {#stageId: stageId},
          ),
        )),
        returnValueForMissingStub:
            _i4.Future<_i2.Either<_i5.Failure, _i6.Success>>.value(_FakeEither_0<_i5.Failure, _i6.Success>(
          this,
          Invocation.method(
            #deleteStage,
            [],
            {#stageId: stageId},
          ),
        )),
      ) as _i4.Future<_i2.Either<_i5.Failure, _i6.Success>>);

  @override
  _i4.Future<_i2.Either<_i5.Failure, List<_i8.StageModel>>> getListOfStages({
    required int? plantId,
    required int? page,
    required int? size,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #getListOfStages,
          [],
          {
            #plantId: plantId,
            #page: page,
            #size: size,
          },
        ),
        returnValue: _i4.Future<_i2.Either<_i5.Failure, List<_i8.StageModel>>>.value(
            _FakeEither_0<_i5.Failure, List<_i8.StageModel>>(
          this,
          Invocation.method(
            #getListOfStages,
            [],
            {
              #plantId: plantId,
              #page: page,
              #size: size,
            },
          ),
        )),
        returnValueForMissingStub: _i4.Future<_i2.Either<_i5.Failure, List<_i8.StageModel>>>.value(
            _FakeEither_0<_i5.Failure, List<_i8.StageModel>>(
          this,
          Invocation.method(
            #getListOfStages,
            [],
            {
              #plantId: plantId,
              #page: page,
              #size: size,
            },
          ),
        )),
      ) as _i4.Future<_i2.Either<_i5.Failure, List<_i8.StageModel>>>);

  @override
  _i4.Future<_i2.Either<_i5.Failure, _i8.StageModel>> getStageInfo({required int? stageId}) => (super.noSuchMethod(
        Invocation.method(
          #getStageInfo,
          [],
          {#stageId: stageId},
        ),
        returnValue:
            _i4.Future<_i2.Either<_i5.Failure, _i8.StageModel>>.value(_FakeEither_0<_i5.Failure, _i8.StageModel>(
          this,
          Invocation.method(
            #getStageInfo,
            [],
            {#stageId: stageId},
          ),
        )),
        returnValueForMissingStub:
            _i4.Future<_i2.Either<_i5.Failure, _i8.StageModel>>.value(_FakeEither_0<_i5.Failure, _i8.StageModel>(
          this,
          Invocation.method(
            #getStageInfo,
            [],
            {#stageId: stageId},
          ),
        )),
      ) as _i4.Future<_i2.Either<_i5.Failure, _i8.StageModel>>);
}
