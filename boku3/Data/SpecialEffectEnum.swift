//
//  SpecialEffectEnum.swift
//  boku3
//
//  Created by 森田敦也 on 2022/08/28.
//

import Foundation

enum SpecialEffect: String,CaseIterable {
    case kuuhaku = "未定or効果なし"
    
    case forALL = "全体攻撃力UP"
    case forSelf = "自分の攻撃力UP"
    
    case habatu_eji = "派閥　エジプト"
    case habatu_kyuu = "派閥　旧支配"
    case habatu_giri = "派閥　ギリシャ"
    case habatu_doku = "派閥　独立"
    
    case tipe_1 = "攻撃間隔　1"
    case tipe_3 = "攻撃間隔　3"
    case tipe_5 = "攻撃間隔　5"
    case tipe_8 = "攻撃間隔　8"
    
    case zokusei_nya = "属性　にゃんこ"
    case zokusei_mega = "属性　女神"
    case zokusei_ike = "属性　イケメン"
    case zokusei_no = "属性　なし"
    
    case rerity4 = "レア4　UP"
    case speed = "攻撃スピードUP"
    
    case tehai_HP = "手配書　HP減少"
    case tehai_pt = "手配書　ポイントUP"
    case tehai_time = "手配書　時間UP"
    
    case partyDepend_NotNormal_Normal = "ノーマル以外ごとノーマル"
    

}
