part of 'download_buttons_cubit.dart';

@freezed
class DownloadButtonsState with _$DownloadButtonsState {
  const factory DownloadButtonsState.noDownload() = _NoDownload;
  const factory DownloadButtonsState.downloads({required double progress}) =
      _Downloads;
  const factory DownloadButtonsState.successDownloads() = _SuccessDownloads;
}
