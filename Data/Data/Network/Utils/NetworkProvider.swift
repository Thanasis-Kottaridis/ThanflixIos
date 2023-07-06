//
//  NetworkProvider.swift
//  Data
//
//  Created by thanos kottaridis on 13/2/23.
//

import Foundation
import Domain
import Alamofire // SOS... Needs alamofire 5

/**
 # Network Provider Protocol
 We use this protocol in order to provade an implementation
 of Alamofire session Manager with custom configurations.
 
 It will also be used in order to make alamofire requests tesable.
 */
public protocol NetworkProvider {
    /*
     What mutating get does?
     
     A lazy stored property is a property whose initial value
     is not calculated until the first time it is used.
     
     By default get computed properties asumes that has
     initializes at protocol conformance (nonmutating get).
     So by using `mutating get` we tell swift that object
     will change after its declaration.
     */
    /**
     # sessionManager:
     This var provides an `Alamofire` sessionManager with custom Configurations
     based on app useCase.
     */
    var sessionManager: Session { mutating get }
}

public class NetworkProviderImpl: NetworkProvider {
    
    lazy public var sessionManager: Session = {
        //1
        let configuration = URLSessionConfiguration.af.default
        //2
        configuration.timeoutIntervalForRequest = 30
        //3
        return Session(configuration: configuration)
    }()
        
    public init() {}
    
    // TODO: - Add more implementation
}

