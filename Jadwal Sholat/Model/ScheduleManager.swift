//
//  ScheduleManager.swift
//  Jadwal Sholat
//
//  Created by Muhamad Arif on 19/06/22.
//

import Foundation
import UIKit

protocol ScheduleManagerDelegate {
    func didUpdateSchedule(_ scheduleManager: ScheduleManager, schedule: ScheduleModel)
    func didFailWithError(error: Error)
}

struct ScheduleManager {
    
    var delegate: ScheduleManagerDelegate?
    
    let lokasiURL = "https://api.myquran.com/v1/sholat/jadwal"
    let lokasi = [CityData(id: "0301", lokasi: "KAB. AGAM", logo: #imageLiteral(resourceName: "Kabupaten_Agam.png")), CityData(id: "0302", lokasi: "KAB. DHARMASRAYA", logo: #imageLiteral(resourceName: "Kabupaten_Dharmasraya.png")), CityData(id: "0303", lokasi: "KAB. KEPULAUAN MENTAWAI", logo: #imageLiteral(resourceName: "Kabupaten_Kepulauan_Mentawai.png")), CityData(id: "0304", lokasi: "KAB. LIMA PULUH KOTA", logo: #imageLiteral(resourceName: "Kabupaten_Lima_Puluh_Kota.png")), CityData(id: "0305", lokasi: "KAB. PADANG PARIAMAN", logo: #imageLiteral(resourceName: "Kabupaten_Padang_Pariaman.png")), CityData(id: "0306", lokasi: "KAB. PASAMAN", logo: #imageLiteral(resourceName: "Kabupaten_Pasaman.png")), CityData(id: "0307", lokasi: "KAB. PASAMAN BARAT", logo: #imageLiteral(resourceName: "Kabupaten_Pasaman_Barat.png")), CityData(id: "0308", lokasi: "KAB. PESISIR SELATAN", logo: #imageLiteral(resourceName: "Kabupaten_Pesisir_Selatan.png")), CityData(id: "0309", lokasi: "KAB. SIJUNJUNG", logo: #imageLiteral(resourceName: "Kabupaten_Sijunjung.png")), CityData(id: "0310", lokasi: "KAB. SOLOK", logo: #imageLiteral(resourceName: "Kabupaten_Solok.png")), CityData(id: "0311", lokasi: "KAB. SOLOK SELATAN", logo: #imageLiteral(resourceName: "Kabupaten_Solok_Selatan.png")), CityData(id: "0312", lokasi: "KAB. TANAH DATAR", logo: #imageLiteral(resourceName: "Kabupaten_Tanah_Datar.png")), CityData(id: "0313", lokasi: "KOTA BUKITTINGGI", logo: #imageLiteral(resourceName: "Kota_Bukittinggi.png")), CityData(id: "0314", lokasi: "KOTA PADANG", logo: #imageLiteral(resourceName: "Kota_Padang.png")), CityData(id: "0315", lokasi: "KOTA PADANGPANJANG", logo: #imageLiteral(resourceName: "Kota_Padangpanjang.png")), CityData(id: "0316", lokasi: "KOTA PARIAMAN", logo: #imageLiteral(resourceName: "Kota_Pariaman.png")), CityData(id: "0317", lokasi: "KOTA PAYAKUMBUH", logo: #imageLiteral(resourceName: "Kota_Payakumbuh.png")), CityData(id: "0318", lokasi: "KOTA SAWAHLUNTO", logo: #imageLiteral(resourceName: "Kota_Sawahlunto.png")), CityData(id: "0319", lokasi: "KOTA SOLOK", logo: #imageLiteral(resourceName: "Kota_Solok.png"))]
    
    
    func fetchSchedule(for id: String) {
        let urlString = "\(lokasiURL)/\(id)/\(calculateDate())"
        
        
        if let url = URL(string: urlString) {
            
        
            let session = URLSession(configuration: .default)
            
           
            let task = session.dataTask(with: url) { (datas, response, error) in
                if error != nil {
//                    print(error!)
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
               
                if let safeData = datas {
                   if let schedule = self.parseJSON(safeData){
                        self.delegate?.didUpdateSchedule(self, schedule: schedule)
//                       print(schedule)
                    }
                }
                
            }
            
            task.resume()
        }
    }
    
    func parseJSON(_ datas: Data) -> ScheduleModel? {
        let decoder = JSONDecoder()
        do {
            let decodeData = try decoder.decode(ScheduleData.self, from: datas)
            
            let kota = decodeData.data.lokasi
            let subuh = decodeData.data.jadwal.subuh
            let dzuhur = decodeData.data.jadwal.dzuhur
            let ashar = decodeData.data.jadwal.ashar
            let maghrib = decodeData.data.jadwal.maghrib
            let isya = decodeData.data.jadwal.isya
            let tanggal = decodeData.data.jadwal.tanggal
            
            let schedule = ScheduleModel(kota: kota, subuh: subuh, dzuhur: dzuhur, ashar: ashar, maghrib: maghrib, isya: isya, date: tanggal)
            
            
            return schedule
        } catch {
            self.delegate?.didFailWithError(error: error)
            return nil
        }
    }
    
    
    
    func getLokasi(index: Int) -> String {

        return lokasi[index].lokasi
    }
    
    private func calculateDate() -> String {
            let dateFormatter = DateFormatter()//OK!

            dateFormatter.dateFormat = "yyyy/MM/dd"
            let dateString = dateFormatter.string(from: Date())//2
//            print(dateString)//3
            return dateString
        }
}
