import Foundation

// MARK: - CoinData
struct CoinData: Codable {
    let data: [CoinInfo]
}

// MARK: - CoinInfo
struct CoinInfo: Codable {
    let name: String
    let symbol: String
    let metrics: Metrics
}

// MARK: - Metrics
struct Metrics: Codable {
    let marketData: MarketData
    let marketcap: Marketcap
    let supplyActivity: SupplyActivity
    
    enum CodingKeys: String, CodingKey {
        case marketData = "market_data"
        case marketcap
        case supplyActivity = "supply_activity"
    }
}

// MARK: - MarketData
struct MarketData: Codable {
    let priceUsd: Double
    let percentChangeUsdLast24Hours: Double?
    let percentChangeUsdLast7Days: Double?
    let percentChangeUsdLast1Year: Double?
    let percentChangeUsdEver: Double?
    
    enum CodingKeys: String, CodingKey {
        case priceUsd = "price_usd"
        case percentChangeUsdLast24Hours = "percent_change_usd_last_24_hours"
        case percentChangeUsdLast7Days
        case percentChangeUsdLast1Year
        case percentChangeUsdEver
    }
}

// MARK: - Marketcap
struct Marketcap: Codable {
    let rank: Int
    let marketcapDominancePercent: Double
    let currentMarketcapUsd: Double
    
    enum CodingKeys: String, CodingKey {
        case rank
        case marketcapDominancePercent = "marketcap_dominance_percent"
        case currentMarketcapUsd = "current_marketcap_usd"
    }
}

// MARK: - SupplyActivity
struct SupplyActivity: Codable {
    let supplyActive1D: Double?
    let supplyActive7D: Double?
    let supplyActive1Y: Double?
    let supplyActiveEver: Double?
    
    enum CodingKeys: String, CodingKey {
        case supplyActive1D = "supply_active_1d"
        case supplyActive7D = "supply_active_7d"
        case supplyActive1Y = "supply_active_1y"
        case supplyActiveEver = "supply_active_ever"
    }
}
