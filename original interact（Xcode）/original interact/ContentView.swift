import SwiftUI

struct ContentView: View {
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var showingAlert = false
    @State private var alertMessage = ""
    
    // 这里可以设置一个简单的用户名和密码
    let correctUsername = "2422824985"
    let correctPassword = "18782105346"

    var body: some View {
        VStack {
            Text("登录")
                .font(.largeTitle)
                .padding()

            TextField("用户名", text: $username)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            SecureField("密码", text: $password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            Button(action: login) {
                Text("登录")
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(5)
            }
            .padding()
        }
        .padding()
        .alert(isPresented: $showingAlert) {
            Alert(title: Text("提示"), message: Text(alertMessage), dismissButton: .default(Text("确定")))
        }
    }

    func login() {
        if username == correctUsername && password == correctPassword {
            alertMessage = "登录成功!"
        } else {
            alertMessage = "登录失败: 用户名或密码错误"
        }
        showingAlert = true
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
