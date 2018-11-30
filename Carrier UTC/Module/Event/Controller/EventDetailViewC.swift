//
//  EventDetailViewC.swift
//  Carrier UTC
//
//  Created by Shilpa Sharma on 21/11/18.
//  Copyright © 2018 Indigo. All rights reserved.
//

import UIKit


class EventDetailViewC: UIViewController, UIDocumentInteractionControllerDelegate {
    //MARK: - IBOutlet
    @IBOutlet weak var tblEventDetail: UITableView!
    @IBOutlet weak var btnInterested: UIButton!
    
    internal var viewModel: EventDetailViewModelling?
    var eventId = 0
    var eventDetail: EventModel? {
        didSet {
            self.tblEventDetail.reloadData()
        }
    }
    
    //MARK: - View Life cycle
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
        apiCallEventDetail()
        self.navigationItem.hidesBackButton = true
        self.tblEventDetail.contentInset = UIEdgeInsets(top: -36, left: 0, bottom: 0, right: 0);
        btnInterested.roundCorners(borderWidth: 0.0, borderColor: UIColor.clear.cgColor, cornerRadius: btnInterested.frame.size.height/2)
    }
    
    private func recheckVM() {
        if self.viewModel == nil {
            self.viewModel = EventDetailVM()
        }
    }
    
    private func registerNib() {
        self.tblEventDetail.register(UINib(nibName: "CellEventDetail", bundle: nil), forCellReuseIdentifier: "CellEventDetail")
        let nibName = UINib(nibName: "EventImageView", bundle: nil)
        self.tblEventDetail.register(nibName, forHeaderFooterViewReuseIdentifier: "EventImageView")
    }
    
    private func setUpFooter() {
        btnInterested.backgroundColor = (eventDetail?.user_interest)! ? UIColor.lightGray : UIColor.clear
        btnInterested.isUserInteractionEnabled = (eventDetail?.user_interest)! ? false : true
        btnInterested.setImage(UIImage( named: (eventDetail?.user_interest)! ? "" : "interested"), for: .normal)
        btnInterested.setTitle((eventDetail?.user_interest)! ? "INTERESTED" : "", for: .normal)
    }
    
    private func apiCallEventDetail() {
        self.viewModel?.getEventDetail(eventId: eventId, eventDetailHandler: { [weak self] (eventDetail, success, msg) in
            guard self != nil else { return }
            if success {
                self?.eventDetail = eventDetail
                self?.setUpFooter()
            } else {
                
            }
        })
    }

    //MARK: - IBAction Methods
    @IBAction func tapBack(_ sender: Any) {
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func tapInterested(_ sender: UIButton) {
        self.viewModel?.setInterestedEvent(eventId: eventId, interestedEventHandler: { (success, msg) in
            if success {
                self.eventDetail?.user_interest = true
                self.setUpFooter()
            } else {
            }
        })
    }
    
    @IBAction func tapTwitter(_ sender: UIButton) {
        let imgURL = URL(string: (eventDetail?.event_image)!)
        let data = try? Data(contentsOf: imgURL!)
        let imageInstagram = UIImage(data: data!)
        
        guard let date = eventDetail?.event_date,
            let name = eventDetail?.heading,
            let desc = eventDetail?.event_description else {
                return
        }
        let contentShare = "Event Date : \(date) \n Event Name: \(name) \n \(desc)"
        
        Helper.shareToInstagram(imageInstagram: imageInstagram!, contentShare: contentShare, view: self.view)
    }
    
    @IBAction func tapFacebook(_ sender: UIButton) {
        guard let date = eventDetail?.event_date,
            let name = eventDetail?.heading,
            let desc = eventDetail?.event_description else {
            return
        }
        let contentShare = "Event Date : \(date) \n Event Name: \(name) \n \(desc)"
        Helper.shareToFacebook(image: (eventDetail?.event_image)!, content: contentShare)
    }
}

extension EventDetailViewC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return (eventDetail == nil) ? 0 : 220
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView: EventImageView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "EventImageView" ) as! EventImageView
        headerView.imgevent.setImageWith(strImage: eventDetail!.event_image)
        return headerView
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (eventDetail == nil) ? 0: 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.0001
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellEventDetail", for: indexPath) as! CellEventDetail
        cell.setEventDetail(event: eventDetail!)
        return cell
    }
}
