//
//  SchoolCell.swift
//  2023_01_17-DarinBurch--NYCSchools
//
//  Created by Mapspot on 1/17/23.
//

import SwiftUI

struct SchoolCell: View {
    
    @ObservedObject var vm : SchoolViewModel
    
    @State var school: School
    
    var body: some View {
        HStack {
            VStack(spacing: 7.5) {
                SchoolName(name: school.school_name ?? "")
                SchoolLocation(location: school.location ?? "")
                SchoolOverview(overview: school.overview_paragraph ?? "")
                SchoolNumber(vm: vm, school: school, action: { getSatScore() })
            }.padding()
            ChevronArrow()
        }
        .listRowInsets(EdgeInsets()) // expand to edge of device
        .background ( /// programatic navigation link
            NavigationLink("", destination: SatScoreView(vm: vm), isActive: $vm.presentSatView).hidden()
        )
    }
    
    func getSatScore() {
        vm.selectedSchoolDbn = ""
        vm.selectedSchoolDbn = school.dbn
        vm.getSatScore(dbn: school.dbn)
    }
}


struct SchoolName: View {
    let name: String
    
    var body: some View {
        HStack {
            Text(name)
                .lineLimit(3)
                .font(.system(size: 18, weight: .bold))
                .padding(.trailing, TRAILING_PADDING)
            Spacer()
        }
    }
}

struct SchoolLocation: View {
    let location: String
    
    var components: [String] {     /// exclude coordinates for UI
        return location.components(separatedBy: "(")
    }
    
    var body: some View {
        HStack {
            Text(components[0])
                .multilineTextAlignment(.center)
                .font(.system(size: 15, weight: .semibold))
            Spacer()
        }
    }
}


struct SchoolOverview: View {
    let overview: String
    
    var body: some View {
        Text(overview)
            .lineLimit(nil)
            .font(.system(size: 12, weight: .regular))
            .padding(.trailing, TRAILING_PADDING)
    }
}


struct SchoolNumber: View {
    @ObservedObject var vm : SchoolViewModel
    let school: School
    let action: () -> Void
    
    var body: some View {
        HStack {
            Text(school.phone_number ?? NA)
                .lineLimit(1)
                .font(.system(size: 14, weight: .bold))
            Button(action: {action()}, label: {
                Text("View SAT Results")
                    .opacity(satOpacity())
                    .font(.system(size: 14, weight: .bold))
                    .foregroundColor(.blue)
                    .padding(.leading, 20)
                    .overlay(
                        ProgressView().tint(.blue)
                            .opacity(loadingOpacity())
                    )
            })
            Spacer()
        }
    }
    
    /// below 2 functions make sure progress view shows for correct cell only and not all
    func satOpacity() -> Double {
        if vm.satLoading && vm.selectedSchoolDbn == school.dbn {
            return 0.0
        }
        return 1.0
    }
    
    func loadingOpacity() -> Double {
        if vm.satLoading && vm.selectedSchoolDbn == school.dbn {
            return 1.0
        }
        return 0.0
    }
    
}

struct ChevronArrow: View {
    
    var body: some View {
        Image(systemName: "chevron.right")
            .font(.system(size: 20, weight: .regular))
            .foregroundColor(.gray)
            .padding(.trailing, 17.5)
    }
}
