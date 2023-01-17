//
//  School.swift
//  2023_01_17-DarinBurch--NYCSchools
//
//  Created by Mapspot on 1/17/23.
//

import Foundation
  
struct School: Decodable {
    var id : UUID = UUID()
    let dbn: String
    let school_name: String?
    let overview_paragraph: String?
    let location: String?
    let phone_number: String?
    let school_email: String?
    let website: String?
    let total_students: String?
}



/*
"dbn": "02M260",
"school_name": "Clinton School Writers & Artists, M.S. 260",
"overview_paragraph": "Students who are prepared for college must have an education that encourages them to take risks as they produce and perform. Our college preparatory curriculum develops writers and has built a tight-knit community. Our school develops students who can think analytically and write creatively. Our arts programming builds on our 25 years of experience in visual, performing arts and music on a middle school level. We partner with New Audience and the Whitney Museum as cultural partners. We are a International Baccalaureate (IB) candidate school that offers opportunities to take college courses at neighboring universities.",
"location": "10 East 15th Street, Manhattan NY 10003 (40.736526, -73.992727)",
"phone_number": "212-524-4360",
"school_email": "admissions@theclintonschool.net",
"website": "www.theclintonschool.net",
"total_students": "376",
*/
