//
//  DetailViewModel.swift
//  SampleProject
//
//  Created by Valeh Amirov on 26.05.24.
//

import Foundation

final class DetailViewModel: ObservableObject {
    
    @Published var character: Results = Results(id: nil, name: "", status: "", species: "", type: "", gender: "", origin: nil, location: nil, image: "", episode: [], url: "", created: "", isMarked: false)
    
    private var repository = CharacterRepository()
        
    func fetchData(id: Int) {
        repository.getID(id: id) { result in
            switch result {
            case .success(let result):
                DispatchQueue.main.async {
                    self.character = result
                }
//                MARK: ------ Bu menim errorumu dala qaytaracaqmı?
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
