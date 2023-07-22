//
//  ProductionCompaniesMapper.swift
//  Data
//
//  Created by thanos kottaridis on 23/7/23.
//

import Foundation
import Domain

public class ProductionCompaniesMapper: DomainMapper {
    
    public typealias Model = ProductionCompanyDto // TODO ADD DTO (API RESPONSE) MODEL
    
    public typealias DomainModel = ProductionCompany // TODO Add application Model
    
    public init() {}
    
    public func modelToDomain(model: ProductionCompanyDto) -> ProductionCompany {
        return ProductionCompany(id: model.id, logoPath: model.logoPath, name: model.name)
    }
    
    public func domainToModel(domainModel: ProductionCompany) -> ProductionCompanyDto {
        return ProductionCompanyDto()
    }
}
