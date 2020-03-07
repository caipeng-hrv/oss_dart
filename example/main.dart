
import '../lib/oss_dart.dart';

void main() async{
  OssClient client = OssClient(bucketName: 'bucketName',endpoint: 'endpoint',tokenGetter: getStsAccount);
  
  List<int> fileData = [];//上传文件的二进制
  
  String fileKey = 'ABC.text';//上传文件名
  var response;
  //上传文件
  response = await client.putObject(fileData, fileKey);
  //获取文件
  response = await client.getObject(fileKey);
  //分片上传
  //First get uploadId 
  String uploadId = await client.initiateMultipartUpload(fileKey);
  //Second upload part
  num partNum = 1;//上传分块的序号
  String etag = await client.uploadPart(fileData,fileKey,uploadId,partNum);
  //Third complate multiUpload
  List etags = [etag];//所有区块上传完成后返回的etag，按顺序排列
  response = await client.completeMultipartUpload(etags, fileKey, uploadId);
  //response 是阿里云返回的xml格式的数据，需要单独解析
  print(response);
 
}
//获取阿里云临时账号，具体实现参考阿里云文档
 Future<Map> getStsAccount()async{
    
    return {};
  }