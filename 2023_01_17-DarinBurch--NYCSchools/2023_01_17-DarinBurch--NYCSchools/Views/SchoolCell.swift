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
                SchoolNumber(vm: vm, number: school.phone_number ?? "", action: { vm.getSatScore(dbn: school.dbn) })
            }.padding()
            ChevronArrow()
        }
        .listRowInsets(EdgeInsets()) // expand to edge of device
        .background (
            NavigationLink("", destination: SatScoreView(vm: vm), isActive: $vm.presentSatView).hidden()
        )
    }
}


struct SchoolName: View {
    let name: String
    
    var components: [String] {
        return name.components(separatedBy: "")
    }
    
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
    
    var components: [String] {
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
    let number: String
    let action: () -> Void
    
    var body: some View {
        HStack {
            Text(number)
                .lineLimit(1)
                .font(.system(size: 14, weight: .bold))
            Button(action: {action()}, label: {
                Text("View SAT Results")
                    .opacity(vm.satLoading ? 0.0 : 1.0)
                    .font(.system(size: 14, weight: .bold))
                    .foregroundColor(.blue)
                    .padding(.leading, 20)
                    .overlay(
                        ProgressView().tint(.blue)
                            .opacity(vm.satLoading ? 1.0 : 0.0)
                    )
            })
            Spacer()
        }
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
