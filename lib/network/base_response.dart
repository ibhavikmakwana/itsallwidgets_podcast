
class BaseResponse<T> {
  Status status;

  T data;

  String message;

  BaseResponse.loading(this.message) : status = Status.LOADING;

  BaseResponse.success(this.data, {this.message}) : status = Status.COMPLETED;

  BaseResponse.error(this.message, {this.data}) : status = Status.ERROR;

  @override
  String toString() {
    return "Status : $status \n Message : $message \n Data : $data";
  }
}

enum Status { LOADING, COMPLETED, ERROR }
