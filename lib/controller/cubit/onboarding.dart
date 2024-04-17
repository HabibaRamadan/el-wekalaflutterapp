import 'package:elwekala_ecommerce_app/controller/states/onboarding.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OnBoardingCubit extends Cubit<OnBoardingStates> {
  OnBoardingCubit(super.initialState);

  static OnBoardingCubit get(context) {
    return BlocProvider.of(context);
  }

  int screen = 0;
  bool islast = false;

  void lastPage(index, context) {
    screen = index;
    islast = true;
    emit(IsLastPageState());
    
  }

  void notlastPage(index) {
    screen = index;
    islast = false;
    emit((IsNotLastPageStete()));
  }
}
