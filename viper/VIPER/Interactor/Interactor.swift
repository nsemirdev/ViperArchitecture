//
//  Interactor.swift
//  viper
//
//  Created by Emir Alkal on 17.01.2023.
//

import Foundation

protocol AnyInteractor {
    var presenter: AnyPresenter? { get set }
    
    func getUsers()
}

final class UserInteractor: AnyInteractor {
    var presenter: AnyPresenter?
    
    func getUsers() {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/users") else { return }
        let req = URLRequest(url: url)
        
        let task = URLSession.shared.dataTask(with: req) { [weak self] data, _, error in
            guard let self else { return }
            guard let data, error == nil else {
                self.presenter?.interactorDidFetchUsers(with: .failure(error!))
                return
            }
            do {
                let entities = try JSONDecoder().decode([User].self, from: data)
                self.presenter?.interactorDidFetchUsers(with: .success(entities))
            } catch {
                self.presenter?.interactorDidFetchUsers(with: .failure(error))
            }
        }
        task.resume()
    }
    
}
