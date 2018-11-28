//
//  HistoryViewC.swift
//  Carrier UTC
//
//  Created by Shilpa Sharma on 28/11/18.
//  Copyright © 2018 Indigo. All rights reserved.
//

import UIKit

class HistoryViewC: BaseViewC {
    //MARK: - IBOutlets
    @IBOutlet weak var tblViewHistory: UITableView!
    
    internal var viewModel: HistoryViewModelling?
    var tower25Scale = [PMTowerModel]()
    var tower10Scale = [PMTowerModel]()
    var pmScale = [PMScaleModel]()
    
    //MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    //MARK: - Private Methods
    
    private func setUp() {
        registerNib()
        recheckVM()
        apiCallHistory()
    }
    
    private func recheckVM() {
        if self.viewModel == nil {
            self.viewModel = HistoryVM()
        }
    }
    
    private func registerNib() {
        self.tblViewHistory.register(UINib(nibName: "CellHistory", bundle: nil), forCellReuseIdentifier: "CellHistory")
        self.tblViewHistory.register(UINib(nibName: "HistoryHeaderView", bundle: nil), forHeaderFooterViewReuseIdentifier: "HistoryHeaderView")
    }
    
    private func apiCallHistory() {
        self.viewModel?.getHistory(historyHandler: { [weak self] (historyModel, success, msg) in
            guard self != nil else { return }
            if success {
                self?.pmScale = historyModel.pm_scale.reversed()
                self?.tower10Scale = historyModel.pm10
                self?.tower25Scale = historyModel.pm25
                self?.tblViewHistory.reloadData()
            } else {
                Alert.showOkAlert(title: "Error!!", message: msg)
            }
        })
    }
    
    
    //MARK: - IBActions
    @IBAction func tapBack(_ sender: UIButton) {
        _ = self.navigationController?.popViewController(animated: true)
    }
    
}

extension HistoryViewC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView: HistoryHeaderView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "HistoryHeaderView" ) as! HistoryHeaderView
        let view = UIView(frame: CGRect(x: 0, y: 0, width: Constant.kScreenWidth, height: 60))
        view.backgroundColor = UIColor.white
        headerView.backgroundView = view
        headerView.viewUnderLine.isHidden = (section == 2) ? false : true
        headerView.lblHeader.text = (section == 2) ? "PM SCALE" : (section == 0) ? "PM 2.5" : "PM 10"
        headerView.lblHeader.font = (section == 2) ? UIFont.font(name: .OpenSans, weight: .SemiBold, size: .size_15) : UIFont.font(name: .OpenSans, weight: .SemiBold, size: .size_22)
        return headerView
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return (indexPath.section == 2) ? 110 : 115
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellHistory", for: indexPath) as! CellHistory
        cell.collectionScale.tag = indexPath.section
        cell.collectionScale.delegate = self
        cell.collectionScale.dataSource = self
        if indexPath.section == 2 {
            cell.minWidthCnst.constant = 0
            cell.maxWidthCnst.constant = 0
            cell.collectionScale.register(UINib(nibName: "CellPMScale", bundle: nil), forCellWithReuseIdentifier: "CellPMScale")
            cell.collectionScale.reloadData()
        } else {
            cell.collectionScale.register(UINib(nibName: "CellPM", bundle: nil), forCellWithReuseIdentifier: "CellPM")
            cell.collectionScale.reloadData()
        }
        return cell
    }
}

extension HistoryViewC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (collectionView.tag == 2) ? (pmScale.count + 1) : (collectionView.tag == 0) ? tower25Scale.count : tower10Scale.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView.tag == 2 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CellPMScale", for: indexPath) as! CellPMScale
            if indexPath.row == 0 {
                cell.setUpScaleInfo(scaleInfo: nil, index: indexPath.row)
            } else {
                let inputRow = indexPath.row - 1
                cell.setUpScaleInfo(scaleInfo: pmScale[inputRow], index: indexPath.row)
            }
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CellPM", for: indexPath) as! CellPM
            cell.setUpTowerInfo(towerInfo: (collectionView.tag == 0) ? tower25Scale[indexPath.row] : tower10Scale[indexPath.row])
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return (collectionView.tag == 2) ? CGSize(width: 90, height: 90) : CGSize(width: 85, height: 95) // The size of one cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0) // margin between cells
    }
}
