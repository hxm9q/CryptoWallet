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
    
    private let authViewModel = AuthViewModel()
    
    // MARK: - CoinList Constants
    private enum CoinListConstants {
        static let backgroundColor = UIColor(red: 255/255, green: 154/255, blue: 178/255, alpha: 1)
        static let tableViewBackgroundColor = UIColor(red: 247/255, green: 247/255, blue: 250/255, alpha: 1)
        static let learnMoreButtonBackgroundColor = UIColor(red: 250/255, green: 251/255, blue: 251/255, alpha: 1)
        static let homeImageViewShadowColor = UIColor(red: 231/255, green: 68/255, blue: 109/255, alpha: 1).cgColor
        static let homeImageViewSize: CGFloat = 242
        
    }
    
    // MARK: - UI Components
    private let tableView = UITableView()
    private let homeLabel = UILabel()
    private let affiliateLabel = UILabel()
    private let refreshLogoutButton = UIButton()
    private let learnMoreButton = UIButton()
    private let homeImageView = UIImageView()
    
    private var refreshLogoutMenu: UIView?
    private var sortMenu: UIView?
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = CoinListConstants.backgroundColor
        
        setupUI()
        setupLayout()
        setupTableHeaderView()
    }
}

// MARK: - Setup UI
private extension CoinListViewController {
    
    func setupUI() {
        // MARK: TableView
        tableView.register(CoinCell.self, forCellReuseIdentifier: "CoinCell")
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.rowHeight = 70
        tableView.layer.cornerRadius = 40
        tableView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        tableView.clipsToBounds = true
        tableView.backgroundColor = CoinListConstants.tableViewBackgroundColor
        
        // MARK: Home Label
        homeLabel.text = "Home"
        homeLabel.font = .systemFont(ofSize: 32, weight: .bold)
        homeLabel.textColor = .white
        
        // MARK: Affiliate Label
        affiliateLabel.text = "Affiliate program"
        affiliateLabel.font = .systemFont(ofSize: 20, weight: .semibold)
        affiliateLabel.textColor = .white
        
        // MARK: Refresh & Logout Button
        refreshLogoutButton.setImage(UIImage(named: "threedots"), for: .normal)
        refreshLogoutButton.imageView?.contentMode = .scaleToFill
        refreshLogoutButton.layer.cornerRadius = 25
        refreshLogoutButton.clipsToBounds = true
        refreshLogoutButton.backgroundColor = .white.withAlphaComponent(0.8)
        refreshLogoutButton.addTarget(self, action: #selector(refreshLogoutButtonTapped), for: .touchUpInside)
        
        // MARK: Learn More Button
        learnMoreButton.setTitle("Learn More", for: .normal)
        learnMoreButton.setTitleColor(.black, for: .normal)
        learnMoreButton.titleLabel?.font = .systemFont(ofSize: 14, weight: .regular)
        learnMoreButton.backgroundColor = CoinListConstants.learnMoreButtonBackgroundColor
        learnMoreButton.layer.cornerRadius = 18
        learnMoreButton.clipsToBounds = true
        
        // MARK: Home Image View
        homeImageView.image = UIImage(named: "home_logo")
        homeImageView.contentMode = .scaleAspectFill
        homeImageView.layer.shadowColor = CoinListConstants.homeImageViewShadowColor
        homeImageView.layer.shadowOpacity = 0.7
        homeImageView.layer.shadowOffset = CGSize(width: -30, height: 30)
        homeImageView.layer.shadowRadius = 20
        homeImageView.clipsToBounds = true
        homeImageView.layer.masksToBounds = true
    }
}

// MARK: - Setup Layout
private extension CoinListViewController {
    
    func setupLayout() {
        [homeImageView, tableView, homeLabel, refreshLogoutButton, affiliateLabel, learnMoreButton].forEach {
            view.addSubview($0)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(258)
            make.centerX.equalToSuperview()
            make.width.equalTo(view.bounds.width)
            make.height.equalTo(554)
        }
        
        homeLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(-32)
            make.leading.equalTo(view.snp.leading).offset(25)
            make.height.equalTo(48)
            make.width.equalTo(97)
        }
        
        affiliateLabel.snp.makeConstraints { make in
            make.top.equalTo(homeLabel.snp.bottom).offset(46)
            make.leading.equalTo(view.snp.leading).offset(25)
            make.height.equalTo(30)
            make.width.equalTo(172)
        }
        
        refreshLogoutButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(-32)
            make.trailing.equalTo(view.snp.trailing).offset(-25)
            make.width.height.equalTo(48)
        }
        
        learnMoreButton.snp.makeConstraints { make in
            make.top.equalTo(affiliateLabel.snp.bottom).offset(21)
            make.leading.equalTo(view.snp.leading).offset(25)
            make.height.equalTo(35)
            make.width.equalTo(127)
        }
        
        homeImageView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(90)
            make.leading.equalTo(view.snp.leading).offset(165)
            make.width.height.equalTo(CoinListConstants.homeImageViewSize)
        }
    }
}

// MARK: - Setup Table Header View
private extension CoinListViewController {
    
