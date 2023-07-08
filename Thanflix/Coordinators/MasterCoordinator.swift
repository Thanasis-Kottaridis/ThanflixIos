//
//  MasterCoordinator.swift
//  Thanflix
//
//  Created by thanos kottaridis on 8/7/23.
//

import UIKit
import Domain
import Presentation

class MasterCoordinator: Coordinator {
    
    var parentCoordinator: (any Coordinator)?
    var childCoordinators = [String : any Coordinator]()
    var deepLinkedCoordinators = [any Coordinator]()
    var navigationController: UINavigationController
    var coordinatorKey: CoordinatorKey = CoordinatorKeyImpl.masterCoordinator
    
    ///#  Application state machine
    @Injected(\.applicationStateManager)
    private var applicationStateManager: ApplicationStateManager
    
    // MARK: - INIT
    //Inject main navigation Controller
    init(navigationController: UINavigationController? = nil) {
        // no parent coordinator for this coord
        parentCoordinator = nil
        self.navigationController = navigationController ?? UINavigationController()
    }

    func start() {
        // 2. Initialize Applicarion State Manager
        applicationStateManager.actionHandler = self
        applicationStateManager.enter(event: .enterToUninitializedState)
    }
}

// MARK: - Navigation EXT
extension MasterCoordinator {
    func handleAction(action: Action) {
        switch action {
        case _ as GoToInitializedState:
            applicationStateManager.enter(event: .enterToInitializedState)
        case _ as GoToMainApp:
            goToMainApp()
        case _ as LogoutAction:
           logout()
        default:
            // Use super implementation of BaseActionHandler
            handleBaseAction(action: action)
        }
    }
}

// MARK: - Helper Functions
extension MasterCoordinator {
    
    private func goToMainApp() {
        // clear child coordinator stack before enter MainApp
        childCoordinators.removeAll()
        let mainAppCoordinator = MainAppCoordinator(with: self.navigationController, andParent: self)
        self.addChild(coordinator: mainAppCoordinator, with: CoordinatorKeyImpl.mainAppCoordinator)
        mainAppCoordinator.start()
    }
    
    private func logout() {
        // clean everything in this coordinator
        self.childCoordinators.removeAll()
        var navArray = self.navigationController.viewControllers
        navArray.removeAll()
        self.navigationController.viewControllers = navArray
        navigationController.presentedViewController?.dismiss(animated: false)
        applicationStateManager.enter(event: .enterToUninitializedState)
    }
}
