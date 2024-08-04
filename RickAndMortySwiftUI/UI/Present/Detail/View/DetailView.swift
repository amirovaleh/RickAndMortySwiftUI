//
//  DetailView.swift
//  SampleProject
//
//  Created by Valeh Amirov on 26.05.24.
//

import SwiftUI
import SDWebImageSwiftUI

struct DetailView: View {
    
    @StateObject var vm = DetailViewModel()
    var id: Int
    @State var isOn: Bool = false
    
    @Environment(\.dismiss) private var dismiss
    
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.customPurple
                    .ignoresSafeArea()
                VStack {
                    Text(vm.character.name ?? "Can't Found Data")
                        .font(.system(size: 40))
                    VStack(alignment: .leading) {
                        HeaderView(character: vm.character)
                        Spacer().frame(height: 30)
                            VStack(alignment: .leading) {
                                InfoView(character: vm.character)
                            }
                        Spacer()
                    }
                    .onAppear {
                        vm.fetchData(id: id)
                    }
                    .padding(20)
                }
                .foregroundStyle(Color.white)
            }
        }
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItemGroup(placement: .navigationBarLeading) {
                Button(action: {
                    dismiss()
                }, label: {
                    HStack(spacing: 3) {
                        Image(systemName: "chevron.backward")
                            .padding()
                            .background(Color.customGray.opacity(0.5))
                            .clipShape(Circle())
                    }
                    .tint(.white)
                })
            }
            
            ToolbarItem(placement: .navigationBarTrailing) {
                
                Toggle("", isOn: $vm.isOn)
                    .toggleStyle(ToggleBookMark())
                    .onChange(of: vm.isOn) { oldValue, newValue in
                        vm.checkAndSet(id: self.id, isMarked: newValue)
                    }
            }
        }
        .onAppear {
            vm.fetchCheckMark(id: self.id)
        }
    }
}

#Preview {
    DetailView(id: 0)
}
