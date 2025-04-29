import 'package:equatable/equatable.dart';

abstract class DetailMealState extends Equatable{
  const DetailMealState();
  @override
  List<Object?> get props => [];
}


class DetailMealEmpty extends DetailMealState{}
class DetailMealLoading extends DetailMealState{}


class DetailMealIndexChange extends DetailMealState{
  final int index;

  const DetailMealIndexChange({required this.index});
  @override
  List<Object?> get props => [index];
}

class DetailMealLikeMeal extends DetailMealState {
  final bool isLiked;

  const DetailMealLikeMeal({required this.isLiked});

  @override
  List<Object?> get props => [isLiked];
}