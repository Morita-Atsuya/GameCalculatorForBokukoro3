//
//  ZokuseiButton.swift
//  boku3
//
//  Created by 森田敦也 on 2022/08/28.
//

import SwiftUI

struct ZokuseiButton: View {
    @Environment(\.managedObjectContext) private var viewContext
    @ObservedObject var character: Character
    var body: some View {
        HStack{
            Text("属性")
                .font(.title2)
            Spacer()
            
            if character.megami{
                Button("女神"){
                    character.megami.toggle()
                    save()
                }
                .foregroundColor(.red)
                .font(.title)
            }else{
                Button("女神"){
                    character.megami.toggle()
                    save()
                }
                .foregroundColor(.gray)
                .font(.title)
            }
            if character.nyannko{
                Button("にゃんこ"){
                    character.nyannko.toggle()
                    save()
                }
                .foregroundColor(.red)
                .font(.title)
            }else{
                Button("にゃんこ"){
                    character.nyannko.toggle()
                    save()
                }
                .foregroundColor(.gray)
                .font(.title)
            }
            if character.ikemenn{
                Button("イケメン"){
                    character.ikemenn.toggle()
                    save()
                }
                .foregroundColor(.red)
                .font(.title)
            }else{
                Button("イケメン"){
                    character.ikemenn.toggle()
                    save()
                }
                .foregroundColor(.gray)
                .font(.title)
            }
        }
    }
    private func save(){
        try? viewContext.save()
    }
}

/*
struct ZokuseiButton_Previews: PreviewProvider {
    static var previews: some View {
        ZokuseiButton()
    }
}
*/
