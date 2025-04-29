import 'package:equatable/equatable.dart';

abstract class OtpState extends Equatable{
  const OtpState();
  @override
  List<Object> get props => [];
}

class OtpEmpty extends OtpState{}
class OtpLoading extends OtpState{}

class OtpVerify extends OtpState{
  String? otpCode;
  String? verificationId;
  OtpVerify({required this.otpCode, required this.verificationId});
  @override
  List<Object> get props => [otpCode ?? '', verificationId ?? ''];

}

class OtpSucess extends OtpState{}

class OtpFail extends OtpState{
  String? error;
  OtpFail({required this.error});
  @override
  List<Object> get props => [error ?? ''];
}