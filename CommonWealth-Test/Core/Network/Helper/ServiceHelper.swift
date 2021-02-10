//
//  ServiceHelper.swift
//  CommonWealth-Test
//
//  Created by Angga Setiawan on 10/02/21.
//

import Foundation
import Moya

public struct ServiceHelper {

    static var defaultPlugins: [PluginType] {
        var plugins: [PluginType] = [
            NetworkActivityPlugin(networkActivityClosure: { (type, _) in
                DispatchQueue.main.async { UIApplication.shared.isNetworkActivityIndicatorVisible = type == .began }
            }),
        ]
        let config = NetworkLoggerPlugin.Configuration.init(logOptions: .verbose)
        plugins.append(NetworkLoggerPlugin(configuration: config))
        return plugins
    }

    static var emptyMultipartData: Moya.MultipartFormData {
        return MultipartFormData(provider: .data(Data()), name: "empty")
    }

    public static func provider<T: TargetType>(for type: T.Type) -> MoyaProvider<T> {
        return MoyaProvider<T>(plugins: ServiceHelper.defaultPlugins)
    }
}
