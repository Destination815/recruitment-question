import SwiftUI
import Alamofire
import CryptoKit
  
// 定义数据模型
struct LoginResponse: Decodable {
    let retCode: Int
    let msg: String?
    let data: UserDataContainer?
}
  
struct UserDataContainer: Decodable {
    let userId: Int
    let userLevel: Int
    let signature: String
}
  
struct UserData {
    let userId: Int
    let userLevel: Int
    let signature: String
}
  
struct ContentView: View {
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var loginMessage: String = ""
    @State private var isLoggedIn: Bool = false
    @State private var userData: UserData?
  
    var body: some View {
        NavigationView {
            VStack {
                TextField("用户名", text: $username)
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(5)
  
                SecureField("密码", text: $password)
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(5)
  
                Button("登录") {
                    login()
                }
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
  
                if !loginMessage.isEmpty {
                    Text(loginMessage)
                        .foregroundColor(.red)
                        .padding()
                }
  
                NavigationLink(destination: UserDetailView(userData: userData), isActive: $isLoggedIn) {
                    EmptyView()
                }
            }
            .padding()
        }
    }
  
    private func login() {
        guard let sha256Password = sha256(password) else {
            loginMessage = "密码加密失败"
            return
        }
  
        let urlString = "https://star-studio-ios.hakubill.tech/?username=\(username)&password=\(sha256Password)"
        AF.request(urlString).responseDecodable(of: LoginResponse.self) { response in
            switch response.result {
            case .success(let loginResponse):
                DispatchQueue.main.async {
                    if loginResponse.retCode == 0, let userDataContainer = loginResponse.data {
                        userData = UserData(
                            userId: userDataContainer.userId,
                            userLevel: userDataContainer.userLevel,
                            signature: userDataContainer.signature
                        )
                        isLoggedIn = true
                    } else {
                        let message = loginResponse.msg ?? "未知错误"
                        loginMessage = "错误码: \(loginResponse.retCode), 原因: \(message)"
                    }
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    loginMessage = "网络请求失败: \(error.localizedDescription)"
                }
            }
        }
    }
  
    private func sha256(_ input: String) -> String? {
        let inputData = Data(input.utf8)
        let hashed = SHA256.hash(data: inputData)
        return hashed.map { String(format: "%02hhx", $0) }.joined()
    }
}
  
struct UserDetailView: View {
    var userData: UserData?
  
    var body: some View {
        VStack {
            if let userData = userData {
                Text("用户ID: \(userData.userId)")
                Text("用户等级: \(userData.userLevel)")
                Text("签名: \(userData.signature)")
            }
        }
        .padding()
    }
}
  
@main
struct YourProjectNameApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
