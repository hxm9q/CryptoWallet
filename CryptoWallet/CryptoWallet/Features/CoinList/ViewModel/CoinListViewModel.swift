import Foundation

final class CoinListViewModel {
    
    private let coinRepository: CoinRepositoryProtocol
    private(set) var coins: [Coin] = []
    private(set) var isLoading: Bool = false
    
    var onUpdate: (() -> Void)?
    var onError: ((String) -> Void)?
    var onLoadingStateChange: ((Bool) -> Void)?
    
    init(coinRepository: CoinRepositoryProtocol = CoinRepository()) {
        self.coinRepository = coinRepository
    }
    
    func fetchCoins() {
        setLoadingState(true)
        
        coinRepository.fetchCoins { [weak self] result in
            DispatchQueue.main.async {
                guard let self = self else { return }
                
                self.setLoadingState(false)
                
                switch result {
                case .success(let coins):
                    self.coins = coins
                    self.onUpdate?()
                    
                case .failure(let error):
                    self.onError?(error.localizedDescription)
                }
            }
        }
    }
    
    func coin(at index: Int) -> Coin? {
        guard index < coins.count else { return nil }
        return coins[index]
    }
    
    func numberOfCoins() -> Int {
        return coins.count
    }
    
    func clearCoins() {
        coins.removeAll()
        onUpdate?()
    }
    
    func sortAscendingByPrice() {
        coins.sort { $0.priceValue < $1.priceValue }
        onUpdate?()
    }
    
    func sortDescendingByPrice() {
        coins.sort { $0.priceValue > $1.priceValue }
        onUpdate?()
    }
    
    private func setLoadingState(_ loading: Bool) {
        isLoading = loading
        onLoadingStateChange?(loading)
    }
}
