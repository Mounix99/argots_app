import 'package:dartz/dartz.dart';

import '../../../core/errors/failure.dart';
import '../../../core/success_objects/success_object.dart';
import '../../../core/usecase_contract.dart';
import '../../repositories/plant_repository.dart';

typedef RemovePlantToUserParams = ({int plantId, String userId});

class RemovePlantToUserUseCase implements Usecase<Success, RemovePlantToUserParams> {
  final PlantsRepository _plantsRepository;

  RemovePlantToUserUseCase(this._plantsRepository);

  @override
  Future<Either<Failure, Success>> call(params) async {
    return await _plantsRepository.removePlantFromUser(plantId: params.plantId, userId: params.userId);
  }
}
