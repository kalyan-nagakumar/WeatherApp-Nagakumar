//
//  LoadingView.swift
//  NagaKumar-WeatherApp-SwiftUI
//
//  Created by Kalyan Vajrala on 11/30/23.
//

import SwiftUI
/// made changes in loading view
struct LoadingView: View {
    
    var body: some View {
        ProgressView()
            .progressViewStyle(CircularProgressViewStyle(tint: .blue))
            .frame(width: .infinity,height: .infinity)
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}
