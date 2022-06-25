//
//  ScheduleData.swift
//  Jadwal Sholat
//
//  Created by Muhamad Arif on 21/06/22.
//

import Foundation

struct ScheduleData: Codable {
    let data: Datas
}

struct Datas: Codable {
    let id: String
    let lokasi: String
    let daerah: String
    let jadwal: Jadwal
}

struct Jadwal: Codable {
    let tanggal: String
    let subuh: String
    let dzuhur: String
    let ashar: String
    let maghrib: String
    let isya: String
    
}


