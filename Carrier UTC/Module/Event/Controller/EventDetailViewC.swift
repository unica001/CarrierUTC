//
//  EventDetailViewC.swift
//  Carrier UTC
//
//  Created by Shilpa Sharma on 21/11/18.
//  Copyright © 2018 Indigo. All rights reserved.
//

import UIKit
import FacebookShare
import FacebookCore

class EventDetailViewC: UIViewController, UIDocumentInteractionControllerDelegate {
    //MARK: - IBOutlet
    @IBOutlet weak var tblEventDetail: UITableView!
    @IBOutlet weak var btnInterested: UIButton!
    
    private let kInstagramURL = "instagram://"
    private let kUTI = "com.instagram.exclusivegram"
    private let kfileNameExtension = "instagram.igo"
    private let kAlertViewTitle = "Error"
    private let kAlertViewMessage = "Please install the Instagram application"
    
    private let documentInteractionController = UIDocumentInteractionController()
    
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
       /* if (eventDetail?.user_interest)! {
            btnInterested.backgroundColor = UIColor.lightGray
            btnInterested.isUserInteractionEnabled = false
            btnInterested.setImage(UIImage( named: ""), for: .normal)
            btnInterested.setTitle("INTERESTED", for: .normal)
        } else {
            btnInterested.backgroundColor = UIColor.clear
            btnInterested.isUserInteractionEnabled = true
            btnInterested.setImage(UIImage(named: "interested"), for: .normal)
            btnInterested.setTitle("", for: .normal)
        }*/
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
                print("Success")
                self.eventDetail?.user_interest = true
                
            } else {
                print("Not success")
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
        
        let instagramURL = NSURL(string: kInstagramURL)
        if UIApplication.shared.canOpenURL(instagramURL! as URL) {
            
            let jpgPath = NSTemporaryDirectory().appending(kfileNameExtension)
            do {
                if let pngImageData = imageInstagram!.jpegData(compressionQuality: 1.0) {
                    try pngImageData.write(to: URL(fileURLWithPath: jpgPath), options: .atomic)
                } } catch { }

            let rect = CGRect.zero
            let fileURL = NSURL.fileURL(withPath: jpgPath)
            documentInteractionController.url = fileURL
            documentInteractionController.delegate = self
            documentInteractionController.uti = kUTI
            
            // adding caption for the image
            documentInteractionController.annotation = ["InstagramCaption": contentShare]
            documentInteractionController.presentOpenInMenu(from: rect, in: view, animated: true)
        }
        else {
            Alert.showOkAlert(title: kAlertViewTitle, message: kAlertViewMessage)
        }
    }
    
    @IBAction func tapFacebook(_ sender: UIButton) {
        guard let date = eventDetail?.event_date,
            let name = eventDetail?.heading,
            let desc = eventDetail?.event_description else {
            return
        }
        let contentShare = "Event Date : \(date) \n Event Name: \(name) \n \(desc)"
        let content = LinkShareContent(url: URL(string: (eventDetail?.event_image)!)!, quote: contentShare)
        
        let dialog = ShareDialog(content: content)
        dialog.presentingViewController = self
        dialog.mode = .automatic
        dialog.completion = { result in

        }
        try? dialog.show()
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
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellEventDetail", for: indexPath) as! CellEventDetail
        cell.setEventDetail(event: eventDetail!)
        return cell
    }
}
