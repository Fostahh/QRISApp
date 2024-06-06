//
//  HomeView.swift
//  QRISApp
//
//  Created by Mohammad Azri on 02/04/24.
//

import Foundation
import shared

protocol HomeView: BaseView {
    var presenter: HomePresenter? { get set }
    
    func update(with user: User)
    func update(with error: String)
    
    func updateDotaHeroes(with dotaHeroes: [MockResponse])
}
