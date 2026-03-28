import 'package:fpdart/fpdart.dart';

import '../../../core/errors/failure.dart';
import '../../../core/success_objects/success_object.dart';
import '../../../core/usecase_contract.dart';
import '../../repositories/plant_repository.dart';

typedef AddPlantToUserParams = ({int plantId, String userId});

class AddPlantToUserUseCase implements UseCase<Success, AddPlantToUserParams> {
  final PlantsRepository _plantsRepository;

  AddPlantToUserUseCase(this._plantsRepository);

  @override
  Future<Either<Failure, Success>> call(params) async {
    return await _plantsRepository.addPlantToUser(plantId: params.plantId, userId: params.userId);
  }
}
