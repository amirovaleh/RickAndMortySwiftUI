//
//  DetailViewModel.swift
//  SampleProject
//
//  Created by Valeh Amirov on 26.05.24.
//

import Foundation

final class DetailViewModel: ObservableObject {
    
    @Published var character: Results = Results(id: nil, name: "", status: "", species: "", type: "", gender: "", origin: nil, location: nil, image: "", episode: [], url: "", created: "", isMarked: false)
    
     @Published var isOn: Bool = false

    @Published var isMarkedData: [CheckModel] = []
    
    
    
    private var repository = CharacterRepository()
    private let manager = DataManager()

    
    func checkAndSet(id: Int, isMarked: Bool) {
        
        if let idIndex = isMarkedData.firstIndex(where: {$0.id == id }) {
            isMarkedData[idIndex].isMarked = isMarked
        } else {
            let item = CheckModel(id: id, isMarked: isMarked)
            isMarkedData.append(item)
        }
        setData()
    }

    
    
    func setData() {
        manager.encode(items: isMarkedData) { result in
            switch result {
            case .success(let result):
                UserDefaults.standard.checkData = result
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func fetchCheckMark(id: Int) {
        guard let data = UserDefaults.standard.checkData else { return }
        manager.decode(data: data, model: [CheckModel].self) { result in
            switch result {
            case .success(let result):
                self.isMarkedData = result
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        isOn = check(id: id)
    }
    
    func check(id: Int) -> Bool {
        if let idIndex = isMarkedData.firstIndex(where: {$0.id == id }) {
            let item = isMarkedData[idIndex].isMarked
            return item
        }
        return false
    }
    
    func fetchData(id: Int) {
        repository.getID(id: id) { result in
            switch result {
            case .success(let result):
                DispatchQueue.main.async {
                    self.character = result
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

