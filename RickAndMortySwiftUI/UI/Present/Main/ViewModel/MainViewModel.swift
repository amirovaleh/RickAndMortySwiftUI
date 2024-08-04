//
//  MainViewModel.swift
//  SampleProject
//
//  Created by Valeh Amirov on 24.05.24.
//

import Foundation

class MainViewModel: ObservableObject {
    
    private let repository = CharacterRepository()
    private var allData: [Results] = []
    @Published var filteredData: [Results] = []
    @Published var isMarkedData: [CheckModel] = []

    private let manager = DataManager()

    @Published var checkData: [CheckModel] = []
    
    func search(text: String) {
        if !text.isEmpty {
            filteredData.removeAll()
            allData.forEach { item in
                guard let name = item.name else { return }
                if name.lowercased().contains(text.lowercased()) {
                    filteredData.append(item)
                }
            }
        } else {
            filteredData = allData
        }
    }
    
    func fetchData() {
        
        repository.getCharacter { result in
            switch result {
            case .success(let result):
                DispatchQueue.main.async {
                    self.allData = result.results
                    self.filteredData = result.results
                    self.fetchCheckMark()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func fetchCheckMark() {
        guard let data = UserDefaults.standard.checkData else { return }
        manager.decode(data: data, model: [CheckModel].self) { result in
            switch result {
            case .success(let result):
                
                DispatchQueue.main.async {
                    self.isMarkedData = result
                    self.isMarkedData.forEach { result in
                        if let index = self.filteredData.firstIndex(where: {$0.id == result.id}) {
                            self.filteredData[index].isMarked = result.isMarked
                        }
                    }
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
