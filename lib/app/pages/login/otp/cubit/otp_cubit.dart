import 'package:bloc/bloc.dart';
import 'package:cooking_project/domain/use_cases/auth_use_case/verify_otp_use_case.dart';
import 'otp_state.dart';

class OtpCubit extends Cubit<OtpState>{
  final VerifyOTPUseCase verifyOTPUseCase;
  OtpCubit({required this.verifyOTPUseCase})  : super(OtpEmpty());


  void verifyOtp({required String otp, required String verificationId}) async{
    emit(OtpLoading());
    try{
      var result = await verifyOTPUseCase.call(otp: otp, verificationId: verificationId);
      if(result) {
        emit(OtpSucess());
      } else {
        emit(OtpFail(error: 'Mã OTP không khớp'));
      }
    }catch(e){
      emit(OtpFail(error: e.toString()));
    }
  }
}