import Foundation

final class CoinListViewModel: ObservableObject {
    
    weak var coordinator: CoinListCoordinator?
    private let coinRepository: CoinRepositoryProtocol
    
    @Published var coins: [Coin] = []
    @Published var isLoading: Bool = false
    @Published var showError: Bool = false
    @Published var errorMessage: String? = nil
    
    @Published var showRefreshLogoutMenu: Bool = false
    @Published var showSortMenu: Bool = false
    
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
                    
                case .failure(let error):
                    self.showErrorAlert(error.localizedDescription)
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
    
    func refreshCoins() {
        clearCoins()
        fetchCoins()
        hideAllMenus()
    }
    
    func sortAscendingByPrice() {
        coins.sort { $0.priceValue < $1.priceValue }
        hideAllMenus()
    }
    
    func sortDescendingByPrice() {
        coins.sort { $0.priceValue > $1.priceValue }
        hideAllMenus()
    }
    
    private func setLoadingState(_ loading: Bool) {
        isLoading = loading
    }
    
    private func showErrorAlert(_ message: String) {
        errorMessage = message
        showError = true
    }
    
    func toggleRefreshLogoutMenu() {
        showSortMenu = false
        showRefreshLogoutMenu.toggle()
    }
    
    func toggleSortMenu() {
        showRefreshLogoutMenu = false
        showSortMenu.toggle()
    }
    
    func hideAllMenus() {
        showRefreshLogoutMenu = false
        showSortMenu = false
    }
    
    func logout() {
        coordinator?.logout()
    }
    
    func showCoinDetail(at index: Int) {
        guard let coin = coin(at: index) else { return }
        coordinator?.showCoinDetail(coin: coin)
    }
}
