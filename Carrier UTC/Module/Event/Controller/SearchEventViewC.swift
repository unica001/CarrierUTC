//
//  SearchEventViewC.swift
//  Carrier UTC
//
//  Created by Shilpa Sharma on 21/11/18.
//  Copyright © 2018 Indigo. All rights reserved.
//

import UIKit

class SearchEventViewC: UIViewController {
    //MARK: - IBOutlet
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var collectionSearchEvent: UICollectionView!
    @IBOutlet weak var lblHeader: UILabel!
    
    var strHeaderTitle = ""
    var totalRecords = 0
    var pageIndex = 1
    internal var viewModel: SearchEventViewModelling?
    
    var arrEvents = [EventModel]() {
        didSet {
            self.collectionSearchEvent.reloadData()
        }
    }
    
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
        apiCallEventList()
        self.navigationItem.hidesBackButton = true
        self.searchBar.placeholder = strHeaderTitle
        self.lblHeader.text = strHeaderTitle
    }
    
    private func recheckVM() {
        if self.viewModel == nil {
            self.viewModel = SearchEventVM()
        }
    }
    
    private func registerNib() {
        collectionSearchEvent.register(UINib(nibName: "CellEvent", bundle: nil), forCellWithReuseIdentifier: "CellEvent")
    }
    
    private func apiCallEventList() {
        var searchType = ""
        switch strHeaderTitle {
        case EventType.Upcoming.rawValue:
            searchType = "upcoming"
        case EventType.Past.rawValue:
            searchType = "past"
        default:
            searchType = "all"
        }
        self.viewModel?.getSearchEvent(pageIndex: pageIndex, searchText: searchBar.text ?? "", searchType: searchType, searchEventListHandler: { [weak self] (eventList, total, success, msg) in
            guard self != nil else { return }
            if success {
                if self?.pageIndex == 1 {
                    self?.arrEvents = eventList
                } else {
                    for i in 0 ..< eventList.count {
                        let dict = eventList[i]
                        self?.arrEvents.append(dict)
                    }
                }
                self?.totalRecords = total
            } else {
                Alert.Alert(msg, okButtonTitle: "Ok", target: self)
            }
        })
    }
    
    //MARK: - IBAction Methods
    @IBAction func tapBack(_ sender: UIButton) {
        _ = self.navigationController?.popViewController(animated: true)
    }
}

extension SearchEventViewC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrEvents.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CellEvent", for: indexPath) as! CellEvent
        cell.setUpEventList(event: arrEvents[indexPath.row])
        return cell
    }
    
    // MARK: UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: Constant.kScreenWidth - 30, height: 200) // The size of one cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15) // margin between cells
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let eventDetailViewC = Constant.kStoryboardEvent.instantiateViewController(withIdentifier: "EventDetailViewC") as? EventDetailViewC {
            let event = arrEvents[indexPath.row]
            eventDetailViewC.eventId = event.id!
            self.navigationController?.pushViewController(eventDetailViewC, animated: true)
        }
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let currentOffset = scrollView.contentOffset.y
        let maximumOffset = scrollView.contentSize.height - scrollView.frame.size.height
        if maximumOffset - currentOffset <= -40 && totalRecords > arrEvents.count {
            pageIndex = pageIndex + 1
            self.apiCallEventList()
        }
    }
}

extension SearchEventViewC: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        pageIndex = 1
        let str = (searchBar.text as NSString?)?.replacingCharacters(in: range, with: text)
        let newLength = (searchBar.text?.count)! + text.count - range.length
        if let text = str {
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(3), execute: {
                self.apiCallEventList()
            })
        }
        return true
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        pageIndex = 1
        print(searchBar.text ?? "")
        self.view.endEditing(true)
        self.apiCallEventList()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.view.endEditing(true)
    }
}
