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
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.presentationMode) var presentationMode
    
    @State private var isShowingImagePicker = false
    @State private var selectedImage: UIImage?
    @State private var name = ""
    @State private var phoneNumber = ""
    @State private var email = ""
    @State private var isAlert = false
    @State private var localUsername: String
    
    init(localUsername: String) {
        _localUsername = State(initialValue: localUsername)
    }
    
    
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
                HStack {
                    Text("姓名:")
                    TextField("名字", text: $name)
                        .textFieldStyle(.roundedBorder)
                        .disabled(true)
                }
                HStack {
                    Text("手机号码:")
                    TextField("手机号码", text: $phoneNumber)
                        .textFieldStyle(.roundedBorder)
                        .disabled(true)
                }
                HStack {
                    Text("邮箱:")
                    TextField("邮箱", text: $email)
                        .textFieldStyle(.roundedBorder)
                        .disabled(true)
                }
            }
            .alert(isPresented: $isAlert) {
                Alert(title: Text("错误"), message: Text("请重新登录"), dismissButton: .default(Text("确定"), action: {self.presentationMode.wrappedValue.dismiss()}
                                                                                        )
                )
            }
            .padding()
            .navigationTitle("个人信息")
            
            
        }
        .onAppear {
            let request = NSFetchRequest<User>(entityName: "User")
            request.predicate = NSPredicate(format: "username == %@ ", localUsername)
            
            do {
                let users = try viewContext.fetch(request)
                if let user = users.first {
                    self.name = user.username ?? "无名"
                    self.email = user.email ?? "没有"
                    self.phoneNumber = user.phoneNumber ?? "没有"
                    if let imageData = user.avatar {
                        selectedImage = UIImage(data: imageData)
                    } else {
                        // isShowingImagePicker = true
                    }
                } else {
                    // Invalid credentials.
                    // Show an error message to the user.
                    self.isAlert = true
                }
            } catch {
                // Error fetching users.
                // Show an error message to the user.
            }
        }
    }
    
    func loadImage() {
        guard let selectedImage = selectedImage else { return }
        
        guard let imageURL = selectedImage.saveToDisk() else { return }
        
        // 将图像数据编码为PNG格式
        guard let imageData = selectedImage.pngData() else { return }
        
        let request = NSFetchRequest<User>(entityName: "User")
        request.predicate = NSPredicate(format: "username == %@ ", localUsername)
        
        do {
            let users = try viewContext.fetch(request)
            if let user = users.first {
                // 更新用户实体的头像属性
                user.avatar = imageData
                user.avatarURL = imageURL.absoluteString
                try? viewContext.save()
            } else {
                // Invalid credentials.
                // Show an error message to the user.
                self.isAlert = true
            }
        } catch {
            // Error fetching users.
            // Show an error message to the user.
        }
    }
}
