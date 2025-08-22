//import UIKit
//import SnapKit
//
//class CoinListViewController: UIViewController {
//    
//    // MARK: - ViewModel
//    private let coinListViewModel: CoinListViewModel
//    
//    init(coinListViewModel: CoinListViewModel) {
//        self.coinListViewModel = coinListViewModel
//        super.init(nibName: nil, bundle: nil)
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    // MARK: - CoinList Constants
//    private enum CoinListConstants {
//        static let backgroundColor = UIColor(red: 255/255, green: 154/255, blue: 178/255, alpha: 1)
//        static let tableViewBackgroundColor = UIColor(red: 247/255, green: 247/255, blue: 250/255, alpha: 1)
//        static let learnMoreButtonBackgroundColor = UIColor(red: 250/255, green: 251/255, blue: 251/255, alpha: 1)
//        static let homeImageViewShadowColor = UIColor(red: 231/255, green: 68/255, blue: 109/255, alpha: 1).cgColor
//        static let homeImageViewSize: CGFloat = 210
//    }
//    
//    // MARK: - UI Components
//    private let tableView = UITableView()
//    private let homeLabel = UILabel()
//    private let affiliateLabel = UILabel()
//    private let refreshLogoutButton = UIButton()
//    private let learnMoreButton = UIButton()
//    private let homeImageView = UIImageView()
//    private let activityIndicator = UIActivityIndicatorView()
//    private let footerView = UIView()
//    private var refreshLogoutMenu: UIView?
//    private var sortMenu: UIView?
//    
//    private var tapGestureRecognizer: UITapGestureRecognizer?
//    
//    // MARK: - Lifecycle
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        view.backgroundColor = CoinListConstants.backgroundColor
//        
//        setupUI()
//        setupLayout()
//        setupTableView()
//        bindViewModel()
//        coinListViewModel.fetchCoins()
//    }
//    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        navigationController?.setNavigationBarHidden(true, animated: false)
//    }
//}
//
// MARK: - Setup UI
//private extension CoinListViewController {
//    
//    func setupUI() {
//        // MARK: TableView
//        tableView.register(CoinCell.self, forCellReuseIdentifier: "CoinCell")
//        tableView.dataSource = self
//        tableView.delegate = self
//        tableView.separatorStyle = .none
//        tableView.rowHeight = 70
//        tableView.layer.cornerRadius = 40
//        tableView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
//        tableView.clipsToBounds = true
//        tableView.backgroundColor = CoinListConstants.tableViewBackgroundColor
//        
//        // MARK: Labels
//        homeLabel.text = "Home"
//        homeLabel.font = .systemFont(ofSize: 32, weight: .bold)
//        homeLabel.textColor = .white
//        
//        affiliateLabel.text = "Affiliate program"
//        affiliateLabel.font = .systemFont(ofSize: 20, weight: .semibold)
//        affiliateLabel.textColor = .white
//        
//        // MARK: Buttons
//        refreshLogoutButton.setImage(UIImage(named: "threedots"), for: .normal)
//        refreshLogoutButton.imageView?.contentMode = .scaleAspectFit
//        refreshLogoutButton.layer.cornerRadius = 24
//        refreshLogoutButton.clipsToBounds = true
//        refreshLogoutButton.backgroundColor = .white.withAlphaComponent(0.8)
//        refreshLogoutButton.addTarget(self, action: #selector(refreshLogoutButtonTapped), for: .touchUpInside)
//        
//        learnMoreButton.setTitle("Learn More", for: .normal)
//        learnMoreButton.setTitleColor(.black, for: .normal)
//        learnMoreButton.titleLabel?.font = .systemFont(ofSize: 14, weight: .regular)
//        learnMoreButton.backgroundColor = CoinListConstants.learnMoreButtonBackgroundColor
//        learnMoreButton.layer.cornerRadius = 18
//        learnMoreButton.clipsToBounds = true
//        
//        // MARK: Home Image View
//        homeImageView.image = UIImage(named: "home_logo")
//        homeImageView.contentMode = .scaleAspectFill
//        homeImageView.layer.shadowColor = CoinListConstants.homeImageViewShadowColor
//        homeImageView.layer.shadowOpacity = 0.7
//        homeImageView.layer.shadowOffset = CGSize(width: -30, height: 30)
//        homeImageView.layer.shadowRadius = 20
//        homeImageView.clipsToBounds = true
//        homeImageView.layer.masksToBounds = true
//        
//        // MARK: Activity Indicator
//        activityIndicator.style = .medium
//        activityIndicator.color = .gray
//        activityIndicator.hidesWhenStopped = true
//        
//        // MARK: Footer View
//        footerView.frame = CGRect(x: 0, y: 0, width: tableView.frame.width, height: 30)
//        footerView.addSubview(activityIndicator)
//    }
//}
//
// MARK: - Setup Layout
//private extension CoinListViewController {
//    
//    func setupLayout() {
//        [homeImageView, tableView, homeLabel, affiliateLabel, learnMoreButton, refreshLogoutButton].forEach {
//            view.addSubview($0)
//        }
//        
//        refreshLogoutButton.snp.makeConstraints { make in
//            make.top.equalTo(view.snp.top).offset(100)
//            make.trailing.equalTo(view.snp.trailing).offset(-25)
//            make.width.height.equalTo(48)
//        }
//        
//        homeLabel.snp.makeConstraints { make in
//            make.top.equalTo(refreshLogoutButton.snp.top)
//            make.leading.equalToSuperview().offset(25)
//        }
//        
//        affiliateLabel.snp.makeConstraints { make in
//            make.top.equalTo(homeLabel.snp.bottom).offset(46)
//            make.leading.equalTo(homeLabel.snp.leading)
//            make.height.equalTo(30)
//            make.width.equalTo(172)
//        }
//        
//        learnMoreButton.snp.makeConstraints { make in
//            make.top.equalTo(affiliateLabel.snp.bottom).offset(12)
//            make.leading.equalTo(homeLabel.snp.leading)
//            make.height.equalTo(35)
//            make.width.equalTo(127)
//        }
//        
//        homeImageView.snp.makeConstraints { make in
//            make.top.equalTo(refreshLogoutButton.snp.bottom).offset(21)
//            make.trailing.equalTo(view.snp.trailing).inset(-2)
//            make.width.height.equalTo(CoinListConstants.homeImageViewSize)
//        }
//        
//        tableView.snp.makeConstraints { make in
//            make.top.equalTo(learnMoreButton.snp.bottom).offset(55)
//            make.leading.equalToSuperview()
//            make.trailing.equalToSuperview()
//            make.bottom.equalTo(view.safeAreaLayoutGuide)
//        }
//        
//        activityIndicator.snp.makeConstraints { make in
//            make.centerX.equalToSuperview()
//            make.centerY.equalToSuperview().offset(120)
//        }
//    }
//}
//
// MARK: - Setup Table Header & Footer View
//private extension CoinListViewController {
//    
//    func setupTableView() {
//        let tableHeaderView = UIView()
//        tableHeaderView.frame = CGRect(x: 0, y: 0, width: tableView.frame.width, height: 60)
//        
//        let trendingLabel = UILabel()
//        trendingLabel.text = "Trending"
//        trendingLabel.textColor = .black
//        trendingLabel.font = .systemFont(ofSize: 20, weight: .semibold)
//        
//        let sortButton = UIButton()
//        sortButton.setImage(UIImage(named: "Search icon"), for: .normal)
//        sortButton.addTarget(self, action: #selector(sortButtonTapped), for: .touchUpInside)
//        
//        [trendingLabel, sortButton].forEach {
//            tableHeaderView.addSubview($0)
//        }
//        
//        trendingLabel.snp.makeConstraints { make in
//            make.top.equalTo(tableHeaderView.snp.top).offset(20)
//            make.leading.equalTo(tableHeaderView.snp.leading).offset(25)
//            make.width.equalTo(90)
//            make.height.equalTo(30)
//        }
//        
//        sortButton.snp.makeConstraints { make in
//            make.top.equalTo(tableHeaderView.snp.top).offset(20)
//            make.trailing.equalTo(tableHeaderView.snp.trailing).offset(-25)
//            make.width.height.equalTo(24)
//        }
//        
//        tableView.tableHeaderView = tableHeaderView
//        tableView.tableFooterView = footerView
//    }
//}
//
// MARK: - ViewModel Binding
//private extension CoinListViewController {
//    
//    func bindViewModel() {
//        coinListViewModel.onUpdate = { [weak self] in
//            DispatchQueue.main.async {
//                self?.tableView.reloadData()
//            }
//        }
//        
//        coinListViewModel.onError = { [weak self] error in
//            DispatchQueue.main.async {
//                self?.showErrorAlert(message: error)
//            }
//        }
//        
//        coinListViewModel.onLoadingStateChange = { [weak self] isLoading in
//            DispatchQueue.main.async {
//                if isLoading {
//                    self?.activityIndicator.startAnimating()
//                } else {
//                    self?.activityIndicator.stopAnimating()
//                }
//            }
//        }
//    }
//    
//    func showErrorAlert(message: String) {
//        let alert = UIAlertController(
//            title: "Ошибка",
//            message: message,
//            preferredStyle: .alert
//        )
//        alert.addAction(UIAlertAction(title: "OK", style: .default))
//        present(alert, animated: true)
//    }
//}
//
// MARK: - Menu Handling
//private extension CoinListViewController {
//    
//    func enableTapToCloseMenu() {
//        if tapGestureRecognizer == nil {
//            tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTapToCloseMenu))
//            tapGestureRecognizer?.delegate = self
//            view.addGestureRecognizer(tapGestureRecognizer!)
//        }
//    }
//    
//    func disableTapToCloseMenu() {
//        if let gestureRecognizer = tapGestureRecognizer {
//            view.removeGestureRecognizer(gestureRecognizer)
//            tapGestureRecognizer = nil
//        }
//    }
//    
//    @objc func handleTapToCloseMenu() {
//        hideMenus()
//    }
//    
//    func hideMenus() {
//        hideRefreshLogoutMenu()
//        hideSortMenu()
//        disableTapToCloseMenu()
//    }
//    
//    func hideRefreshLogoutMenu() {
//        refreshLogoutMenu?.removeFromSuperview()
//        refreshLogoutMenu = nil
//    }
//    
//    func hideSortMenu() {
//        sortMenu?.removeFromSuperview()
//        sortMenu = nil
//    }
//}
//
// MARK: - Refresh & Logout Pop Up Menu
//private extension CoinListViewController {
//    
//    @objc func refreshLogoutButtonTapped() {
//        if refreshLogoutMenu == nil {
//            hideSortMenu()
//            
//            let menu = UIView()
//            menu.backgroundColor = .white
//            menu.layer.cornerRadius = 16
//            
//            view.addSubview(menu)
//            menu.snp.makeConstraints { make in
//                make.width.equalTo(157)
//                make.height.equalTo(102)
//                make.top.equalTo(refreshLogoutButton.snp.bottom).offset(8)
//                make.leading.equalTo(view.snp.leading).offset(209)
//            }
//            
//            // MARK: Configs
//            var refreshConfig = UIButton.Configuration.plain()
//            refreshConfig.image = UIImage(named: "rocket")
//            refreshConfig.title = "Обновить"
//            refreshConfig.baseForegroundColor = .black
//            refreshConfig.imagePadding = 8
//            refreshConfig.imagePlacement = .leading
//            
//            var logoutConfig = UIButton.Configuration.plain()
//            logoutConfig.image = UIImage(named: "trash")
//            logoutConfig.title = "Выйти"
//            logoutConfig.baseForegroundColor = .black
//            logoutConfig.imagePadding = 8
//            logoutConfig.imagePlacement = .leading
//            
//            // MARK: Buttons
//            let refreshButton = UIButton()
//            refreshButton.configuration = refreshConfig
//            refreshButton.addTarget(self, action: #selector(refreshButtonTapped), for: .touchUpInside)
//            
//            let logoutButton = UIButton()
//            logoutButton.configuration = logoutConfig
//            logoutButton.addTarget(self, action: #selector(logoutButtonTapped), for: .touchUpInside)
//            
//            // MARK: Stack
//            let stack = UIStackView(arrangedSubviews: [refreshButton, logoutButton])
//            stack.axis = .vertical
//            stack.distribution = .fillEqually
//            stack.spacing = 6
//            stack.alignment = .leading
//            
//            menu.addSubview(stack)
//            stack.snp.makeConstraints { make in
//                make.edges.equalToSuperview().inset(10)
//            }
//            
//            refreshLogoutMenu = menu
//            enableTapToCloseMenu()
//        } else {
//            hideMenus()
//        }
//    }
//    
//    @objc func refreshButtonTapped() {
//        tableView.tableFooterView = footerView
//        
//        coinListViewModel.clearCoins()
//        tableView.reloadData()
//        activityIndicator.startAnimating()
//        coinListViewModel.fetchCoins()
//        
//        hideMenus()
//    }
//    
//    @objc func logoutButtonTapped() {
//        coinListViewModel.logout()
//        hideMenus()
//    }
//}
//
// MARK: - Sort Pop Up Menu
//private extension CoinListViewController {
//    
//    @objc func sortButtonTapped() {
//        if sortMenu == nil {
//            hideRefreshLogoutMenu()
//            
//            let menu = UIView()
//            menu.backgroundColor = .white
//            menu.layer.cornerRadius = 16
//            
//            view.addSubview(menu)
//            menu.snp.makeConstraints { make in
//                make.width.equalTo(140)
//                make.height.equalTo(80)
//                make.bottom.equalTo(tableView.snp.top).offset(-10)
//                make.leading.equalTo(view.snp.leading).offset(240)
//            }
//            
//            // MARK: Configs
//            var ascendingConfig = UIButton.Configuration.plain()
//            ascendingConfig.title = "Ascending"
//            ascendingConfig.baseForegroundColor = .black
//            
//            var descendingConfig = UIButton.Configuration.plain()
//            descendingConfig.title = "Descending"
//            descendingConfig.baseForegroundColor = .black
//            
//            // MARK: Buttons
//            let ascendingButton = UIButton()
//            ascendingButton.configuration = ascendingConfig
//            ascendingButton.addTarget(self, action: #selector(ascendingButtonTapped), for: .touchUpInside)
//            
//            let descendingButton = UIButton()
//            descendingButton.configuration = descendingConfig
//            descendingButton.addTarget(self, action: #selector(descendingButtonTapped), for: .touchUpInside)
//            
//            // MARK: Stack
//            let stack = UIStackView(arrangedSubviews: [ascendingButton, descendingButton])
//            stack.axis = .vertical
//            stack.distribution = .fillProportionally
//            stack.spacing = 8
//            stack.alignment = .center
//            
//            menu.addSubview(stack)
//            stack.snp.makeConstraints { make in
//                make.edges.equalToSuperview().inset(12)
//            }
//            
//            sortMenu = menu
//            enableTapToCloseMenu()
//        } else {
//            hideMenus()
//        }
//    }
//    
//    @objc func ascendingButtonTapped() {
//        UIView.transition(
//            with: tableView,
//            duration: 0.3,
//            options: .transitionCrossDissolve,
//            animations: {
//                self.coinListViewModel.sortAscendingByPrice()
//                self.tableView.reloadData()
//            }
//        )
//        hideMenus()
//    }
//    
//    @objc func descendingButtonTapped() {
//        UIView.transition(
//            with: tableView,
//            duration: 0.3,
//            options: .transitionCrossDissolve,
//            animations: {
//                self.coinListViewModel.sortDescendingByPrice()
//                self.tableView.reloadData()
//            }
//        )
//        hideMenus()
//    }
//}
//
// MARK: - TableViewDatasource & TableViewDelegate
//extension CoinListViewController: UITableViewDataSource, UITableViewDelegate {
//    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return coinListViewModel.numberOfCoins()
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        guard
//            let cell = tableView.dequeueReusableCell(withIdentifier: "CoinCell", for: indexPath) as? CoinCell,
//            let coin = coinListViewModel.coin(at: indexPath.row)
//        else {
//            return UITableViewCell()
//        }
//        cell.configure(with: coin)
//        return cell
//    }
//    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        tableView.deselectRow(at: indexPath, animated: true)
//        coinListViewModel.showCoinDetail(at: indexPath.row)
//    }
//}
//
// MARK: - UIGestureRecognizerDelegate
//extension CoinListViewController: UIGestureRecognizerDelegate {
//    
//    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
//        if let menu = refreshLogoutMenu, menu.bounds.contains(touch.location(in: menu)) {
//            return false
//        }
//        if let menu = sortMenu, menu.bounds.contains(touch.location(in: menu)) {
//            return false
//        }
//        return true
//    }
//}
//
// MARK: - Preview
//#Preview {
//    MainTabBarController()
//}
