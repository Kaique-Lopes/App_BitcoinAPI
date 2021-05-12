//
//  ViewController.swift
//  App_BitcoinAPI
//
//  Created by Kaique Lopes on 06/05/21.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var lbResult: UILabel! {
        didSet {
            lbResult.alpha = 0.2
        }
    }
    @IBOutlet weak var btConsult: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func consult(_ sender: Any) {
        self.valueBitcoin()
    }
    
    func formatValue(value: NSNumber) -> String {
        let nf = NumberFormatter()
        nf.numberStyle = .decimal
        nf.locale = Locale(identifier: "pt_BR")
        
        if let valueFinal = nf.string(from: value) {
            return valueFinal
        }
        return "0,00"
    }
    
    func valueBitcoin() {
        self.btConsult.setTitle("Atualizando", for: .normal)
            // MARK: - URL API
        if let url = URL(string: "https://blockchain.info/pt/ticker") {
            
            // MARK: - Verificação de erro
            let data = URLSession.shared.dataTask(with: url) { datas, request, error in
                if error == nil {
                    // MARK: - Retornando os dados
                    if let dataRequest = datas {
                        do {
                            if let json = try JSONSerialization.jsonObject(with: dataRequest, options: []) as? [String: Any] {
                                // MARK: - Retornando Valores
                                if let brl = json["BRL"] as? [String: Any] {
                                    if let buy = brl["buy"] as? Double {
                                        let valueFormated = self.formatValue(value: NSNumber(value: buy))
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                            self.lbResult.text = "R$ " + valueFormated
                                            self.lbResult.alpha = 1.0
                                            self.btConsult.setTitle("Atualizado", for: .normal)
                                        }
                                        
                                    }
                                }
                                
                            }
                            
                        } catch {
                            print("erro")
                        }
                    }
                    
                } else {
                    print("Erro ao consultar a API")
                }
            }
            data.resume()
        }
    }
}

