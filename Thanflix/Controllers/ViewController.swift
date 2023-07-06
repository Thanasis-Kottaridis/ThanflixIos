//
//  ViewController.swift
//  Thanflix
//
//  Created by thanos kottaridis on 2/7/23.
//

import UIKit
import Data
import Domain

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.view.backgroundColor = .red
    }

    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        Task.init{
            let result = await MoviesDataContextImpl().getFavoriteMovies()
            
            switch result {
            case .Success(let response):
                print(response)
            case .Failure(let error):
                print(error)
            }
        }
    }

}

