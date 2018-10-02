//
//  Model.swift
//  CoolRocket
//
//  Created by Andrey Karpets on 18/07/2018.
//  Copyright © 2018 DemoApp. All rights reserved.
//

import Foundation


protocol Mappable {
    
    static func object(fromResponse response: JsonReponse) -> Self?
    static func objects(fromResponse response: [JsonReponse]) -> [Self]
}

extension Mappable {

    static func objects(fromResponse response: [JsonReponse]) -> [Self] {
        return response.map({ Self.object(fromResponse: $0 )}).compactMap({ $0 })
    }
}
 
