Pod::Spec.new do |s|

#名称
s.name= "GZToolsManager"

#版本号
s.version= "0.0.7"

#介绍
s.summary= "整理一些自己平时收集或编写的一些小工具."

s.description= <<-DESC

这里整理的都是一些收集别人的或自己平时研究写下的一些代码片段

以图自己平时做东西方便

如果发现有什么问题记得联系

DESC

#主页,我理解应该是个人主页,我就随便写了github主页
s.homepage= "https://github.com/ghost320/GZToolsManager"

#协议
s.license= "MIT"

#个人资料
s.author= { "ghost320" => "ghost_320@hotmail.com" }

#平台
s.platform= :ios, "9.0"

#源
s.source= { :git => "https://github.com/ghost320/GZToolsManager.git", :tag => "#{s.version}" }

#上传的文件,之前默认的是有oc的"Classes/**/*.{h,m}",我删掉了,需要用oc的同学可以留下
s.source_files= "GZToolsManager/*.swift"

#所需的framework,多个用逗号隔开
s.frameworks = 'UIKit', 'QuartzCore', 'Foundation'

#是否支持arc
s.requires_arc = true

end
