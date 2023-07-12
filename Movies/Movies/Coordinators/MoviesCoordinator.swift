//
//  MoviesCoordinator.swift
//  Thanflix
//
//  Created by thanos kottaridis on 8/7/23.
//

import UIKit
import Domain
import Presentation

// MARK: - Actions
struct GoToMoviesLanding: Action {}

public class MoviesCoordinator: Coordinator {
    
    public weak var parentCoordinator: (any Coordinator)?
    public var childCoordinators: [String : any Coordinator] = [:]
    public var deepLinkedCoordinators = [any Coordinator]()
    public var navigationController: UINavigationController
    public let coordinatorKey: CoordinatorKey = CoordinatorKeyImpl.moviesCoordinator
    
    // MARK: - INIT
    //Inject main navigation Controller
    public init(
        with navigationController: UINavigationController? = nil,
        andParent parentCoordinator: any Coordinator,
        doStart: Bool = true
    ) {
        self.parentCoordinator = parentCoordinator
        self.navigationController = navigationController ?? UINavigationController()
        self.navigationController.navigationBar.isHidden = true

        if doStart {
            start()
        }
    }
    
    public func start() {
        handleAction(action: GoToMoviesLanding())
    }
}

// MARK: - Handle Actions
extension MoviesCoordinator {
    public func handleAction(action: Action) {
        switch action {
        case _ as GoToMoviesLanding:
            let viewModel = MoviesLandingViewModel(actionHandler: self)
            let vc = MoviesLandingVC(viewModel: viewModel)
            navigate(to: vc, with: .push)
        default:
            // Use super implementation of BaseActionHandler
            handleBaseAction(action: action)
        }
    }
}
