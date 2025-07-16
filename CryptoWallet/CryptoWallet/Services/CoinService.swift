import Foundation

class CoinService {
    
    static let shared = CoinService()
    private init() {}
    
    private let urlString = "https://data.messari.io/api/v1/assets"
    private let coinsToFetch = ["btc", "eth", "tron", "luna", "polkadot", "doge", "tether", "stellar", "cardano", "xrp"]
    
    func fetchCoins(completion: @escaping ([Coin]?, Error?) -> Void) {
        guard let url = URL(string: urlString) else {
            completion(nil, NSError(
                domain: "",
                code: -1,
                userInfo: [NSLocalizedDescriptionKey: "Invalid URL"]
            ))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(nil, error)
                return
            }
            
            guard let data = data else {
                completion(nil, NSError(
                    domain: "",
                    code: -2,
                    userInfo: [NSLocalizedDescriptionKey: "No data received"]
                ))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let coinData = try decoder.decode(CoinData.self, from: data)
                
                let filteredData = coinData.data.filter { coinInfo in
                    let lowercasedName = coinInfo.name.lowercased()
                    let lowercasedSymbol = coinInfo.symbol.lowercased()
                    return self.coinsToFetch.contains(lowercasedName) || self.coinsToFetch.contains(lowercasedSymbol)
                }
                
                let coins = filteredData.map { coinInfo in
                    Coin(
                        name: coinInfo.name,
                        symbol: coinInfo.symbol,
                        price: coinInfo.metrics.marketData.priceUsd,
                        change24H: coinInfo.metrics.marketData.percentChangeUsdLast24Hours,
                        change7D: coinInfo.metrics.marketData.percentChangeUsdLast7Days,
                        change1Y: coinInfo.metrics.marketData.percentChangeUsdLast1Year,
                        changeEver: coinInfo.metrics.marketData.percentChangeUsdEver,
                        marketcap: coinInfo.metrics.marketcap.currentMarketcapUsd,
                        supply1D: coinInfo.metrics.supplyActivity.supplyActive1D,
                        supply7D: coinInfo.metrics.supplyActivity.supplyActive7D,
                        supply1Y: coinInfo.metrics.supplyActivity.supplyActive1Y,
                        supplyEver: coinInfo.metrics.supplyActivity.supplyActiveEver
                    )
                }
                completion(coins, nil)
            } catch {
                completion(nil, error)
            }
        }.resume()
    }
}
