//
//  Network.swift
//  VIP Architecture
//
//  Created by haoxian on 2018/4/19.
//  Copyright © 2018年 haoxian. All rights reserved.
//

import Foundation

typealias JSONResponse = (_ json: Data) -> ()

class Network {
  static let apiManager = Network()
  
  private init() {}
  
  // 假装这是一个网络请求
  func loginFetch(account: String, password: String, response: @escaping JSONResponse) {
    let loginUrl = EndPoint.login.endPointUrl
    DispatchQueue.global().asyncAfter(deadline: .now() + 1.5) {
      let json: String
      if account == "haoxian", password == "123" {
        json = """
        {
          "success": true,
          "user": {
            "id": "8888",
            "name": "\(account)",
            "age": 18,
            "sex": "male",
            "language": "Chinese"
          }
        }
        """
      } else {
        json = """
        {
          "success": false,
          "errorMsg": "Account or password error."
        }
        """
      }
      DispatchQueue.main.async {
        response(json.data(using: .utf8)!)
      }
    }
  }
}

extension Network {
  enum EndPoint: String {
    case login = "/login"
  }
}

extension Network.EndPoint {
  static let baseUrl = "https://host"
  
  var endPointUrl: String {
    return Network.EndPoint.baseUrl + rawValue
  }
}
