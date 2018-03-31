//
//  TabBarViewController.swift
//  TravelGuide
//
//  Created by Anton Makarov on 21.03.2018.
//  Copyright © 2018 Anton Makarov. All rights reserved.
//

import UIKit

class TabBarViewController: UITabBarController, UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
       
        let sightVC = storyboard.instantiateViewController(withIdentifier: "SightBoard") as? SightViewController
        let mainVC = storyboard.instantiateViewController(withIdentifier: "CityBoard") as? MainCityViewController
        let profileVC = storyboard.instantiateViewController(withIdentifier: "ProfileBoard") as? ProfileViewController


        mainVC?.tabBarItem = UITabBarItem(title: "City", image: nil, selectedImage: nil)
        sightVC?.tabBarItem = UITabBarItem(title: "Sight", image: nil, selectedImage: nil)
        profileVC?.tabBarItem = UITabBarItem(title: "Profile", image: nil, selectedImage: nil)

        let controllers = [mainVC, sightVC, profileVC]
        viewControllers = controllers as? [UIViewController]
        
        // Loading all data before view
        for viewController in self.viewControllers! {
            let _ = viewController.view
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true;
    }
    
    deinit {
        Logger.info(msg: "Deinit")
    }
}
