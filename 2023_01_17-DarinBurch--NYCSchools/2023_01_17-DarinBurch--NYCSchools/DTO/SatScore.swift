//
//  SatScore.swift
//  2023_01_17-DarinBurch--NYCSchools
//
//  Created by Mapspot on 1/17/23.
//

import Foundation


struct SatScore: Codable {
    let dbn: String
    let school_name: String?
    let num_of_sat_test_takers: String?
    let sat_critical_reading_avg_score: String?
    let sat_math_avg_score: String?
    let sat_writing_avg_score: String?
}


/*
"dbn": "01M292",
"school_name": "HENRY STREET SCHOOL FOR INTERNATIONAL STUDIES",
"num_of_sat_test_takers": "29",
"sat_critical_reading_avg_score": "355",
"sat_math_avg_score": "404",
"sat_writing_avg_score": "363"
 */
