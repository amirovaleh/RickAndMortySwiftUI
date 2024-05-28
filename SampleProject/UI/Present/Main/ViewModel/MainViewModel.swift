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
    
    @Published var checkData: [CheckModel] = []
    
    func search(text: String) {
        if !text.isEmpty {
            filteredData.removeAll()
            allData.forEach { item in
                guard let name = item.name else { return }
                if name.prefix(text.count).lowercased().contains(text.lowercased()) {
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
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
