//
//  AuthViewController.swift
//  Shopping App
//
//  Created by Berkay YAY on 31.10.2022.
//

import UIKit

class AuthViewController: UIViewController, AlertPresentable {
 
    private let viewModel: AuthViewModel
    
    enum AuthType: String {
        case signIn = "Sign In"
        case signUp = "Sign Up"
        
        init(text: String) {
            switch text {
            case "Sign In":
                self = .signIn
            case "Sign Up":
                self = .signUp
            default:
                self = .signIn
            }
        }
    }
    
    var authType: AuthType = .signIn {
        didSet {
            let title = segmentedControl.titleForSegment(at: segmentedControl.selectedSegmentIndex)
            titleLabel.text = title
            confirmButton.setTitle(title, for: .normal)
        }
    }
    
    // MARK: - Init
    init(viewModel: AuthViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.changeHandler = { change in
            switch change {
            case .didErrorOccurred(let error):
                self.showError(error)
            case .didSignUpSuccessful:
                self.showAlert(title: "SIGN UP SUCCESSFUL!")
            }
        }
        title = "Auth"
    }


    @IBOutlet private weak var segmentedControl: UISegmentedControl!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var credentialTextField: UITextField!
    @IBOutlet private weak var confirmButton: UIButton!
    @IBOutlet private weak var passwordTextField: UITextField!
    
    
    @IBAction func didTapLoginButton(_ sender: UIButton) {
        guard let credential = credentialTextField.text,
              let password = passwordTextField.text else {
            return
        }
        switch authType {
        case .signIn:
            viewModel.signIn(email: credential,
                             password: password,
                             completion: { [weak self] in
                guard let self = self else { return }
                self.navigationController?.pushViewController(MainTabBarController(), animated: true)
            })
        case .signUp:
            viewModel.signUp(email: credential,
                             password: password)
        }
    }
    
    @IBAction func didSegmentedValueChanged(_ sender: UISegmentedControl) {
        let title = segmentedControl.titleForSegment(at: segmentedControl.selectedSegmentIndex)
        authType = AuthType(text: title ?? "Sign In")
    }
    
}
