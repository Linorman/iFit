//
//  PersonView.swift
//  iFit
//
//  Created by 霍治宇 on 2023/5/7.
//

import Foundation
import SwiftUI
import CoreData

struct PersonView: View {
    @Environment(\.localUser) private var localUser
    @Environment(\.managedObjectContext) private var viewContext
    
    @State private var isShowingImagePicker = false
    @State private var selectedImage: UIImage?
    @State private var name = ""
    @State private var phoneNumber = ""
    @State private var email = ""
    
    
    
    var body: some View {
        NavigationView {
            VStack(alignment: .center, spacing: 20) {
                Button(action: {
                    self.isShowingImagePicker.toggle()
                }) {
                    if let image = selectedImage {
                        Image(uiImage: image)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 200, height: 200)
                            .clipShape(Circle())
                    } else {
                        Image(systemName: "person.circle.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 200, height: 200)
                            .foregroundColor(.gray)
                    }
                }
                .sheet(isPresented: $isShowingImagePicker, onDismiss: loadImage) {
                    ImagePicker(image: self.$selectedImage)
                }
//                HStack {
//                    Text("姓名:")
//                    TextField("名字", text: $name)
//                        .textFieldStyle(.roundedBorder)
//                        .onAppear {
//                            name =   localUser.wrappedValue.username ?? ""
//                        }
//                }
//                HStack {
//                    Text("手机号码:")
//                    TextField("手机号码", text: $phoneNumber)
//                        .textFieldStyle(.roundedBorder)
//                        .onAppear {
//                            phoneNumber = localUser.wrappedValue.phoneNumber ?? ""
//                        }
//                }
//                HStack {
//                    Text("邮箱:")
//                    TextField("邮箱", text: $email)
//                        .textFieldStyle(.roundedBorder)
//                        .onAppear {
//                            email = localUser.wrappedValue.email ?? ""
//                        }
//                }
//                HStack {
//                    Text("姓名:")
//                    TextField("名字", text: $name)
//                        .textFieldStyle(.roundedBorder)
//                }
//                HStack {
//                    Text("手机号码:")
//                    TextField("手机号码", text: $phoneNumber)
//                        .textFieldStyle(.roundedBorder)
//                }
//                HStack {
//                    Text("邮箱:")
//                    TextField("邮箱", text: $email)
//                        .textFieldStyle(.roundedBorder)
//                }
            }
            .padding()
            .navigationTitle("个人信息")
            .onAppear {
                print(localUser.wrappedValue)
                let request = NSFetchRequest<User>(entityName: "User")
                request.predicate = NSPredicate(format: "username == %@ ", localUser.wrappedValue)
                
                do {
                    let users = try viewContext.fetch(request)
                    if let user = users.first {
                        self.name = user.username ?? "无名"
                        self.email = user.email ?? "没有"
                        self.phoneNumber = user.phoneNumber ?? "没有"
                    } else {
                        // Invalid credentials.
                        // Show an error message to the user.
                    }
                } catch {
                    // Error fetching users.
                    // Show an error message to the user.
                }
            }
            
        }
    }
    
    func loadImage() {
        guard let selectedImage = selectedImage else { return }
        // 保存头像图片到相册或者服务器
    }
}
