//
//  MainViewModel.swift
//  2023_01_17-DarinBurch--NYCSchools
//
//  Created by Mapspot on 1/17/23.
//

import SwiftUI


class SchoolViewModel: ObservableObject {
    
    @Published var showAlert = false
    var alertTitle = ""
    var alertMessage = ""
    
    @Published var orderBy: SchoolOrder = .name
    @Published var schools: [School] = []
    
    @Published var currentSat: SatScore?
    
    
    @Published var presentSatView: Bool = false
    
    @Published var isLoading: Bool = false
    @Published var satLoading: Bool = false
    @Published var loadingMoreSchools = false
    
    var currentPage = 0
    
    @Published var allCaughtUp: Bool = false
    
    var task: Task<(), Never>?
    
    func loadSchools() {
        DispatchQueue.main.async {
            self.currentPage = 0
            self.isLoading = true
        }
        task = Task {
            do {
                let schools = try await SchoolDataService.loadSchoolData(limit: SCHOOL_LIMIT, page: currentPage, orderBy: orderBy)
                DispatchQueue.main.async {
                    if schools.count < 10 {
                        self.allCaughtUp = true
                        self.schools = schools
                        self.isLoading = false
                        return
                    }
                    self.schools = schools
                    self.currentPage += 1
                    self.isLoading = false
                }
            } catch {
                print(error)
                DispatchQueue.main.async {
                    self.allCaughtUp = false
                    self.loadingMoreSchools = false
                    self.isLoading = false
                    self.showAlert = true
                    self.alertTitle = "Error"
                    self.alertMessage = error.localizedDescription
                }
            }
        }
    }
    
    func loadMoreSchools() async {
        self.allCaughtUp = false
        self.loadingMoreSchools = true
        do {
            let schools = try await SchoolDataService.loadSchoolData(limit: SCHOOL_LIMIT, page: currentPage, orderBy: orderBy)
            DispatchQueue.main.async {
                if self.schools.count < 10 {
                    self.allCaughtUp = true
                    self.schools.append(contentsOf: schools)
                    self.loadingMoreSchools = false
                    return
                }
                self.schools.append(contentsOf: schools)
                self.currentPage += 1
                self.loadingMoreSchools = false
            }
        } catch {
            self.allCaughtUp = false
            self.loadingMoreSchools = false
            self.alertMessage = error.localizedDescription
            self.showAlert = true
        }
    }
    
    @MainActor
    func getSatScore(dbn: String) {
        self.currentSat = nil
        self.satLoading = true
        task = Task {
            do {
                let satArray = try await SatDataService.loadSatData(dbn: dbn)
                self.currentSat = satArray[0]
                guard self.currentSat != nil else {
                    self.showAlert = true
                    self.alertTitle = "Error getting score"
                    self.alertMessage = "Sat score is empty"
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
                        self.satLoading = false
                    }
                    return
                }
                DispatchQueue.main.async {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
                        self.satLoading = false
                    }
                    self.presentSatView = true
                }
            } catch {
                DispatchQueue.main.async {
                    self.satLoading = false
                    self.showAlert = true
                    self.alertTitle = "Error"
                    self.alertMessage = error.localizedDescription
                }
            }
        }
    }
    
    init() {
        loadSchools()
    }
    
    deinit {
        self.currentPage = 0
        self.schools = []
        self.currentSat = nil
    }
}
