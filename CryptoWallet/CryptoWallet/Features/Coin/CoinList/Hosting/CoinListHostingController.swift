import UIKit
import SwiftUI

class CoinListHostingController: UIHostingController<CoinListView> {
    private let viewModel: CoinListViewModel
    
    // MARK: - Init
    init(viewModel: CoinListViewModel) {
        self.viewModel = viewModel
        let coinListView = CoinListView(viewModel: CoinListViewModel())
        super.init(rootView: coinListView)
    }
    
    @MainActor required dynamic init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
}
