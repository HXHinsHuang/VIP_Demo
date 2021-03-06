//
//  LoginInteractor.swift
//  VIP Architecture
//
//  Created by haoxian on 2018/4/19.
//  Copyright (c) 2018年 haoxian. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import Foundation

/// ViewContoller output
protocol LoginBusinessLogic {
  func loginAction(request: Login.LoginEvent.Request)
  func fetchRouterDataStroe(with userId: String)
}

/// Router DataStore
protocol LoginDataStore {
  var user: User? { get set }
}

class LoginInteractor: LoginDataStore {
  var presenter: LoginPresentationLogic?
  /// Worker
  let networkWorker = LoginNetworkWorker()
  /// Worker
  let databaseWoeker = LoginDatabaseWorker()
  
  // MARK: - LoginDataStore
  var user: User?
  
}

/// 遵循协议，作为ViewContoller 的 output
extension LoginInteractor: LoginBusinessLogic {
  func loginAction(request: Login.LoginEvent.Request) {
    guard let account = request.account, let password = request.password else {
      let response = Login.LoginEvent.Response(user: nil, success: false, errorMsg: "Fields may not be empty.")
      presenter?.presentLoginResult(response)
      return
    }
    networkWorker.fetch(account: account, password: password, complete: { (response) in
      if response.success {
        self.databaseWoeker.saveUserInfo(response)
      }
      self.presenter?.presentLoginResult(response)
    })
  }
  
  func fetchRouterDataStroe(with userId: String) {
    user = databaseWoeker.fetchUserInfoFromDatabase(with: userId)
  }
}
