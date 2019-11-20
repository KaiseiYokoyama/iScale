//
//  ContentView.swift
//  iScale
//
//  Created by Murakumo on 2019/10/20.
//  Copyright © 2019 YOKOYAMA. All rights reserved.
//

import SwiftUI

struct ContentView: View {
//    @State
    let scale: Scale
    @State
    var subScales: [Scale] = []
    
    static var dateFormatter: DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .short
        dateFormatter.dateStyle = .short
        return dateFormatter
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading) {
                    ScaleView(self.scale)
                        .navigationBarTitle(Text(self.scale.title))
//                    List {
                        ForEach(subScales) { (scale) in
                            NavigationLink(destination: ContentView(scale)) {
                                SubScaleView(scale)
                            }
                        }
//                        .onMove(perform: move)
//                    }
                    .navigationBarTitle(Text(self.scale.title))
                }
            }
        }
//        .navigationBarTitle(Text(self.scale.title))
        .navigationViewStyle(StackNavigationViewStyle())
    }
    
    init(_ scale: Scale) {
        self.scale = scale
        self.subScales = scale.subScales
        self._subScales = State(initialValue: scale.subScales)
    }
    
    func move(from source: IndexSet, to destination: Int) {
        self.subScales.move(fromOffsets: source, toOffset: destination)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        // get sample scale
        let scale = Scale.sampleScale()
        for i in 1...5 {
            let subScale = Scale.sampleScale()
            subScale.title = subScale.title + String(i)
            if (i%2==0) {
                subScale.disabled = true
            }
            scale.push(subScale)
        }

        return ContentView(scale).previewDevice(PreviewDevice(rawValue: "iPad (6th generation)"))
    }
}
