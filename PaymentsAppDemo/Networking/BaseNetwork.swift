//
//  BaseNetwork.swift
//  PaymentsAppDemo
//
//  Created by Laura Sofia Cantero Hernandez on 8/23/20.
//  Copyright © 2020 Sofia Cantero. All rights reserved.
//

import Foundation
import Moya

typealias NetworkFailureBlock = ((Error?) -> ())
typealias NetworkSuccessBlock<T> = ((T) -> ())

class BaseNetwork {
    func processResponse<T>(result: Result<Moya.Response, MoyaError>,
                            success: NetworkSuccessBlock<T>?,
                            failure: NetworkFailureBlock?) where T: Codable {
        switch result {
        case .success(let response):
            do {
                let data = try response.map(T.self)
                success?(data)
            }
            catch let error {
                failure?(error)
            }
        case .failure(let error):
            failure?(error)
        }
    }
}
