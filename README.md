```
flutter_workspace/
├── apps/
│   ├── app1/             # Flutter应用1
│   └── app2/             # Flutter应用2
├── packages/
│   └── common_ui/          # 通用的 Flutter UI 组件库
│   └── utils/              # 通用工具函数，如日期处理、字符串操作等
│   └── network/            # 网络请求封装
│   └── auth/               # 认证模块，如 OAuth2 登录
│   └── state_management/   # 状态管理封装（比如 GetX、Provider 的封装）
│   └── storage/            # 存储操作封装（比如Sqlite、shared_preferences）
│   └── notifications/      # 通知推送（比如本地通知、推送通知）
│   └── reflection/         # 反射相关操作
│   └── analytics/          # 数据埋点与分析
│   └── theming/            # 主题管理（颜色、字体、样式）
│   └── localization/       # 多语言支持
│   └── testing/            # 测试工具或模拟数据
├── .gitignore
├── pubspec.yaml          # 根pubspec文件（定义全局依赖管理）
└── README.md
```

## 使用 Melos 的流程

### 安装 Melos
```
dart pub global activate melos
```
### 初始化依赖 在根目录执行以下命令，初始化并安装所有包的依赖：
```
melos bootstrap
```