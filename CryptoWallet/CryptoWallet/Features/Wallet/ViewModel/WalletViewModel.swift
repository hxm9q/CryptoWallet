import UIKit

final class WalletViewModel {
    
    weak var coordinator: WalletCoordinator?
    
    let title: String
    var transactions: [Wallet] = []
    
    init(title: String) {
        self.title = title
    }
    
    func loadTransactions() {
        transactions = [ Wallet(name: "Bitcoin Purchase", amount: 0.0005, date: "15-08-2025") ]
    }
    
    func showWalletDetail() {
        let btcPurchase = transactions[0]
        coordinator?.showWalletDetail(wallet: btcPurchase)
    }
}
