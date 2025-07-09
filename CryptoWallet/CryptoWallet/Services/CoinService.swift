import Foundation

class CoinService {
    
    static let shared = CoinService()
    private init() {}
    
    private let urlString = "https://data.messari.io/api/v1/assets"
    
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
                let coins = coinData.data.map { coinInfo in
                    Coin(
                        name: coinInfo.name,
                        symbol: coinInfo.symbol,
                        price: coinInfo.metrics.marketData.priceUsd,
                        change: coinInfo.metrics.marketData.percentChangeUsdLast24Hours
                    )
                }
                completion(coins, nil)
            } catch {
                completion(nil, error)
            }
        }.resume()
    }
}
