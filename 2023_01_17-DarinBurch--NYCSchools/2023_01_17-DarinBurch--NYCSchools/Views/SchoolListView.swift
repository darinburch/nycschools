//
//  SchoolListView.swift
//  2023_01_17-DarinBurch--NYCSchools
//
//  Created by Mapspot on 1/17/23.
//

import SwiftUI

struct SchoolListView: View {
    @StateObject var vm = SchoolViewModel()
    
    var moreSchoolsToLoad: Bool {
        /// if vm.schools.count cannot evenly be divided by 10, no more to load...
        let double = Double(vm.schools.count) / Double(SCHOOL_LIMIT)
        return floor(double) == double
    }
    
    /// get id of last index so when that cell appears we make an API call to load 10 more schools
    var schoolDbnLastIndex: String {
        if let lastSchool = vm.schools.last {
            return lastSchool.dbn 
        }
        return ""
    }
    
    var body: some View {
        if vm.isLoading {
            VStack {
                Spacer()
                Text("Loading NYC schools...")
                    .bold()
                ProgressView().tint(.black)
                Spacer()
            }
        } else {
            List(vm.schools, id: \.dbn) { school in
                SchoolCell(vm: vm, school: school)
                    .onAppear { /// when last element appears we load more
                        if school.dbn == schoolDbnLastIndex && moreSchoolsToLoad {
                            Task.detached {
                                await vm.loadMoreSchools()
                            }
                        }
                    }
            }
            .clipped()
            .alert(isPresented: $vm.showAlert) {
                Alert(title: Text(vm.alertTitle), message: Text(vm.alertMessage), dismissButton: .default(Text("Ok")))
            }
            .listStyle(PlainListStyle()) /// get rid of extra padding TOP AND BOTTOM
            .refreshable { /// pull down to refresh functionality
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.9) {
                    Task.detached {
                        await vm.loadSchools()
                    }
                }
            }
            .navigationViewStyle(StackNavigationViewStyle())
            .navigationBarTitle(Text("NYC School Data"), displayMode: .inline)
        }
    }
}


