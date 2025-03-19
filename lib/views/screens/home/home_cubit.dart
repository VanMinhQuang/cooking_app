import 'package:bloc/bloc.dart';
import 'package:cooking_project/views/screens/home/home_state.dart';

class HomeCubit extends Cubit<HomeState>{
  HomeCubit() : super(HomeInitial());

  void changePageIndex(int index) => emit(ChangeIndexBottomBarState(index: index));

}