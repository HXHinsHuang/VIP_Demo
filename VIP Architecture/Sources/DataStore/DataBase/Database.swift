//
//  Database.swift
//  VIP Architecture
//
//  Created by haoxian on 2018/4/19.
//  Copyright © 2018年 haoxian. All rights reserved.
//

import Foundation

class DataBase {
  static let manager = DataBase()
  
  private init() {}
  
  // 假装这是一个数据库
  var database: [String: Any] = [:]
  
  func saveUserInfo(_ user: User) {
    database[user.id] = user
  }
  
  func getUserInfo(with id: String) -> User? {
    return database[id] as? User
  }
  
}
