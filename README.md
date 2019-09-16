# flutter_project_initialization

A flutter application project with only initialization.

## 项目框架及依赖

- **网络交互**：基于dio封装了`DioManager`,`cookie_jar`作为cookie管理方案，在`data`包下，包含：

	- `dio_manager`：封装dio的单例

	- `data_repo`：数据仓库中心，里面包含API定义以及获取对应接口的方法

	- `model`：数据模型，存储所有接口交互的数据类型

- **状态管理**：基于bloc方案，在`bloc`包下，包含：

	- `bloc_provider`：bloc工具类及基类定义，使用该类获取对应所需的bloc

	- `blocs`：定义了业务所需的bloc

	- `index_bloc`：bloc包索引，外界包可以`import`该索引从而导入可使用的包bloc下面所有内容

- **国际化i18n**：基于插件`Flutter i18n`实现自动化管理国际化方案，资源定义在`res/values/`目录下

- **图片资源管理**：基于插件[`flutter-img-sync`](https://github.com/Leo0618/flutter-img-sync)实现图片资源的管理

	- `r.dart`：定义了图片资源的常量池，代码中可直接引用

	- 插件的使用需参考使用文档，需要配置`pubspec.yaml`文件

- **业务ui**：在包`ui`下面包含了`page`和`widget`用于存放业务相关的代码

	- `ui`：存放各个页面widget

	- `widget`：存放自定义的组件或者第三方开源项目

	- `util`：存放一些常用的工具类

- **响应式编程**：使用`rxdart`进行响应式编程

- **其他依赖**：

	- `shared_preferences`：shared_preferences读写操作
	
	- `package_info`：package信息

	- `device_info`：设备信息

	- `path_provider`：文件存储目录路径获取

	- `fluttertoast`：toast提示

	- [`flog`](https://github.com/Leo0618/flog)：日志打印，目前适配了android的各级别打印，ios仍使用默认的`print`方法