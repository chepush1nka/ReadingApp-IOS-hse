//
//  ViewController.swift
//  ReadingAppIOShse
//
//  Created by Павел Вяльцев on 24.11.2022.
//

import UIKit

class SignInViewController: UITabBarController {
    // Header view
    private let headerView = SignInHeaderView()
    // Email field
    private let emailField: UITextField = {
        let field = UITextField()
        field.keyboardType = .emailAddress
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 50))
        field.leftViewMode = .always
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.placeholder = "Email"
        field.backgroundColor = .secondarySystemBackground
        field.layer.cornerRadius = 8
        field.layer.masksToBounds = true
        return field
    }()
    // Password field
    private let passwordField: UITextField = {
        let field = UITextField()
        field.keyboardType = .emailAddress
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 50))
        field.leftViewMode = .always
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.placeholder = "Password"
        field.isSecureTextEntry = true
        field.backgroundColor = .secondarySystemBackground
        field.layer.cornerRadius = 8
        field.layer.masksToBounds = true
        return field
    }()
    // Sign in button
    private let signInButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(red: 1, green: 0.69803921568, blue: 0.11372549019, alpha: 1)
        button.setTitle("Sign In", for: .normal)
        button.setTitleColor(.systemBackground, for: .normal)
        button.layer.cornerRadius = 18
        return button
    }()
    
    // Create Account
    private let createAccountButton: UIButton = {
        let button = UIButton()
        button.setTitle("Sign Up", for: .normal)
        button.setTitleColor(.label, for: .normal)
        button.layer.cornerRadius = 18
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //title = "Вход"
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tap))
        view.addGestureRecognizer(tapGesture)
        
        view.backgroundColor = .systemBackground
        view.addSubview(headerView)
        let tmpEmail = emailField
        tmpEmail.delegate = self
        view.addSubview(tmpEmail)
        let tmpPassword = passwordField
        tmpPassword.delegate = self
        view.addSubview(tmpPassword)
        view.addSubview(signInButton)
        view.addSubview(createAccountButton)
        signInButton.addTarget(self, action: #selector(didTapSignIn), for: .touchUpInside)
        createAccountButton.addTarget(self, action: #selector(didTapCreateAccount), for: .touchUpInside)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        headerView.frame = CGRect(x: 0, y: view.safeAreaInsets.top, width: view.width, height: view.height/3)
        emailField.frame = CGRect(x: 20, y: headerView.bottom + 10, width: view.width - 40, height: 50)
        passwordField.frame = CGRect(x: 20, y: emailField.bottom + 20, width: view.width - 40, height: 50)
        signInButton.frame = CGRect(x: 20, y: passwordField.bottom + 20, width: view.width - 40, height: 50)
        createAccountButton.frame = CGRect(x: 20, y: signInButton.bottom + 10, width: view.width - 40, height: 50)
    }
    
    @objc private func didTapSignIn() {
        guard let email = emailField.text, !email.isEmpty else {
            emailField.attributedPlaceholder = NSAttributedString(string: "Email", attributes: [NSAttributedString.Key.foregroundColor: UIColor.red.withAlphaComponent(0.6)])
            if passwordField.text == nil || passwordField.text!.isEmpty {
                passwordField.attributedPlaceholder = NSAttributedString(string: "Password", attributes: [NSAttributedString.Key.foregroundColor: UIColor.red.withAlphaComponent(0.6)])
            }
            return
        }
        
        guard let password = passwordField.text, !password.isEmpty else {
            passwordField.attributedPlaceholder = NSAttributedString(string: "Password", attributes: [NSAttributedString.Key.foregroundColor: UIColor.red.withAlphaComponent(0.6)])
            return
        }
        
        AuthManager.shared.signIn(email: email, password: password) { [weak self] success in
            guard success else {
                self?.headerView.label.text = "Wrong password or email"
                return
            }
            UserDefaults.standard.set(email, forKey: "email")
            DispatchQueue.main.async {
                let vc = TabBarViewController()
                vc.modalPresentationStyle = .fullScreen
                self?.present(vc, animated: true)
            }
        }
    }
    
    @objc private func didTapCreateAccount() {
        let vc = SignUpViewController()
        vc.title = "Sign Up"
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension SignInViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        switch textField {
        case emailField:
            emailField.attributedPlaceholder = nil
            emailField.placeholder = "Email"
            self.headerView.label.text = ""
        case passwordField:
            passwordField.attributedPlaceholder = nil
            passwordField.placeholder = "Password"
            self.headerView.label.text = ""
        default:
            print("somthing wrong")
        }
    }
}

extension SignInViewController {
    @objc private func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y += (view.bounds.height - keyboardSize.height - 700)
            }
        }
    }
    
    @objc private func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
    
    @objc
    func tap(gesture: UITapGestureRecognizer) {
        emailField.resignFirstResponder()
        passwordField.resignFirstResponder()
    }
}

