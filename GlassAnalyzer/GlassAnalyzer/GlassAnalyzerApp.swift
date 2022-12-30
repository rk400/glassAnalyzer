//
//  GlassAnalyzerApp.swift
//  GlassAnalyzer
//
//  Created by Aula11 on 18/11/22.
//

import SwiftUI

@main
//Prueba
struct GlassAnalyzerApp: App {
    @StateObject private var vm: ViewModel = ViewModel()
    var body: some Scene {
        WindowGroup {
            LoginView().environmentObject(vm)
        }
    }
}
