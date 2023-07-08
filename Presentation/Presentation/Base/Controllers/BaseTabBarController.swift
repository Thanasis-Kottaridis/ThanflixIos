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
        //Mask For Blur View
        let maskView = UIView(frame: view.frame)
        maskView.clipsToBounds = true
        maskView.backgroundColor = UIColor.clear
       
        //Give Mask To BlurView
        blurEffectView.mask = maskView
        //Add Blur To Tab Bar
        tabBar.addSubview(blurEffectView)
    }
    
    func setTabUI() {
        self.delegate = self
        //TabBar UI
        let appearance = UITabBarAppearance()
        appearance.backgroundImage = nil
        appearance.backgroundColor = ColorPalette.White.value
        appearance.selectionIndicatorTintColor = ColorPalette.Red.value

        tabBar.standardAppearance = appearance
        tabBar.tintColor = .systemCyan

        if #available(iOS 15.0, *) {
            self.tabBar.scrollEdgeAppearance = appearance
        }
        //Set Shadows
        tabBar.layer.shadowOffset = CGSize(width: 0, height: 0)
        tabBar.layer.shadowRadius = 20
        tabBar.layer.shadowColor = UIColor.black.cgColor
        tabBar.layer.shadowOpacity = 0.16
    }
}
