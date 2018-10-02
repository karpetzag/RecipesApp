//
//  ApiClient.swift
//  CoolRocket
//
//  Created by Andrey Karpets on 18/07/2018.
//  Copyright © 2018 DemoApp. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire

typealias JsonReponse = JSON

typealias RequestParameters = [String: Any]

typealias RequestCompletionHandler = (ApiResult) -> ()

enum HttpMethod {
    case get, post
}

enum ApiInternalError: Int, Error {
    
    case unknown = 1000
    case invalidResponseFormat = 1001
}

struct ApiSuccessResponse {
    let originalData: Any
    let json: JsonReponse
}
 
enum ApiResult {
    case success(ApiSuccessResponse)
    case failure(Error)
}

struct ApiRequest {
    let httpMethod: HttpMethod
    let params: RequestParameters?
    let methodName: String
}

extension ApiRequest {
    
    init(httpMethod: HttpMethod,
         methodName: String,
         params: RequestParameters? = nil) {
        self.httpMethod = httpMethod
        self.methodName = methodName
        self.params = params
    }
}

protocol ApiClient {
    
    func send(request: ApiRequest, withCompletionHandler handler: @escaping RequestCompletionHandler)
    
}

class DefaultApiClient: ApiClient {
    
    private var baseURL = ""
    
    func set(baseURL: String) {
        var urlToSet = baseURL
        if baseURL.last != "/" {
            urlToSet += "/"
        }
        self.baseURL = urlToSet
    }

    func send(request aRequest: ApiRequest, withCompletionHandler handler: @escaping (ApiResult) -> ()) {
        let method: Alamofire.HTTPMethod
        switch aRequest.httpMethod {
        case .get: method = .get
        case .post: method = .post
            
        }
        let url = baseURL + aRequest.methodName
        let params = aRequest.params ?? [:]
      
        request(url,
                method: method,
                parameters: params).validate().responseJSON { (response) in
                    switch response.result {
                    case .success(let val):
                        let json = JSON(val)
                        let result = ApiSuccessResponse(originalData: val, json: json)
                        handler(.success(result))
                    case .failure(let e):
                        handler(.failure(e))
                    }
        }
    }
}
