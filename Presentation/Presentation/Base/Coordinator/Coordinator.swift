//
//  Coordinator.swift
//  Presentation
//
//  Created by thanos kottaridis on 29/1/23.
//

import UIKit
import SwiftUI

public enum NavigationStyle {
    case present
    case push
    case resetStack
    case bottomSheet
    case overCurrentContext
    case overFullScreen
    case pop
    case reversePush
    case fade
}

public protocol Coordinator: AnyObject, ObservableObject, BaseActionHandler {
    // MARK: - Vars
    var parentCoordinator: (any Coordinator)? { get set }
    var childCoordinators: [String: any Coordinator] { get set }
    var navigationController: UINavigationController { get set }
    var coordinatorKey: CoordinatorKey { get }
    // Deep Link Helper VARS
    var deepLinkedCoordinators: [any Coordinator] { get set }
    var isPresentedOnDeepLink: Bool { get }
    
    // MARK: - Funcs
    func start()
    func stop(completion: (() -> Void)?)
    func dismiss(animated: Bool, completion: (() -> Void)?)
    func addChild(coordinator: any Coordinator, with key: CoordinatorKey, fromDeepLink: Bool)
    func removeChild(coordinator: any Coordinator)
    func removeChild(key: CoordinatorKey)
}

// MARK: Default Implementations.
extension Coordinator {
    
    public func addChild(
        coordinator: any Coordinator,
        with key: CoordinatorKey,
        fromDeepLink: Bool = false
    ) {
        childCoordinators[key.value] = coordinator
        if fromDeepLink == true {
            deepLinkedCoordinators.append(coordinator)
        }
    }
    
    public func removeChild(coordinator: any Coordinator) {
        childCoordinators = childCoordinators.filter {
            $0.value !== coordinator
        }
    }
    
    public func removeChild(key: CoordinatorKey) {
        if let coord = childCoordinators[key.value] {
            removeChild(coordinator: coord)
            print("Coordinator with key: \(key) removed")
        }
    }
    
    public func getCoordingator(_ key: CoordinatorKey) -> (any Coordinator)? {
        return childCoordinators[key.value]
    }
    
    public func stop(completion: (() -> Void)? = nil) {
        self.parentCoordinator?.removeChild(coordinator: self)
        completion?()
    }
    
    public func dismiss(animated: Bool = true, completion: (() -> Void)? = nil) {
        navigationController.dismiss(animated: animated) { [weak self] in
            guard let self = self else { return }
            self.stop(completion: completion)
        }
    }
}

// MARK: DeepLink Implementations.
extension Coordinator {
    
    public var isPresentedOnDeepLink: Bool {
        return parentCoordinator?
            .deepLinkedCoordinators
            .contains(where: { $0 is Self }) ?? false
    }
}

// MARK: - Navigation EXT
extension Coordinator {
    
    public func navigate(
        to view: some View,
        with navigationStyle: NavigationStyle,
        animated: Bool = true,
        resetingStack: Bool = false,
        hideNavigationBar: Bool = true,
        hideTabBar: Bool = true,
        isSwipeBackEnable: Bool = true,
        completion: (() -> Void)? = nil
    ) {
        
        let viewController = SwiftUIBaseVC(
            rootView: view,
            hideNavigationBar: hideNavigationBar,
            hideTabBar: hideTabBar,
            isSwipeBackEnable: isSwipeBackEnable
        )
        
        navigate(
            to: viewController,
            with: navigationStyle,
            animated: animated,
            resetingStack: resetingStack,
            completion: completion
        )
    }
    
    public func navigate(
        to viewController: UIViewController,
        with navigationStyle: NavigationStyle,
        animated: Bool = true,
        resetingStack: Bool = false,
        completion: (() -> Void)? = nil
    ) {
        switch navigationStyle {
        case .push:
            navigationController.pushViewController(viewController, animated: animated)
        case .present:
            viewController.modalPresentationStyle = .fullScreen
            viewController.definesPresentationContext = true
            navigationController.present(viewController, animated: animated, completion: completion)
        case .resetStack:
            navigationController.setViewControllers([viewController], animated: animated)
        case .bottomSheet:
            // FIXME: - NOT YET IMPLEMENTED
            break
        case .overCurrentContext:
            viewController.modalPresentationStyle = .overCurrentContext
            navigationController.present(viewController, animated: animated, completion: completion)
        case .overFullScreen:
            viewController.modalPresentationStyle = .overFullScreen
            navigationController.present(viewController, animated: animated, completion: completion)
        case .pop:
            navigationController.popViewController(animated: animated)
        case .reversePush:
            navigationController.addTransition()
            navigationController.pushViewController(viewController, animated: false)
        case .fade:
            navigationController.addTransition(transitionType: .fade)
            navigationController.pushViewController(viewController, animated: false)
        }
    }
}
