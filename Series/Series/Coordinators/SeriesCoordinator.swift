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
struct GoToSeriesDetails: Action {
    let id: Int
}

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
        handleAction(action: GoToSeriesLanding())
    }
}

// MARK: - Handle Actions
extension SeriesCoordinator {
    public func handleAction(action: Action) {
        switch action {
        case _ as GoToSeriesLanding:
            let viewModel = SeriesLandingViewModel(actionHandler: self)
            let screen = SeriesLandingScreen(viewModel: viewModel)
            navigate(
                to: screen,
                with: .push,
                hideNavigationBar: true,
                hideTabBar: false,
                isSwipeBackEnable: true
            )
        case let action as GoToSeriesDetails:
            let viewModel = SeriesDetailsViewModel(seriesId: action.id, actionHandler: self)
            let screen = SeriesDetailsScreen(viewModel: viewModel)
            navigate(to: screen, with: .push)
        default:
            // Use super implementation of BaseActionHandler
            handleBaseAction(action: action)
        }
    }
}
