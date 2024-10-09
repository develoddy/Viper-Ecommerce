//
//  TabBarWireFrame.swift
//  VIPER
//
//  Created by Eddy Donald Chinchay Lujan on 16/1/22.
//

import UIKit

class TabBarWireFrame {
    
    var viewController : UIViewController
    
    typealias Submodules = (
        home: UIViewController,
        search: UIViewController,
        profile: UIViewController,
        wishlist: UIViewController,
        cart: UIViewController
    )
    
    init(viewController: UIViewController) {
        self.viewController = viewController
    }
}



extension TabBarWireFrame {
    
    static func tabs(unsingSubmodules submodules: Submodules) -> Tabs {
        let homeTabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), tag: 11)
        let searchTabBarItem = UITabBarItem(title: "Buscar", image: UIImage(systemName: "magnifyingglass"), tag: 12)
        let profileTabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person"), tag: 13)
        let wishlistTabBarItem = UITabBarItem(title: "favoritos", image: UIImage(systemName: "heart"), tag: 14)
        let cartTabBarItem = UITabBarItem(title: "Carrito", image: UIImage(systemName: "cart"), tag: 15)
        
        submodules.home.tabBarItem = homeTabBarItem
        submodules.profile.tabBarItem = profileTabBarItem
        submodules.search.tabBarItem = searchTabBarItem
        submodules.wishlist.tabBarItem = wishlistTabBarItem
        submodules.cart.tabBarItem = cartTabBarItem
        
        return (
            home: submodules.home,
            search: submodules.search,
            profile: submodules.profile,
            wishlist: submodules.wishlist,
            cart: submodules.cart
        )
    }
}
