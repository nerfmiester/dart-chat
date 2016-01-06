// Copyright (c) 2016, <your name>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:html';
import 'dart:convert';

var wordList;
InputElement name;
InputElement email;
InputElement password;
var strName;
var strEmail;
var strPassword;

void main() {
  querySelector('#output').text = 'Create a user.';



  querySelector('#getWords').onClick.listen(makeRequest);
  wordList = querySelector('#wordList');
}

void makeRequest(Event e) {
  name = querySelector('#name');
  strName=name.value;
  email= querySelector('#email');
  strEmail=email.value;
  password = querySelector('#password');
  strPassword=password.value;
  //var data = '?name=Spice Girl&email=Spice@glophopper.com&password=girl';
  var path = 'http://localhost:3000/users/create?name=$strName&email=$strEmail&password=$strPassword';
  //var urrl = path.concat(data);
  var httpRequest = new HttpRequest();
  print('urrl value: $name]');
  httpRequest
    ..open('POST', path)
    ..onLoadEnd.listen((e) => requestComplete(httpRequest))
    ..send('');
}

requestComplete(HttpRequest request) {
  if (request.status == 200) {
    List<String> portmanteaux = JSON.decode(request.responseText);
    for (int i = 0; i < portmanteaux.length; i++) {
      wordList.children.add(new LIElement()..text = portmanteaux[i]);
    }
  } else {
    wordList.children.add(new LIElement()
      ..text = 'Request failed, status=${request.status}');
  }
}

