//
//  Interactor.swift
//  MarvelProyect
//
//  Created by Ricardo Sanchez on 12/4/22.
//

import Foundation

protocol AnyInteractor {
    var presenter: AnyPresenter? {get set}

    func getData(count: String)
}

class HomeInteractor: AnyInteractor {

    var presenter: AnyPresenter?

    func getData(count: String) {
        let session = URLSession.shared
         let constans = Constants()

             let urlString = "\(constans.url)\(constans.ts)\(constans.apikey)\(constans.hash)&limit=\(count)"

             guard let url = URL(string: urlString) else {
                 print("No se pudo hacer la llamada")
                 self.presenter?.interactorDidFetchHeros(with: .failure(.unknown))
                 return
             }

             let task = session.dataTask(with: url) {(data, urlResponse, error) in
                 if let error = error {
                     print("Ha ocurrido un error: \(error.localizedDescription)")
                     self.presenter?.interactorDidFetchHeros(with: .failure(.unknown))
                     return
                 }

                 guard let data = data else {
                     print("Datos Vacios")
                     self.presenter?.interactorDidFetchHeros(with: .failure(.empyData))
                     return
                 }

                 do {
                     let heroResponse = try JSONDecoder().decode(Heros.self, from: data)
                     let heros = HeroMapper.mapHero(response: heroResponse)
                     self.presenter?.interactorDidFetchHeros(with: .success(heros))
                 } catch let error {
                     print("Detail")
                     print(error.localizedDescription)
                     self.presenter?.interactorDidFetchHeros(with: .failure(.wrongFormat))
                 }
             }; task.resume()
    }
}
