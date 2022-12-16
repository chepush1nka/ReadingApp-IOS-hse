//
//  TabBarViewController.swift
//  ReadingAppIOShse
//
//  Created by Павел Вяльцев on 24.11.2022.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setUpControllers()
    }
    
    private func setUpControllers() {
        let books = BooksViewController()
        books.title = "Books"
        let library = LibraryViewController()
        library.title = "Library"
        let profile = ProfileViewController()
        profile.title = "Profile"
        
        books.navigationItem.largeTitleDisplayMode = .always
        library.navigationItem.largeTitleDisplayMode = .always
        profile.navigationItem.largeTitleDisplayMode = .always
        
        let nav1 = UINavigationController(rootViewController: books)
        let nav2 = UINavigationController(rootViewController: library)
        let nav3 = UINavigationController(rootViewController: profile)
        
        nav1.navigationBar.prefersLargeTitles = true
        nav2.navigationBar.prefersLargeTitles = true
        nav3.navigationBar.prefersLargeTitles = true
        
        nav1.tabBarItem = UITabBarItem(title: "Books", image: UIImage(systemName: "books.vertical"), tag: 1)
        
        nav2.tabBarItem = UITabBarItem(title: "Library", image: UIImage(systemName: "book"), tag: 2)
        
        nav3.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person"), tag: 3)
        
        self.tabBar.tintColor = .label
        self.tabBar.unselectedItemTintColor = .systemGray
        setViewControllers([nav1, nav2, nav3], animated: true)
    }
}
