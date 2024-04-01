//
//  TruckInfoViewController.swift
//  TruckApp
//
//  Created by SAGAR SINGH on 01/04/24.
//

import UIKit

class TruckInfoViewController: UIViewController {
    //MARK: - PROPERTIES.
    @IBOutlet private weak var activityLoader: UIActivityIndicatorView!
    @IBOutlet private weak var truckInfoTable: UITableView!
    private let viewModel = TruckViewModel()

    //MARK: - VIEW's LIFECYCLE METHODS.
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    //MARK: - FUNCTION TO CONFIGURE UI.
    private func configureUI() {
        self.navigationController?.isNavigationBarHidden = true
        truckInfoTable.delegate = self
        truckInfoTable.dataSource = self
        let nibFile = UINib(nibName: "TruckInfoTableViewCell", bundle: nil)
        truckInfoTable.register(nibFile, forCellReuseIdentifier: "TruckInfoTableViewCell")
        viewModel.requestTruckInfo()
        handleEvents()
    }
    
    //MARK: - FUNCTION TO UPDATE UI BASED ON API EVENTS.
    private func handleEvents() {
        viewModel.eventhandler = {[weak self] event in
            guard let self else { return }
            switch event {
                
            case .startLoading:
                print("Starting Loading...")
            case .stopLoading:
                print("Stopped Loading...")
            case .dataLoaded:
                DispatchQueue.main.async {
                    self.truckInfoTable.reloadData()
                    self.activityLoader.stopAnimating()
                }
            case .error(let error):
                print(error ?? "")
            }
        }
    }
    
    //MARK: - FUNCTION TO HANDLE MAP BUTTON ACTION.
    @IBAction private func mapButtonAction(_ sender: UIButton) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        guard let vc = storyBoard.instantiateViewController(withIdentifier: "MapViewController") as? MapViewController else {
            return
        }
        vc.truckInfo = viewModel.truckInfo
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

//MARK: - TABLEVIEW DELEGATE AND DATA-SOURCE METHODS.
extension TruckInfoViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.truckInfo.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = truckInfoTable.dequeueReusableCell(withIdentifier: "TruckInfoTableViewCell", for: indexPath) as? TruckInfoTableViewCell else {
            return UITableViewCell()
        }
        let cellDataModel = viewModel.truckInfo[indexPath.row]
        cell.configureCell(data: cellDataModel)
        cell.selectionStyle = .none
        cell.layoutIfNeeded()
        return cell
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
