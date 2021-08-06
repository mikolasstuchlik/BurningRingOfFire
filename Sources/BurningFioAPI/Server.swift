import FTAPIKit
import Foundation
import FoundationNetworking

protocol Authorized {
    var tokenPlaceholder: String { get }
}

extension Authorized {
    var tokenPlaceholder: String { "auth-token-placholder" }
}

public struct FioServer: URLServer {
    public enum Error: Swift.Error {
        case failedToEmbedTokenIntoAuthorizedEndpoint
    }

    public let baseUri = URL(string: "https://www.fio.cz/ib_api/rest")!
    public let token: String

    public init(token: String) {
        self.token = token
    }

    public func buildRequest(endpoint: Endpoint) throws -> URLRequest {
        let request = try buildStandardRequest(endpoint: endpoint)
        
        return try embedTokenIf(authorized: endpoint, to: request)  
    }

    private func embedTokenIf(authorized endpoint: Endpoint, to request: URLRequest) throws 
    -> URLRequest {
        var requestCopy = request
        if let authorized = endpoint as? Authorized, var url = requestCopy.url {
            var stackOfComponents = [String]()
            while !url.pathComponents.isEmpty {
                stackOfComponents.append(url.lastPathComponent)
                url.deleteLastPathComponent()
                if stackOfComponents.last == authorized.tokenPlaceholder {
                    break
                }
            }

            guard stackOfComponents.last == authorized.tokenPlaceholder else {
                throw Error.failedToEmbedTokenIntoAuthorizedEndpoint
            }

            stackOfComponents[stackOfComponents.count - 1] = token
            stackOfComponents.reversed().forEach { url.appendPathComponent($0) }
            requestCopy.url = url
        }
        return requestCopy
    }
} 