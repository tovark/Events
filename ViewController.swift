//
//  ViewController.swift
//  Events
//
//  Created by Karina Tovar on 4/8/22.
//

import UIKit
import EventKitUI
import EventKit

class ViewController: UIViewController , EKEventViewDelegate{
    
let store = EKEventStore()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem:
            .add, target: self, action: #selector(didTapAdd))
    
    }
    
    @objc func didTapAdd(){
      //let vc =  EKCalendarChooser()
       // vc.showsDoneButton = true
       // vc.showsCancelButton = true
       // present(UINavigationController(rootViewController: vc), animated: true)
        
        store.requestAccess(to: .event) { [weak self] success, error in
            if success, error == nil {
                DispatchQueue.main.async{
                    guard let store = self?.store else { return}
                    
                    let newEvent = EKEvent(eventStore: store)
                    newEvent.title = ""
                    newEvent.startDate = Date()
                    newEvent.endDate = Date()
                    
                    let otherVC = EKEventEditViewController()
                    otherVC.eventStore = store
                    otherVC.event = newEvent
                    self?.present(otherVC, animated: true, completion: nil)
                    
                    let vc = EKEventViewController()
                    vc.delegate = self
                    vc.event = newEvent
                    let navVC = UINavigationController(rootViewController: vc)
                    self?.present(navVC, animated:true)
                }
            }
        }
    }
    
    
    func eventViewController(_ controller: EKEventViewController, didCompleteWith action: EKEventViewAction) {
        controller.dismiss(animated: true, completion: nil)

    }

}

