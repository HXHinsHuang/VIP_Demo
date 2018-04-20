//
//  LoginViewController.swift
//  VIP Architecture
//
//  Created by haoxian on 2018/4/19.
//  Copyright (c) 2018年 haoxian. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

/// Presenter output
protocol LoginDisplayLogic: class {
  func loginSuccessed(viewModel: Login.LoginEvent.ViewModel)
  func loginFailed(viewModel: Login.LoginEvent.ViewModel)
}

class LoginViewController: UIViewController {
  var interactor: LoginBusinessLogic?
  var router: (NSObjectProtocol & LoginRoutingLogic & LoginDataPassing)?
  
  @IBOutlet weak var accountTF: UITextField!
  @IBOutlet weak var passwordTF: UITextField!
  @IBOutlet weak var loginBtn: UIButton!

  // MARK: Object lifecycle
  
  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    setup()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    setup()
  }
  
  // MARK: Setup
  /// 根据整个VIP架构来设置各个部分之间的关系
  private func setup() {
    let viewController = self
    let interactor = LoginInteractor()
    let presenter = LoginPresenter()
    let router = LoginRouter()
    viewController.interactor = interactor
    viewController.router = router
    interactor.presenter = presenter
    presenter.viewController = viewController
    router.viewController = viewController
    router.dataStore = interactor
  }
  
  // MARK: View lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configure()
  }
  
  func configure() {
    accountTF.text = "haoxian"
    passwordTF.text = "123"
  }
  
  @IBAction func LoginButtonDidTap(_ sender: UIButton) {
    guard let account = accountTF.text, let password = passwordTF.text else {
      return print("Fields of account and password may not be empty!")
    }
    let request = Login.LoginEvent.Request(account: account, password: password)
    interactor?.loginAction(request: request)
  }
  
  func ToMainView() {
    interactor?.fetchRouterDataStroe(with: "8888")
    router?.toMainView()
  }
}

/// 遵循协议，作为 Presenter 的 output
extension LoginViewController: LoginDisplayLogic {
  func loginSuccessed(viewModel: Login.LoginEvent.ViewModel) {
    print("login successed.")
    ToMainView()
  }
  
  func loginFailed(viewModel: Login.LoginEvent.ViewModel) {
    if let errorMsg = viewModel.errorMsg {
      print("login failed, error: \(errorMsg)")
    } else {
      print("login failed")
    }
  }
}
