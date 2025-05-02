//
//  RankComponent.swift
//  Sedam
//
//  Created by minsong kim on 4/25/25.
//

import SwiftUI

struct RankComponent: View {
    @Binding var rank: String
    
    var body: some View {
        ZStack {
            Circle()
                .foregroundStyle(.dadsCoupe)
                .frame(width: 48)
            Text(rank)
                .font(.danjoBold24)
                .foregroundStyle(.white)
        }
    }
}
