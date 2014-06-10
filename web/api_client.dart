import 'dart:html';
import 'dart:async';
import 'dart:convert';
import 'package:angular/angular.dart';
import 'package:angular/application_factory.dart';


@Component(
    selector: 'create',
    templateUrl: 'packages/create_component.html',
    cssUrl: 'packages/create_component.css',
    publishAs: 'create_form')
class CreateFormAPIComponent implements AttachAware{
  Map _options;
  String message = 'LOADING_MESSAGE';
  @NgAttr('url')
  String url;
  
  void attach(){
    this.loadOptions();
  }
  
  void loadOptions(){
    Future <HttpRequest> request;
    Map headers;
    headers = {'Authorization': 'Basic aXZhbjoxMjM='};
    request = HttpRequest.request(this.url, method: 'OPTIONS', requestHeaders: headers)
        .then((HttpRequest request) {
              this._options = JSON.decode(request.responseText);
            })
            .catchError((e) {
              message = 'ERROR_MESSAGE';
            });
  }
 
  Map get options => this._options;
}


class APIClientModule extends Module {
  APIClientModule() {
    type(CreateFormAPIComponent);
  }
}


void main() {
  applicationFactory()
      ..addModule(new APIClientModule())
      ..run();
}