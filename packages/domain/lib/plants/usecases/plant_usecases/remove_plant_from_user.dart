import 'package:fpdart/fpdart.dart';

import '../../../core/errors/failure.dart';
import '../../../core/success_objects/success_object.dart';
import '../../../core/usecase_contract.dart';
import '../../repositories/plant_repository.dart';

typedef RemovePlantFromUserParams = ({int plantId, String userId});

class RemovePlantFromUserUseCase implements UseCase<Success, RemovePlantFromUserParams> {
  final PlantsRepository _plantsRepository;

  RemovePlantFromUserUseCase(this._plantsRepository);

  @override
  Future<Either<Failure, Success>> call(params) async {
    return await _plantsRepository.removePlantFromUser(plantId: params.plantId, userId: params.userId);
  }
}
