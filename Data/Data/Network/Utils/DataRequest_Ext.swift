//
//  DataRequest+Extensions.swift
//  iOSGovWallet
//
//  Created by Victor Benetatos on 6/3/22.
//

import Foundation
import Domain
import Alamofire

// MARK: Raw responses Wrappers Async Await EXT
extension DataRequest {
    
    public func validateRawResponseWrapper<T: Codable>(
        fromType: T.Type
    ) async -> Domain.Result<T?, BaseException> {
        return await validateRawResponseWrapper(
            fromType: T.self,
            mapperType: T.self,
            mapper: { response in
                return response
            }
        )
    }
    
    @discardableResult
    public func validateRawResponseWrapper<T, M>(
        fromType: T.Type,
        mapperType: M.Type,
        mapper: @escaping (T) -> M?
    ) async -> Domain.Result<M?, BaseException> where T: (Codable) {
        
        return await withCheckedContinuation { continuation in
            _ = self.validate()
                .responseDecodable(of: T.self) { (response: AFDataResponse<T>) in
                    switch response.result {
                    case .success(let dataResponse):
                        let mappedData = mapper(dataResponse)
                        continuation.resume(returning: Result.Success(mappedData))
                    case .failure(let error):
                        print("error is: \(error.localizedDescription)")
                        continuation.resume(
                            returning: Result.Failure(
                                BaseException(
                                    errorCode: error.responseCode ?? -1,
                                    throwable: error
                                ))
                        )
                    }
                }.cURLDescription()
        }
    }
    
    @discardableResult
    public func validateRawResponseWrapper<T>(
        fromType: T.Type,
        cacheLocally: @escaping (T?) -> Void
    ) async -> Domain.Result<T?, BaseException> where T: (Codable) {
        return await validateRawResponseWrapper(
            fromType: T.self,
            mapperType: T.self,
            mapper: { response in
                return response
            },
            cacheLocally: cacheLocally
        )
    }
    
    @discardableResult
    public func validateRawResponseWrapper<T, M>(
        fromType: T.Type,
        mapperType: M.Type,
        mapper: @escaping (T) -> M?,
        cacheLocally: @escaping (M?) -> Void
    ) async -> Domain.Result<M?, BaseException> where T: (Codable) {
        
        let result = await validateRawResponseWrapper(
            fromType: T.self,
            mapperType: M.self,
            mapper: mapper
        )
        
        switch result {
        case .Success(let data):
            cacheLocally(data)
            return result
        case .Failure(_):
            return result
        }
    }
    
    @discardableResult
    public func validateRawResponseWrapper<T>(
        fromType: T.Type,
        cacheLocally: @escaping (T?) -> Void,
        getLocalData: @escaping () -> T?,
        forceUpdate: Bool
    ) async -> Domain.Result<T?, BaseException> where T: (Codable) {
        return await validateRawResponseWrapper(
            fromType: T.self,
            mapperType: T.self,
            mapper: { response in
                return response
            },
            cacheLocally: cacheLocally,
            getLocalData: getLocalData,
            forceUpdate: forceUpdate
        )
    }
    
    @discardableResult
    public func validateRawResponseWrapper<T, M>(
        fromType: T.Type,
        mapperType: M.Type,
        mapper: @escaping (T) -> M?,
        cacheLocally: @escaping (M?) -> Void,
        getLocalData: @escaping () -> M?,
        forceUpdate: Bool
    ) async -> Domain.Result<M?, BaseException> where T: (Codable) {
        
        if !forceUpdate, let localData = getLocalData() {
            return Result.Success(localData)
        } else {
            return await validateRawResponseWrapper(
                fromType: T.self,
                mapperType: M.self,
                mapper: mapper,
                cacheLocally: cacheLocally
            )
        }
    }
}
