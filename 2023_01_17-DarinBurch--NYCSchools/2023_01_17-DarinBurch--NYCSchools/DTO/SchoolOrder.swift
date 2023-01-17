//
//  SchoolOrder.swift
//  2023_01_17-DarinBurch--NYCSchools
//
//  Created by Mapspot on 1/17/23.
//

import Foundation


enum SchoolOrder {
    
    case name, studentCount
    
    func key() -> String {
        switch self {
        case .name:
            return "school_name"
        case .studentCount:
            return "total_students"
        }
    }
}
