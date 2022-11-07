//
//  File.swift
//  Shopping App
//
//  Created by Berkay YAY on 31.10.2022.
//

import UIKit

final class MainTabBarController: UITabBarController {

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let productViewModel = ProductViewModel()
        let productViewController = ProductsViewController(viewModel: productViewModel)
        productViewController.title = "Advert"
        let searchViewController = SearchViewController()
        searchViewController.title = "Search"
        let profileViewController = ProfileViewController()
        
        
        setViewControllers([productViewController, searchViewController,profileViewController], animated: true)
    }
}