    func setupTableHeaderView() {
        let tableHeaderView = UIView()
        tableHeaderView.frame = CGRect(x: 0, y: 0, width: tableView.frame.width, height: 60)
        
        let trendingLabel = UILabel()
        trendingLabel.text = "Trending"
        trendingLabel.textColor = .black
        trendingLabel.font = .systemFont(ofSize: 20, weight: .semibold)
        
        let sortButton = UIButton()
        sortButton.setImage(UIImage(named: "Search icon"), for: .normal)
        sortButton.addTarget(self, action: #selector(sortButtonTapped), for: .touchUpInside)
        
        [trendingLabel, sortButton].forEach {
            tableHeaderView.addSubview($0)
        }
        
        trendingLabel.snp.makeConstraints { make in
            make.top.equalTo(tableHeaderView.snp.top).offset(20)
            make.leading.equalTo(tableHeaderView.snp.leading).offset(25)
            make.width.equalTo(90)
            make.height.equalTo(30)
        }
        
        sortButton.snp.makeConstraints { make in
            make.top.equalTo(tableHeaderView.snp.top).offset(20)
            make.trailing.equalTo(tableHeaderView.snp.trailing).offset(-25)
            make.width.height.equalTo(24)
        }
        
        tableView.tableHeaderView = tableHeaderView
    }
}

// MARK: - Refresh & Logout Pop Up Menu
private extension CoinListViewController {
    
    @objc func refreshLogoutButtonTapped() {
        if refreshLogoutMenu == nil {
            let menu = UIView()
            menu.backgroundColor = .white
            menu.layer.cornerRadius = 16
            
            view.addSubview(menu)
            menu.snp.makeConstraints { make in
                make.width.equalTo(157)
                make.height.equalTo(102)
                make.top.equalTo(refreshLogoutButton.snp.bottom).offset(8)
                make.leading.equalTo(view.snp.leading).offset(209)
            }
            
            // MARK: Configs
            var refreshConfig = UIButton.Configuration.plain()
            refreshConfig.image = UIImage(named: "rocket")
            refreshConfig.title = "Обновить"
            refreshConfig.baseForegroundColor = .black
            refreshConfig.imagePadding = 8
            refreshConfig.imagePlacement = .leading
            
            var logoutConfig = UIButton.Configuration.plain()
            logoutConfig.image = UIImage(named: "trash")
            logoutConfig.title = "Выйти"
            logoutConfig.baseForegroundColor = .black
            logoutConfig.imagePadding = 8
            logoutConfig.imagePlacement = .leading
            
            // MARK: Buttons
            let refreshButton = UIButton()
            refreshButton.configuration = refreshConfig
            refreshButton.addTarget(self, action: #selector(refreshButtonTapped), for: .touchUpInside)
            
            let logoutButton = UIButton()
            logoutButton.configuration = logoutConfig
            logoutButton.addTarget(self, action: #selector(logoutButtonTapped), for: .touchUpInside)
            
            // MARK: Stack
            let stack = UIStackView(arrangedSubviews: [refreshButton, logoutButton])
            stack.axis = .vertical
            stack.distribution = .fillEqually
            stack.spacing = 6
            stack.alignment = .leading
            
            menu.addSubview(stack)
            stack.snp.makeConstraints { make in
                make.edges.equalToSuperview().inset(10)
            }
            
            refreshLogoutMenu = menu
        } else {
            refreshLogoutMenu?.removeFromSuperview()
            refreshLogoutMenu = nil
        }
    }
    
    @objc func refreshButtonTapped() {
        // после подключения апи доделать
        refreshLogoutMenu?.removeFromSuperview()
        refreshLogoutMenu = nil
    }
    
    @objc func logoutButtonTapped() {
        authViewModel.logout()
        refreshLogoutMenu?.removeFromSuperview()
        refreshLogoutMenu = nil
    }
}

// MARK: - Sort Pop Up Menu
private extension CoinListViewController {
    
    @objc func sortButtonTapped() {
        if sortMenu == nil {
            let menu = UIView()
            menu.backgroundColor = .white
            menu.layer.cornerRadius = 16
            
            view.addSubview(menu)
            menu.snp.makeConstraints { make in
                make.width.equalTo(140)
                make.height.equalTo(80)
                make.bottom.equalTo(tableView.snp.top).offset(-10)
                make.leading.equalTo(view.snp.leading).offset(240)
            }
            
            // MARK: Configs
            var ascendingConfig = UIButton.Configuration.plain()
            ascendingConfig.title = "Ascending"
            ascendingConfig.baseForegroundColor = .black
            
            var descendingConfig = UIButton.Configuration.plain()
            descendingConfig.title = "Descending"
            descendingConfig.baseForegroundColor = .black
            
            // MARK: Buttons
            let ascendingButton = UIButton()
            ascendingButton.configuration = ascendingConfig
            ascendingButton.addTarget(self, action: #selector(ascendingButtonTapped), for: .touchUpInside)
            
            let descendingButton = UIButton()
            descendingButton.configuration = descendingConfig
            descendingButton.addTarget(self, action: #selector(descendingButtonTapped), for: .touchUpInside)
            
            // MARK: Stack
            let stack = UIStackView(arrangedSubviews: [ascendingButton, descendingButton])
            stack.axis = .vertical
            stack.distribution = .fillProportionally
            stack.spacing = 8
            stack.alignment = .center
            
            menu.addSubview(stack)
            stack.snp.makeConstraints { make in
                make.edges.equalToSuperview().inset(12)
            }
            
            sortMenu = menu
        } else {
            sortMenu?.removeFromSuperview()
            sortMenu = nil
        }
    }
    
    @objc func ascendingButtonTapped() {
        // сортировка по возрастанию
    }
    
    @objc func descendingButtonTapped() {
        // сортировка по убыванию
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

// MARK: - Preview
#Preview {
    CoinListTabBarController()
}
