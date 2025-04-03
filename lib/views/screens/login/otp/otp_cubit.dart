import 'package:bloc/bloc.dart';
import 'package:cooking_project/data/repository/login_repository.dart';
import 'package:cooking_project/views/screens/login/otp/otp_state.dart';

class OtpCubit extends Cubit<OtpState>{
  final LoginRepository loginRepository;
  OtpCubit({required this.loginRepository})  : super(OtpEmpty());


  void verifyOtp({required String otp, required String verificationId}) async{
    emit(OtpLoading());
    try{
      var result = await loginRepository.verifyOtp(otp: otp, verificationId: verificationId);
      if(result ?? true) {
        emit(OtpSucess());
      } else {
        emit(OtpFail(error: 'Mã OTP không khớp'));
      }
    }catch(e){
      emit(OtpFail(error: e.toString()));
    }
  }
}