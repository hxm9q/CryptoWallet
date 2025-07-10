import Foundation

final class CoinListViewModel {
    
    private(set) var coins: [Coin] = []
    
    var onUpdate: (() -> Void)?
    var onError: ((String) -> Void)?
    
    func fetchCoins() {
        CoinService.shared.fetchCoins { [weak self] coins, error in
            DispatchQueue.main.async {
                if let error = error {
                    self?.onError?(error.localizedDescription)
                } else if let coins = coins {
                    self?.coins = coins
                    self?.onUpdate?()
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
    }
    
    func sortAscendingByPrice() {
        coins.sort { $0.priceValue < $1.priceValue }
        onUpdate?()
    }
    
    func sortDescendingByPrice() {
        coins.sort { $0.priceValue > $1.priceValue }
        onUpdate?()
    }
}
