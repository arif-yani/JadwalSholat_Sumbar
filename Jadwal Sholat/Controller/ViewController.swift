//
//  ViewController.swift
//  Jadwal Sholat
//
//  Created by Muhamad Arif on 19/06/22.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var lokasiTableView: UITableView!
    
    var scheduleManager = ScheduleManager()
    
    var tableRow = 0
    var kota = ""
    var subuh = ""
    var dzuhur = ""
    var ashar = ""
    var maghrib = ""
    var isya = ""
    var tanggal = ""
    var lokasi = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lokasiTableView.dataSource = self
        lokasiTableView.delegate = self
        scheduleManager.delegate = self
        
        lokasiTableView.register(
          UINib(nibName: "CityViewCell", bundle: nil),
          forCellReuseIdentifier: "CityCell"
        )
    }

    @IBAction func aboutPressed(_ sender: UIButton) {
        self.performSegue(withIdentifier: "MainToAbout", sender: self)
        
        
    }
    
    

    
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return scheduleManager.lokasi.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(
          withIdentifier: "CityCell",
          for: indexPath
        ) as? CityViewCell {
            
            let city = scheduleManager.lokasi[indexPath.row]
            cell.cityLabel.text = city.lokasi
            cell.logoImage.image = city.logo
            
          return cell
        } else {
          return UITableViewCell()
        }


    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let id = scheduleManager.lokasi[indexPath.row].id
        scheduleManager.fetchSchedule(for: id)
        
    }



}

extension ViewController: ScheduleManagerDelegate {
    func didUpdateSchedule(_ scheduleManager: ScheduleManager, schedule: ScheduleModel) {
        DispatchQueue.main.async {
            self.kota = schedule.kota
            self.subuh = schedule.subuh
            self.dzuhur = schedule.dzuhur
            self.ashar = schedule.ashar
            self.maghrib = schedule.maghrib
            self.isya = schedule.isya
            self.tanggal = schedule.date
            self.performSegue(withIdentifier: "MainToDetail", sender: self)
            
        }
    }

    func didFailWithError(error: Error) {
        print(error)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.identifier == "MainToDetail" {
                let destinationVC = segue.destination as! DetailViewController
                destinationVC.city = self.kota
                destinationVC.subuhTime = self.subuh
                destinationVC.dzuhurTime = self.dzuhur
                destinationVC.asharTime = self.ashar
                destinationVC.maghribTime = self.maghrib
                destinationVC.isyaTime = self.isya
                destinationVC.tanggal = self.tanggal


            }
       
        }
    
   
    
    
}



    


