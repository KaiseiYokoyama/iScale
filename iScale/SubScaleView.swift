//
//  SubScaleView.swift
//  iScale
//
//  Created by Murakumo on 2019/11/18.
//  Copyright © 2019 YOKOYAMA. All rights reserved.
//

import Foundation
import SwiftUI

struct SubScaleView: View, Identifiable {
    let id = UUID()
    let scale: Scale
    var accentColor: Color {
        if self.scale.disabled {
            return .secondary
        } else {
            return .primary
        }
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(self.scale.title)
                .font(.title)
                .padding()
            Text(self.scale.summary)
                .lineLimit(nil)
                .padding()
        }
//        .fixedSize(horizontal: false, vertical: true)
            .accentColor(self.accentColor)
    }
    
    init(_ scale: Scale) {
        self.scale = scale
    }
}

struct SubScaleView_Previews: PreviewProvider {
    static var previews: some View {
        SubScaleView(Scale.sampleScale()).previewDevice(PreviewDevice(rawValue: "iPad (6th generation)"))
    }
}
