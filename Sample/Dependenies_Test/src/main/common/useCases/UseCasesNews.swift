//
//  UseCasesNews.swift
//
//  Created by Rafael Fernandez Alvarez on 12/06/2020.
//  Archivo creado usando la plantilla VIPER por SDOS http://www.sdos.es/
//

import Foundation
import PromiseKit
import SDOSAlamofire
import Alamofire

/*
 Dependency register JSON
 
 {
    "dependencyName": "UseCaseNewsDetail",
    "className": "UseCaseNews.Detail"
 }
 */

//MARK: - Definition
protocol UseCaseNewsDetail: BaseUseCaseProtocol {
    func execute() -> Promise<[NewsBO]>
}

//MARK: - Implementation
struct UseCaseNews {
    class Detail: UseCaseNewsDetail {
        private lazy var repository: NewsRepositoryActions = {
            return Dependency.injector.news.newsDetail.newsRepository.resolveNewsRepositoryActions()
        }()
        var request: Request?
        
        func execute() -> Promise<[NewsBO]> {
            request?.cancel()
            return firstly { [weak self] () -> Promise<[NewsBO]> in
                guard let self = self else { throw PMKError.cancelled }
                let requestValue = repository.load()
                self.request = requestValue.request
                return requestValue.value
            }
        }
    }
}
