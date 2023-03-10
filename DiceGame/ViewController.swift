//
//  ViewController.swift
//  DiceGame
//
//  Created by ahmet kardesseven on 10.03.2023.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var lblOyuncu1Skor: UILabel!
    
    @IBOutlet weak var lblOyuncu2Skor: UILabel!
    
    @IBOutlet weak var lblOyuncu2Durum: UIImageView!
    @IBOutlet weak var lblOyuncu1Durum: UIImageView!
    @IBOutlet weak var lblOyuncu2Puan: UILabel!
    @IBOutlet weak var lblOyuncu1Puan: UILabel!

    @IBOutlet weak var imageZar1: UIImageView!
    @IBOutlet weak var imageZar2: UIImageView!
    @IBOutlet weak var lblSetSonucu: UILabel!
    
    var oyuncuPuanlari = (birinciOyuncuPuani : 0, ikinciOyuncuPuani : 0)
    var oyuncuSkorlari = (birinciOyuncuSkoru : 0, ikinciOyuncuSkoru : 0)
    var oyuncuSira : Int = 1
    
    var maxSetSayisi : Int = 5
    var suankiSet : Int = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        
        
        
        
        
        
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "arkaPlan")!)
    }
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        print("Telefon sallandı")
        
        if suankiSet > maxSetSayisi {
            return
        }
        zarDegerleriniUret()
    }
    func setSonucu(zar1 : Int, zar2 : Int){
        
        
        if oyuncuSira == 1 {
            oyuncuPuanlari.birinciOyuncuPuani = zar1 + zar2
            lblOyuncu1Puan.text = String(oyuncuPuanlari.birinciOyuncuPuani)
            lblOyuncu1Durum.image = UIImage(named: "bekle")
            lblOyuncu2Durum.image = UIImage(named: "onay")
            lblSetSonucu.text = "Sıra 2. Oyuncuda"
            oyuncuSira = 2
            lblOyuncu2Puan.text = "0"
        }else {
            oyuncuPuanlari.ikinciOyuncuPuani = zar1 + zar2
            lblOyuncu2Puan.text = String(oyuncuPuanlari.ikinciOyuncuPuani)
            lblOyuncu1Durum.image = UIImage(named: "onay")
            lblOyuncu2Durum.image = UIImage(named: "bekle")
            oyuncuSira = 1
            
            if oyuncuPuanlari.birinciOyuncuPuani > oyuncuPuanlari.ikinciOyuncuPuani {
                
                oyuncuSkorlari.birinciOyuncuSkoru += 1
                lblSetSonucu.text = "\(suankiSet). Seti 1. Oyuncu Kazandı"
                
                suankiSet += 1
                lblOyuncu1Skor.text = String(oyuncuSkorlari.birinciOyuncuSkoru)
            }else if oyuncuPuanlari.ikinciOyuncuPuani > oyuncuPuanlari.birinciOyuncuPuani {
                
                oyuncuSkorlari.ikinciOyuncuSkoru += 1
                lblSetSonucu.text = "\(suankiSet). Seti 2. Oyuncu Kazandı"
                suankiSet += 1
                lblOyuncu2Skor.text = String(oyuncuSkorlari.ikinciOyuncuSkoru)
            }else {
                lblSetSonucu.text = "\(suankiSet). Set Berabere Sona Erdi."
                
            }
            
            
            
        }
        
    }
    func zarDegerleriniUret(){
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3){ [self] in
            let zar1 = arc4random_uniform(6) + 1
            let zar2 = arc4random_uniform(6) + 1
            imageZar1.image = UIImage(named: String(zar1))
            imageZar2.image = UIImage(named: String(zar2))
            setSonucu(zar1: Int(zar1), zar2: Int(zar2))
            
            if suankiSet > maxSetSayisi {
                if oyuncuSkorlari.birinciOyuncuSkoru > oyuncuSkorlari.ikinciOyuncuSkoru{
                    lblSetSonucu.text = "Oyunun Galibi 1. Oyuncu"
                }else{
                    lblSetSonucu.text = "Oyunun Galibi 2. Oyuncu"
                }
            }

        }
        lblSetSonucu.text = "\(oyuncuSira). Oyuncusu Zar atıyor"
        imageZar1.image = UIImage(named: "bilinmeyenZar")
        imageZar2.image = UIImage(named: "bilinmeyenZar")
         
    }


}

