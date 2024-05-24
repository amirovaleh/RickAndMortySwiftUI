//
//  MainViewModel.swift
//  SampleProject
//
//  Created by Valeh Amirov on 24.05.24.
//

import Foundation

class MainViewModel: ObservableObject {
    
    private let repository: DICharacterRepository
    
    
    @Published var charactersData: [Results] = []
    
    init(repository: DICharacterRepository) {
        self.repository = repository
    }
    
    
    func fetchData() {
        
        repository.getCharacter { result in
            switch result {
            case .success(let result):
                self.charactersData = result.results
            case .failure(let error):
                print(error.errorDescription)
                print("sen get Veysəl gəlsin")
            }
        }
    }
    
}
