import UIKit
import SnapKit

class CoinDetailViewController: UIViewController {
    
    static let testCoin = [
        Coin(
            name: "Etherium",
            symbol: "ETH",
            price: 32128.80,
            change: 2.5,
            marketcap: 231233,
            supply1D: 1,
            supply7D: 7,
            supply1Y: 365,
            supplyEver: 1421421
        )
    ]
    
    private let coin: Coin
    private let timeFilterSections = ["24H", "1W", "1Y", "ALL", "Point"]
    private var selectedSupplyValue: Double?
    
    // MARK: - UI Components
    private let nameLabel = UILabel()
    private let priceLabel = UILabel()
    private let changeLabel = UILabel()
    private let changeImageView = UIImageView()
    private let segmentedControl = UISegmentedControl()
    private let tableView = UITableView()
    private let changeStackView = UIStackView()
    
    private let navigationButton = UIButton()
    
    // MARK: - Init
    init(coin: Coin) {
        self.coin = coin
        super.init(nibName: nil, bundle: nil)
        selectedSupplyValue = coin.supply1D
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 243/255, green: 245/255, blue: 246/255, alpha: 1)
        
        setupUI()
        setupLayout()
        setupNavigationButton()
    }
}

// MARK: - Setup UI
private extension CoinDetailViewController {
    
    func setupUI() {
        // MARK: Coin Name Label
        nameLabel.text = "\(coin.name) (\(coin.symbol.uppercased()))"
        nameLabel.font = .systemFont(ofSize: 14, weight: .semibold)
        
        // MARK: Coin Price Label
        priceLabel.text = "$\(coin.price)"
        priceLabel.font = .systemFont(ofSize: 28, weight: .semibold)
        
        // MARK: Change Label
        changeLabel.text = "\(coin.change)"
        changeLabel.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        changeLabel.textColor = .lightGray
        
        // MARK: Change Image Arrow
        changeImageView.contentMode = .scaleAspectFit
        let arrowImageName = coin.isPositiveChange ? "arrow up" : "arrow down"
        changeImageView.image = UIImage(named: arrowImageName)
        
        // MARK: Segmented Control
        segmentedControl.removeAllSegments()
        for (index, title) in timeFilterSections.enumerated() {
            segmentedControl.insertSegment(withTitle: title, at: index, animated: false)
        }
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.addTarget(self, action: #selector(segmentedControlChanged), for: .valueChanged)
        
        // MARK: Table View
        tableView.register(CoinDetailCell.self, forCellReuseIdentifier: CoinDetailCell.identifier)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.rowHeight = 30
        tableView.layer.cornerRadius = 40
        tableView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        tableView.clipsToBounds = true
    }
    
    @objc private func segmentedControlChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            selectedSupplyValue = coin.supply1D
        case 1:
            selectedSupplyValue = coin.supply7D
        case 2:
            selectedSupplyValue = coin.supply1Y
        case 3:
            selectedSupplyValue = coin.supplyEver
        default:
            selectedSupplyValue = nil
        }
        tableView.reloadData()
    }
}

// MARK: - Setup Layout
private extension CoinDetailViewController {
    
    func setupLayout() {
        [nameLabel, priceLabel, changeStackView, segmentedControl, tableView].forEach {
            view.addSubview($0)
        }
        
        changeStackView.axis = .horizontal
        changeStackView.alignment = .center
        changeStackView.spacing = 4
        changeStackView.addArrangedSubview(changeImageView)
        changeStackView.addArrangedSubview(changeLabel)
        
        let screenHeight = UIScreen.main.bounds.height
        let topOffsetTableView: CGFloat = screenHeight < 668 ? 320 : 470
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(view.snp.top).offset(80)
            make.centerX.equalToSuperview()
            make.height.equalTo(21)
        }
        
        priceLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.height.equalTo(42)
        }
        
        changeStackView.snp.makeConstraints { make in
            make.top.equalTo(priceLabel.snp.bottom).offset(3)
            make.centerX.equalToSuperview()
        }
        
        segmentedControl.snp.makeConstraints { make in
            make.top.equalTo(changeLabel.snp.bottom).offset(24)
            make.centerX.equalToSuperview()
            make.width.equalTo(325)
            make.height.equalTo(56)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(topOffsetTableView)
            make.width.equalToSuperview()
            make.height.equalTo(242)
        }
    }
}

// MARK: - Navigation Button Setup
private extension CoinDetailViewController {
    
    func setupNavigationButton() {
        navigationButton.setImage(UIImage(named: "back_button"), for: .normal)
        navigationButton.imageView?.contentMode = .scaleToFill
        navigationButton.layer.cornerRadius = 24
        navigationButton.clipsToBounds = true
        navigationButton.backgroundColor = .white.withAlphaComponent(0.8)
        navigationButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        
        let barButtonItem = UIBarButtonItem(customView: navigationButton)
        navigationItem.hidesBackButton = true
        navigationItem.leftBarButtonItem = barButtonItem
    }
    
    @objc func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
}

// MARK: - TableViewDatasource & TableViewDelegate
extension CoinDetailViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: CoinDetailCell.identifier, for: indexPath) as? CoinDetailCell
        else {
            return UITableViewCell()
        }
        cell.configure(with: coin)
        cell.configureSupply(with: coin, value: selectedSupplyValue)
        return cell
    }
}

// MARK: - Preview
#Preview {
    UINavigationController(rootViewController: CoinDetailViewController(coin: CoinDetailViewController.testCoin[0]))
}
