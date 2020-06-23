//
//  NewsRepository.swift
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
    "dependencyName": "NewsRepositoryActions",
    "className": "NewsRepository"
 }
 */

protocol NewsRepositoryActions: BaseRepositoryActions {
    func load() -> RequestValue<Promise<[NewsBO]>>
}

class NewsRepository: BaseRepository {
    private lazy var session = GenericSession()
}

extension NewsRepository: NewsRepositoryActions {
    func load() -> RequestValue<Promise<[NewsBO]>> {
        let url = "Constants.ws.NewsDetail"
        let responseSerializer = SDOSJSONResponseSerializer<[NewsDTO], ErrorDTO>()
        let request = session.request(url, method: .get, parameters: nil)
        
        let promise = Promise<[NewsDTO]> { seal in
            request.validate().responseSDOSDecodable(responseSerializer: responseSerializer) {
                (dataResponse: AFDataResponse<[NewsDTO]>) in
                switch dataResponse.result {
                case .success(let items):
                    seal.fulfill(items)
                case .failure(let error):
                    seal.reject(error)
                }
            }
            }.map { items -> [NewsBO] in
                return items.compactMap{ $0.toBO() }
        }
        
        return RequestValue(request: request, value: promise)
    }
}
