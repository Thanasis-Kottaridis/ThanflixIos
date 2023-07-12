//
//  BaseTabBarController.swift
//  SharedPresentation

import UIKit

public struct OpenQuickActions: Action{
    public init() {}
}


public class BaseTabBarController: UITabBarController, UITabBarControllerDelegate {
    weak var parentCoordinator: (any Coordinator)?
    private let blurEffectView = UIVisualEffectView()
    
    public init(parentCoordinator: any Coordinator) {
        self.parentCoordinator = parentCoordinator
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setBlurEffect()
        setTabUI()
        
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    // MARK: Shape Of Tab Bar
    func setBlurEffect() {
        //Blur View Set Up
        blurEffectView.effect = UIBlurEffect(style: .light)
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        //Add Blur To Tab Bar
        tabBar.insertSubview(blurEffectView, at: 0)
    }
    
    func setTabUI() {
        self.delegate = self
        //TabBar UI
        let appearance = UITabBarAppearance()
        appearance.shadowImage = nil
        appearance.shadowColor = .clear
        appearance.backgroundImage = nil
        appearance.backgroundColor = .clear
        appearance.backgroundEffect = .none
        tabBar.standardAppearance = appearance
        tabBar.scrollEdgeAppearance = appearance
        tabBar.tintColor = ColorPalette.BrandPrimary.value
        
        //Set Shadows
        tabBar.layer.shadowOffset = CGSize(width: 0, height: 0)
        tabBar.layer.shadowRadius = 20.adapted()
        tabBar.layer.shadowColor = ColorPalette.EffectShadow.value.cgColor
        tabBar.layer.shadowOpacity = 0.16
    }
}
