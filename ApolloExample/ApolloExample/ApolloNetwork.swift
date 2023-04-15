//
//  ApolloNetwork.swift
//  ApolloNetwork
//
//  Created by Gunjit on 06/08/21.
//

import Foundation
import Apollo

class ApolloNetwork {
  static let shared = ApolloNetwork()
    
    private init(){}
    
  private(set) lazy var apollo: ApolloClient = {
      // The cache is necessary to set up the store, which we're going to hand to the provider
      let cache = InMemoryNormalizedCache()
      let store = ApolloStore(cache: cache)
      let configuration = URLSessionConfiguration.default
      configuration.timeoutIntervalForRequest = 30.0
      configuration.timeoutIntervalForResource = 30.0
      let client = URLSessionClient(sessionConfiguration: configuration, callbackQueue: nil)
      let provider = NetworkInterceptorProvider(store: store, client: client)
      let url = URL(string: "https://rickandmortyapi.com/graphql")!

      let requestChainTransport = RequestChainNetworkTransport(interceptorProvider: provider,
                                                               endpointURL: url, useGETForQueries: true)
                                                               
      // Remember to give the store you already created to the client so it
      // doesn't create one on its own
      
      
      return ApolloClient(networkTransport: requestChainTransport,
                                store: store)
  }()
}


struct NetworkInterceptorProvider: InterceptorProvider {
    
    // These properties will remain the same throughout the life of the `InterceptorProvider`, even though they
    // will be handed to different interceptors.
    private let store: ApolloStore
    private let client: URLSessionClient
    
    init(store: ApolloStore,
         client: URLSessionClient) {
        self.store = store
        self.client = client
    }
    
    func interceptors<Operation>(for operation: Operation) -> [ApolloInterceptor] {
        return [
            MaxRetryInterceptor(),
            CacheReadInterceptor(store: self.store),
            RequestLoggingInterceptor(),
            NetworkFetchInterceptor(client: self.client),
            ResponseLoggingInterceptor(),
            ResponseCodeInterceptor(),
            JSONResponseParsingInterceptor(),
            //JSONResponseParsingInterceptor(cacheKeyForObject: self.store.cacheKeyForObject),
            AutomaticPersistedQueryInterceptor(),
            CacheWriteInterceptor(store: self.store)
        ]
    }
}


class ResponseLoggingInterceptor: ApolloInterceptor {
   // let logger = Logger(label: "Apollo")
    enum ResponseLoggingError: Error {
        case notYetReceived
    }
    
    func interceptAsync<Operation>(
        chain: RequestChain,
        request: HTTPRequest<Operation>,
        response: HTTPResponse<Operation>?,
        completion: @escaping (Result<GraphQLResult<Operation.Data>, Error>) -> Void) {
        
        defer {
            // Even if we can't log, we still want to keep going.
            chain.proceedAsync(request: request,
                               response: response,
                               completion: completion)
        }
        
        guard let receivedResponse = response else {
            chain.handleErrorAsync(ResponseLoggingError.notYetReceived,
                                   request: request,
                                   response: response,
                                   completion: completion)
            return
        }

          //  logger.debug("HTTP Response: \(receivedResponse.httpResponse)")
        
        if let stringData = String(bytes: receivedResponse.rawData, encoding: .utf8) {
           // logger.debug("Data: \(stringData)")
        } else {
           // logger.debug("Could not convert data to string!")
        }
    }
}


class RequestLoggingInterceptor: ApolloInterceptor {
   // let logger = Logger(label: "Apollo")
    func interceptAsync<Operation>(
        chain: RequestChain,
        request: HTTPRequest<Operation>,
        response: HTTPResponse<Operation>?,
        completion: @escaping (Result<GraphQLResult<Operation.Data>, Error>) -> Void) {
       // logger.debug("Outgoing request: \(request)")
       // request.addHeader(name: "devicetype", value: Constants.DEVICE_TYPE)
         //   request.addHeader(name: "authorization", value: "user:gh.0ebb1b63-4be8-417d-9b6f-3ad717d80d34:clemMPcfseGbEpSG3V3pgg")
          //  request.addHeader(name: "content-type", value: "Application/JSON")
//        request.addHeader(name: "Cookie", value: "connect.sid=s%3AevslbW3FqUVxm_x5CbG_RyGj1bra24sU.BLSrfJvCl0r%2Fg%2FDOY2cK3X6Tq8w3ibgoRq5k2ERagL8; Domain=.byjusexamprep.com; Path=/; Expires=Fri, 28 Oct 2022 14:31:57 GMT; HttpOnly;statefree=true")
        chain.proceedAsync(request: request,
                           response: response,
                           completion: completion)
    }
}
