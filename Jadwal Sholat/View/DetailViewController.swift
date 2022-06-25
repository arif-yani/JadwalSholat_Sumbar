//
//  DetailViewController.swift
//  Jadwal Sholat
//
//  Created by Muhamad Arif on 21/06/22.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var labelCity: UILabel!
    
    @IBOutlet weak var labelDate: UILabel!
    @IBOutlet weak var isyaTimeLabel: UILabel!
    @IBOutlet weak var maghribTimeLabel: UILabel!
    @IBOutlet weak var asharTimeLabel: UILabel!
    @IBOutlet weak var dzuhurTimeLabel: UILabel!
    @IBOutlet weak var subuhTimeLabel: UILabel!
    
    var scheduleManager = ScheduleManager()
//    var scheduleResult: ScheduleModel?
    var city: String?
    var subuhTime: String?
    var dzuhurTime: String?
    var asharTime: String?
    var maghribTime: String?
    var isyaTime: String?
    var tanggal: String?
    
//    var resultData: ResultData?
    override func viewDidLoad() {
        super.viewDidLoad()
        
 

        labelCity.text = city!
        subuhTimeLabel.text = subuhTime!
        dzuhurTimeLabel.text = dzuhurTime!
        asharTimeLabel.text = asharTime!
        maghribTimeLabel.text = maghribTime!
        isyaTimeLabel.text = isyaTime!
        labelDate.text = tanggal!
    }
    

    
    
}


