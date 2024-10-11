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
        
        // Envolver cada controlador en un UINavigationController
        let homeNavController = UINavigationController(rootViewController: submodules.home)
        let profileNavController = UINavigationController(rootViewController: submodules.profile)
        let searchNavController = UINavigationController(rootViewController: submodules.search)
        let wishlistNavController = UINavigationController(rootViewController: submodules.wishlist)
        let cartNavController = UINavigationController(rootViewController: submodules.cart)
        
        /**submodules.home.tabBarItem = homeTabBarItem
        submodules.profile.tabBarItem = profileTabBarItem
        submodules.search.tabBarItem = searchTabBarItem
        submodules.wishlist.tabBarItem = wishlistTabBarItem
        submodules.cart.tabBarItem = cartTabBarItem*/
        
        // Asignar los UITabBarItem a cada controlador
        homeNavController.tabBarItem = homeTabBarItem
        profileNavController.tabBarItem = profileTabBarItem
        searchNavController.tabBarItem = searchTabBarItem
        wishlistNavController.tabBarItem = wishlistTabBarItem
        cartNavController.tabBarItem = cartTabBarItem
        
        return (
            home: homeNavController,
            search: searchNavController,
            profile: profileNavController,
            wishlist: wishlistNavController,
            cart: cartNavController
        )
        
        /**return (
            home: submodules.home,
            search: submodules.search,
            profile: submodules.profile,
            wishlist: submodules.wishlist,
            cart: submodules.cart
        )*/
    }
}
