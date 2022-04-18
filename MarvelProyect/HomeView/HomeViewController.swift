//
//  HomeViewController.swift
//  MarvelProyect
//
//  Created by Ricardo Sanchez on 12/4/22.
//

import Foundation
import UIKit
import PKHUD

protocol AnyView {
    var presenter: AnyPresenter? {get set}

    func update(with heros: [Hero])
    func update(with error: String)
    func showActivity()
    func stopAndHidenActivity(typeOfHUD: HUDContentType)
}

class HomeViewController: ViewController, AnyView {

    var presenter: AnyPresenter?
    var heros: [Hero] = []

    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = edge.right
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        return collectionView
    }()

    lazy var button: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(systemName: "plus.circle"), for: .normal)
        btn.addTarget(self, action: #selector(moreHeros), for: .touchUpInside)

        return btn
    }()

    let edge: UIEdgeInsets = UIEdgeInsets(top: 24, left: 24, bottom: 24, right: 24)
    var countHeros = 10

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
        initViews()
        applyConstraints()
        collectionView.dataSource = self
        collectionView.delegate = self

        collectionView.register(UINib(nibName: HeroCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: HeroCollectionViewCell.identifier)
    }

//    override func loadView() {
//        view = collectionView
//    }

    func update(with heros: [Hero]) {
        DispatchQueue.main.async {
            self.heros = heros
            self.collectionView.reloadData()
        }
    }

    func update(with error: String) {

    }

    func showActivity() {
        DispatchQueue.main.async {
        HUD.show(.progress)
        }
    }

    func stopAndHidenActivity(typeOfHUD: HUDContentType) {
        DispatchQueue.main.async {
        HUD.flash(typeOfHUD, delay: 0.7, completion: {_ in
            HUD.hide()
        })
        }
    }

    @objc func moreHeros() {
        countHeros += 10
        presenter?.getMoreHeros(numberOfHeros: countHeros)
    }
}

extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return heros.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HeroCollectionViewCell.identifier, for: indexPath) as! HeroCollectionViewCell
        cell.setup(name: heros[indexPath.row].name, url: heros[indexPath.row].imageUrl)
        return cell
    }


}

private extension HomeViewController {
    func initViews() {
        view.backgroundColor = UIColor(red: 247/255, green: 237/255, blue: 235/255, alpha: 1)
        collectionView.backgroundColor = UIColor(red: 247/255, green: 237/255, blue: 235/255, alpha: 1)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(collectionView)
        button.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(button)
    }

    func applyConstraints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 8),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        ])

        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 8),
            button.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            button.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            button.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension HomeViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return edge
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let colums: CGFloat = 2
        let width = (collectionView.frame.width - edge.right)/colums - (edge.right)
        let height = (collectionView.frame.height * 0.25) - edge.top
        let size = CGSize(width: width, height: height)

        return size
    }

}
