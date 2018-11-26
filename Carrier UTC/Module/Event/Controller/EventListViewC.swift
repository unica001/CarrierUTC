//
//  EventListViewC.swift
//  Carrier UTC
//
//  Created by Shilpa Sharma on 21/11/18.
//  Copyright © 2018 Indigo. All rights reserved.
//

import UIKit

class EventListViewC: BaseViewC {

    //MARK: - IBOutlet
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var viewHeader: UIView!
    @IBOutlet weak var collectionViewUpcoming: UICollectionView!
    @IBOutlet weak var collectionViewPast: UICollectionView!
    @IBOutlet weak var viewAllUpcoming: UIView!
    @IBOutlet weak var viewAllPast: UIView!

    var upcomingEventCount = 0
    var pastEventCount = 0
    internal var viewModel: EventListViewModelling?
    
    var arrUpcomingEvent = [EventModel]() {
        didSet {
            self.collectionViewUpcoming.reloadData()
        }
    }
    var arrPastEvent = [EventModel]() {
        didSet {
            self.collectionViewPast.reloadData()
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
        recheckVM()
        registerNib()
        apiCallEvent()
    }
    
    private func recheckVM() {
        if self.viewModel == nil {
            self.viewModel = EventListVM()
        }
    }
    
    private func registerNib() {
        collectionViewUpcoming.register(UINib(nibName: "CellEvent", bundle: nil), forCellWithReuseIdentifier: "CellEvent")
        collectionViewPast.register(UINib(nibName: "CellEvent", bundle: nil), forCellWithReuseIdentifier: "CellEvent")
    }
    
    private func setUpViewAll() {
        viewAllUpcoming.isHidden = (upcomingEventCount > 5) ? false : true
        viewAllPast.isHidden = (pastEventCount > 5) ? false : true
    }
    
    private func apiCallEvent() {
        self.viewModel?.getAllEvents(allEventListHandler: { [weak self] (upcomingEvents, upcomingCount, pastEvents, pastCount, success, msg) in
            guard self != nil else { return }
            if success {
                self?.arrUpcomingEvent = upcomingEvents
                self?.arrPastEvent = pastEvents
                self?.upcomingEventCount = upcomingCount
                self?.pastEventCount = pastCount
                self?.setUpViewAll()
            } else {
                Alert.Alert(msg, okButtonTitle: "Ok", target: self)
            }
        })
    }
    
    //MARK: - IBAction Methods
    @IBAction func tapSearch(_ sender: UIButton) {
        if let searchEventViewC = Constant.kStoryboardEvent.instantiateViewController(withIdentifier: "SearchEventViewC") as? SearchEventViewC {
            searchEventViewC.strHeaderTitle = EventType.Search.rawValue
            self.navigationController?.pushViewController(searchEventViewC, animated: true)
        }
    }
    
    @IBAction func tapViewAll(_ sender: UIButton) {
        if let searchEventViewC = Constant.kStoryboardEvent.instantiateViewController(withIdentifier: "SearchEventViewC") as? SearchEventViewC {
            searchEventViewC.strHeaderTitle = (sender.tag == 100) ? EventType.Upcoming.rawValue : EventType.Past.rawValue
            self.navigationController?.pushViewController(searchEventViewC, animated: true)
        }
    }
}

extension EventListViewC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (collectionView.tag == 200) ? self.arrUpcomingEvent.count : self.arrPastEvent.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CellEvent", for: indexPath) as! CellEvent
        cell.setUpEventList(event: (collectionView.tag == 200) ? arrUpcomingEvent[indexPath.row] : arrPastEvent[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let eventDetailViewC = Constant.kStoryboardEvent.instantiateViewController(withIdentifier: "EventDetailViewC") as? EventDetailViewC {
            let event = (collectionView.tag == 200) ? arrUpcomingEvent[indexPath.row] : arrPastEvent[indexPath.row]
            eventDetailViewC.eventId = event.id!
            self.navigationController?.pushViewController(eventDetailViewC, animated: true)
        }
    }
    
    // MARK: UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 280, height: collectionView.frame.size.height) // The size of one cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0) // margin between cells
    }
}
