//
//  ViewController.swift
//  AllAboutAppsAssissment
//
//  Created by Moaaz Ahmed Fawzy Taha on 24/01/2022.
//

import UIKit
import Reachability
import TBDropdownMenu

class ClubListViewController: BaseViewController {
    
    @IBOutlet weak var clubsList: UITableView!
    @IBOutlet weak var loadingView: UIView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    let viewModel = ClubsListViewModel()
    var sortingMenu:DropdownMenu? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSortingMenu()
        showBuffering()
        setuptableView()
        setupClubList()
        
        clubsList.refreshControl = UIRefreshControl()
        clubsList.refreshControl?.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        
    }
    
    private func setuptableView() {
        clubsList.register(UINib(nibName: String(describing: ClubListCell.self) , bundle: nil), forCellReuseIdentifier:CellIdentifier.ClubListCell.rawValue)
        clubsList.dataSource = self
        clubsList.delegate = self
    }
    
    private func setupClubList() {
        viewModel.fetchClubs {[weak self] in
            DispatchQueue.main.async {[weak self] in
                guard let self = self else {return}
                self.clubsList.reloadData()
                self.hideBuffering()
            }
        }
    }
    
    // activityIndicator utils
    func showBuffering(){
        self.activityIndicator.startAnimating()
        self.loadingView.isHidden = false
    }
    
    func hideBuffering(){
        activityIndicator.stopAnimating()
        loadingView.isHidden = true
    }
    
    //DropDown preparation
    func setupSortingMenu() {
        let defaultSorting = DropdownItem(title: "Default".localized())
        let nameAscending = DropdownItem(title: "Name Ascendingly".localized())
        let clubValueDescending = DropdownItem(title: "Value Descendingly".localized())
        
        let items = [defaultSorting, nameAscending, clubValueDescending]
        sortingMenu = DropdownMenu(navigationController: navigationController!, items: items)
        sortingMenu?.delegate = self
    }
    
    //MARK: - Action
    
    @objc func refresh(_ sender: AnyObject) {
        setupClubList()
        clubsList.refreshControl?.endRefreshing()
    }
    
    @IBAction func showMenu(_ sender: Any) {
        sortingMenu?.showMenu()
    }
    
}

//MARK: - TableView Delegate & Data source
// DataSource
extension ClubListViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard !viewModel.clubs.isEmpty else {return 0}
        return viewModel.clubs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.ClubListCell.rawValue) as! ClubListCell
        cell.configuringCell(club: viewModel.clubs[indexPath.row])
        return cell
    }
    
    
}

// Delegate
extension ClubListViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedClub = viewModel.clubs[indexPath.row]
        let viewModel = ClubDetailsViewModel(club: selectedClub)
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        if let viewController = storyboard.instantiateViewController(withIdentifier: String(describing: ClubDetailsViewcontroller.self)) as? ClubDetailsViewcontroller {
            viewController.viewModel = viewModel
            self.navigationController?.pushViewController(viewController, animated: true)
            self.clubsList.deselectRow(at: indexPath, animated: true)
        }
        
    }
}

//MARK: - DropdownMenu Delegate
extension ClubListViewController: DropdownMenuDelegate {
    func dropdownMenu(_ dropdownMenu: DropdownMenu, didSelectRowAt indexPath: IndexPath) {
        if let parameter = SoritngParameter(rawValue: indexPath.row) {
            viewModel.sorting(with: parameter)
            clubsList.reloadData()
        }
    }
}



