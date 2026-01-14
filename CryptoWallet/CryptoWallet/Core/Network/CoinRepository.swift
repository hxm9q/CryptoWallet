import Foundation

protocol CoinRepositoryProtocol {
    func fetchCoins(completion: @escaping (Result<[Coin], NetworkError>) -> Void)
}

class CoinRepository: CoinRepositoryProtocol {
    
    private let networkService: NetworkServiceProtocol
    private let coinsToFetch = ["btc", "eth", "tron", "luna", "polkadot", "doge", "tether", "stellar", "cardano", "xrp"]
    
    init(networkService: NetworkServiceProtocol = NetworkService.shared) {
        self.networkService = networkService
    }
    
    func fetchCoins(completion: @escaping (Result<[Coin], NetworkError>) -> Void) {
        networkService.request(CoinAPI.fetchCoins, responseType: CoinData.self) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let coinData):
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
                completion(.success(coins))
                
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
