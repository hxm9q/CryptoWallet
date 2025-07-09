import Foundation

struct CoinData: Codable {
    let data: [CoinInfo]
}

struct CoinInfo: Codable {
    let name: String
    let symbol: String
    let metrics: Metrics
}

struct Metrics: Codable {
    let marketData: MarketData
    
    enum CodingKeys: String, CodingKey {
        case marketData = "market_data"
    }
}

struct MarketData: Codable {
    let priceUsd: Double
    let percentChangeUsdLast24Hours: Double
    
    enum CodingKeys: String, CodingKey {
        case priceUsd = "price_usd"
        case percentChangeUsdLast24Hours = "percent_change_usd_last_24_hours"
    }
}
