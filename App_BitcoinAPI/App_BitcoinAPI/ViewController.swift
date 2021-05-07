//
//  ViewController.swift
//  App_BitcoinAPI
//
//  Created by Kaique Lopes on 06/05/21.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let url = URL(string: "https://blockchain.info/pt/ticker") {
            let data = URLSession.shared.dataTask(with: url) { datas, request, error in
                if error == nil {
                    print("Sucesso ao consultar a API")
                } else {
                    print("Erro ao consultar a API")
                }
            }
            data.resume()
        }
    }
}

