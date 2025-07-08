import UIKit
import SnapKit

class CoinListViewController: UIViewController {
    
    private let testCoins = [
        Coin(
            name: "Bitcoin",
            ticker: "BTC",
            image: UIImage(named: "bitcoin"),
            price: "32128.80",
            change: "2.5%",
            isPositiveChange: true
        ),
        Coin(
            name: "Neo",
            ticker: "NEO",
            image: UIImage(named: "bitcoin"),
            price: "13221.55",
            change: "2.2%",
            isPositiveChange: true
        ),
        Coin(
            name: "Ahcain",
            ticker: "ACT",
            image: UIImage(named: "bitcoin"),
            price: "28312.22",
            change: "2.2%",
            isPositiveChange: false
        )
    ]
    
    private let tableView = UITableView()
    private let homeLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 255/255, green: 154/255, blue: 178/255, alpha: 1)
        
        setupUI()
        setupLayout()
    }
    
    private func setupUI() {
        // MARK: TableView
        tableView.register(CoinCell.self, forCellReuseIdentifier: "CoinCell")
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.rowHeight = 70
        tableView.layer.cornerRadius = 40
        tableView.backgroundColor = UIColor(red: 247/255, green: 247/255, blue: 250/255, alpha: 1)
        
        // MARK: HomeLabel
        
    }
    
    private func setupLayout() {
        [tableView, homeLabel].forEach {
            view.addSubview($0)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(258)
            make.centerX.equalToSuperview()
            make.width.equalTo(view.bounds.width)
            make.height.equalTo(554)
        }
    }
}

// MARK: - TableViewDatasource & TableViewDelegate
extension CoinListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return testCoins.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: "CoinCell", for: indexPath) as? CoinCell
        else {
            return UITableViewCell()
        }
        cell.configure(with: testCoins[indexPath.row])
        return cell
    }
}

// MARK: - Coin Cell
class CoinCell: UITableViewCell {
    
    // MARK: Identifier
    static let identifier = "CoinCell"
    
    // MARK: UI Components
    private let coinImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "bitcoin")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 25
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        return label
    }()
    
    private let tickerLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = .lightGray
        return label
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        label.textAlignment = .right
        return label
    }()
    
    private let changeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = .lightGray
        label.textAlignment = .right
        return label
    }()
    
    private let changeArrowImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let leftStackView = UIStackView()
    private let rightStackView = UIStackView()
    private let changeStackView = UIStackView()
    
    // MARK: Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Methods
    private func setupLayout() {
        [coinImageView, leftStackView, rightStackView].forEach {
            contentView.addSubview($0)
        }
        
        coinImageView.snp.makeConstraints { make in
            make.width.height.equalTo(50)
            make.leading.equalToSuperview().offset(25)
            make.centerY.equalToSuperview()
        }
        
        leftStackView.axis = .vertical
        leftStackView.spacing = 6
        leftStackView.alignment = .leading
        leftStackView.addArrangedSubview(nameLabel)
        leftStackView.addArrangedSubview(tickerLabel)
        
        leftStackView.snp.makeConstraints { make in
            make.leading.equalTo(coinImageView.snp.trailing).offset(12)
            make.centerY.equalToSuperview()
        }
        
        changeArrowImageView.snp.makeConstraints { make in
            make.width.height.equalTo(12)
        }
        
        changeStackView.axis = .horizontal
        changeStackView.spacing = 5
        changeStackView.alignment = .center
        changeStackView.addArrangedSubview(changeArrowImageView)
        changeStackView.addArrangedSubview(changeLabel)
        
        rightStackView.axis = .vertical
        rightStackView.spacing = 6
        rightStackView.alignment = .trailing
        rightStackView.addArrangedSubview(priceLabel)
        rightStackView.addArrangedSubview(changeStackView)
        
        rightStackView.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(25)
            make.centerY.equalToSuperview()
        }
    }
    
    func configure(with coin: Coin) {
        nameLabel.text = "\(coin.name)"
        tickerLabel.text = "\(coin.ticker)"
        priceLabel.text = coin.price
        changeLabel.text = coin.change
        
        let arrowImageName = coin.isPositiveChange ? "arrow up" : "arrow down"
        changeArrowImageView.image = UIImage(named: arrowImageName)
        
        coinImageView.image = coin.image
    }
}

// MARK: - Preview
#Preview {
    CoinListTabBarController()
}
