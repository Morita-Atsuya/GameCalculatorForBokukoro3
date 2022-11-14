//
//  DouguSpecialEffectView.swift
//  boku3
//
//  Created by 森田敦也 on 2022/08/30.
//

import SwiftUI

struct DouguSpecialEffectView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @ObservedObject var dougu: Dougu
    @State private var isChange = false
    
    var body: some View {
        VStack{
            Text("特殊能力")
                .font(.title2)
            
            HStack{
                Text("メイン")
                DouguSpecialEffectEditor(dougu: dougu, effectKeyPath: \Dougu.specialE, effectAmountKeyPath: \Dougu.specialE_amount)
            }
            HStack{
                Text("全体枠")
                DouguSpecialEffectEditor(dougu: dougu, effectKeyPath: \Dougu.powerUpForAll, effectAmountKeyPath: \Dougu.powerUpForAllAmount)
            }
        }
    }
}


/*
struct DouguSpecialEffectView_Previews: PreviewProvider {
    static var previews: some View {
        DouguSpecialEffectView()
    }
}
*/
