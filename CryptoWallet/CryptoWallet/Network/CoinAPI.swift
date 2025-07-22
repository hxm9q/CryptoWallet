import Foundation

enum CoinAPI {
    case fetchCoins
}

extension CoinAPI: Endpoint {
    
    var baseURL: String {
        return "https://data.messari.io/api/v1"
    }
    
    var path: String {
        switch self { case .fetchCoins: return "/assets" }
    }
    
    var method: HTTPMethod {
        return .GET
    }
    
    var headers: [String : String]? {
        return ["Content-Type": "application/json"]
    }
    
    var parameters: [String : Any]? {
        return nil
    }
    
    var queryItems: [URLQueryItem]? {
        return nil
    }
}
