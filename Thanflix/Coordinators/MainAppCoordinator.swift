//
//  MainAppCoordinator.swift
//  Thanflix
//
//  Created by thanos kottaridis on 8/7/23.
//

import UIKit
import Domain
import Presentation
import Series
import Movies

class MainAppCoordinator: NSObject, Coordinator {
    
    // MARK: - vars
    /// # Coordinator vars
    var parentCoordinator: (any Coordinator)?
    var childCoordinators = [String : any Coordinator]()
    var deepLinkedCoordinators = [any Coordinator]()
    var navigationController: UINavigationController
    var coordinatorKey: CoordinatorKey = CoordinatorKeyImpl.mainAppCoordinator
    
    /// # Custom Vars
    // set up tabbar controller
    var tabController: UITabBarController?
    
    // MARK: - INIT
    //Inject main navigation Controller
    init(
        with navigationController: UINavigationController? = nil,
        andParent parent: any Coordinator
    ) {
        // no parent coordinator for this coord
        parentCoordinator = parent
        self.navigationController = navigationController ?? UINavigationController()
        self.navigationController.navigationBar.isHidden = true
        super.init()
        
        // init tab bar
        tabController =  BaseTabBarController(parentCoordinator: self)
    }

    func start() {
        setUpTabBarController()
    }
    
    private func setUpTabBarController() {
        
        var controllers: [UIViewController] = []
        
        /// # Tab Coordinators
        let moviesCoord: MoviesCoordinator =  MoviesCoordinator(
            with: UINavigationController(),
            andParent: self
        )
        addChild(coordinator: moviesCoord, with: CoordinatorKeyImpl.moviesCoordinator)
        
        let seriesCoord: SeriesCoordinator = SeriesCoordinator(
            with: UINavigationController(),
            andParent: self
        )
        addChild(coordinator: seriesCoord, with: CoordinatorKeyImpl.seriesCoordinator)
        
        // TODO: - Add more tab coords
        
        let moviesRoot = moviesCoord.navigationController
        moviesRoot.tabBarItem = UITabBarItem(
            title: "Movies",
            image: UIImage(named: "Movies_unselected"),
            selectedImage: UIImage(named: "Movies_selected")
        )
        
        let seriesRoot = seriesCoord.navigationController
        seriesRoot.tabBarItem = UITabBarItem(
            title: "Series",
            image: UIImage(named: "Series_unselected"),
            selectedImage: UIImage(named: "Series_selected")
        )
        
        
        controllers.append(moviesRoot)
        controllers.append(seriesRoot)
        
        tabController?.viewControllers = controllers
        tabController?.selectedIndex = 0
        
        // navigate to tab bar controller with reset stack
        navigationController.setViewControllers([tabController!], animated: true)
    }
}

// MARK: - Action Handler
extension MainAppCoordinator {
    func handleAction(action: Action) {
        switch action {
        default:
            // Use super implementation of BaseActionHandler
            handleBaseAction(action: action)
        }
    }
}

// MARK: - UITabBarControllerDelegate
extension MainAppCoordinator: UITabBarControllerDelegate {
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        return true
    }
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {}
}
