//
//  ProfileViewController.swift
//  ReadingAppIOShse
//
//  Created by Павел Вяльцев on 24.11.2022.
//

import UIKit

class ProfileViewController: UIViewController {
    
    private let headerView = ProfileLabelView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupHeaderView()
        setupSignOutButton()
    }
    
    private func setupHeaderView() {
        view.addSubview(headerView)
        headerView.frame = CGRect(x: 17, y: 150, width: view.bounds.width - 34, height: view.bounds.height/6)
    }
    
    private func setupSignOutButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Sign Out",
            style: .done,
            target: self,
            action: #selector(didTapSignOut))
        navigationItem.rightBarButtonItem?.tintColor =  UIColor(red: 1, green: 0.69803921568, blue: 0.11372549019, alpha: 1)
    }
    
    @objc private func didTapSignOut() {
        let sheet = UIAlertController(title: "Sign Out", message: "Are you shure to Sign Out", preferredStyle: .actionSheet)
        sheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        sheet.addAction(UIAlertAction(title: "Sign Out", style: .destructive, handler: { _ in
            AuthManager.shared.signOut { [weak self] success in
                if success {
                    DispatchQueue.main.async {
                        UserDefaults.standard.set(nil, forKey: "email")
                        UserDefaults.standard.set(nil, forKey: "name")
                        let signInVc = SignInViewController()
                        signInVc.navigationItem.largeTitleDisplayMode = .always
                        
                        let navVc = UINavigationController(rootViewController: signInVc)
                        navVc.navigationBar.prefersLargeTitles = true
                        navVc.modalPresentationStyle = .fullScreen
                        self?.present(navVc, animated: true, completion: nil)
                    }
                }
                
            }
        }))
        
        present(sheet, animated: true)
        
    }


}
