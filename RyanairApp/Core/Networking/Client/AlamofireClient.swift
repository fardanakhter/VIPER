//
//  AlamofireClient.swift
//  Dubizzle
//
//  Created by Fardan Akhter on 18/07/2022.
//

import Alamofire
import Foundation

class AlamofireClient: NetworkInteractor {
    
    private let session: Alamofire.Session
    
    init(session: Alamofire.Session) {
        self.session = session
    }
    
    init() {
        let config = URLSessionConfiguration.default
        config.httpAdditionalHeaders = HTTPHeaders.default.dictionary
        config.timeoutIntervalForResource = TimeInterval(30) // seconds
        config.timeoutIntervalForRequest  = TimeInterval(30) // seconds
        self.session = Alamofire.Session(configuration: config)
    }
    
    func request<T>(route: Routable, decoder: JSONDecoder, completion: @escaping((APIResult<T>) -> Void)) where T : Decodable, T : Encodable {
        
        session.request(
            route.path,
            method: HTTPMethod(rawValue: route.method.rawValue),
            parameters: route.params ?? [:],
            encoding: getEncoding(route.parameterEncoding),
            headers: HTTPHeaders(route.headers ?? [:])
        ).validate(
            statusCode: [200]
        ).responseDecodable(
            of: T.self,
            decoder: decoder,
            emptyResponseCodes: [200, 204, 205]
        ) { (response) in
            
            print("API RESPONSE:\n******************************************")
            print(response.debugDescription)
            print("*************************************")
            
            switch response.result {
            case .success(let value):
                completion(.success(value))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    // MARK: - Helper
    private func getEncoding(_ encoding: EncodingType) -> ParameterEncoding {
        switch encoding {
        case .jsonEncoding:
            return JSONEncoding.default
        case .urlEncoding:
            return URLEncoding.default
        }
    }
}
