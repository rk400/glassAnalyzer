//
//  TabBarView.swift
//  GlassAnalyzer
//
//  Created by Ruth Rodriguez on 24/11/22.
//

import SwiftUI

struct TabBarView: View {
    
    @State var selectedTab = "0"
    @Binding var pages: [TabBarPage]
    init(pages: Binding<[TabBarPage]>) {
        UITabBar.appearance().isHidden = true
        self._pages = pages
    }
    var body: some View {
        ZStack(alignment: .bottom) {
            
            TabView(selection: $selectedTab) {
                
                ForEach(pages) { item in
                    AnyView(_fromValue: item.page)
                        .tabItem{
                            EmptyView()
                        }.tag(item.tag)
                }
            }
            
            HStack {
                ForEach(pages) { item in
                    Button(action: {
                        self.selectedTab = item.tag
                    }) {
                        ZStack {
                            VStack{
                                Spacer().frame(height: 5)
                                Image(systemName: item.icon)
                                    .foregroundColor(self.selectedTab == item.tag ? Color.gray : Color.blue)
                                    .imageScale(.large)
                                    .frame(width: 20, height: 20, alignment: .center)
                                HStack{
                                    Text(item.name)
                                        .foregroundColor(self.selectedTab == item.tag ? Color.gray : Color.blue)
                                        .font(.custom("Inter",fixedSize: 12))
                                }
                            }
                        }
                    }
                    .frame(maxWidth: .infinity)
                }
            }
            .padding(5)
            .background(Color.white)
            .cornerRadius(35)
            .padding()
        }
        
        
    }
}

struct TabBarPage: Identifiable {
    var id = UUID()
    var page: Any
    var icon: String
    var tag: String
    var name: String
    var color: Color
}
