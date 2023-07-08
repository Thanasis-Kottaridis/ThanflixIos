//
//  SeriesCoordinator.swift
//  Thanflix
//
//  Created by thanos kottaridis on 8/7/23.
//

import UIKit
import Domain
import Presentation

// MARK: - Actions
struct GoToSeriesLanding: Action {}

public class SeriesCoordinator: Coordinator {
    
    public weak var parentCoordinator: (any Coordinator)?
    public var childCoordinators: [String : any Coordinator] = [:]
    public var deepLinkedCoordinators = [any Coordinator]()
    public var navigationController: UINavigationController
    public let coordinatorKey: CoordinatorKey = CoordinatorKeyImpl.seriesCoordinator
    
    // MARK: - INIT
    //Inject main navigation Controller
    public init(
        with navigationController: UINavigationController? = nil,
        andParent parentCoordinator: any Coordinator,
        doStart: Bool = true
    ) {
        self.parentCoordinator = parentCoordinator
        self.navigationController = navigationController ?? UINavigationController()
        
        if doStart {
            start()
        }
    }
    
    public func start() {
        handleAction(action: GoToMoviesLanding())
    }
}

// MARK: - Handle Actions
extension SeriesCoordinator {
    public func handleAction(action: Action) {
        switch action {
        case _ as GoToMoviesLanding:
            let vc = ViewController()
            vc.view.backgroundColor = .orange
            navigate(to: vc, with: .push)
        default:
            // Use super implementation of BaseActionHandler
            handleBaseAction(action: action)
        }
    }
}
