import UIKit
import SnapKit

class CoinDetailViewController: UIViewController {
    
    // MARK: - Test Coin Instance For Testing in Preview
    static let testCoin = [
        Coin(
            name: "Bitcoin",
            symbol: "BTC",
            price: 32128.80,
            change24H: 2.5,
            change7D: -1.2,
            change1Y: nil,
            changeEver: 120.5,
            marketcap: 231233,
            supply1D: nil,
            supply7D: 7,
            supply1Y: 365,
            supplyEver: 1421421
        )
    ]
    
    // MARK: - ViewModel
    let viewModel: CoinDetailViewModel
    
    // MARK: - Constants
    private enum CoinDetailConstants {
        static let backgroundColor = UIColor(red: 243/255, green: 245/255, blue: 246/255, alpha: 1)
        static let screenHeight = UIScreen.main.bounds.height
        static let topOffsetTableView: CGFloat = screenHeight < 668 ? 320 : 470
    }
    
    // MARK: - UI Components
    private let nameLabel = UILabel()
    private let priceLabel = UILabel()
    private let changeLabel = UILabel()
    private let changeImageView = UIImageView()
    private let segmentedControl = SegmentedControl()
    private let tableView = UITableView()
    private let changeStackView = UIStackView()
    private let navigationButton = UIButton()
    
    // MARK: - Init
    init(viewModel: CoinDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    convenience init(coin: Coin) {
        let viewModel = CoinDetailViewModel(coin: coin)
        self.init(viewModel: viewModel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = CoinDetailConstants.backgroundColor
        
        setupUI()
        setupLayout()
        setupNavigationButton()
        updateChangeDisplay()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
}

// MARK: - Setup UI
private extension CoinDetailViewController {
    
    func setupUI() {
        // MARK: Labels
        nameLabel.text = viewModel.displayName
        nameLabel.font = .systemFont(ofSize: 14, weight: .semibold)
        
        priceLabel.text = viewModel.displayPrice
        priceLabel.font = .systemFont(ofSize: 28, weight: .semibold)
        
        changeLabel.text = ""
        changeLabel.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        changeLabel.textColor = .lightGray
        
        // MARK: Change Image Arrow
        changeImageView.contentMode = .scaleAspectFit
        
        // MARK: Segmented Control
        segmentedControl.removeAllSegments()
        for (index, title) in viewModel.timeFilters.enumerated() {
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
        tableView.isScrollEnabled = false
    }
    
    @objc func segmentedControlChanged(_ sender: UISegmentedControl) {
        viewModel.updateSelectedIndex(sender.selectedSegmentIndex)
        updateChangeDisplay()
        tableView.reloadData()
    }
    
    func updateChangeDisplay() {
        if let changeValue = viewModel.selectedChangeValue() {
            let formatter = NumberFormatter()
            formatter.minimumFractionDigits = 0
            formatter.maximumFractionDigits = 2
            let formattedNumber = formatter.string(from: NSNumber(value: changeValue)) ?? "\(changeValue)"
            let formattedChange = "\(formattedNumber)%"
            
            changeLabel.text = formattedChange
            changeLabel.textColor = .lightGray
            changeLabel.font = .systemFont(ofSize: 14, weight: .medium)
            
            let imageName = viewModel.arrowImageName
            changeImageView.image = UIImage(named: imageName)
            changeImageView.isHidden = false
        } else {
            changeLabel.text = "N/A"
            changeLabel.textColor = .lightGray
            changeLabel.font = .italicSystemFont(ofSize: 14)
            changeImageView.isHidden = true
        }
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
            make.top.equalTo(view.safeAreaLayoutGuide).offset(CoinDetailConstants.topOffsetTableView)
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
        
        let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(backButtonTapped))
        swipeGesture.direction = .right
        view.addGestureRecognizer(swipeGesture)
    }
    
    @objc func backButtonTapped() {
        viewModel.goBack()
    }
}

// MARK: - TableViewDatasource & TableViewDelegate
extension CoinDetailViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: CoinDetailCell.identifier, for: indexPath) as? CoinDetailCell
        else {
            return UITableViewCell()
        }
        let coin = viewModel.coinData()
        cell.configure(with: coin)
        cell.configureSupply(with: coin, value: viewModel.selectedSupplyValue())
        return cell
    }
}

// MARK: - Preview
#Preview {
    UINavigationController(rootViewController: CoinDetailViewController(coin: CoinDetailViewController.testCoin[0]))
}
