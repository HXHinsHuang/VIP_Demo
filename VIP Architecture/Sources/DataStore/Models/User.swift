//
//  User.swift
//  VIP Architecture
//
//  Created by haoxian on 2018/4/19.
//  Copyright © 2018年 haoxian. All rights reserved.
//

import Foundation

struct User: Codable {
  let id: String
  let name: String
  let age: Int
  let sex: Sex
  let language: Language
}

extension User {
  enum Sex: String, Codable {
    case male
    case female
  }
}

extension User {
  enum Language: String, Codable {
    case Chinese
    case English
    case Japanese
    case French
    case Korean
  }
}
